Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9A6C433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 13:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbiKSNH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 08:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbiKSNHy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 08:07:54 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9979B8FF8B
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:52 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id l11so10604762edb.4
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdLtHAMPlY1D5GoKUQBaTZvYHsE1AWCSANryp5WaWCc=;
        b=HYpltvmztDRmPw7svRoZmTfsPl0D1FZkIeZcBXuAPnf/R6AaJyROeIL4MJKxirdNr2
         3XDiKuvfHT68m595qniIC+XyeiRHdZ+mZ6hErWY/iwV06sJtChZ+zDjP3LHWJLlPTqGs
         nVeLG0cuC3GCQixp4GXcqm7uAWCGrNnwCOJFGJFHZUp0HtA816ZhxrerU7nyoV8rba7P
         GVQw2V9AD8KI0rUMDybFaPsxZmw67X8G83BIGOjLS8/wU7pEfLLepNuN42YPj/5rHUSW
         cEYjH668uFAAQl/4QvwXgUR0j2vkIGLzpcmdF6Qwl/6g4wsw+rhVx+/myioTTUlQidzY
         zWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdLtHAMPlY1D5GoKUQBaTZvYHsE1AWCSANryp5WaWCc=;
        b=A8nbFi0+sUgMg8Oe6evHjVHfcB97glkZJ0HngWzOwZwJtNSsc8hGRJ5kbiIOk0eUe1
         +AnUh2FfsfCc9eVnULD6Qxw4KnuF6f8yuxzKSyd/mcQ92xzszx97d8RKWNW6QMvzcLPc
         4nOnTwiadlXlSAWASK9cPl1tTJ/GoEvoDxxylH3O7+66v0OXRFgGmg9nCPj3pKV8ZsMN
         0/K80SII9gW4fARDdmudgBXHBxKAVMpjxc4DL/mLs2sk+IdTivqH9hImfelefDhsO95x
         z0AVS7XAvLE05KfozVEYTPdExiQ0lC6hPk/kRg1S2bPOSaND36orOfWcZQxXeHhBRVdq
         sxKQ==
X-Gm-Message-State: ANoB5pndna8NW2jRSj//eG95Z74PU9/aKZf06XCzyTwdMnFQrRceIMqW
        OATnvqqLFbNfReiJ/PdNfQmfXX5VzRmC8w==
X-Google-Smtp-Source: AA0mqf7BnYJQwcVha4zhun/z/lZ2xTHOFXc6Rl/QAfNIPz81ED3SoFvOI5F4d27CNiXJ4+IYzjxZTg==
X-Received: by 2002:a05:6402:3203:b0:467:b8c9:a7fa with SMTP id g3-20020a056402320300b00467b8c9a7famr10003141eda.25.1668863270802;
        Sat, 19 Nov 2022 05:07:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ch28-20020a0564021bdc00b0045d74aa401fsm2923802edb.60.2022.11.19.05.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 05:07:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/11] read-cache API & users: make discard_index() return void
Date:   Sat, 19 Nov 2022 14:07:31 +0100
Message-Id: <patch-v2-04.11-b4d6685585a-20221119T125551Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1509.g9445af83948
In-Reply-To: <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The discard_index() function has not returned non-zero since
7a51ed66f65 (Make on-disk index representation separate from in-core
one, 2008-01-14), but we've had various code in-tree still acting as
though that might be the case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 add-interactive.c |  8 ++++----
 add-patch.c       |  3 ++-
 builtin/merge.c   |  3 ++-
 cache.h           |  2 +-
 read-cache.c      |  4 +---
 sequencer.c       | 15 +++++++++------
 6 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index ecc5ae1b249..ae1839c04a7 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -530,8 +530,8 @@ static int get_modified_files(struct repository *r,
 	struct collection_status s = { 0 };
 	int i;
 
-	if (discard_index(r->index) < 0 ||
-	    repo_read_index_preload(r, ps, 0) < 0)
+	discard_index(r->index);
+	if (repo_read_index_preload(r, ps, 0) < 0)
 		return error(_("could not read index"));
 
 	prefix_item_list_clear(files);
@@ -1156,8 +1156,8 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 		    _("staged"), _("unstaged"), _("path"));
 	opts.list_opts.header = header.buf;
 
-	if (discard_index(r->index) < 0 ||
-	    repo_read_index(r) < 0 ||
+	discard_index(r->index);
+	if (repo_read_index(r) < 0 ||
 	    repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 1,
 					 NULL, NULL, NULL) < 0)
 		warning(_("could not refresh index"));
diff --git a/add-patch.c b/add-patch.c
index 33ecd8398a1..a86a92e1646 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1750,7 +1750,8 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 		s.mode = &patch_mode_add;
 	s.revision = revision;
 
-	if (discard_index(r->index) < 0 || repo_read_index(r) < 0 ||
+	discard_index(r->index);
+	if (repo_read_index(r) < 0 ||
 	    (!s.mode->index_only &&
 	     repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 1,
 					  NULL, NULL, NULL) < 0) ||
diff --git a/builtin/merge.c b/builtin/merge.c
index da11dfae19e..89fdac24e40 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -390,7 +390,8 @@ static void restore_state(const struct object_id *head,
 	run_command(&cmd);
 
 refresh_cache:
-	if (discard_cache() < 0 || read_cache() < 0)
+	discard_cache();
+	if (read_cache() < 0)
 		die(_("could not read index"));
 }
 
diff --git a/cache.h b/cache.h
index 53dc4341717..489e9e1925b 100644
--- a/cache.h
+++ b/cache.h
@@ -774,7 +774,7 @@ void ensure_full_index(struct index_state *istate);
  */
 int write_locked_index(struct index_state *, struct lock_file *lock, unsigned flags);
 
-int discard_index(struct index_state *);
+void discard_index(struct index_state *);
 void move_index_extensions(struct index_state *dst, struct index_state *src);
 int unmerged_index(const struct index_state *);
 
diff --git a/read-cache.c b/read-cache.c
index 32024029274..46f5e497b14 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2531,7 +2531,7 @@ int is_index_unborn(struct index_state *istate)
 	return (!istate->cache_nr && !istate->timestamp.sec);
 }
 
-int discard_index(struct index_state *istate)
+void discard_index(struct index_state *istate)
 {
 	/*
 	 * Cache entries in istate->cache[] should have been allocated
@@ -2562,8 +2562,6 @@ int discard_index(struct index_state *istate)
 		mem_pool_discard(istate->ce_mem_pool, should_validate_cache_entries());
 		FREE_AND_NULL(istate->ce_mem_pool);
 	}
-
-	return 0;
 }
 
 /*
diff --git a/sequencer.c b/sequencer.c
index a46f3ad2e33..746a71cdc92 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3564,7 +3564,8 @@ static int do_exec(struct repository *r, const char *command_line)
 	status = run_command(&cmd);
 
 	/* force re-reading of the cache */
-	if (discard_index(r->index) < 0 || repo_read_index(r) < 0)
+	discard_index(r->index);
+	if (repo_read_index(r) < 0)
 		return error(_("could not read index"));
 
 	dirty = require_clean_work_tree(r, "rebase", NULL, 1, 1);
@@ -4029,9 +4030,11 @@ static int do_merge(struct repository *r,
 		ret = run_command(&cmd);
 
 		/* force re-reading of the cache */
-		if (!ret && (discard_index(r->index) < 0 ||
-			     repo_read_index(r) < 0))
-			ret = error(_("could not read index"));
+		if (!ret) {
+			discard_index(r->index);
+			if (repo_read_index(r) < 0)
+				ret = error(_("could not read index"));
+		}
 		goto leave_merge;
 	}
 
@@ -4404,8 +4407,8 @@ void create_autostash(struct repository *r, const char *path)
 		printf(_("Created autostash: %s\n"), buf.buf);
 		if (reset_head(r, &ropts) < 0)
 			die(_("could not reset --hard"));
-		if (discard_index(r->index) < 0 ||
-			repo_read_index(r) < 0)
+		discard_index(r->index);
+		if (repo_read_index(r) < 0)
 			die(_("could not read index"));
 	}
 	strbuf_release(&buf);
-- 
2.38.0.1509.g9445af83948

