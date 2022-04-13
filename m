Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A62C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbiDMUEx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238559AbiDMUEc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:04:32 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC537B10B
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:09 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id q20so1772473wmq.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3bk8aBYDP4VTS6k3L85acd37blowp/4B/W+POriaOzc=;
        b=i5DA/EbEu4QY90bGXS5G4+JmugebV8Tk5T7AYizCU7lXgDKFxKOtDQ7YA8A6tJXh8U
         KJXBBzqllywO76I/2KS8cpVFDq+aITYcB7VU/Uxtcspz9Fg1S3VCUh/7wiLSDRin/3wP
         AyrCRkHuA9LYU8uD+5+YALEiRIfwApA5O7e+ZFOW4GGWDjxpQqoc5rP4Ov2lDOAHO8Rm
         vNfj87OW4qNxN9Wxd+jmMPL0x/mc5yHS5zc892aZXetwoz2NNwBTUtkp6TIMKedv6Acg
         5y0j7KRokiIWz/nrPxWUfOHNFWsohFK71AqWqSqAxqTA2uYwIkRoJYfVDp1vW0GrehX6
         32cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3bk8aBYDP4VTS6k3L85acd37blowp/4B/W+POriaOzc=;
        b=Bm77fb7hlEI2+eMX2+x0Bfb2TNID/aC5+qdnFGDsHPuupHz/NBzh5gA0Wv3B75FBc7
         419/vJyNKZc5DrQn6lEsXdWRuOtIY27eKBNHHAkeY0B3XNz8pwd683zSflUolGtoWY9D
         Z5TNtCoitcKljnQ9UfQowid+24lw8xmrFIHCtODSNfYMcr5V33oKNZd5RcTkmTK83miu
         HzSmuWuUspKrgWEVkgDOXNdn+SX1vLbAGX2rAWhkay0A8sIknSbELREcJ24UXpaUub6+
         uoOz3soGlW7m4Q4RmO+y/EorPwQB8qcZ+QPasCOTz6XeRmJvqVDlmvNhk3ahEq4XRumy
         xq0g==
X-Gm-Message-State: AOAM531mGf2yjXMCexCEhP2coHC0QEteQU5bksAZ+uzn8nPIKoobYlDK
        vcqCD8RpF2y/2YxuleiLHkJPOEwyRBNooA==
X-Google-Smtp-Source: ABdhPJz2FImLe2dxH4qYB2N37rBRNcxKymt+2GyOSnomvx6+8++xuecYiWQVFyBO0xSIPxhFXy+H7Q==
X-Received: by 2002:a05:600c:3548:b0:38f:20d9:4f03 with SMTP id i8-20020a05600c354800b0038f20d94f03mr286096wmq.189.1649880127458;
        Wed, 13 Apr 2022 13:02:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm35220498wri.48.2022.04.13.13.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:02:06 -0700 (PDT)
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
Subject: [PATCH v6 07/27] revisions API users: add straightforward release_revisions()
Date:   Wed, 13 Apr 2022 22:01:36 +0200
Message-Id: <patch-v6-07.27-31c8eccf68e-20220413T195935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com> <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a release_revisions() to various users of "struct rev_list" in
those straightforward cases where we only need to add the
release_revisions() call to the end of a block, and don't need to
e.g. refactor anything to use a "goto cleanup" pattern.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 add-interactive.c                | 1 +
 bisect.c                         | 2 ++
 builtin/add.c                    | 1 +
 builtin/am.c                     | 3 +++
 builtin/bisect--helper.c         | 2 ++
 builtin/blame.c                  | 1 +
 builtin/checkout.c               | 1 +
 builtin/commit.c                 | 1 +
 builtin/describe.c               | 2 ++
 builtin/fast-export.c            | 1 +
 builtin/merge.c                  | 2 ++
 builtin/pack-objects.c           | 2 ++
 builtin/prune.c                  | 1 +
 builtin/reflog.c                 | 1 +
 builtin/shortlog.c               | 2 ++
 builtin/submodule--helper.c      | 1 +
 fmt-merge-msg.c                  | 1 +
 merge-ort.c                      | 1 +
 merge-recursive.c                | 1 +
 midx.c                           | 1 +
 pack-bitmap-write.c              | 1 +
 ref-filter.c                     | 1 +
 remote.c                         | 1 +
 sequencer.c                      | 3 +++
 shallow.c                        | 1 +
 submodule.c                      | 2 ++
 t/helper/test-revision-walking.c | 1 +
 wt-status.c                      | 1 +
 28 files changed, 39 insertions(+)

diff --git a/add-interactive.c b/add-interactive.c
index 72472103017..54cdfc82017 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -570,6 +570,7 @@ static int get_modified_files(struct repository *r,
 
 		if (ps)
 			clear_pathspec(&rev.prune_data);
+		release_revisions(&rev);
 	}
 	hashmap_clear_and_free(&s.file_map, struct pathname_entry, ent);
 	if (unmerged_count)
diff --git a/bisect.c b/bisect.c
index 9e6a2b7f201..cc6b8b6230d 100644
--- a/bisect.c
+++ b/bisect.c
@@ -884,6 +884,7 @@ static int check_ancestors(struct repository *r, int rev_nr,
 	/* Clean up objects used, as they will be reused. */
 	clear_commit_marks_many(rev_nr, rev, ALL_REV_FLAGS);
 
+	release_revisions(&revs);
 	return res;
 }
 
@@ -964,6 +965,7 @@ static void show_diff_tree(struct repository *r,
 
 	setup_revisions(ARRAY_SIZE(argv) - 1, argv, &opt, NULL);
 	log_tree_commit(&opt, commit);
+	release_revisions(&opt);
 }
 
 /*
diff --git a/builtin/add.c b/builtin/add.c
index 3ffb86a4338..f507d2191cd 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -340,6 +340,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 
 	unlink(file);
 	free(file);
+	release_revisions(&rev);
 	return 0;
 }
 
diff --git a/builtin/am.c b/builtin/am.c
index 0f4111bafa0..93bec62afa9 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1397,6 +1397,7 @@ static void write_commit_patch(const struct am_state *state, struct commit *comm
 	add_pending_object(&rev_info, &commit->object, "");
 	diff_setup_done(&rev_info.diffopt);
 	log_tree_commit(&rev_info, commit);
+	release_revisions(&rev_info);
 }
 
 /**
@@ -1429,6 +1430,7 @@ static void write_index_patch(const struct am_state *state)
 	add_pending_object(&rev_info, &tree->object, "");
 	diff_setup_done(&rev_info.diffopt);
 	run_diff_index(&rev_info, 1);
+	release_revisions(&rev_info);
 }
 
 /**
@@ -1582,6 +1584,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		add_pending_oid(&rev_info, "HEAD", &our_tree, 0);
 		diff_setup_done(&rev_info.diffopt);
 		run_diff_index(&rev_info, 1);
+		release_revisions(&rev_info);
 	}
 
 	if (run_apply(state, index_path))
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8b2b259ff0d..e4d7b6779ae 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -555,6 +555,7 @@ static int bisect_skipped_commits(struct bisect_terms *terms)
 	reset_revision_walk();
 
 	strbuf_release(&commit_name);
+	release_revisions(&revs);
 	fclose(fp);
 	return 0;
 }
@@ -1041,6 +1042,7 @@ static enum bisect_error bisect_skip(struct bisect_terms *terms, const char **ar
 						oid_to_hex(&commit->object.oid));
 
 			reset_revision_walk();
+			release_revisions(&revs);
 		} else {
 			strvec_push(&argv_state, argv[i]);
 		}
diff --git a/builtin/blame.c b/builtin/blame.c
index 885b381ab83..24bac822c56 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1203,5 +1203,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 cleanup:
 	cleanup_scoreboard(&sb);
+	release_revisions(&revs);
 	return 0;
 }
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4d9e0bd3ac1..7ad4a7113c9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1082,6 +1082,7 @@ static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
 
 	/* Clean up objects used, as they will be reused. */
 	repo_clear_commit_marks(the_repository, ALL_REV_FLAGS);
+	release_revisions(&revs);
 }
 
 static int switch_branches(const struct checkout_opts *opts,
diff --git a/builtin/commit.c b/builtin/commit.c
index 009a1de0a3d..c7eda9bbb72 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1123,6 +1123,7 @@ static const char *find_author_by_nickname(const char *name)
 		strbuf_release(&buf);
 		format_commit_message(commit, "%aN <%aE>", &buf, &ctx);
 		clear_mailmap(&mailmap);
+		release_revisions(&revs);
 		return strbuf_detach(&buf, NULL);
 	}
 	die(_("--author '%s' is not 'Name <email>' and matches no existing author"), name);
diff --git a/builtin/describe.c b/builtin/describe.c
index 42159cd26bd..a76f1a1a7a7 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -517,6 +517,7 @@ static void describe_blob(struct object_id oid, struct strbuf *dst)
 
 	traverse_commit_list(&revs, process_commit, process_object, &pcd);
 	reset_revision_walk();
+	release_revisions(&revs);
 }
 
 static void describe(const char *arg, int last_one)
@@ -667,6 +668,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 				suffix = NULL;
 			else
 				suffix = dirty;
+			release_revisions(&revs);
 		}
 		describe("HEAD", 1);
 	} else if (dirty) {
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index a7d72697fba..f34ae451ee3 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1275,6 +1275,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		printf("done\n");
 
 	refspec_clear(&refspecs);
+	release_revisions(&revs);
 
 	return 0;
 }
diff --git a/builtin/merge.c b/builtin/merge.c
index f178f5a3ee1..d9784d4891c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -443,6 +443,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 	}
 	write_file_buf(git_path_squash_msg(the_repository), out.buf, out.len);
 	strbuf_release(&out);
+	release_revisions(&rev);
 }
 
 static void finish(struct commit *head_commit,
@@ -998,6 +999,7 @@ static int evaluate_result(void)
 	 */
 	cnt += count_unmerged_entries();
 
+	release_revisions(&rev);
 	return cnt;
 }
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 014dcd4bc98..180fff03569 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4177,11 +4177,13 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		read_object_list_from_stdin();
 	} else if (pfd.have_revs) {
 		get_object_list(&pfd.revs, rp.nr, rp.v);
+		release_revisions(&pfd.revs);
 	} else {
 		struct rev_info revs;
 
 		repo_init_revisions(the_repository, &revs, NULL);
 		get_object_list(&revs, rp.nr, rp.v);
+		release_revisions(&revs);
 	}
 	cleanup_preferred_base();
 	if (include_tag && nr_result)
diff --git a/builtin/prune.c b/builtin/prune.c
index c2bcdc07db4..df376b2ed1e 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -196,5 +196,6 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 		prune_shallow(show_only ? PRUNE_SHOW_ONLY : 0);
 	}
 
+	release_revisions(&revs);
 	return 0;
 }
diff --git a/builtin/reflog.c b/builtin/reflog.c
index c943c2aabe6..4dd297dce86 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -293,6 +293,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		if (verbose)
 			printf(_("Marking reachable objects..."));
 		mark_reachable_objects(&revs, 0, 0, NULL);
+		release_revisions(&revs);
 		if (verbose)
 			putchar('\n');
 	}
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index fcde07c9367..35825f075e3 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -422,6 +422,8 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	else
 		get_from_rev(&rev, &log);
 
+	release_revisions(&rev);
+
 	shortlog_output(&log);
 	if (log.file != stdout)
 		fclose(log.file);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2c87ef9364f..5d6b43fe3c0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1269,6 +1269,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 		run_diff_files(&rev, 0);
 	prepare_submodule_summary(info, &list);
 	strvec_clear(&diff_args);
+	release_revisions(&rev);
 	return 0;
 }
 
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index baca57d5b64..f48f44f9cd1 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -699,6 +699,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 			shortlog(origins.items[i].string,
 				 origins.items[i].util,
 				 head, &rev, opts, out);
+		release_revisions(&rev);
 	}
 
 	strbuf_complete_line(out);
diff --git a/merge-ort.c b/merge-ort.c
index 8545354dafd..4c0d4eba19b 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1594,6 +1594,7 @@ static int find_first_merges(struct repository *repo,
 	}
 
 	object_array_clear(&merges);
+	release_revisions(&revs);
 	return result->nr;
 }
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 32bbba5fbb1..acd13b2b069 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1160,6 +1160,7 @@ static int find_first_merges(struct repository *repo,
 	}
 
 	object_array_clear(&merges);
+	release_revisions(&revs);
 	return result->nr;
 }
 
diff --git a/midx.c b/midx.c
index 107365d2114..d5724df7d60 100644
--- a/midx.c
+++ b/midx.c
@@ -1061,6 +1061,7 @@ static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
 	if (indexed_commits_nr_p)
 		*indexed_commits_nr_p = cb.commits_nr;
 
+	release_revisions(&revs);
 	return cb.commits;
 }
 
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index cf681547f2e..c43375bd344 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -326,6 +326,7 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 	trace2_data_intmax("pack-bitmap-write", the_repository,
 			   "num_maximal_commits", num_maximal);
 
+	release_revisions(&revs);
 	free_commit_list(reusable);
 }
 
diff --git a/ref-filter.c b/ref-filter.c
index 7838bd22b8d..a91688bbf17 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2392,6 +2392,7 @@ static void reach_filter(struct ref_array *array,
 		clear_commit_marks(merge_commit, ALL_REV_FLAGS);
 	}
 
+	release_revisions(&revs);
 	free(to_clear);
 }
 
diff --git a/remote.c b/remote.c
index 42a4e7106e1..fa3152a5d52 100644
--- a/remote.c
+++ b/remote.c
@@ -2172,6 +2172,7 @@ static int stat_branch_pair(const char *branch_name, const char *base,
 	clear_commit_marks(theirs, ALL_REV_FLAGS);
 
 	strvec_clear(&argv);
+	release_revisions(&revs);
 	return 1;
 }
 
diff --git a/sequencer.c b/sequencer.c
index a1bb39383db..f9d7acd1065 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1347,6 +1347,7 @@ void print_commit_summary(struct repository *r,
 		log_tree_commit(&rev, commit);
 	}
 
+	release_revisions(&rev);
 	strbuf_release(&format);
 }
 
@@ -3415,6 +3416,7 @@ static int make_patch(struct repository *r,
 		unuse_commit_buffer(commit, commit_buffer);
 	}
 	strbuf_release(&buf);
+	release_revisions(&log_tree_opt);
 
 	return res;
 }
@@ -4525,6 +4527,7 @@ static int pick_commits(struct repository *r,
 					      &log_tree_opt.diffopt);
 				log_tree_diff_flush(&log_tree_opt);
 			}
+			release_revisions(&log_tree_opt);
 		}
 		flush_rewritten_pending();
 		if (!stat(rebase_path_rewritten_list(), &st) &&
diff --git a/shallow.c b/shallow.c
index e158be58b05..797a593633f 100644
--- a/shallow.c
+++ b/shallow.c
@@ -262,6 +262,7 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 		if ((o->flags & both_flags) == both_flags)
 			o->flags &= ~not_shallow_flag;
 	}
+	release_revisions(&revs);
 	return result;
 }
 
diff --git a/submodule.c b/submodule.c
index 9b715b4a5cb..7b5d7753930 100644
--- a/submodule.c
+++ b/submodule.c
@@ -923,9 +923,11 @@ static void collect_changed_submodules(struct repository *r,
 		diff_rev.diffopt.format_callback_data = &data;
 		diff_rev.dense_combined_merges = 1;
 		diff_tree_combined_merge(commit, &diff_rev);
+		release_revisions(&diff_rev);
 	}
 
 	reset_revision_walk();
+	release_revisions(&rev);
 }
 
 static void free_submodules_data(struct string_list *submodules)
diff --git a/t/helper/test-revision-walking.c b/t/helper/test-revision-walking.c
index 625b2dbf822..4a45d5bac2a 100644
--- a/t/helper/test-revision-walking.c
+++ b/t/helper/test-revision-walking.c
@@ -43,6 +43,7 @@ static int run_revision_walk(void)
 	}
 
 	reset_revision_walk();
+	release_revisions(&rev);
 	return got_revision;
 }
 
diff --git a/wt-status.c b/wt-status.c
index 922cf787f95..f9100621375 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1152,6 +1152,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 		rev.diffopt.b_prefix = "w/";
 		run_diff_files(&rev, 0);
 	}
+	release_revisions(&rev);
 }
 
 static void wt_longstatus_print_tracking(struct wt_status *s)
-- 
2.36.0.rc2.843.g193535c2aa7

