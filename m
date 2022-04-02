Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE23EC433EF
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350684AbiDBKx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354567AbiDBKwI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:52:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6BD141D93
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:50:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id k23so7241369ejd.3
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EQ8zO4Ds5+Pm+JZ6ih5V9HSQ2n3TlV5KpNJAgwvgJsQ=;
        b=f5f2gqnlv6US2mWBJdS3hGjr3ODrTDpPTfELH15mHdBk0V6RO1fmr0TWDWw1V0WJ2s
         KFKgGsziyPkCDtmHGi2cv4lojaFxyD7/tl6k8OvfkGywu879kuCS8o12k6XJs0dLxfxF
         JvffQFkOvKpa4QFmPm+haFlpBWQOSq2pQFeh3tpyBPRysSGAUR1QcqTB2n2JqpjdlB+5
         OSIVHToeU2PNCRdSF/TCrgQmHtEGYXHdOqOJIRjusMLyD5V6Zl+6Yjbx/caG8wp4oBy2
         Q5sk4mureNniHNLPuQOdaPUXWQIRlfVKgwzGl2pjs0al1t4WcwN9jgYyZZyaovSI70Si
         VIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EQ8zO4Ds5+Pm+JZ6ih5V9HSQ2n3TlV5KpNJAgwvgJsQ=;
        b=ERRu5x3/JkTQina5lLzvpj3crVCjY2KibfrwvMZ50rdwsz8FjVuW47HUBZ+rsxQIgi
         lmYcVeXmr2FX7L08cexqTyEPy7ALD63Sn+/PaQzPLNRKYwdWudjfkwhmmp/cwOIzV6R+
         9tMvgPCRbbFlcqeF84KgAUqasa71ajf9oM2hpn18G1/1RDSDeP/LPIkmeDFL3t9NJa7c
         KY+aXu4kXjvwTDfb+WFb+D61AaFmpicAlHxaYajvpZ+6wMRJt7sUvFpAGt/oTrUFviEk
         Qu0yf9QUX4SZwWZDV+Y7uz+Rwkbty44sXllfIrhpPiDWdLLtwlKdQ+BEd1n72uwXFCJZ
         7J7g==
X-Gm-Message-State: AOAM5333Rh66Hh2QKbGPd2CF7aXQPg4xxm6rBX5Y3u4pvChs6NuIwuDS
        oyq5T62/LPbYKnoHYqphoPFU8twZl9ONcw==
X-Google-Smtp-Source: ABdhPJxosu1ddFqbY5t/LbpvA4yyGmLGpo0Jt/A8vMDthnp3aucDs+FyDfMj6ddSN3HEKAjopGpU7Q==
X-Received: by 2002:a17:907:1623:b0:6df:c9da:a6a8 with SMTP id hb35-20020a170907162300b006dfc9daa6a8mr3297776ejc.303.1648896605716;
        Sat, 02 Apr 2022 03:50:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:50:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 21/27] revisions API: have release_revisions() release "prune_data"
Date:   Sat,  2 Apr 2022 12:49:35 +0200
Message-Id: <patch-v5-21.27-84c8714571a-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the the release_revisions() function so that it frees the
"prune_data" in the "struct rev_info". This means that any code that
calls "release_revisions()" already can get rid of adjacent calls to
clear_pathspec().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 add-interactive.c | 2 --
 builtin/add.c     | 1 -
 builtin/stash.c   | 2 --
 diff-lib.c        | 1 -
 revision.c        | 1 +
 wt-status.c       | 2 --
 6 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 54cdfc82017..6047e8f6489 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -568,8 +568,6 @@ static int get_modified_files(struct repository *r,
 			run_diff_files(&rev, 0);
 		}
 
-		if (ps)
-			clear_pathspec(&rev.prune_data);
 		release_revisions(&rev);
 	}
 	hashmap_clear_and_free(&s.file_map, struct pathname_entry, ent);
diff --git a/builtin/add.c b/builtin/add.c
index 115a26ea633..fc729e14c17 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -142,7 +142,6 @@ int add_files_to_cache(const char *prefix,
 	rev.diffopt.flags.override_submodule_config = 1;
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
-	clear_pathspec(&rev.prune_data);
 	release_revisions(&rev);
 	return !!data.add_errors;
 }
diff --git a/builtin/stash.c b/builtin/stash.c
index fce4393d123..16aad4b4d35 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1064,7 +1064,6 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 	}
 
 done:
-	clear_pathspec(&rev.prune_data);
 	release_revisions(&rev);
 	return ret;
 }
@@ -1276,7 +1275,6 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 
 done:
 	discard_index(&istate);
-	clear_pathspec(&rev.prune_data);
 	release_revisions(&rev);
 	strbuf_release(&diff_output);
 	remove_path(stash_index_path.buf);
diff --git a/diff-lib.c b/diff-lib.c
index 0f16281253f..298265e5b54 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -641,7 +641,6 @@ int do_diff_cache(const struct object_id *tree_oid, struct diff_options *opt)
 
 	if (diff_cache(&revs, tree_oid, NULL, 1))
 		exit(128);
-	clear_pathspec(&revs.prune_data);
 	release_revisions(&revs);
 	return 0;
 }
diff --git a/revision.c b/revision.c
index 2c23de60093..9fb18924cbf 100644
--- a/revision.c
+++ b/revision.c
@@ -2951,6 +2951,7 @@ void release_revisions(struct rev_info *revs)
 	object_array_clear(&revs->pending);
 	release_revisions_cmdline(&revs->cmdline);
 	list_objects_filter_release(&revs->filter);
+	clear_pathspec(&revs->prune_data);
 	release_revisions_mailmap(revs->mailmap);
 	free_grep_patterns(&revs->grep_filter);
 }
diff --git a/wt-status.c b/wt-status.c
index a14fad1e03a..61e0c1022f5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -616,7 +616,6 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_files(&rev, 0);
-	clear_pathspec(&rev.prune_data);
 	release_revisions(&rev);
 }
 
@@ -664,7 +663,6 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_index(&rev, 1);
 	release_revisions(&rev);
-	clear_pathspec(&rev.prune_data);
 }
 
 static int add_file_to_list(const struct object_id *oid,
-- 
2.35.1.1585.gd85f8dcb745

