Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A09E7202AB
	for <e@80x24.org>; Fri, 30 Jun 2017 20:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbdF3Ulf (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:41:35 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34518 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752523AbdF3Uld (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:41:33 -0400
Received: by mail-wr0-f195.google.com with SMTP id k67so39893820wrc.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HM9h69V673Y5tI12FD3Y/ARFsYMjRHhyrisuK7S+qYI=;
        b=KglTXPOd2EeaPYbFMLLYbtROjKiuhiyLA1cGC4VkiekrssnLUJEIAH5MBhQhLLRMA7
         ji0Q/XsHPeuWtoQbJ3VifiV8+fLPkJ9S13I0oaUZuSapHGP7SDycCUaLMBCmLQoaht9i
         YZrPi5PXMqfz3vkLNLrBFK2IPo8Xr9TdTWvj8exmv7ATa5yL3HZOw1vgA0tnfhW2ALx8
         S9ojsIqwT7F0DKvg2NhaeTl4tQprOsnTIQ2FIHOAifA8M+2BPEO5a7G9w7p2L2OzHx85
         cFzW+obsWwa+K8W4FsJmQNYmYWpc2qTqkgICErlzvbdK1SKi5Za8lkizHSQcm+JDoNSC
         rdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HM9h69V673Y5tI12FD3Y/ARFsYMjRHhyrisuK7S+qYI=;
        b=bxhGpDkkTdNBuLp6Ioeq36GU/pwlgcfxWMVtrU43Jas69PXR9FRkDzzLjOBRGwLswn
         DvjroJpbSXHoCHBOihcVp8arzLRzlNLSx6IWbaHQscJtnjOupZXj+DVO7rJq3sN7O4P/
         hsYEeYbXZLqOPpiy+FaKV4jTlq+iMQrG6NBd48JeFQ7oKhu5lw1PekVFnLm5fQNMgKOD
         d3//hvCAv1Qd40qkyKZ887JLcojfjpc78weHea8/dehPeHCsBcyUmGU5qk/wd7NpWU3i
         XmjU86zDrb3fqgofa0HL6YhIiGP2l5jTtjQc8BTrkNOGxneMXIKNFVe26/fWC12q+hZP
         MN2Q==
X-Gm-Message-State: AKS2vOxIJ0n/m33PqgBZeh9xHTXncoUl0oH3bTX/pbtLhnBhvTDbBnGu
        gBPD4B2AqbUsrJJ0
X-Received: by 10.223.166.8 with SMTP id k8mr28429767wrc.172.1498855291690;
        Fri, 30 Jun 2017 13:41:31 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB4C89.dip0.t-ipconnect.de. [93.219.76.137])
        by smtp.gmail.com with ESMTPSA id v144sm10648239wmv.27.2017.06.30.13.41.30
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:41:31 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v9 1/7] t0021: keep filter log files on comparison
Date:   Fri, 30 Jun 2017 22:41:22 +0200
Message-Id: <20170630204128.48708-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170630204128.48708-1-larsxschneider@gmail.com>
References: <20170630204128.48708-1-larsxschneider@gmail.com>
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

