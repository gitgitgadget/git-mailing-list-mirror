Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C19E20D13
	for <e@80x24.org>; Thu,  1 Jun 2017 08:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbdFAIWJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 04:22:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35280 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbdFAIWI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 04:22:08 -0400
Received: by mail-wm0-f68.google.com with SMTP id g15so9276028wmc.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 01:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZQJqi6yieVVG05EWp6npXJ04hvzmH8PrSLC1srFkNYY=;
        b=HN909A9VvUj3qkVB6Z1VqFeqjofBiTe/P6nXil9cSoSEPQaO0u3CI4mr4R2jm9JN8+
         pMzEPyv4eJRhduHuqu2VrpXhca0euzbCgh0sqPMPc0afar5YgrV/8ctN9Ri6C873uJp2
         4YD65K/Sub1StENWuQBB2hx2Klw3V9dQdx7yvpPzjEmgNxp5Pe+BmnSEXzn1z02HzzKQ
         CnptUQWqPTH8YrnTurGsQW6l6FKTSCDUDtS1GTPNsyNdh2jewkpHgTcNg6UTcrrLxt07
         69jEqOaPXIPH6vahALR3xXUMz9AYRemnosEt2QVxqOXt9SHCNbZq0JHw1ReOH/u8hOuv
         vMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZQJqi6yieVVG05EWp6npXJ04hvzmH8PrSLC1srFkNYY=;
        b=efFNc166cNJA7bS6IziMgurvuvECKSgu12LqF77TIv/96gflIPInGWVu02eWEi4tGs
         abUhmbJD0vPeLof6jauDw4wrwyX2eJM089S3TMik7Yt6fHgyBlcZEXn67yJXgnEl8KJs
         3r9UiXAbeCA4zZtsf7c3kZGRiVd0OogcuYskmhmTpZ7b/nqcSbOWphEvfKWJae6ZoxRw
         6t8MA8S+xZMfDRgNngEnQ1GC7tCHbXhkXrPMrDPXrDFYafwcXxJ3kFrX7mVmZVHxtPYC
         vBw+wWwoOu4oH7ReEoD/kyus3s/1rJ4Up/tQG+QMjmiiUngKBvDDGn32a0miDRkDnibg
         nX5w==
X-Gm-Message-State: AODbwcBHCe/1J/ozT9LsEA8EHiG2VB9T3xSpe1Agl9J2yc57d3Cjh/WB
        bxjMMq1TeFLgGR0j
X-Received: by 10.28.31.135 with SMTP id f129mr8819070wmf.78.1496305326431;
        Thu, 01 Jun 2017 01:22:06 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB4864.dip0.t-ipconnect.de. [93.219.72.100])
        by smtp.gmail.com with ESMTPSA id 140sm15351595wmu.23.2017.06.01.01.22.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 01:22:05 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v5 1/5] t0021: keep filter log files on comparison
Date:   Thu,  1 Jun 2017 10:21:59 +0200
Message-Id: <20170601082203.50397-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170601082203.50397-1-larsxschneider@gmail.com>
References: <20170601082203.50397-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The filter log files are modified on comparison. Write the modified log files
to temp files for comparison to fix this.

This is useful for the subsequent patch 'convert: add "status=delayed" to
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
2.13.0

