Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEE3C4332F
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9796361132
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346983AbhIHBpC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 21:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346899AbhIHBo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 21:44:57 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818F1C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 18:43:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b6so713325wrh.10
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 18:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BaX/CWU9N3jqABC+OWfBVOROIH/P8jSVAopIgXDvppU=;
        b=g9QN0hnQSrHnRRhKrS7/jgozjEG4hDzA1XD2XB2hk9OdwHkUsncqSirx7OyovfzSgP
         KbHStWlsDeCCDI31v+ZannnNJMuUmjWmnMTZSgSpKCvgzF6ty0rUNbfDFCGKjtGxJiNj
         1vdg9E5891xtWapEkd0P7LRNQKylTctRAuFTcLVHec3vSwzGmphar2sdheXwOosGth9w
         QAs+8Apzg2GH164CZs+X8Tg4Htd/Tsoxbs2DqvnH55R/haDEkRIyqhg25OBiIqEsCSyr
         +Us9zN0MoLExMw9T8yEx/pUKPt+X7uP37F8VTtJ8hs48L4n789Envvh711xqNaYuyEM8
         GzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BaX/CWU9N3jqABC+OWfBVOROIH/P8jSVAopIgXDvppU=;
        b=zj/Uy5C+wQNJZ+4HVm7GhC+b4CgIomovkWqMQa6jG75qLEQcInjO2K9wd8OvQ8rqhh
         gps8eJS7C1JwA/z6y3A1f5ahxfQ7TvnZM2yH3tPoJ+ibTiOdtNWoevC7m8EwdxIDkyaR
         Y8BVSEhvCsAfDMXVS/vJ2OUAA22efWoK8bjQew7EOD5qO97AhyD8+wbJNEFmTtFMo422
         6w8B0qOwmHPc1Zq+rbvmfGCuw93IC7APhyBGWUMttf526L+sAu+LsvB1j+nCVm6Xpy1A
         1p2yYlG6Me1bTGZq1F9JzJ0a+p1ou+lQBVMT4nAgmloo8zFinYKTlG1KpfgrL1rEWkTC
         hj7Q==
X-Gm-Message-State: AOAM5302DpsXu3RK3IkOV/g3msH1QlWi9p/ONXzo3NvvGxHHRWmupOKN
        aK5+Sx65w3aVuCy/0ILg3vyxv+dmaIo=
X-Google-Smtp-Source: ABdhPJxCaT5VSFwjVcxXzjcxghsvnpyuHzY9Zc/W8uwRGHmMM5bHV4LrPeceQjLBulLnmeR9p9HCBA==
X-Received: by 2002:a05:6000:374:: with SMTP id f20mr1103855wrf.129.1631065429142;
        Tue, 07 Sep 2021 18:43:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k14sm571210wri.46.2021.09.07.18.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 18:43:48 -0700 (PDT)
Message-Id: <ac8ca07481d2ed4156036c2441d10712a1b92b0e.1631065427.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1086.git.git.1631065426.gitgitgadget@gmail.com>
References: <pull.1086.git.git.1631065426.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 01:43:46 +0000
Subject: [PATCH 3/3] stash: restore untracked files AFTER restoring tracked
 files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

If a user deletes a file and places a directory of untracked files
there, then stashes all these changes, the untracked directory of files
cannot be restored until after the corresponding file in the way is
removed.  So, restore changes to tracked files before restoring
untracked files.

There is no similar problem to worry about in the opposite directory,
because untracked files are always additive.  Said another way, there's
no way to "stash a removal of an untracked file" because if an untracked
file is removed, git simply doesn't know about it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/stash.c  | 6 +++---
 t/t3903-stash.sh | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index b85cf9d267e..9a1f6a5a854 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -530,9 +530,6 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		}
 	}
 
-	if (info->has_u && restore_untracked(&info->u_tree))
-		return error(_("could not restore untracked files from stash"));
-
 	init_merge_options(&o, the_repository);
 
 	o.branch1 = "Updated upstream";
@@ -567,6 +564,9 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		unstage_changes_unless_new(&c_tree);
 	}
 
+	if (info->has_u && restore_untracked(&info->u_tree))
+		return error(_("could not restore untracked files from stash"));
+
 	if (!quiet) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index fc74918ccc0..bfd3158a502 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1325,7 +1325,7 @@ test_expect_success 'git stash succeeds despite directory/file change' '
 	)
 '
 
-test_expect_failure 'git stash can pop directory/file saved changes' '
+test_expect_success 'git stash can pop directory/file saved changes' '
 	test_create_repo directory_file_switch_v2 &&
 	(
 		cd directory_file_switch_v2 &&
-- 
gitgitgadget
