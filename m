Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE71C4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241436AbiKRLb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240866AbiKRLbO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:31:14 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47C674CED
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:31:13 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id m22so12248351eji.10
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GanvJAzy7D31oJ3Vkczm4t3gtImZ9ZRprQkzz4sumFs=;
        b=Pm0SBkMpHCi31sBn8F4B0BdStXizKIst86asC1bciorCizvul/8m05mAeMef80dU6w
         wzBOX2Wzwf22RSFhYSXn0eMjI2jsDicvSLd2P3X6Zjnl1t5tQx+z/mHoec7yptR6tUq/
         TVtWZ6eBg8h8u92fn8B6WymMBvb6nVY7b9O3sEm2CAfzU5JuKzy5jbH/Mrh0TQ3rIPVR
         VIur2tP0Wa87KY+E7vf4eYxsAMyA26IQ4iqnqBHpkG35vyX+u6cNTx8c6lyKwGOlqGfC
         Mlj9ussqDu9iyngNMVQm34dnYKcZp8+f7DME95eoLcjbohU31yPL05Ut/zu9TgGyQR6W
         pzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GanvJAzy7D31oJ3Vkczm4t3gtImZ9ZRprQkzz4sumFs=;
        b=g2UTxIrJJjENEVQZSMEMpj8bn8YLYbmvlcMAb7ZX4lONxAHrG7LFf6boTNuc+ePGwy
         vFkgj5RvuOhIGHc0ndjU5VDvbN+FkMiuAxylSBVNTtFvL2zgPy8wW0EW4LWTnKMbfsF4
         fToztP5lrC5PahMLyaYIeACivR8cwF7AtyyRSCeh/kZU9o7C5qhEVHadEA8svYoudEZg
         ML1b9DZUDOU7jpMjHxQDwrZafeCFu0Dvce6iBJOMb2St7nQEE1gXCLACZGhyGiKYrPJ0
         oWT4o5iPCPbqjUZOMJNlFaEMw4FRKyTJBJCMZQH9UBe0+xx+1r8VNJic9p/Ej2bWj1TO
         vygw==
X-Gm-Message-State: ANoB5pldsXrY/DZRWtE+Bx+CGjF//UENBXAIPkkjd/+VL4bv2FRIcQfJ
        TlGfJPuT2lIWlQ5NJu/W1/djXK1Rj3JJmQ==
X-Google-Smtp-Source: AA0mqf5x2v2eJL0a55UR2CMPCixBjyXJqVbq4eelzjqy87EFfbHDnjQykfxo8W9CkTgifb0LDf0znA==
X-Received: by 2002:a17:906:c7d1:b0:7ae:fdcd:8198 with SMTP id dc17-20020a170906c7d100b007aefdcd8198mr5769955ejb.475.1668771071926;
        Fri, 18 Nov 2022 03:31:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id cw24-20020a056402229800b0046730154ccbsm1713302edb.42.2022.11.18.03.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:31:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/12] read-cache API & users: make discard_index() return void
Date:   Fri, 18 Nov 2022 12:30:58 +0100
Message-Id: <patch-04.12-362a14a0539-20221118T112205Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
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
index f0f1af4d478..58ad2a77565 100644
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
@@ -4028,9 +4029,11 @@ static int do_merge(struct repository *r,
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
 
@@ -4400,8 +4403,8 @@ void create_autostash(struct repository *r, const char *path)
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
2.38.0.1511.gcdcff1f1dc2

