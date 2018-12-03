Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 204E2211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 22:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbeLCWhz (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 17:37:55 -0500
Received: from mail-vs1-f73.google.com ([209.85.217.73]:40332 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeLCWhy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 17:37:54 -0500
Received: by mail-vs1-f73.google.com with SMTP id e124so7695646vsc.7
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 14:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=96kzJFmnJbzPZwOoaYZ2hDgg41aU3foLRhQycn2bTpM=;
        b=gIi0pgw2h5HyFmMi7+dMNQJPsgP3lqISrhPthKK5imv5QCtLFgc+AiBEkRaZEcLEus
         JKCfGgEbRV8y9FNR4Qd1D3mDieOQfnjYQ/t0n27gxcMKdWsLc+iQWv8E+l4dLTGv+IWK
         eTIAbafn+FbjVy6WIhIM+cUvTQVnpPPxhgw9ZWWDLVpWyDlD6SsgE3uaK2zTotTzsDop
         3Av/kCmq/q4cRD3ezsv7vBntbsq3OxKsP+2Twe7SMkierBPNe1jVK+lAu1xatJRfw19v
         u5Mt35/ZhY0F04KYdLet+5abEpJQsC0enxCEl7DLQcmdqljzrWNGPgQI45jeMiEJJvvs
         Gxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=96kzJFmnJbzPZwOoaYZ2hDgg41aU3foLRhQycn2bTpM=;
        b=XsR1x8gb0Ee2q15T2UmyWLYDnO/VUVdq6BWQd978C2TkEBRzq3StSH/r6jv+J6WTW+
         rirDJDccbnRkpdvplftxQv1hcPw8eLNPbLwvNxBQgJPIa1qTYq4fTwCEF3yY5VXRBiy0
         lZ+WyK6KYvA1lzAUNgR0OFCmnvgYgkTNZbCY1u8dxoExxIHTix1Jo/900AnOr8CLuq6b
         +15BDr58kCwDeHo1/e5mnG7xYXavcnRYAFVlAoYuDngQJPWov/UAzczC9MQeBrUUI42t
         /S3Hh7BeLifZdWIOG0C/YWBfjDkiLbB7ElCJI2cYuq87uoBLB2LsGIwuRNopXz/A5VlP
         0hTg==
X-Gm-Message-State: AA+aEWZBJsK1ZaWbGLCZQDesguhOKxYpf+7Ar1Ai7Z3roS8jyZ0kLrSU
        tl0Blc5CJd6l7TR2219PS3dZuOxyFVcS
X-Google-Smtp-Source: AFSGD/X8yfP/m5ol45DtDA0Oh22T0yppjz6iG2fwFYGo4JUCal5U2gocOW/Qke2seRgTpeAaq93LjDTk1+iN
X-Received: by 2002:a1f:b989:: with SMTP id j131mr15076194vkf.5.1543876673493;
 Mon, 03 Dec 2018 14:37:53 -0800 (PST)
Date:   Mon,  3 Dec 2018 14:37:13 -0800
Message-Id: <20181203223713.158394-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH] sideband: color lines with keyword only
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com, gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When bf1a11f0a1 (sideband: highlight keywords in remote sideband output,
2018-08-07) was introduced, it was carefully considered which strings
would be highlighted. However 59a255aef0 (sideband: do not read beyond
the end of input, 2018-08-18) brought in a regression that the original
did not test for. A line containing only the keyword and nothing else
("SUCCESS") should still be colored.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 sideband.c                          | 5 +++--
 t/t5409-colorize-remote-messages.sh | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sideband.c b/sideband.c
index 368647acf8..7c3d33d3f8 100644
--- a/sideband.c
+++ b/sideband.c
@@ -87,7 +87,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 		struct keyword_entry *p = keywords + i;
 		int len = strlen(p->keyword);
 
-		if (n <= len)
+		if (n < len)
 			continue;
 		/*
 		 * Match case insensitively, so we colorize output from existing
@@ -95,7 +95,8 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 		 * messages. We only highlight the word precisely, so
 		 * "successful" stays uncolored.
 		 */
-		if (!strncasecmp(p->keyword, src, len) && !isalnum(src[len])) {
+		if (!strncasecmp(p->keyword, src, len) &&
+		    (len == n || !isalnum(src[len]))) {
 			strbuf_addstr(dest, p->color);
 			strbuf_add(dest, src, len);
 			strbuf_addstr(dest, GIT_COLOR_RESET);
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index f81b6813c0..2a8c449661 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -17,6 +17,7 @@ test_expect_success 'setup' '
 	echo " " "error: leading space"
 	echo "    "
 	echo Err
+	echo SUCCESS
 	exit 0
 	EOF
 	echo 1 >file &&
@@ -35,6 +36,7 @@ test_expect_success 'keywords' '
 	grep "<BOLD;RED>error<RESET>: error" decoded &&
 	grep "<YELLOW>hint<RESET>:" decoded &&
 	grep "<BOLD;GREEN>success<RESET>:" decoded &&
+	grep "<BOLD;GREEN>SUCCESS<RESET>" decoded &&
 	grep "<BOLD;YELLOW>warning<RESET>:" decoded
 '
 
-- 
2.20.0.rc2.403.gdbc3b29805-goog

