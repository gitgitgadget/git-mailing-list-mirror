Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D1EC7619C
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 04:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F63820726
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 04:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPXLUxc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgBQExQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 23:53:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34683 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgBQExN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 23:53:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id n10so16037575wrm.1
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 20:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lnsT90haYi8aXQv2xc7ovgJBe4ZUQqvZxZRum5GQbr4=;
        b=DPXLUxc4HdJ6IvRPmf/xnPzNNiMKdTmnRRUhoi/kNFBBtGPGkkZMfPMH/Ul+2J0j4Y
         lOw1A+hGGFmX9CYVpcCrfGvxxZeAgnwJPZXm4hCcWbPLAIwcm8+VioQQEq6/jakZa/5J
         xQzLIpJRXjnsjin1FYHEXTJw5IMLISOV2mKl6SN5pJyRo050vPdIkjd4/HZvIA5WbUMA
         C8MVtVpuYqq7L5dD/Hqai7lggRd3B7fOkFxdbrq5lxnBh76N9Fp3wx8uCC/E6Dc5CQxs
         pE0Wei9oAluIOeP86Akgh60o0TG9eyb6uN8E7cmqjk/EL50FrWEOsQgeWxnDbf2XgtQy
         BAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lnsT90haYi8aXQv2xc7ovgJBe4ZUQqvZxZRum5GQbr4=;
        b=JL2b+M30Ezw++qKcE/oEdp9tQO0p2JYn383uk4f1IXZ149L50Stv0IHFeCLnKg2ee5
         mSoQFraDRRMgzgtL5HGaA/vi03TBQmzp4RW2/MBL5neInetI9ASCnKhgXzI4gQfK/Nva
         +8PkTa3S3gJqWWRqp0k1r8W3rwJ7DvYxCmi2ws86ub4JQvg4+UKD+NFvBpJsPejlv5o4
         FpZkc2D3fZjws7/RkpNOzPaOcZ+gCIOUDJmeCHsGPftxn5RuHZIdJCBLI5AhoLW/f67Y
         t8tBU9DLyLgXWvqRPFB/RfKD0m2Vddux1o/1fGiqprnByBF8D/HYfrrMcfDP9E8Ed1o/
         M3DQ==
X-Gm-Message-State: APjAAAVjJR/ah/nNX0LRJU2wp2yi+u0E1ql3Bb6yden5OmFTjXyoUHgH
        DzX7mXyv3kBTw82Xt/gvWr4chXHS
X-Google-Smtp-Source: APXvYqy98+Pwz6pfnpdf9WrtM5Y1M9x1RCkMTxRI9Ezwyl+6CyIrXURZjkLEpL537xHsrMK3E5U4iw==
X-Received: by 2002:adf:ee0b:: with SMTP id y11mr19198907wrn.62.1581915189447;
        Sun, 16 Feb 2020 20:53:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c77sm18463753wmd.12.2020.02.16.20.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 20:53:09 -0800 (PST)
Message-Id: <fa64ff03647e85d79414da6776309ab7488bc2be.1581915186.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.555.git.1581915186.gitgitgadget@gmail.com>
References: <pull.555.git.1581915186.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Feb 2020 04:53:03 +0000
Subject: [PATCH 3/6] t/lib-submodule-update: move a test to the right section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Damien Robert <damien.olivier.robert@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The test "$command: submodule branch is not changed, detach HEAD
instead" is in the "Appearing submodule" section of
test_submodule_recursing_with_args_common(), but this test updates a
submodule; it does not test a transition from a state with no submodule
to a state with a submodule.

As such, for consistency, move it to the "Modified submodule" section of
the same function. While at it, add a comment describing the test.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/lib-submodule-update.sh | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 5f9eb682f6a..417da3602ae 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -658,22 +658,6 @@ test_submodule_recursing_with_args_common() {
 			test_submodule_content sub1 origin/add_sub1
 		)
 	'
-	test_expect_success "$command: submodule branch is not changed, detach HEAD instead" '
-		prolog &&
-		reset_work_tree_to_interested add_sub1 &&
-		(
-			cd submodule_update &&
-			git -C sub1 checkout -b keep_branch &&
-			git -C sub1 rev-parse HEAD >expect &&
-			git branch -t modify_sub1 origin/modify_sub1 &&
-			$command modify_sub1 &&
-			test_superproject_content origin/modify_sub1 &&
-			test_submodule_content sub1 origin/modify_sub1 &&
-			git -C sub1 rev-parse keep_branch >actual &&
-			test_cmp expect actual &&
-			test_must_fail git -C sub1 symbolic-ref HEAD
-		)
-	'
 
 	# Replacing a tracked file with a submodule produces a checked out submodule
 	test_expect_success "$command: replace tracked file with submodule checks out submodule" '
@@ -789,6 +773,23 @@ test_submodule_recursing_with_args_common() {
 			test_submodule_content sub1 origin/add_sub1
 		)
 	'
+	# Updating a submodule does not touch the currently checked out branch in the submodule
+	test_expect_success "$command: submodule branch is not changed, detach HEAD instead" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git -C sub1 checkout -b keep_branch &&
+			git -C sub1 rev-parse HEAD >expect &&
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			$command modify_sub1 &&
+			test_superproject_content origin/modify_sub1 &&
+			test_submodule_content sub1 origin/modify_sub1 &&
+			git -C sub1 rev-parse keep_branch >actual &&
+			test_cmp expect actual &&
+			test_must_fail git -C sub1 symbolic-ref HEAD
+		)
+	'
 }
 
 # Declares and invokes several tests that, in various situations, checks that
-- 
gitgitgadget

