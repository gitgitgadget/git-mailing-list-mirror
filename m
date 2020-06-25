Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CCAC433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 17:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DBFC207E8
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 17:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKdUqec8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406957AbgFYRxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406936AbgFYRxo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 13:53:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485EDC08C5DC
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 10:53:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t194so6859499wmt.4
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 10:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dWGIG3v5b0SDgS7NEtM/beyL6iDFK+K2rNHA/7Btnhk=;
        b=VKdUqec8EbTo33xqE+1VS/rji3IgooIApawrAg1+vHxXZUbALdJOAseHGxi6/xZXaK
         HGPX0kj89PfCKLniTEPrpGr7Ohi4KqJdARGMvIbxgCLIuhx7EAPPPIhFLAGwtTECMv3K
         lgAs4Wj68Vs1qLr/YZmxnfEJNJmp9Z0ZkJwSndxJDaBtJdqCAQZL+JTry+0q4ECD7qW6
         eQJuMZyIBgxlnCcEzKpebfDgtHp5Br/633wwGD38lCxNRCNE8g7C2dDD+dlQxmXXPq/9
         yTHRdNqiq1S4uYoEWcBswMySWzrP46QQu2KDp8dMmEpNyr+mtyRY6FhUDEhBhojQSngH
         AW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dWGIG3v5b0SDgS7NEtM/beyL6iDFK+K2rNHA/7Btnhk=;
        b=WiKNppwX949TQ02CW5M5Q8G2Lhb5zqxlaa2QcnKi6o/hc5YVGnGdAyvHEFpkTG3zRo
         DjlBxkNTd4spQocKMlKeFyUSEFoP9WHXyYxAxSfgnyOqwADX3SQ/dIARCtxviQvCD1wo
         u16JtJEaYGXsnclb9HC0cpYY81rzr2TNIOiwPHtaPdHGWdbW0ttZh9aJzDKDIqBoeFIW
         aM4lgB00Ik34Hii/09WLs3BdEDuhF38aXQprUxjW89Blp2uSLE43KfCaVDhYYTbm2YVb
         Tzdh2sdyHPw+CTq0JvmfPftW0cdu+NcW/iE6inmJ7FOrlJhEUE+TPjBOCaRHhgtHXgBR
         1slQ==
X-Gm-Message-State: AOAM530rJPKB7qTm50PdXgQrvmhrAuOQEgJWC2G2aqxh25qFU1sYmB/B
        u3W8jkSJH2FzrtTM5weW4sMhg+2v
X-Google-Smtp-Source: ABdhPJzOzcdqubdegZLsUngQMxrBSMfnVgd631UFJl9uce7aMoYvF36xHHV9laaOpb79RzEWHIpI2Q==
X-Received: by 2002:a1c:8192:: with SMTP id c140mr4537728wmd.108.1593107622832;
        Thu, 25 Jun 2020 10:53:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 40sm9235698wrc.27.2020.06.25.10.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 10:53:42 -0700 (PDT)
Message-Id: <69256ab9107c3dba0dc007b69cc0ce98a9b91f9a.1593107621.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.654.v4.git.1593107621.gitgitgadget@gmail.com>
References: <pull.654.v3.git.1593010066.gitgitgadget@gmail.com>
        <pull.654.v4.git.1593107621.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Jun 2020 17:53:40 +0000
Subject: [PATCH v4 1/2] diff-files --raw: show correct post-image of
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

This happens for example when showing modified, unstaged files.

For intent-to-add files, we used to show the empty blob's hash instead.
In c26022ea8f5 (diff: convert diff_addremove to struct object_id,
2017-05-30), we made that worse by inadvertently changing that to the
hash of the empty tree.

Let's make the behavior consistent with modified files by showing
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

