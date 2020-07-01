Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332BDC433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 21:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E21A207CD
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 21:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntLaz235"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgGAVTM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgGAVTL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 17:19:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87332C08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 14:19:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l2so23581690wmf.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 14:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iXEFssLPF3N2PO6fm0qRhM3QJ9o6Zg4A4QMSRviZytE=;
        b=ntLaz235VfOevVhQKGyf3BiKpZoqX1OBV8og0OfR9UyG8LzsV1PWkJWUYoe30FTiWx
         BLZI4GaspNZt06A9PahBXASMsnO6h3cThE4PivxY8/LsVWzsuUUju+SMEWDUeGJuXrHs
         /73LZxUGZkW/2OUQuaX0hvBHxRkyiDlHoFDKr/ptgguWaL/B+7gxqFy+Rgd+1B7APVmG
         n5oMXOSuiENEo+CCq9M7LrJDDxt8j1kc5OkoZpzyvMys6hdy/JjI3TxqTYnRmKWIyo22
         ile4yTdYC/OLKj3YUX/OfSjC/UP9inX/TlW1IZnISFq1tFcgQ5HbpXvHqCCmSew1H4jH
         5LJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iXEFssLPF3N2PO6fm0qRhM3QJ9o6Zg4A4QMSRviZytE=;
        b=PpXiPUVcoB083mOrYMp5e7OCSyJH159GQ972Cg4F2Af5zIPKoWovsGTx14Syqy24wu
         /E0O9clJqD5d13ce2ptBrfU57JGX8nWe8F/9ikLkcNGqf7s+gtk3rz6icfhMzAJ5GgJe
         vjgQxlQnz7WYeIa62t7fWp7pkvjwuqXOuxdFY8HC8Hm6mx4MP+MpkQV2wBzB++3SNhMs
         9iuO+qzFv+UGsAgCM97WmzJWIK0ahMF1GMtoi1Yf8Vhd7tDoK4tDR4OKClwLWD2Apg06
         zbp5/fxd/cdqXdnEAGq51r+SPiHhmMfnQXURwd/mLhOG8z0Jb8mgNOp1TDh2qhrzv7dt
         VbxA==
X-Gm-Message-State: AOAM532HT3NOhBZsTnXQCFON+rrcpDJnzFyPd7AG1ymLxD4Np2cDPRIP
        WCxbZzQsaRtc196mnI8BMEbEtst4
X-Google-Smtp-Source: ABdhPJxxjo+xybUgF/KB95M9E6H8VSNKkOICv0iBqRKXMgQlBdmadRB+K2TU5eim/h1yq2Xt9PfTfw==
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr28379502wme.160.1593638350082;
        Wed, 01 Jul 2020 14:19:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 65sm9067528wre.6.2020.07.01.14.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 14:19:09 -0700 (PDT)
Message-Id: <4392ae4be6ff4f1baad4bba7d166a0aaf634ca6e.1593638347.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.654.v5.git.1593638347.gitgitgadget@gmail.com>
References: <pull.654.v4.git.1593107621.gitgitgadget@gmail.com>
        <pull.654.v5.git.1593638347.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Jul 2020 21:19:06 +0000
Subject: [PATCH v5 1/2] diff-files --raw: show correct post-image of
 intent-to-add files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The documented behavior of `git diff-files --raw` is to display

	[...] 0{40} if creation, unmerged or "look at work tree".

on the right hand (i.e. postimage) side. This happens for files that
have unstaged modifications, and for files that are unmodified but
stat-dirty.

For intent-to-add files, we used to show the empty blob's hash instead.
In c26022ea8f5 (diff: convert diff_addremove to struct object_id,
2017-05-30), we made that worse by inadvertently changing that to the
hash of the empty tree.

Let's make the behavior consistent with files that have unstaged
modifications (which applies to intent-to-add files, too) by showing
all-zero values also for intent-to-add files.

Accordingly, this patch adjusts the expectations set by the regression
test introduced in feea6946a5b (diff-files: treat "i-t-a" files as
"not-in-index", 2020-06-20).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff-lib.c            | 3 +--
 t/t2203-add-intent.sh | 5 ++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 61812f48c2..25fd2dee19 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -220,8 +220,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			} else if (revs->diffopt.ita_invisible_in_index &&
 				   ce_intent_to_add(ce)) {
 				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
-					       the_hash_algo->empty_tree, 0,
-					       ce->name, 0);
+					       &null_oid, 0, ce->name, 0);
 				continue;
 			}
 
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 8a5d55054f..cf0175ad6e 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -240,7 +240,6 @@ test_expect_success 'i-t-a files shown as new for "diff", "diff-files"; not-new
 
 	hash_e=$(git hash-object empty) &&
 	hash_n=$(git hash-object not-empty) &&
-	hash_t=$(git hash-object -t tree /dev/null) &&
 
 	cat >expect.diff_p <<-EOF &&
 	diff --git a/empty b/empty
@@ -259,8 +258,8 @@ test_expect_success 'i-t-a files shown as new for "diff", "diff-files"; not-new
 	 create mode 100644 not-empty
 	EOF
 	cat >expect.diff_a <<-EOF &&
-	:000000 100644 0000000 $(git rev-parse --short $hash_t) A$(printf "\t")empty
-	:000000 100644 0000000 $(git rev-parse --short $hash_t) A$(printf "\t")not-empty
+	:000000 100644 0000000 0000000 A$(printf "\t")empty
+	:000000 100644 0000000 0000000 A$(printf "\t")not-empty
 	EOF
 
 	git add -N empty not-empty &&
-- 
gitgitgadget

