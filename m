Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBD2C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B54196115C
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhJDBOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 21:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbhJDBN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 21:13:56 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26999C061781
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 18:12:08 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m42so1609968wms.2
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 18:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QO4N3KhiEHtNiCLFo3m/eIQ8nenzEe7XaPfIPeL5Emw=;
        b=WL8A7ehIuwoEMGOPBYAlwEiSdphKW8IIhEjNZHVVjJ1Pbv/KfJHiWncwszYjCdZWo3
         zPmdovbMWYo3CJwzA4H+gs0nVh9K7rA4ttaLhE876TAVOUkKDr+2h4hqrW32fuiCGIdd
         Sy1H1D84Qo9+Cc+Q9whUVFfWAgHJ9MdGJQ0aXlD++soK/F3C6rZCYiSttlZg6GbgHO4f
         SSPrmQ36EQ3vnSJqCZYoujQ8aeJPuY7D1RjCbqSk2EzpK2JB3GpGo2gFmP5+DQk6FcjE
         IxLp0VhvGayM9hgbc7z9vdB0vg5obylDfJrKbJOH4DaeC1xy3u5wuJVEOqO/tDTqD3MA
         nivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QO4N3KhiEHtNiCLFo3m/eIQ8nenzEe7XaPfIPeL5Emw=;
        b=pOQMem6erIeO+GE+zlGeJPfwIcmpsHAkXnR7duk6rtjE/7vuVpuaebiOyQJOWJNKrB
         2FfabIfEDAbO9n9Ur4cqPHtIElil35hMwVOFXO/f/NkrdQWyD/knIX5JE8u7/VTBUsvw
         XkFPGmjE/BY2c+iku78qAyCb/5y7LYUua/WwBfu5pWp3kcWip8kTvDDSlk0YdFefo3QZ
         pfu6qKHwUixlK2B+4Ea1l1Qcj81KWxkDc4Yvi8g8KQI3cBRP7tuip4kFLW9pIp16Ma9W
         ptQGbUbQzSrZ2uPaa8NDO/OfROgpyxaBr4F7WLJAWFJcrFYk4mDPgxwI7r/Sitv0l/qe
         W2Bg==
X-Gm-Message-State: AOAM533G50VK62vA+u/Y11dCEeDLAnTkm0NXROX14vODTyRjpinjOeTB
        w+eiGDsDwmna5cvt0mEhfwrjycj8nHn1eA==
X-Google-Smtp-Source: ABdhPJy0oy2uAq9dsM+unD9fEALfATETHPcUy/t9T5EiDSd+haB0SRjnAXawFf5bAn4zd903Ke4t7Q==
X-Received: by 2002:a05:600c:210f:: with SMTP id u15mr8134515wml.157.1633309926442;
        Sun, 03 Oct 2021 18:12:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q3sm12384317wmc.25.2021.10.03.18.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:12:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v4 05/10] Remove ignored files by default when they are in the way
Date:   Mon,  4 Oct 2021 03:11:54 +0200
Message-Id: <RFC-patch-v4-05.10-27496506430-20211004T004902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g83021034c5d
In-Reply-To: <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
References: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com> <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Change several commands to remove ignored files by default when they are
in the way.  Since some commands (checkout, merge) take a
--no-overwrite-ignore option to allow the user to configure this, and it
may make sense to add that option to more commands (and in the case of
merge, actually plumb that configuration option through to more of the
backends than just the fast-forwarding special case), add little
comments about where such flags would be used.

Incidentally, this fixes a test failure in t7112.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c               | 3 +--
 builtin/clone.c            | 3 +--
 builtin/merge.c            | 3 +--
 builtin/reset.c            | 3 +--
 builtin/stash.c            | 3 +--
 merge-ort.c                | 2 +-
 reset.c                    | 3 +--
 sequencer.c                | 3 +--
 t/t7112-reset-submodule.sh | 1 -
 9 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 3c6efe2a46b..8cb7e72e6c5 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1919,8 +1919,7 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 	opts.merge = 1;
 	opts.reset = reset;
 	if (!reset)
-		/* FIXME: Default should be to remove ignored files */
-		opts.preserve_ignored = 1;
+		opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	opts.fn = twoway_merge;
 	init_tree_desc(&t[0], head->buffer, head->size);
 	init_tree_desc(&t[1], remote->buffer, remote->size);
diff --git a/builtin/clone.c b/builtin/clone.c
index e76c38e4e81..49edb4a2aaa 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -686,8 +686,7 @@ static int checkout(int submodule_progress)
 	opts.update = 1;
 	opts.merge = 1;
 	opts.clone = 1;
-	/* FIXME: Default should be to remove ignored files */
-	opts.preserve_ignored = 1;
+	opts.preserve_ignored = 0;
 	opts.fn = oneway_merge;
 	opts.verbose_update = (option_verbosity >= 0);
 	opts.src_index = &the_index;
diff --git a/builtin/merge.c b/builtin/merge.c
index 55aac869e5a..7f990e36651 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -680,8 +680,7 @@ static int read_tree_trivial(struct object_id *common, struct object_id *head,
 	opts.verbose_update = 1;
 	opts.trivial_merges_only = 1;
 	opts.merge = 1;
-	/* FIXME: Default should be to remove ignored files */
-	opts.preserve_ignored = 1;
+	opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	trees[nr_trees] = parse_tree_indirect(common);
 	if (!trees[nr_trees++])
 		return -1;
diff --git a/builtin/reset.c b/builtin/reset.c
index 73477239146..9d1391335a1 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -66,8 +66,7 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 	case KEEP:
 	case MERGE:
 		opts.update = 1;
-		/* FIXME: Default should be to remove ignored files */
-		opts.preserve_ignored = 1;
+		opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 		break;
 	case HARD:
 		opts.update = 1;
diff --git a/builtin/stash.c b/builtin/stash.c
index 78492013529..92ad3241270 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -258,8 +258,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 	opts.reset = reset;
 	opts.update = update;
 	if (update && !reset)
-		/* FIXME: Default should be to remove ignored files */
-		opts.preserve_ignored = 1;
+		opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	opts.fn = oneway_merge;
 
 	if (unpack_trees(nr_trees, t, &opts)) {
diff --git a/merge-ort.c b/merge-ort.c
index e5620bda212..5c443b2b00d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4044,7 +4044,7 @@ static int checkout(struct merge_options *opt,
 	unpack_opts.quiet = 0; /* FIXME: sequencer might want quiet? */
 	unpack_opts.verbose_update = (opt->verbosity > 2);
 	unpack_opts.fn = twoway_merge;
-	unpack_opts.preserve_ignored = 0; /* FIXME: !opts->overwrite_ignore*/
+	unpack_opts.preserve_ignored = 0; /* FIXME: !opts->overwrite_ignore */
 	parse_tree(prev);
 	init_tree_desc(&trees[0], prev->buffer, prev->size);
 	parse_tree(next);
diff --git a/reset.c b/reset.c
index cd344f47f13..5f69311b9f4 100644
--- a/reset.c
+++ b/reset.c
@@ -56,8 +56,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
 	unpack_tree_opts.update = 1;
 	unpack_tree_opts.merge = 1;
-	/* FIXME: Default should be to remove ignored files */
-	unpack_tree_opts.preserve_ignored = 1;
+	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
 	if (!detach_head)
 		unpack_tree_opts.reset = 1;
diff --git a/sequencer.c b/sequencer.c
index 669ea15944c..05395db9e01 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3698,8 +3698,7 @@ static int do_reset(struct repository *r,
 	unpack_tree_opts.fn = oneway_merge;
 	unpack_tree_opts.merge = 1;
 	unpack_tree_opts.update = 1;
-	/* FIXME: Default should be to remove ignored files */
-	unpack_tree_opts.preserve_ignored = 1;
+	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	init_checkout_metadata(&unpack_tree_opts.meta, name, &oid, NULL);
 
 	if (repo_read_index_unmerged(r)) {
diff --git a/t/t7112-reset-submodule.sh b/t/t7112-reset-submodule.sh
index 19830d90365..a3e2413bc33 100755
--- a/t/t7112-reset-submodule.sh
+++ b/t/t7112-reset-submodule.sh
@@ -6,7 +6,6 @@ test_description='reset can handle submodules'
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
-KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
 
 test_submodule_switch_recursing_with_args "reset --keep"
 
-- 
2.33.0.1404.g83021034c5d

