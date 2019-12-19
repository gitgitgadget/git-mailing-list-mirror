Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7214AC2D0D1
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4220B24672
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vhxduOad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfLSWVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:21:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43896 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfLSWVm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 17:21:42 -0500
Received: by mail-pl1-f196.google.com with SMTP id p27so3197304pli.10
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 14:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gk5ZJhKfpe1whOMTpaFphgIH3CNUsLpTz28Dli3F+m4=;
        b=vhxduOadd/1k9Z675vGio+s7oblf0wPYjzRvjBzI1MYJ2+3rTLMBRsEEIbIPtTJBpK
         8Rc/EMy8n6xsO4cQf0IMSzOIXWpATvYUAAnGgjuhii2m26AHrerFcw5Sia55iPDMVzNl
         OL22pF0W9Vcwd0FBSmD46FJg6H674lGDL8XYpB5+rtL4ni+uPu4IWWgeOvgupe8Y1KNC
         HLomtI/TOftHcM4j4FAx/g4V2Xupwvt2Uaq2yt32lz21TYqiil1RXJiaQqX/OtC9Jr3i
         0MsWTrLFogDdw48lQrYCb9VbLrktzTLJb6V1zZK8gVBIPu6DoWtoiUaplpzoApRhxv4r
         UoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gk5ZJhKfpe1whOMTpaFphgIH3CNUsLpTz28Dli3F+m4=;
        b=PcBg4E9ngXAgY1rC4cjeG1Y327BTq9oKTZuMW3HuyqsBuJZ1G9CYraF57sivMWEz/E
         CLXpAex0MKbwvhV4dh/MX3kA22F/9i94bOHHXz/Eq+GTaGUgk8OLr/W9vHsroHDqJCQb
         I7Q8viE1gXxI5H0E1+jq9rQ2E8FBNCXP7nuryake9idv4SJEw3cf6wf+2nD27wEnuxeQ
         mD9Sa09s8eX+GZAKfgBa56+WoG5TWQn9Q4RIlPa9iWTxHJXsiFg5EwrZiiVzdWXZB4/d
         p9P059rho6yMsDUqNuol3vQWqahtteIXL6wsJ7UwMD8S6Dky1FxV57qz2TbFwHfQdY5I
         OzDA==
X-Gm-Message-State: APjAAAVuY0DbXjQmGpreqFfvpiS3ui5E/WxbT3xV+Iljpu3p+mnjpVuU
        aUZR3GMCSDtwpTEJGZBOmppmzCAA
X-Google-Smtp-Source: APXvYqwVt6aP2Fddsf2Kpbq0Ue+pd5+QwyJyRF7gP1w4T7jE31XHUKOO6nQm3hiOd/K5gq/AfiJiiA==
X-Received: by 2002:a17:902:fe98:: with SMTP id x24mr11544299plm.155.1576794101321;
        Thu, 19 Dec 2019 14:21:41 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id o19sm11428528pjr.2.2019.12.19.14.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 14:21:40 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/16] t0020: don't use `test_must_fail has_cr`
Date:   Thu, 19 Dec 2019 14:22:42 -0800
Message-Id: <8da6c96b39183bc1f6b8b40a2345876017d53921.1576794144.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576794144.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com> <cover.1576794144.git.liu.denton@gmail.com>
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

