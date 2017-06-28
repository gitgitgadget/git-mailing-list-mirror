Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DD9520287
	for <e@80x24.org>; Wed, 28 Jun 2017 21:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbdF1VaA (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 17:30:00 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36215 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdF1V35 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 17:29:57 -0400
Received: by mail-wr0-f196.google.com with SMTP id 77so35305444wrb.3
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 14:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HM9h69V673Y5tI12FD3Y/ARFsYMjRHhyrisuK7S+qYI=;
        b=No1OhheQmabmxjke0Z+KVcIJN+pl2gciRO8QKUUwEsIIAxKxo/Xbh2FgbmGiURiiya
         Ea3Oj6+3N0ynnxiL4IfoxYCvUflZPj1EH+jm47ZoqtNuTSyul1A5jKZB5sJ+YSJqkHHr
         3xzrOv1ubxu35mmy0Ze9qR5EfSL6x8zywPwN5C9+50bjgl5laS0jco66N5xVxL3WKkh0
         y8SbXE7MrzHGlPWcVmQecZ2kXu7wne+rNPtDdIVeDrP70ONde6Jbbsd7W4rqfTQJPpFO
         P746V6C5YDkx0uQDSYdfRUpJEAW4xvqgK9OA7nAzBdtz4FqXStMMNmQWrV8vJWKbhsM/
         dyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HM9h69V673Y5tI12FD3Y/ARFsYMjRHhyrisuK7S+qYI=;
        b=sXju2xD6FPM7jgmxN+1KYDgXKeENn+8ooqWhuBpjZqY2kKYo7l+k5cnZIX2uewgeMF
         hdZFKkMaBTPkjTm/wh9OSKG0Sfxqg56PLw8j7KqNF3bwXprFO+yfuSPwOYGPD/yu6XU/
         /g8XKAkVspvS5tHstKjcmF5h9Q0LGa5Fn3V6CS0qwHUGMymWBH+IAWlyehYjHupaIzfu
         Vpbd9ti3TGYFwuwFBDEY1XNfgE196iy4pOS45CNRzbp3VvisuA5wfRg+ds4l5s5D5ZEU
         tNTsqyQlX4IGrMXc/sGuNQSCdBy6tq+Yx+WqPtABmq6Z86xKUhX4ZN7eKiILnrajRdBm
         ueSg==
X-Gm-Message-State: AKS2vOy0mOh7tABgVBjoE4ND8M7R6Y79TVGnRq2XbZg47TquGhV5XT7E
        Zz00ZVRdfwL+wJVH
X-Received: by 10.223.133.211 with SMTP id 19mr23255125wru.27.1498685396105;
        Wed, 28 Jun 2017 14:29:56 -0700 (PDT)
Received: from ccsh0hfn32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id l20sm2581036wre.25.2017.06.28.14.29.54
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 14:29:55 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v8 1/6] t0021: keep filter log files on comparison
Date:   Wed, 28 Jun 2017 23:29:47 +0200
Message-Id: <20170628212952.60781-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170628212952.60781-1-larsxschneider@gmail.com>
References: <20170628212952.60781-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The filter log files are modified on comparison. That might be
unexpected by the caller. It would be even undesirable if the caller
wants to reuse the original log files.

Address these issues by using temp files for modifications. This is
useful for the subsequent patch 'convert: add "status=delayed" to
filter process protocol'.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t0021-conversion.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 161f560446..ff2424225b 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -42,10 +42,10 @@ test_cmp_count () {
 	for FILE in "$expect" "$actual"
 	do
 		sort "$FILE" | uniq -c |
-		sed -e "s/^ *[0-9][0-9]*[ 	]*IN: /x IN: /" >"$FILE.tmp" &&
-		mv "$FILE.tmp" "$FILE" || return
+		sed -e "s/^ *[0-9][0-9]*[ 	]*IN: /x IN: /" >"$FILE.tmp"
 	done &&
-	test_cmp "$expect" "$actual"
+	test_cmp "$expect.tmp" "$actual.tmp" &&
+	rm "$expect.tmp" "$actual.tmp"
 }
 
 # Compare two files but exclude all `clean` invocations because Git can
@@ -56,10 +56,10 @@ test_cmp_exclude_clean () {
 	actual=$2
 	for FILE in "$expect" "$actual"
 	do
-		grep -v "IN: clean" "$FILE" >"$FILE.tmp" &&
-		mv "$FILE.tmp" "$FILE"
+		grep -v "IN: clean" "$FILE" >"$FILE.tmp"
 	done &&
-	test_cmp "$expect" "$actual"
+	test_cmp "$expect.tmp" "$actual.tmp" &&
+	rm "$expect.tmp" "$actual.tmp"
 }
 
 # Check that the contents of two files are equal and that their rot13 version
-- 
2.13.2

