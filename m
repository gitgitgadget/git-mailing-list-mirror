Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2EEC2D0D2
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA502146E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiIPJFwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfLTSOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:14:41 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43948 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfLTSOk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:14:40 -0500
Received: by mail-pf1-f193.google.com with SMTP id x6so4542055pfo.10
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gk5ZJhKfpe1whOMTpaFphgIH3CNUsLpTz28Dli3F+m4=;
        b=ZiIPJFwt9L5HpMJaSMszdUTXGQmQTcjCBrmNw0vcGSXO6nBzu1oAfsyyfc2w0WoQO4
         WGovijp90FvPfgnmtlz6FDe1GeBAZH0aKyjoO01I/YdCZa71JirAWQ7j3xF0eEGbSq7u
         tUq91WPkZdGWwmhQcnqBhyOV7vmTw4aA153Xn+4SVXrQHl8PeU1tWglwc/+E+AaGFklv
         L3TkGPDI9rFgsrxKteUMHtbFcIGzkt4XkefTYQX/+jzwsJGVfi6B4A8BaifT0Q0LwUKU
         VxogM2ZZhu6cleD2HbdPP/02goo2O4XTkHSSisG/qxM9a+AGHi7vdgAxFFpshikUYwJK
         Xd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gk5ZJhKfpe1whOMTpaFphgIH3CNUsLpTz28Dli3F+m4=;
        b=MjNz6YaJmDeT30Ku+enq/lqMi2pZ1vfeP7+6NPFaSQCii3Ev6/Xi8rlDuDej2jJRF0
         mKltxX+6fnpKensrrlYmgsIZSiE7pWjOUyCMNM+t+KdL3s5uB7P/vFJbtkO1nAZF7u8D
         2eaVe/wQjnOyrcodC4qZ8ny2ZOaRXyzxRxRR+OeK6voqIc0SBpwtaYiGGqkk0VpxeYco
         eHZhDk9LlQkkaYYhNx6Ty1pUOcCEkP0UK8eyi0p0WENKjbn5mK99W2bg97NAOpgU7HHk
         5nB7FwFgcXuAdvYuQ2W+KjA/Djo1sh0DTDcavHGpZweUHjIpvVgtZw4p76cW+rVFdqZg
         mHvA==
X-Gm-Message-State: APjAAAURiHLHciPy1ZRch0c061L1I29sn2KO8Bsxp4qOO+T//NqtmUvE
        rSng6RfGIAih1F0JLdXDDTMh7NRO
X-Google-Smtp-Source: APXvYqydNcyV/Rvvl6DcmiJaIJRVkGP6A1/9Q1b4Loa9jW5NOlSkYEdpC5WjNij80ydMp+P+ZD80DA==
X-Received: by 2002:a63:a4b:: with SMTP id z11mr15640628pgk.97.1576865679167;
        Fri, 20 Dec 2019 10:14:39 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id c78sm14063082pfb.122.2019.12.20.10.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:14:38 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 06/15] t0020: don't use `test_must_fail has_cr`
Date:   Fri, 20 Dec 2019 10:15:53 -0800
Message-Id: <f6ef6d245c59b618964099a1d477b4c78889a715.1576865664.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576865663.git.liu.denton@gmail.com>
References: <cover.1576794144.git.liu.denton@gmail.com> <cover.1576865663.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail function should only be used for git commands since
we should assume that external commands work sanely. Since has_cr() just
wraps a tr and grep pipeline, replace `test_must_fail has_cr` with
`! has_cr`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0020-crlf.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 854da0ae16..b63ba62e5d 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -159,8 +159,8 @@ test_expect_success 'checkout with autocrlf=input' '
 	rm -f tmp one dir/two three &&
 	git config core.autocrlf input &&
 	git read-tree --reset -u HEAD &&
-	test_must_fail has_cr one &&
-	test_must_fail has_cr dir/two &&
+	! has_cr one &&
+	! has_cr dir/two &&
 	git update-index -- one dir/two &&
 	test "$one" = $(git hash-object --stdin <one) &&
 	test "$two" = $(git hash-object --stdin <dir/two) &&
@@ -237,9 +237,9 @@ test_expect_success '.gitattributes says two is binary' '
 	git config core.autocrlf true &&
 	git read-tree --reset -u HEAD &&
 
-	test_must_fail has_cr dir/two &&
+	! has_cr dir/two &&
 	verbose has_cr one &&
-	test_must_fail has_cr three
+	! has_cr three
 '
 
 test_expect_success '.gitattributes says two is input' '
@@ -248,7 +248,7 @@ test_expect_success '.gitattributes says two is input' '
 	echo "two crlf=input" >.gitattributes &&
 	git read-tree --reset -u HEAD &&
 
-	test_must_fail has_cr dir/two
+	! has_cr dir/two
 '
 
 test_expect_success '.gitattributes says two and three are text' '
@@ -270,7 +270,7 @@ test_expect_success 'in-tree .gitattributes (1)' '
 	rm -rf tmp one dir .gitattributes patch.file three &&
 	git read-tree --reset -u HEAD &&
 
-	test_must_fail has_cr one &&
+	! has_cr one &&
 	verbose has_cr three
 '
 
@@ -280,7 +280,7 @@ test_expect_success 'in-tree .gitattributes (2)' '
 	git read-tree --reset HEAD &&
 	git checkout-index -f -q -u -a &&
 
-	test_must_fail has_cr one &&
+	! has_cr one &&
 	verbose has_cr three
 '
 
@@ -291,7 +291,7 @@ test_expect_success 'in-tree .gitattributes (3)' '
 	git checkout-index -u .gitattributes &&
 	git checkout-index -u one dir/two three &&
 
-	test_must_fail has_cr one &&
+	! has_cr one &&
 	verbose has_cr three
 '
 
@@ -302,7 +302,7 @@ test_expect_success 'in-tree .gitattributes (4)' '
 	git checkout-index -u one dir/two three &&
 	git checkout-index -u .gitattributes &&
 
-	test_must_fail has_cr one &&
+	! has_cr one &&
 	verbose has_cr three
 '
 
-- 
2.24.1.703.g2f499f1283

