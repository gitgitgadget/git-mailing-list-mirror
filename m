Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE8952082F
	for <e@80x24.org>; Tue, 27 Jun 2017 12:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752942AbdF0MKl (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 08:10:41 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35630 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753069AbdF0MKj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 08:10:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id 131so5409073wmq.2
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 05:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HM9h69V673Y5tI12FD3Y/ARFsYMjRHhyrisuK7S+qYI=;
        b=ieZI1T2gLZtzUCUCpfM0DcD36W9t2WdULw2U+12hRg4V+MTQs6FG6HwdNp0L6J58he
         h0qwKKe474Ls/dc54rPq4X/iBvsqqKiPnQtF9TBfZA1BCNUhF/KP7K6ES2rIxHgm3kc5
         /YnXE6SAX3UC0g9Y9LRoPJCsLQgq7ARxSdZKv1w0GzrLz9MT2XN+82Xc1y4FOEjWdKec
         bH2SPVBI33orWxWjsX2cJ7TwdWKYJJy+TWtYo7IZ8tOt1u3zmKjqLRIA5cXy3fT0WB8P
         rv9NrzOzVGXyt4nSPyls9u2X/gk39QNZxZoblmZXqfiAhqArSavgeiYoz+ocElxwnUh0
         FPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HM9h69V673Y5tI12FD3Y/ARFsYMjRHhyrisuK7S+qYI=;
        b=aIwJyPaJfjC4A6ol54c87noF/jqdZkPct7pFMMi6pBLsREkhW2Bk+L4X0iaArHuEsd
         rD/W6SFjrxSLecHTsJSCRYZuUd018BdVaE8Q8f4pgx/WHf097YMylD2aexz+u47vK4c2
         pTcFcFvZApjbUlOzCAjps8R8v72wRRn0bc+8svLXYRJtUMd6lDS8cbx3izQDYN6U2M8j
         MWKJS9aQzsLCjxev695NSIzT5Ua/w0veQOzo87Vk7Of7avd5gmlZ9vmc6kNut6vtaRpu
         ji5OO493EJS9dhsXxtVRUtOfsHzduULWzpPV0AmztvYyEupLNwo1fpMYdTvxO9cns9WK
         hLKg==
X-Gm-Message-State: AKS2vOzfZzJSBZPK6f82CNyJ0+aaGj69sV9jtPgNYbo/Fesl6RTAgp1P
        QKMGm0yCqanN1S2A
X-Received: by 10.28.20.76 with SMTP id 73mr3272998wmu.118.1498565437806;
        Tue, 27 Jun 2017 05:10:37 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 32sm17873976wry.31.2017.06.27.05.10.34
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 05:10:37 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v7 1/6] t0021: keep filter log files on comparison
Date:   Tue, 27 Jun 2017 14:10:22 +0200
Message-Id: <20170627121027.99209-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170627121027.99209-1-larsxschneider@gmail.com>
References: <20170627121027.99209-1-larsxschneider@gmail.com>
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

