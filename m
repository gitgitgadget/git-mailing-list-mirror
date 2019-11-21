Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B02C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10CD2068E
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uDm4oAor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKUWFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:05:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40714 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfKUWFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:05:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id y5so5444025wmi.5
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EX5YDmS2oMRkwwKDr9GF8nMuKZ8EWcHKff5rZlGTEzI=;
        b=uDm4oAorcreqhBKRhMdEToobSfwHECmXEwwk74jI/2Tb/qChWGidoRsT3ElKrd+v3G
         SFpVwa/uGX2DIyVS3j1MdTSqAxw29IEdBShJWxQaP4WvkFDzY2MhQd4g7aj7bX5HBEmR
         YBgbsrOBlc1/3VMp3q6Iq1MMKNEl0M4/UlBie1Ax5xf7oWehac5Ntgy7aOEj9Qq0+Mqm
         ksbCZgSRHsT4x73wqja36PrZnmDb0g35IRypraTV5Mv3pNQbawLHRewQ3qTKQfRmkwDy
         kiW0FqF6kOqZihprSn3EYw8JO+xv+vb1YoFlikofkw2EDJVMN0S3bcI71JrsumRFn/jV
         ZSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EX5YDmS2oMRkwwKDr9GF8nMuKZ8EWcHKff5rZlGTEzI=;
        b=o8kIB9YezxZ7GqDeD/6UZe/QVr94h1Q7ePZ5PUZpjOxtoQwN3srpm0drf2TvrvClut
         ABPu9RkWQf2jwk2Dm+dz4kqx8PGkMhzQEwsbTnDqK2UljIcc+tNR7DR2zEGBVNPCU7yC
         kZ1pgR5u8jJ0XaFeJLYYTiL2RhPR2s51rSiZyXYmBcEfvpQHlUCChC464qOFbADRJt/Q
         xpJE/K3N6iKpPT4JnyUshe4DDspKqwKK4bHkMLOVwDTrPxOXYXqEi5x5F2fj9SO5sIwK
         jVLHgJG7qKGDRfOzf7DhWU1DF73Rykx98J6puQOFUaOXm5NdLI1D/JMvdApSAvd6YTl+
         nNEA==
X-Gm-Message-State: APjAAAXp/ly9gvfYGe4BgmDAbfHU+QTVQ2cqxueeZTTAk3rx+HZ2M7Us
        6irtLx/qr1TS8cZ3l8so/cpd6bVJ
X-Google-Smtp-Source: APXvYqwGW1CNs4JaVCn6uAO35nTuT1+MmBr+YND5IKUKFW6d2TCXwODI0Ho9UziTTXU3axoWbBLhfQ==
X-Received: by 2002:a05:600c:21c9:: with SMTP id x9mr12746549wmj.54.1574373914537;
        Thu, 21 Nov 2019 14:05:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t185sm1171896wmf.45.2019.11.21.14.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:05:14 -0800 (PST)
Message-Id: <a0dca0056a0a20b5cf50e1af90c4c124ac7c9560.1574373892.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
References: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
        <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:04:48 +0000
Subject: [PATCH v6 16/19] sparse-checkout: write using lockfile
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If two 'git sparse-checkout set' subcommands are launched at the
same time, the behavior can be unexpected as they compete to write
the sparse-checkout file and update the working directory.

Take a lockfile around the writes to the sparse-checkout file. In
addition, acquire this lock around the working directory update
to avoid two commands updating the working directory in different
ways.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 15 +++++++++++----
 t/t1091-sparse-checkout-builtin.sh |  7 +++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index a11ea65599..9a620ff014 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -170,25 +170,32 @@ static int write_patterns_and_update(struct pattern_list *pl)
 {
 	char *sparse_filename;
 	FILE *fp;
+	int fd;
+	struct lock_file lk = LOCK_INIT;
 	int result;
 
-	result = update_working_directory(pl);
+	sparse_filename = get_sparse_checkout_filename();
+	fd = hold_lock_file_for_update(&lk, sparse_filename,
+				      LOCK_DIE_ON_ERROR);
 
+	result = update_working_directory(pl);
 	if (result) {
+		rollback_lock_file(&lk);
+		free(sparse_filename);
 		clear_pattern_list(pl);
 		update_working_directory(NULL);
 		return result;
 	}
 
-	sparse_filename = get_sparse_checkout_filename();
-	fp = fopen(sparse_filename, "w");
+	fp = xfdopen(fd, "w");
 
 	if (core_sparse_checkout_cone)
 		write_cone_to_file(fp, pl);
 	else
 		write_patterns_to_file(fp, pl);
 
-	fclose(fp);
+	fflush(fp);
+	commit_lock_file(&lk);
 
 	free(sparse_filename);
 	clear_pattern_list(pl);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index b8f18e2a09..f074b7f3be 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -277,4 +277,11 @@ test_expect_success 'revert to old sparse-checkout on empty update' '
 	)
 '
 
+test_expect_success 'fail when lock is taken' '
+	test_when_finished rm -rf repo/.git/info/sparse-checkout.lock &&
+	touch repo/.git/info/sparse-checkout.lock &&
+	test_must_fail git -C repo sparse-checkout set deep 2>err &&
+	test_i18ngrep "File exists" err
+'
+
 test_done
-- 
gitgitgadget

