Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0A5C433FE
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiCINTA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiCINSv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:18:51 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB87158E9D
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:17:50 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id q20so1355996wmq.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QWa2NJ81HmU2G6O6UgMIu0wm57xSooCjnEJncNuD+F4=;
        b=gDGn7VRfJodnsy9I+uHrcTQN6grszTg30pwxt1eiojNLHwQt1Pd1NaHxJ9/roFrymu
         giajtNM45H7r6HptzPhmT0PHx5JyXdusjrt2u1Sc2KsUR/GePCtTF1utQv8/Oluerl0G
         Ja4ehx0duXbNvcc8Us+8+x19wwO1GTh7yu636vDkU1uzemSTBAVjxjr/gi5NTcBkQTG7
         RBZMmzm8Xi758DwU4nABc8R3hz0RlYbkdQtM5pE1z7AZ6lcJVaSu1inxbV6XD16dgksv
         mS7h0c+U6Z4XemNt8k9gFsq3QmBy7Y6N62wyYcS/z1afb9wFdoYIQCIEe1mOp5wn2H01
         Iohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QWa2NJ81HmU2G6O6UgMIu0wm57xSooCjnEJncNuD+F4=;
        b=vUYpD310F2nA7mfvjIA0aq1UaKrMb3NwtvpyVpSFQne94Hbt7BHpUk1MbsoWar2THH
         3r/+NG6aPzNzH3oadH2IWDxU6XCCB8LsU8WcyDZDpoKcrDn0hwwb/FcgpOSsmEX3rNj2
         Ygwg/akLCDg3Ouf7FL93MpobdSqWeM9n4rZZ+X8FY4ymOpB7uaNYOzmkeGIb+m9qumns
         +AJfyI5pz6HBawFjscsYN2tzxp9RVNwQPnHP6qewTIYx2B9ZkbWZTbafxVYrlDn9bRqu
         K1Hlvg6LhvqM/+jQChuXOmxQ31dTCI6XXFdQV5td8Il5RvrM3cHrxQDZ22lvDa/8QIDf
         uyPA==
X-Gm-Message-State: AOAM533JxhJZ+QbA57EAtE6N46eAvpn9JvbzSdRdqIsw+HGMU4z6zJPI
        8g5sZJHGBLY9uK3Cghgc6nLnRGDun9qd4g==
X-Google-Smtp-Source: ABdhPJzDCVpsjzActPBDIIqhramtCPRwFUcAEnAtHqgDb1ZkCgwe/cUnD871YtQ3GmIgwBMXl+fZRg==
X-Received: by 2002:a05:600c:1f15:b0:389:ab64:fe80 with SMTP id bd21-20020a05600c1f1500b00389ab64fe80mr7560087wmb.141.1646831868902;
        Wed, 09 Mar 2022 05:17:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:17:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/24] revisions API users: add straightforward release_revisions()
Date:   Wed,  9 Mar 2022 14:16:36 +0100
Message-Id: <patch-06.24-b5d55539b6d-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
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
index e1ab39cce30..13d5ec6f49f 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -568,6 +568,7 @@ static int get_modified_files(struct repository *r,
 
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
index ed993383531..93fe46c6424 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1075,6 +1075,7 @@ static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
 
 	/* Clean up objects used, as they will be reused. */
 	repo_clear_commit_marks(the_repository, ALL_REV_FLAGS);
+	release_revisions(&revs);
 }
 
 static int switch_branches(const struct checkout_opts *opts,
diff --git a/builtin/commit.c b/builtin/commit.c
index 8b8bdad3959..74388a6b9a1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1120,6 +1120,7 @@ static const char *find_author_by_nickname(const char *name)
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
index 510139e9b54..ade0120b3a8 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1275,6 +1275,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		printf("done\n");
 
 	refspec_clear(&refspecs);
+	release_revisions(&revs);
 
 	return 0;
 }
diff --git a/builtin/merge.c b/builtin/merge.c
index a94a03384ae..e99549db6fd 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -443,6 +443,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 	}
 	write_file_buf(git_path_squash_msg(the_repository), out.buf, out.len);
 	strbuf_release(&out);
+	release_revisions(&rev);
 }
 
 static void finish(struct commit *head_commit,
@@ -992,6 +993,7 @@ static int evaluate_result(void)
 	 */
 	cnt += count_unmerged_entries();
 
+	release_revisions(&rev);
 	return cnt;
 }
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 178e611f09d..17194a58155 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3384,6 +3384,7 @@ static void read_packs_list_from_stdin(void)
 	strbuf_release(&buf);
 	string_list_clear(&include_packs, 0);
 	string_list_clear(&exclude_packs, 0);
+	release_revisions(&revs);
 }
 
 static void read_object_list_from_stdin(void)
@@ -3799,6 +3800,7 @@ static void get_object_list(int ac, const char **av)
 	if (unpack_unreachable)
 		loosen_unused_packed_objects();
 
+	release_revisions(&revs);
 	oid_array_clear(&recent_objects);
 }
 
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
index 016466852f1..5d870b4f2d1 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -648,6 +648,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		if (verbose)
 			printf(_("Marking reachable objects..."));
 		mark_reachable_objects(&revs, 0, 0, NULL);
+		release_revisions(&revs);
 		if (verbose)
 			putchar('\n');
 	}
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 228d782754a..e609357bd23 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -420,6 +420,8 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	else
 		get_from_rev(&rev, &log);
 
+	release_revisions(&rev);
+
 	shortlog_output(&log);
 	if (log.file != stdout)
 		fclose(log.file);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d8638434dcb..7fbba812583 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1259,6 +1259,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
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
index ff739d4b360..658c580ab91 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1593,6 +1593,7 @@ static int find_first_merges(struct repository *repo,
 	}
 
 	object_array_clear(&merges);
+	release_revisions(&revs);
 	return result->nr;
 }
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 9ec1e6d043a..6296685d00b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1160,6 +1160,7 @@ static int find_first_merges(struct repository *repo,
 	}
 
 	object_array_clear(&merges);
+	release_revisions(&revs);
 	return result->nr;
 }
 
diff --git a/midx.c b/midx.c
index 865170bad05..702c8a9b178 100644
--- a/midx.c
+++ b/midx.c
@@ -1061,6 +1061,7 @@ static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
 	if (indexed_commits_nr_p)
 		*indexed_commits_nr_p = cb.commits_nr;
 
+	release_revisions(&revs);
 	return cb.commits;
 }
 
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index cab3eaa2acd..ea8e0b51cdf 100644
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
index c97c626eaa8..0a7d8757d99 100644
--- a/remote.c
+++ b/remote.c
@@ -2172,6 +2172,7 @@ static int stat_branch_pair(const char *branch_name, const char *base,
 	clear_commit_marks(theirs, ALL_REV_FLAGS);
 
 	strvec_clear(&argv);
+	release_revisions(&revs);
 	return 1;
 }
 
diff --git a/sequencer.c b/sequencer.c
index 35006c0cea6..b15f8d1ff50 100644
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
@@ -4527,6 +4529,7 @@ static int pick_commits(struct repository *r,
 					      &log_tree_opt.diffopt);
 				log_tree_diff_flush(&log_tree_opt);
 			}
+			release_revisions(&log_tree_opt);
 		}
 		flush_rewritten_pending();
 		if (!stat(rebase_path_rewritten_list(), &st) &&
diff --git a/shallow.c b/shallow.c
index 71e5876f377..2552f139f61 100644
--- a/shallow.c
+++ b/shallow.c
@@ -261,6 +261,7 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 		if ((o->flags & both_flags) == both_flags)
 			o->flags &= ~not_shallow_flag;
 	}
+	release_revisions(&revs);
 	return result;
 }
 
diff --git a/submodule.c b/submodule.c
index 5ace18a7d94..0510cb193b6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -902,9 +902,11 @@ static void collect_changed_submodules(struct repository *r,
 		diff_rev.diffopt.format_callback_data = &data;
 		diff_rev.dense_combined_merges = 1;
 		diff_tree_combined_merge(commit, &diff_rev);
+		release_revisions(&diff_rev);
 	}
 
 	reset_revision_walk();
+	release_revisions(&rev);
 }
 
 static void free_submodules_oids(struct string_list *submodules)
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
index 398d0951aca..a68731ea0f7 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1143,6 +1143,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 		rev.diffopt.b_prefix = "w/";
 		run_diff_files(&rev, 0);
 	}
+	release_revisions(&rev);
 }
 
 static void wt_longstatus_print_tracking(struct wt_status *s)
-- 
2.35.1.1295.g6b025d3e231

