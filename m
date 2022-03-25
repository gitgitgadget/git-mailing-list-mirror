Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1920C4332F
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 17:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiCYRav (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239538AbiCYR2t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 13:28:49 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D41FDE18
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:27:10 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so4817268wme.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O/1Inp9c3am36sk04dyhzdsbX0R/X0lZTSqIHygJL/E=;
        b=PioFlotVZ+QXKP6ixPZ6Gtk4ZEOhy7uduPzp00EfYC2zsWIHL2irutkyXyPaeV+AJ2
         tx6tz8FaYmo1D0KkvjvWhDGIEAGy4I7Nkumt9mLtnVQotYxQUGM5+MgsMNF2i1V9w955
         0OxF18yYJRIjt0mpHt9Y4bHN/lh8l53KgWm+k7qrOvebQNznoAAZgp2PxjAgHHuly2Rr
         kstTGxGOHEg7O9wNDMB+66Sxqb0uiyRNml20+BCrslxCBjxd011DPKc65UJN1DZFjHjX
         /YN7/iDeGkS/ubhTVb4KABeIbMqNBRrvFUGzJZ6SdCEdsjb240PFOYj79ln2e1nmaJDN
         yDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O/1Inp9c3am36sk04dyhzdsbX0R/X0lZTSqIHygJL/E=;
        b=GtqD81Jvk1NPpwGIeO8R7elH7TPjxRI73hhYDvFqWHHsnalURdexs7sFmMZBb48PFs
         JYDFv0NlDoXXG17DgbUrZRcQiANX9P0Uxp+uSq9PIiSYS4UhA6A8oJXqt0T/WbSjs0Ay
         eKvhwiDFxEG71pUkXuj8E3eQkWe7Hn+ZlQQmLN3/1/b9suXUXA6J4aGE/igd8BvPawBa
         2mco225gxy8EBjcSmAqoMeMBmjy+BtV3IXA3XX+7I3LGzlEwSETBJkts+82ZoXL7NRR+
         x1Hc5FtVQrL8j9NhQzgCXpUIXQT1FTAozzHJwAp7lHO10SLNbfQbP64EBbNV5gQTNpeF
         asCQ==
X-Gm-Message-State: AOAM53039lESsdQD2H8IwOcEnnCP/G0uoXm/sK9B0DlX7kN8Xg/ezhYd
        VjUfUqhnQEF+JzB3kLIUeT5sBW03SgiC0w==
X-Google-Smtp-Source: ABdhPJxYPbMuW4k++VvtY5BFgAXHQ4ygidLs0AgU8YfYmetX78hdg98VTJwPaIJVA1q205+Swv3B0Q==
X-Received: by 2002:a7b:cc15:0:b0:38c:8af7:f47c with SMTP id f21-20020a7bcc15000000b0038c8af7f47cmr10980865wmh.177.1648228778437;
        Fri, 25 Mar 2022 10:19:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/27] revisions API users: add straightforward release_revisions()
Date:   Fri, 25 Mar 2022 18:18:31 +0100
Message-Id: <patch-v3-07.27-c4fc1c98e7b-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com> <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
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
index 829ca359cf9..0aa194f68dc 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3384,6 +3384,7 @@ static void read_packs_list_from_stdin(void)
 	strbuf_release(&buf);
 	string_list_clear(&include_packs, 0);
 	string_list_clear(&exclude_packs, 0);
+	release_revisions(&revs);
 }
 
 static void read_object_list_from_stdin(void)
@@ -3800,6 +3801,7 @@ static void get_object_list(int ac, const char **av)
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
index 9407f835cb6..592d5d33442 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -248,6 +248,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
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
index 5301612d24b..24980863f68 100644
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
2.35.1.1509.ge4eeb5bd39e

