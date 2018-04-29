Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B94381F428
	for <e@80x24.org>; Sun, 29 Apr 2018 22:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754501AbeD2WT3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 18:19:29 -0400
Received: from mout.gmx.net ([212.227.17.22]:41443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754164AbeD2WT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 18:19:26 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LwGDy-1eIOOQ0osY-0182Bk; Mon, 30 Apr 2018 00:19:16 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 5/6] Replace all die("BUG: ...") calls by BUG() ones
Date:   Mon, 30 Apr 2018 00:19:01 +0200
Message-Id: <42584f2f7c91590ae130ceb4290bcfb586759b10.1525040253.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.36.gdf4ca5fb72a
In-Reply-To: <cover.1525040253.git.johannes.schindelin@gmx.de>
References: <cover.1525040253.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9AUPwm8wOnpQEYQr9EArA008NHcUIFD4kt47lytR55utza83PQK
 2noi2MO75cnx1sLdzuMprWcNQAm9MMt/HISY28rmh9cc3WCuGhXR6iVo9RjOFSMWm3sM/ME
 7G1UxNroEOlm1oyX9WeKKriQ7s3TcedgaRJ9bkwoLNxBmptdyNRUBa8CesygFIpuUQbLevS
 Sk7p9lsOqEj7g39Zr7ooA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nZh8A6UpWHU=:icvjpkPALLmduO/hM1Mn/v
 bKykXstsKQ4sUL2bbWbRGI3AVT1wdNAm3PcVdfzPYBG86vEfowpRo4lYdh5LYQwhPME0jetDn
 zMz08XurwLMY6QGn4BMtWwTR0GueVgjur7orJSSdBHYcli1/ap7KLgvkdJz9JO5A6GNuiVhfT
 0uSXveesnpUJCTJdP4ldZWU94t2W4EKAX9Ips5Whrhc9Km0/dBvVLK0Ph6DzCXIOh+LokF18z
 lqxElEXC/KKq/RCne5hn2oeTBAuEd3QiD0ANsAzoFUasRPAW6bS9CK0JvkX/RjBULf+vaS/E7
 wLXW/4cgxhofRpxZ56f5Bpq9nDwxS4NYkqOgEAkwXQieA7VTmL0h15jrK2HC7L0MQDqBkQy/c
 A+zJTCBzNAnC1M3yzF58V8El8/g5hfSJzmyjunh5PKUII21mtAOH28GjQT+pT9JUyabeG5o/D
 xhHUVVpvBfekWE6Qn+IfUwQhP3XKGL++33LkFwJhMYZB5l48UtEfPbisVbHuhTIBz+HV/aV3Z
 Q6/xGSLRP+E5oQphIX54fJeYY6UiBEiygWZmQcQ1fPzEYjgTAiUAfVmwi5YEBKwh/VPxpUj92
 PZn5qVH2G6pFYidDc6yi5rk4zgqox+lLookE1dGuz5TsvnaEWrX0Xs4tAqrBDxiYzCU3Ik7jd
 qkflBZ52xj+AuPyvUezEQ4fkEgY0VpOXDVAzNs64hO3l7sdKyAsbmaWbrV5/o9SknExCMBYP7
 qBXgUbxkh2CHbANtHgswY7FdvplBnIrC9r3+UE/yUf0mnWQwYuYx3gvEjB60iFPXeQVvw0Eow
 qYCUbLZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In d8193743e08 (usage.c: add BUG() function, 2017-05-12), a new macro
was introduced to use for reporting bugs instead of die(). It was then
subsequently used to convert one single caller in 588a538ae55
(setup_git_env: convert die("BUG") to BUG(), 2017-05-12).

The cover letter of the patch series containing this patch
(cf 20170513032414.mfrwabt4hovujde2@sigill.intra.peff.net) is not
terribly clear why only one call site was converted, or what the plan
is for other, similar calls to die() to report bugs.

Let's just convert all remaining ones in one fell swoop.

This trick was performed by this invocation:

	sed -i 's/die("BUG: /BUG("/g' $(git grep -l 'die("BUG' \*.c)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 apply.c                          |  4 ++--
 archive-tar.c                    |  2 +-
 attr.c                           | 10 +++++-----
 blame.c                          |  2 +-
 builtin/am.c                     | 20 +++++++++----------
 builtin/branch.c                 |  2 +-
 builtin/cat-file.c               |  4 ++--
 builtin/clone.c                  |  2 +-
 builtin/commit.c                 |  2 +-
 builtin/config.c                 |  2 +-
 builtin/fast-export.c            |  2 +-
 builtin/fsck.c                   |  2 +-
 builtin/index-pack.c             |  4 ++--
 builtin/init-db.c                |  2 +-
 builtin/ls-files.c               |  2 +-
 builtin/notes.c                  |  8 ++++----
 builtin/pack-objects.c           |  4 ++--
 builtin/pull.c                   |  2 +-
 builtin/receive-pack.c           |  2 +-
 builtin/replace.c                |  2 +-
 builtin/update-index.c           |  2 +-
 bulk-checkin.c                   |  2 +-
 color.c                          |  4 ++--
 column.c                         |  2 +-
 config.c                         | 12 +++++------
 date.c                           |  2 +-
 diff.c                           | 12 +++++------
 dir-iterator.c                   |  2 +-
 grep.c                           | 16 +++++++--------
 http.c                           |  8 ++++----
 imap-send.c                      |  2 +-
 lockfile.c                       |  2 +-
 mailinfo.c                       |  2 +-
 merge-recursive.c                | 12 +++++------
 notes-merge.c                    |  4 ++--
 pack-bitmap-write.c              |  2 +-
 pack-bitmap.c                    |  6 +++---
 pack-objects.c                   |  2 +-
 packfile.c                       |  6 +++---
 pathspec.c                       | 10 +++++-----
 pkt-line.c                       |  2 +-
 prio-queue.c                     |  2 +-
 ref-filter.c                     |  4 ++--
 refs.c                           | 34 ++++++++++++++++----------------
 remote.c                         |  2 +-
 revision.c                       |  4 ++--
 run-command.c                    | 10 +++++-----
 setup.c                          |  4 ++--
 sha1-lookup.c                    |  2 +-
 sha1-name.c                      |  4 ++--
 shallow.c                        |  6 +++---
 sigchain.c                       |  2 +-
 strbuf.c                         |  4 ++--
 submodule.c                      |  6 +++---
 t/helper/test-example-decorate.c | 16 +++++++--------
 tmp-objdir.c                     |  2 +-
 trailer.c                        |  6 +++---
 transport.c                      |  4 ++--
 unpack-trees.c                   |  2 +-
 worktree.c                       |  2 +-
 wrapper.c                        |  4 ++--
 wt-status.c                      | 20 +++++++++----------
 zlib.c                           |  4 ++--
 63 files changed, 168 insertions(+), 168 deletions(-)

diff --git a/apply.c b/apply.c
index 7e5792c996f..3866adbc97f 100644
--- a/apply.c
+++ b/apply.c
@@ -2375,7 +2375,7 @@ static void update_pre_post_images(struct image *preimage,
 	if (postlen
 	    ? postlen < new_buf - postimage->buf
 	    : postimage->len < new_buf - postimage->buf)
-		die("BUG: caller miscounted postlen: asked %d, orig = %d, used = %d",
+		BUG("caller miscounted postlen: asked %d, orig = %d, used = %d",
 		    (int)postlen, (int) postimage->len, (int)(new_buf - postimage->buf));
 
 	/* Fix the length of the whole thing */
@@ -3509,7 +3509,7 @@ static int load_current(struct apply_state *state,
 	unsigned mode = patch->new_mode;
 
 	if (!patch->is_new)
-		die("BUG: patch to %s is not a creation", patch->old_name);
+		BUG("patch to %s is not a creation", patch->old_name);
 
 	pos = cache_name_pos(name, strlen(name));
 	if (pos < 0)
diff --git a/archive-tar.c b/archive-tar.c
index 3563bcb9f26..61a1a2547cc 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -441,7 +441,7 @@ static int write_tar_filter_archive(const struct archiver *ar,
 	int r;
 
 	if (!ar->data)
-		die("BUG: tar-filter archiver called with no filter defined");
+		BUG("tar-filter archiver called with no filter defined");
 
 	strbuf_addstr(&cmd, ar->data);
 	if (args->compression_level >= 0)
diff --git a/attr.c b/attr.c
index 03a678fa9be..067fb9e0c08 100644
--- a/attr.c
+++ b/attr.c
@@ -157,7 +157,7 @@ static void all_attrs_init(struct attr_hashmap *map, struct attr_check *check)
 
 	size = hashmap_get_size(&map->map);
 	if (size < check->all_attrs_nr)
-		die("BUG: interned attributes shouldn't be deleted");
+		BUG("interned attributes shouldn't be deleted");
 
 	/*
 	 * If the number of attributes in the global dictionary has increased
@@ -541,7 +541,7 @@ static void check_vector_remove(struct attr_check *check)
 			break;
 
 	if (i >= check_vector.nr)
-		die("BUG: no entry found");
+		BUG("no entry found");
 
 	/* shift entries over */
 	for (; i < check_vector.nr - 1; i++)
@@ -599,11 +599,11 @@ struct attr_check *attr_check_initl(const char *one, ...)
 		const struct git_attr *attr;
 		param = va_arg(params, const char *);
 		if (!param)
-			die("BUG: counted %d != ended at %d",
+			BUG("counted %d != ended at %d",
 			    check->nr, cnt);
 		attr = git_attr(param);
 		if (!attr)
-			die("BUG: %s: not a valid attribute name", param);
+			BUG("%s: not a valid attribute name", param);
 		check->items[cnt].attr = attr;
 	}
 	va_end(params);
@@ -714,7 +714,7 @@ void git_attr_set_direction(enum git_attr_direction new_direction,
 			    struct index_state *istate)
 {
 	if (is_bare_repository() && new_direction != GIT_ATTR_INDEX)
-		die("BUG: non-INDEX attr direction in a bare repo");
+		BUG("non-INDEX attr direction in a bare repo");
 
 	if (new_direction != direction)
 		drop_all_attr_stacks();
diff --git a/blame.c b/blame.c
index 78c9808bd1a..89a1b11e922 100644
--- a/blame.c
+++ b/blame.c
@@ -1806,7 +1806,7 @@ void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blam
 			l->item = c;
 			if (add_decoration(&sb->revs->children,
 					   &c->parents->item->object, l))
-				die("BUG: not unique item in first-parent chain");
+				BUG("not unique item in first-parent chain");
 			c = c->parents->item;
 		}
 
diff --git a/builtin/am.c b/builtin/am.c
index d834f9e62b6..3dc2ef4259a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -403,11 +403,11 @@ static void am_load(struct am_state *state)
 	struct strbuf sb = STRBUF_INIT;
 
 	if (read_state_file(&sb, state, "next", 1) < 0)
-		die("BUG: state file 'next' does not exist");
+		BUG("state file 'next' does not exist");
 	state->cur = strtol(sb.buf, NULL, 10);
 
 	if (read_state_file(&sb, state, "last", 1) < 0)
-		die("BUG: state file 'last' does not exist");
+		BUG("state file 'last' does not exist");
 	state->last = strtol(sb.buf, NULL, 10);
 
 	if (read_author_script(state) < 0)
@@ -986,7 +986,7 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
 	case PATCH_FORMAT_MBOXRD:
 		return split_mail_mbox(state, paths, keep_cr, 1);
 	default:
-		die("BUG: invalid patch_format");
+		BUG("invalid patch_format");
 	}
 	return -1;
 }
@@ -1041,7 +1041,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 		str = "b";
 		break;
 	default:
-		die("BUG: invalid value for state->keep");
+		BUG("invalid value for state->keep");
 	}
 
 	write_state_text(state, "keep", str);
@@ -1058,7 +1058,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 		str = "t";
 		break;
 	default:
-		die("BUG: invalid value for state->scissors");
+		BUG("invalid value for state->scissors");
 	}
 	write_state_text(state, "scissors", str);
 
@@ -1216,7 +1216,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 		mi.keep_non_patch_brackets_in_subject = 1;
 		break;
 	default:
-		die("BUG: invalid value for state->keep");
+		BUG("invalid value for state->keep");
 	}
 
 	if (state->message_id)
@@ -1232,7 +1232,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 		mi.use_scissors = 1;
 		break;
 	default:
-		die("BUG: invalid value for state->scissors");
+		BUG("invalid value for state->scissors");
 	}
 
 	mi.input = xfopen(mail, "r");
@@ -1463,7 +1463,7 @@ static int run_apply(const struct am_state *state, const char *index_file)
 	int options = 0;
 
 	if (init_apply_state(&apply_state, NULL))
-		die("BUG: init_apply_state() failed");
+		BUG("init_apply_state() failed");
 
 	argv_array_push(&apply_opts, "apply");
 	argv_array_pushv(&apply_opts, state->git_apply_opts.argv);
@@ -1489,7 +1489,7 @@ static int run_apply(const struct am_state *state, const char *index_file)
 		apply_state.apply_verbosity = verbosity_silent;
 
 	if (check_apply_state(&apply_state, force_apply))
-		die("BUG: check_apply_state() failed");
+		BUG("check_apply_state() failed");
 
 	argv_array_push(&apply_paths, am_path(state, "patch"));
 
@@ -2407,7 +2407,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		ret = show_patch(&state);
 		break;
 	default:
-		die("BUG: invalid resume value");
+		BUG("invalid resume value");
 	}
 
 	am_state_release(&state);
diff --git a/builtin/branch.c b/builtin/branch.c
index 5bd2a0dd489..1d4b3ce3d79 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -497,7 +497,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 
 	if (!skip_prefix(oldref.buf, "refs/heads/", &interpreted_oldname) ||
 	    !skip_prefix(newref.buf, "refs/heads/", &interpreted_newname)) {
-		die("BUG: expected prefix missing for refs");
+		BUG("expected prefix missing for refs");
 	}
 
 	if (copy)
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 2c46d257cd9..1cc3ccc4515 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -312,7 +312,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 					die("could not convert '%s' %s",
 					    oid_to_hex(oid), data->rest);
 			} else
-				die("BUG: invalid cmdmode: %c", opt->cmdmode);
+				BUG("invalid cmdmode: %c", opt->cmdmode);
 			batch_write(opt, contents, size);
 			free(contents);
 		} else if (stream_blob_to_fd(1, oid, NULL, 0) < 0)
@@ -387,7 +387,7 @@ static void batch_one_object(const char *obj_name, struct batch_options *opt,
 			       (uintmax_t)strlen(obj_name), obj_name);
 			break;
 		default:
-			die("BUG: unknown get_sha1_with_context result %d\n",
+			BUG("unknown get_sha1_with_context result %d\n",
 			       result);
 			break;
 		}
diff --git a/builtin/clone.c b/builtin/clone.c
index 7df5932b855..918820c539c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -823,7 +823,7 @@ static void write_refspec_config(const char *src_ref_prefix,
 			} else if (remote_head_points_at) {
 				const char *head = remote_head_points_at->name;
 				if (!skip_prefix(head, "refs/heads/", &head))
-					die("BUG: remote HEAD points at non-head?");
+					BUG("remote HEAD points at non-head?");
 
 				strbuf_addf(&value, "+%s:%s%s", remote_head_points_at->name,
 						branch_top->buf, head);
diff --git a/builtin/commit.c b/builtin/commit.c
index 5571d4a3e2b..7b47d1b7fb3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -495,7 +495,7 @@ static int is_a_merge(const struct commit *current_head)
 static void assert_split_ident(struct ident_split *id, const struct strbuf *buf)
 {
 	if (split_ident_line(id, buf->buf, buf->len) || !id->date_begin)
-		die("BUG: unable to parse our own ident: %s", buf->buf);
+		BUG("unable to parse our own ident: %s", buf->buf);
 }
 
 static void export_one(const char *var, const char *s, const char *e, int hack)
diff --git a/builtin/config.c b/builtin/config.c
index 01169dd628b..c4f20332d74 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -309,7 +309,7 @@ static char *normalize_value(const char *key, const char *value)
 			return xstrdup(v ? "true" : "false");
 	}
 
-	die("BUG: cannot normalize type %d", types);
+	BUG("cannot normalize type %d", types);
 }
 
 static int get_color_found;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index a15898d6417..116363f685c 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -517,7 +517,7 @@ static void anonymize_ident_line(const char **beg, const char **end)
 	/* skip "committer", "author", "tagger", etc */
 	end_of_header = strchr(*beg, ' ');
 	if (!end_of_header)
-		die("BUG: malformed line fed to anonymize_ident_line: %.*s",
+		BUG("malformed line fed to anonymize_ident_line: %.*s",
 		    (int)(*end - *beg), *beg);
 	end_of_header++;
 	strbuf_add(out, *beg, end_of_header - *beg);
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 087360a6757..1ea414480a4 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -519,7 +519,7 @@ static struct object *parse_loose_object(const struct object_id *oid,
 		return NULL;
 
 	if (!contents && type != OBJ_BLOB)
-		die("BUG: read_loose_object streamed a non-blob");
+		BUG("read_loose_object streamed a non-blob");
 
 	obj = parse_object_buffer(oid, type, size, contents, &eaten);
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 78e66b99866..21f22e34952 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -866,7 +866,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			if (obj->type == OBJ_COMMIT) {
 				struct commit *commit = (struct commit *) obj;
 				if (detach_commit_buffer(commit, NULL) != data)
-					die("BUG: parse_object_buffer transmogrified our buffer");
+					BUG("parse_object_buffer transmogrified our buffer");
 			}
 			obj->flags |= FLAG_CHECKED;
 		}
@@ -1015,7 +1015,7 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 
 		if (!compare_and_swap_type(&child->real_type, OBJ_REF_DELTA,
 					   base->obj->real_type))
-			die("BUG: child->real_type != OBJ_REF_DELTA");
+			BUG("child->real_type != OBJ_REF_DELTA");
 
 		resolve_delta(child, base, result);
 		if (base->ref_first == base->ref_last && base->ofs_last == -1)
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 2542c5244e9..5a5844c1538 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -391,7 +391,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 		else if (get_shared_repository() == PERM_EVERYBODY)
 			xsnprintf(buf, sizeof(buf), "%d", OLD_PERM_EVERYBODY);
 		else
-			die("BUG: invalid value for shared_repository");
+			BUG("invalid value for shared_repository");
 		git_config_set("core.sharedrepository", buf);
 		git_config_set("receive.denyNonFastforwards", "true");
 	}
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a71f6bd088a..967b2b3380d 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -166,7 +166,7 @@ static void show_killed_files(const struct index_state *istate,
 				 */
 				pos = index_name_pos(istate, ent->name, ent->len);
 				if (0 <= pos)
-					die("BUG: killed-file %.*s not found",
+					BUG("killed-file %.*s not found",
 						ent->len, ent->name);
 				pos = -pos - 1;
 				while (pos < istate->cache_nr &&
diff --git a/builtin/notes.c b/builtin/notes.c
index e5bf80eef1d..da279cdd349 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -461,7 +461,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	if (d.buf.len || allow_empty) {
 		write_note_data(&d, &new_note);
 		if (add_note(t, &object, &new_note, combine_notes_overwrite))
-			die("BUG: combine_notes_overwrite failed");
+			BUG("combine_notes_overwrite failed");
 		commit_notes(t, "Notes added by 'git notes add'");
 	} else {
 		fprintf(stderr, _("Removing note for object %s\n"),
@@ -544,7 +544,7 @@ static int copy(int argc, const char **argv, const char *prefix)
 	}
 
 	if (add_note(t, &object, from_note, combine_notes_overwrite))
-		die("BUG: combine_notes_overwrite failed");
+		BUG("combine_notes_overwrite failed");
 	commit_notes(t, "Notes added by 'git notes copy'");
 out:
 	free_notes(t);
@@ -621,7 +621,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	if (d.buf.len || allow_empty) {
 		write_note_data(&d, &new_note);
 		if (add_note(t, &object, &new_note, combine_notes_overwrite))
-			die("BUG: combine_notes_overwrite failed");
+			BUG("combine_notes_overwrite failed");
 		logmsg = xstrfmt("Notes added by 'git notes %s'", argv[0]);
 	} else {
 		fprintf(stderr, _("Removing note for object %s\n"),
@@ -831,7 +831,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 		const char *short_ref = NULL;
 
 		if (!skip_prefix(o.local_ref, "refs/notes/", &short_ref))
-			die("BUG: local ref %s is outside of refs/notes/",
+			BUG("local ref %s is outside of refs/notes/",
 			    o.local_ref);
 
 		strbuf_addf(&merge_key, "notes.%s.mergeStrategy", short_ref);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4bdae5a1d8f..68de9134e1c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1620,7 +1620,7 @@ static void break_delta_chains(struct object_entry *entry)
 		 * is a bug.
 		 */
 		if (cur->dfs_state != DFS_NONE)
-			die("BUG: confusing delta dfs state in first pass: %d",
+			BUG("confusing delta dfs state in first pass: %d",
 			    cur->dfs_state);
 
 		/*
@@ -1677,7 +1677,7 @@ static void break_delta_chains(struct object_entry *entry)
 		if (cur->dfs_state == DFS_DONE)
 			break;
 		else if (cur->dfs_state != DFS_ACTIVE)
-			die("BUG: confusing delta dfs state in second pass: %d",
+			BUG("confusing delta dfs state in second pass: %d",
 			    cur->dfs_state);
 
 		/*
diff --git a/builtin/pull.c b/builtin/pull.c
index 71aac5005e0..a886fa8ad4f 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -539,7 +539,7 @@ static int run_fetch(const char *repo, const char **refspecs)
 		argv_array_push(&args, repo);
 		argv_array_pushv(&args, refspecs);
 	} else if (*refspecs)
-		die("BUG: refspecs without repo?");
+		BUG("refspecs without repo?");
 	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
 	argv_array_clear(&args);
 	return ret;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4b68a28e92e..2d719fa5117 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1378,7 +1378,7 @@ static void warn_if_skipped_connectivity_check(struct command *commands,
 		}
 	}
 	if (!checked_connectivity)
-		die("BUG: connectivity check skipped???");
+		BUG("connectivity check skipped???");
 }
 
 static void execute_commands_non_atomic(struct command *commands,
diff --git a/builtin/replace.c b/builtin/replace.c
index 935647be6bd..91a25394c00 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -501,6 +501,6 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		return list_replace_refs(argv[0], format);
 
 	default:
-		die("BUG: invalid cmdmode %d", (int)cmdmode);
+		BUG("invalid cmdmode %d", (int)cmdmode);
 	}
 }
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 10d070a76fb..ac19bbbb150 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1164,7 +1164,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
 		break;
 	default:
-		die("BUG: bad untracked_cache value: %d", untracked_cache);
+		BUG("bad untracked_cache value: %d", untracked_cache);
 	}
 
 	if (fsmonitor > 0) {
diff --git a/bulk-checkin.c b/bulk-checkin.c
index de1f4040c78..f8a549dd7a4 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -230,7 +230,7 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 		 * pack, and write into it.
 		 */
 		if (!idx)
-			die("BUG: should not happen");
+			BUG("should not happen");
 		hashfile_truncate(state->f, &checkpoint);
 		state->offset = checkpoint.offset;
 		finish_bulk_checkin(state);
diff --git a/color.c b/color.c
index f277e72e4ce..be1040005b4 100644
--- a/color.c
+++ b/color.c
@@ -174,7 +174,7 @@ static char *color_output(char *out, int len, const struct color *c, char type)
 		break;
 	case COLOR_ANSI:
 		if (len < 2)
-			die("BUG: color parsing ran out of space");
+			BUG("color parsing ran out of space");
 		*out++ = type;
 		*out++ = '0' + c->value;
 		break;
@@ -256,7 +256,7 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 #undef OUT
 #define OUT(x) do { \
 	if (dst == end) \
-		die("BUG: color parsing ran out of space"); \
+		BUG("color parsing ran out of space"); \
 	*dst++ = (x); \
 } while(0)
 
diff --git a/column.c b/column.c
index 49ab85b7691..2165297608e 100644
--- a/column.c
+++ b/column.c
@@ -214,7 +214,7 @@ void print_columns(const struct string_list *list, unsigned int colopts,
 		display_table(list, colopts, &nopts);
 		break;
 	default:
-		die("BUG: invalid layout mode %d", COL_LAYOUT(colopts));
+		BUG("invalid layout mode %d", COL_LAYOUT(colopts));
 	}
 }
 
diff --git a/config.c b/config.c
index 62c56099bf8..cface6ab8aa 100644
--- a/config.c
+++ b/config.c
@@ -102,7 +102,7 @@ static int config_buf_ungetc(int c, struct config_source *conf)
 	if (conf->u.buf.pos > 0) {
 		conf->u.buf.pos--;
 		if (conf->u.buf.buf[conf->u.buf.pos] != c)
-			die("BUG: config_buf can only ungetc the same character");
+			BUG("config_buf can only ungetc the same character");
 		return c;
 	}
 
@@ -189,7 +189,7 @@ static int prepare_include_condition_pattern(struct strbuf *pat)
 		strbuf_realpath(&path, cf->path, 1);
 		slash = find_last_dir_sep(path.buf);
 		if (!slash)
-			die("BUG: how is this possible?");
+			BUG("how is this possible?");
 		strbuf_splice(pat, 0, 1, path.buf, slash - path.buf);
 		prefix = slash - path.buf + 1 /* slash */;
 	} else if (!is_absolute_path(pat->buf))
@@ -1717,7 +1717,7 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 	l_item->value_index = e->value_list.nr - 1;
 
 	if (!cf)
-		die("BUG: configset_add_value has no source");
+		BUG("configset_add_value has no source");
 	if (cf->name) {
 		kv_info->filename = strintern(cf->name);
 		kv_info->linenr = cf->linenr;
@@ -3006,7 +3006,7 @@ const char *current_config_origin_type(void)
 	else if(cf)
 		type = cf->origin_type;
 	else
-		die("BUG: current_config_origin_type called outside config callback");
+		BUG("current_config_origin_type called outside config callback");
 
 	switch (type) {
 	case CONFIG_ORIGIN_BLOB:
@@ -3020,7 +3020,7 @@ const char *current_config_origin_type(void)
 	case CONFIG_ORIGIN_CMDLINE:
 		return "command line";
 	default:
-		die("BUG: unknown config origin type");
+		BUG("unknown config origin type");
 	}
 }
 
@@ -3032,7 +3032,7 @@ const char *current_config_name(void)
 	else if (cf)
 		name = cf->name;
 	else
-		die("BUG: current_config_name called outside config callback");
+		BUG("current_config_name called outside config callback");
 	return name ? name : "";
 }
 
diff --git a/date.c b/date.c
index c3e673fd042..49f943e25b5 100644
--- a/date.c
+++ b/date.c
@@ -185,7 +185,7 @@ struct date_mode *date_mode_from_type(enum date_mode_type type)
 {
 	static struct date_mode mode;
 	if (type == DATE_STRFTIME)
-		die("BUG: cannot create anonymous strftime date_mode struct");
+		BUG("cannot create anonymous strftime date_mode struct");
 	mode.type = type;
 	mode.local = 0;
 	return &mode;
diff --git a/diff.c b/diff.c
index 1289df4b1f9..9d8c7f60472 100644
--- a/diff.c
+++ b/diff.c
@@ -1184,7 +1184,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		fputs(o->stat_sep, o->file);
 		break;
 	default:
-		die("BUG: unknown diff symbol");
+		BUG("unknown diff symbol");
 	}
 	strbuf_release(&sb);
 }
@@ -1343,7 +1343,7 @@ static struct diff_tempfile *claim_diff_tempfile(void) {
 	for (i = 0; i < ARRAY_SIZE(diff_temp); i++)
 		if (!diff_temp[i].name)
 			return diff_temp + i;
-	die("BUG: diff is failing to clean up its tempfiles");
+	BUG("diff is failing to clean up its tempfiles");
 }
 
 static void remove_tempfile(void)
@@ -3840,7 +3840,7 @@ static const char *diff_abbrev_oid(const struct object_id *oid, int abbrev)
 		if (abbrev < 0)
 			abbrev = FALLBACK_DEFAULT_ABBREV;
 		if (abbrev > GIT_SHA1_HEXSZ)
-			die("BUG: oid abbreviation out of range: %d", abbrev);
+			BUG("oid abbreviation out of range: %d", abbrev);
 		if (abbrev)
 			hex[abbrev] = '\0';
 		return hex;
@@ -4334,7 +4334,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 	int argcount = 1;
 
 	if (!skip_prefix(arg, "--stat", &arg))
-		die("BUG: stat option does not begin with --stat: %s", arg);
+		BUG("stat option does not begin with --stat: %s", arg);
 	end = (char *)arg;
 
 	switch (*arg) {
@@ -5519,7 +5519,7 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 	struct diff_queue_struct *q = &diff_queued_diff;
 
 	if (WSEH_NEW & WS_RULE_MASK)
-		die("BUG: WS rules bit mask overlaps with diff symbol flags");
+		BUG("WS rules bit mask overlaps with diff symbol flags");
 
 	if (o->color_moved)
 		o->emitted_symbols = &esm;
@@ -6053,7 +6053,7 @@ size_t fill_textconv(struct userdiff_driver *driver,
 	}
 
 	if (!driver->textconv)
-		die("BUG: fill_textconv called with non-textconv driver");
+		BUG("fill_textconv called with non-textconv driver");
 
 	if (driver->textconv_cache && df->oid_valid) {
 		*outbuf = notes_cache_get(driver->textconv_cache,
diff --git a/dir-iterator.c b/dir-iterator.c
index 34182a9a1c1..f2dcd82fde9 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -188,7 +188,7 @@ struct dir_iterator *dir_iterator_begin(const char *path)
 	struct dir_iterator *dir_iterator = &iter->base;
 
 	if (!path || !*path)
-		die("BUG: empty path passed to dir_iterator_begin()");
+		BUG("empty path passed to dir_iterator_begin()");
 
 	strbuf_init(&iter->base.path, PATH_MAX);
 	strbuf_addstr(&iter->base.path, path);
diff --git a/grep.c b/grep.c
index 65b90c10a38..84f8054a3fd 100644
--- a/grep.c
+++ b/grep.c
@@ -404,7 +404,7 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 			die("Couldn't allocate PCRE JIT stack");
 		pcre_assign_jit_stack(p->pcre1_extra_info, NULL, p->pcre1_jit_stack);
 	} else if (p->pcre1_jit_on != 0) {
-		die("BUG: The pcre1_jit_on variable should be 0 or 1, not %d",
+		BUG("The pcre1_jit_on variable should be 0 or 1, not %d",
 		    p->pcre1_jit_on);
 	}
 #endif
@@ -550,7 +550,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 			die("Couldn't allocate PCRE2 match context");
 		pcre2_jit_stack_assign(p->pcre2_match_context, NULL, p->pcre2_jit_stack);
 	} else if (p->pcre2_jit_on != 0) {
-		die("BUG: The pcre2_jit_on variable should be 0 or 1, not %d",
+		BUG("The pcre2_jit_on variable should be 0 or 1, not %d",
 		    p->pcre1_jit_on);
 	}
 }
@@ -917,10 +917,10 @@ static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
 
 	for (p = opt->header_list; p; p = p->next) {
 		if (p->token != GREP_PATTERN_HEAD)
-			die("BUG: a non-header pattern in grep header list.");
+			BUG("a non-header pattern in grep header list.");
 		if (p->field < GREP_HEADER_FIELD_MIN ||
 		    GREP_HEADER_FIELD_MAX <= p->field)
-			die("BUG: unknown header field %d", p->field);
+			BUG("unknown header field %d", p->field);
 		compile_regexp(p, opt);
 	}
 
@@ -933,7 +933,7 @@ static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
 
 		h = compile_pattern_atom(&pp);
 		if (!h || pp != p->next)
-			die("BUG: malformed header expr");
+			BUG("malformed header expr");
 		if (!header_group[p->field]) {
 			header_group[p->field] = h;
 			continue;
@@ -1652,7 +1652,7 @@ static int fill_textconv_grep(struct userdiff_driver *driver,
 		fill_filespec(df, &null_oid, 0, 0100644);
 		break;
 	default:
-		die("BUG: attempt to textconv something without a path?");
+		BUG("attempt to textconv something without a path?");
 	}
 
 	/*
@@ -1748,7 +1748,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		case GREP_BINARY_TEXT:
 			break;
 		default:
-			die("BUG: unknown binary handling mode");
+			BUG("unknown binary handling mode");
 		}
 	}
 
@@ -2072,7 +2072,7 @@ static int grep_source_load(struct grep_source *gs)
 	case GREP_SOURCE_BUF:
 		return gs->buf ? 0 : -1;
 	}
-	die("BUG: invalid grep_source type to load");
+	BUG("invalid grep_source type to load");
 }
 
 void grep_source_load_driver(struct grep_source *gs)
diff --git a/http.c b/http.c
index 3034d10b680..ff60936bb0a 100644
--- a/http.c
+++ b/http.c
@@ -1855,7 +1855,7 @@ static int update_url_from_redirect(struct strbuf *base,
 		return 0;
 
 	if (!skip_prefix(asked, base->buf, &tail))
-		die("BUG: update_url_from_redirect: %s is not a superset of %s",
+		BUG("update_url_from_redirect: %s is not a superset of %s",
 		    asked, base->buf);
 
 	new_len = got->len;
@@ -1903,7 +1903,7 @@ static int http_request_reauth(const char *url,
 			strbuf_reset(result);
 			break;
 		default:
-			die("BUG: HTTP_KEEP_ERROR is only supported with strbufs");
+			BUG("HTTP_KEEP_ERROR is only supported with strbufs");
 		}
 	}
 
@@ -2114,7 +2114,7 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	*lst = (*lst)->next;
 
 	if (!strip_suffix(preq->tmpfile, ".pack.temp", &len))
-		die("BUG: pack tmpfile does not end in .pack.temp?");
+		BUG("pack tmpfile does not end in .pack.temp?");
 	tmp_idx = xstrfmt("%.*s.idx.temp", (int)len, preq->tmpfile);
 
 	argv_array_push(&ip.args, "index-pack");
@@ -2210,7 +2210,7 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
 		CURLcode c = curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE,
 						&slot->http_code);
 		if (c != CURLE_OK)
-			die("BUG: curl_easy_getinfo for HTTP code failed: %s",
+			BUG("curl_easy_getinfo for HTTP code failed: %s",
 				curl_easy_strerror(c));
 		if (slot->http_code >= 300)
 			return size;
diff --git a/imap-send.c b/imap-send.c
index 3573cbfb0fc..b4eb886e2a6 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -511,7 +511,7 @@ static int nfsnprintf(char *buf, int blen, const char *fmt, ...)
 
 	va_start(va, fmt);
 	if (blen <= 0 || (unsigned)(ret = vsnprintf(buf, blen, fmt, va)) >= (unsigned)blen)
-		die("BUG: buffer too small. Please report a bug.");
+		BUG("buffer too small. Please report a bug.");
 	va_end(va);
 	return ret;
 }
diff --git a/lockfile.c b/lockfile.c
index efcb7d7dfe3..8e8ab4f29f3 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -193,7 +193,7 @@ char *get_locked_file_path(struct lock_file *lk)
 	strbuf_addstr(&ret, get_tempfile_path(lk->tempfile));
 	if (ret.len <= LOCK_SUFFIX_LEN ||
 	    strcmp(ret.buf + ret.len - LOCK_SUFFIX_LEN, LOCK_SUFFIX))
-		die("BUG: get_locked_file_path() called for malformed lock object");
+		BUG("get_locked_file_path() called for malformed lock object");
 	/* remove ".lock": */
 	strbuf_setlen(&ret, ret.len - LOCK_SUFFIX_LEN);
 	return strbuf_detach(&ret, NULL);
diff --git a/mailinfo.c b/mailinfo.c
index d04142ccc76..3281a37d518 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -716,7 +716,7 @@ static void flush_inbody_header_accum(struct mailinfo *mi)
 	if (!mi->inbody_header_accum.len)
 		return;
 	if (!check_header(mi, &mi->inbody_header_accum, mi->s_hdr_data, 0))
-		die("BUG: inbody_header_accum, if not empty, must always contain a valid in-body header");
+		BUG("inbody_header_accum, if not empty, must always contain a valid in-body header");
 	strbuf_reset(&mi->inbody_header_accum);
 }
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 0c0d48624da..6409d0770f2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -318,7 +318,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
 					(int)ce_namelen(ce), ce->name);
 		}
-		die("BUG: unmerged index entries in merge-recursive.c");
+		BUG("unmerged index entries in merge-recursive.c");
 	}
 
 	if (!active_cache_tree)
@@ -1060,7 +1060,7 @@ static int merge_file_1(struct merge_options *o,
 				break;
 			}
 		} else
-			die("BUG: unsupported object type in the tree");
+			BUG("unsupported object type in the tree");
 	}
 
 	return 0;
@@ -1462,7 +1462,7 @@ static int process_renames(struct merge_options *o,
 			const char *ren2_dst = ren2->pair->two->path;
 			enum rename_type rename_type;
 			if (strcmp(ren1_src, ren2_src) != 0)
-				die("BUG: ren1_src != ren2_src");
+				BUG("ren1_src != ren2_src");
 			ren2->dst_entry->processed = 1;
 			ren2->processed = 1;
 			if (strcmp(ren1_dst, ren2_dst) != 0) {
@@ -1496,7 +1496,7 @@ static int process_renames(struct merge_options *o,
 			ren2 = lookup->util;
 			ren2_dst = ren2->pair->two->path;
 			if (strcmp(ren1_dst, ren2_dst) != 0)
-				die("BUG: ren1_dst != ren2_dst");
+				BUG("ren1_dst != ren2_dst");
 
 			clean_merge = 0;
 			ren2->processed = 1;
@@ -1962,7 +1962,7 @@ static int process_entry(struct merge_options *o,
 		 */
 		remove_file(o, 1, path, !a_mode);
 	} else
-		die("BUG: fatal merge failure, shouldn't happen.");
+		BUG("fatal merge failure, shouldn't happen.");
 
 	return clean_merge;
 }
@@ -2040,7 +2040,7 @@ int merge_trees(struct merge_options *o,
 		for (i = 0; i < entries->nr; i++) {
 			struct stage_data *e = entries->items[i].util;
 			if (!e->processed)
-				die("BUG: unprocessed path??? %s",
+				BUG("unprocessed path??? %s",
 				    entries->items[i].string);
 		}
 
diff --git a/notes-merge.c b/notes-merge.c
index 8e0726a9418..720e24784c4 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -442,7 +442,7 @@ static int merge_one_change(struct notes_merge_options *o,
 			printf("Using remote notes for %s\n",
 						oid_to_hex(&p->obj));
 		if (add_note(t, &p->obj, &p->remote, combine_notes_overwrite))
-			die("BUG: combine_notes_overwrite failed");
+			BUG("combine_notes_overwrite failed");
 		return 0;
 	case NOTES_MERGE_RESOLVE_UNION:
 		if (o->verbosity >= 2)
@@ -490,7 +490,7 @@ static int merge_changes(struct notes_merge_options *o,
 			trace_printf("\t\t\tno local change, adopted remote\n");
 			if (add_note(t, &p->obj, &p->remote,
 				     combine_notes_overwrite))
-				die("BUG: combine_notes_overwrite failed");
+				BUG("combine_notes_overwrite failed");
 		} else {
 			/* need file-level merge between local and remote */
 			trace_printf("\t\t\tneed content-level merge\n");
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 41ae27fb19a..3c7b5edda8a 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -474,7 +474,7 @@ static void write_selected_commits_v1(struct hashfile *f,
 			sha1_pos(stored->commit->object.oid.hash, index, index_nr, sha1_access);
 
 		if (commit_pos < 0)
-			die("BUG: trying to write commit not in index");
+			BUG("trying to write commit not in index");
 
 		hashwrite_be32(f, commit_pos);
 		hashwrite_u8(f, stored->xor_offset);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 3f2dab340f6..a4837af0f4b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -255,7 +255,7 @@ static char *pack_bitmap_filename(struct packed_git *p)
 	size_t len;
 
 	if (!strip_suffix(p->pack_name, ".pack", &len))
-		die("BUG: pack_name does not end in .pack");
+		BUG("pack_name does not end in .pack");
 	return xstrfmt("%.*s.bitmap", (int)len, p->pack_name);
 }
 
@@ -723,13 +723,13 @@ int prepare_bitmap_walk(struct rev_info *revs)
 		revs->ignore_missing_links = 0;
 
 		if (haves_bitmap == NULL)
-			die("BUG: failed to perform bitmap walk");
+			BUG("failed to perform bitmap walk");
 	}
 
 	wants_bitmap = find_objects(revs, wants, haves_bitmap);
 
 	if (!wants_bitmap)
-		die("BUG: failed to perform bitmap walk");
+		BUG("failed to perform bitmap walk");
 
 	if (haves_bitmap)
 		bitmap_and_not(wants_bitmap, haves_bitmap);
diff --git a/pack-objects.c b/pack-objects.c
index 9558d13834e..0acab27133c 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -58,7 +58,7 @@ static void rehash_objects(struct packing_data *pdata)
 						       &found);
 
 		if (found)
-			die("BUG: Duplicate object in hash");
+			BUG("Duplicate object in hash");
 
 		pdata->index[ix] = i + 1;
 		entry++;
diff --git a/packfile.c b/packfile.c
index 0bc67d0e009..9df0dab44da 100644
--- a/packfile.c
+++ b/packfile.c
@@ -188,7 +188,7 @@ int open_pack_index(struct packed_git *p)
 		return 0;
 
 	if (!strip_suffix(p->pack_name, ".pack", &len))
-		die("BUG: pack_name does not end in .pack");
+		BUG("pack_name does not end in .pack");
 	idx_name = xstrfmt("%.*s.idx", (int)len, p->pack_name);
 	ret = check_packed_git_idx(idx_name, p);
 	free(idx_name);
@@ -317,7 +317,7 @@ void close_all_packs(struct raw_object_store *o)
 
 	for (p = o->packed_git; p; p = p->next)
 		if (p->do_not_close)
-			die("BUG: want to close pack marked 'do-not-close'");
+			BUG("want to close pack marked 'do-not-close'");
 		else
 			close_pack(p);
 }
@@ -1561,7 +1561,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 	case OBJ_OFS_DELTA:
 	case OBJ_REF_DELTA:
 		if (data)
-			die("BUG: unpack_entry: left loop at a valid delta");
+			BUG("unpack_entry: left loop at a valid delta");
 		break;
 	case OBJ_COMMIT:
 	case OBJ_TREE:
diff --git a/pathspec.c b/pathspec.c
index 82eb39cd679..a637a6d15c0 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -198,7 +198,7 @@ static void parse_pathspec_attr_match(struct pathspec_item *item, const char *va
 	}
 
 	if (item->attr_check->nr != item->attr_match_nr)
-		die("BUG: should have same number of entries");
+		BUG("should have same number of entries");
 
 	string_list_clear(&list, 0);
 }
@@ -422,7 +422,7 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 
 	if (pathspec_prefix >= 0 &&
 	    (prefixlen || (prefix && *prefix)))
-		die("BUG: 'prefix' magic is supposed to be used at worktree's root");
+		BUG("'prefix' magic is supposed to be used at worktree's root");
 
 	if ((magic & PATHSPEC_LITERAL) && (magic & PATHSPEC_GLOB))
 		die(_("%s: 'literal' and 'glob' are incompatible"), elt);
@@ -545,7 +545,7 @@ void parse_pathspec(struct pathspec *pathspec,
 
 	if ((flags & PATHSPEC_PREFER_CWD) &&
 	    (flags & PATHSPEC_PREFER_FULL))
-		die("BUG: PATHSPEC_PREFER_CWD and PATHSPEC_PREFER_FULL are incompatible");
+		BUG("PATHSPEC_PREFER_CWD and PATHSPEC_PREFER_FULL are incompatible");
 
 	/* No arguments with prefix -> prefix pathspec */
 	if (!entry) {
@@ -553,7 +553,7 @@ void parse_pathspec(struct pathspec *pathspec,
 			return;
 
 		if (!(flags & PATHSPEC_PREFER_CWD))
-			die("BUG: PATHSPEC_PREFER_CWD requires arguments");
+			BUG("PATHSPEC_PREFER_CWD requires arguments");
 
 		pathspec->items = item = xcalloc(1, sizeof(*item));
 		item->match = xstrdup(prefix);
@@ -609,7 +609,7 @@ void parse_pathspec(struct pathspec *pathspec,
 
 	if (pathspec->magic & PATHSPEC_MAXDEPTH) {
 		if (flags & PATHSPEC_KEEP_ORDER)
-			die("BUG: PATHSPEC_MAXDEPTH_VALID and PATHSPEC_KEEP_ORDER are incompatible");
+			BUG("PATHSPEC_MAXDEPTH_VALID and PATHSPEC_KEEP_ORDER are incompatible");
 		QSORT(pathspec->items, pathspec->nr, pathspec_item_cmp);
 	}
 }
diff --git a/pkt-line.c b/pkt-line.c
index 2827ca772a3..cd3dab4025a 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -249,7 +249,7 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 	ssize_t ret;
 
 	if (fd >= 0 && src_buf && *src_buf)
-		die("BUG: multiple sources given to packet_read");
+		BUG("multiple sources given to packet_read");
 
 	/* Read up to "size" bytes from our source, whatever it is. */
 	if (src_buf && *src_buf) {
diff --git a/prio-queue.c b/prio-queue.c
index 126d0967273..a0784518723 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -20,7 +20,7 @@ void prio_queue_reverse(struct prio_queue *queue)
 	int i, j;
 
 	if (queue->compare != NULL)
-		die("BUG: prio_queue_reverse() on non-LIFO queue");
+		BUG("prio_queue_reverse() on non-LIFO queue");
 	for (i = 0; i < (j = (queue->nr - 1) - i); i++)
 		swap(queue, i, j);
 }
diff --git a/ref-filter.c b/ref-filter.c
index ac82f9f21e1..0291feaf0db 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -751,7 +751,7 @@ static int grab_objectname(const char *name, const struct object_id *oid,
 			v->s = xstrdup(find_unique_abbrev(oid, atom->u.objectname.length));
 			return 1;
 		} else
-			die("BUG: unknown %%(objectname) option");
+			BUG("unknown %%(objectname) option");
 	}
 	return 0;
 }
@@ -1299,7 +1299,7 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		else
 			*s = "";
 	} else
-		die("BUG: unhandled RR_* enum");
+		BUG("unhandled RR_* enum");
 }
 
 char *get_head_description(void)
diff --git a/refs.c b/refs.c
index 8b7a77fe5ee..f7a577c0d60 100644
--- a/refs.c
+++ b/refs.c
@@ -944,10 +944,10 @@ void ref_transaction_free(struct ref_transaction *transaction)
 		/* OK */
 		break;
 	case REF_TRANSACTION_PREPARED:
-		die("BUG: free called on a prepared reference transaction");
+		BUG("free called on a prepared reference transaction");
 		break;
 	default:
-		die("BUG: unexpected reference transaction state");
+		BUG("unexpected reference transaction state");
 		break;
 	}
 
@@ -969,7 +969,7 @@ struct ref_update *ref_transaction_add_update(
 	struct ref_update *update;
 
 	if (transaction->state != REF_TRANSACTION_OPEN)
-		die("BUG: update called for transaction that is not open");
+		BUG("update called for transaction that is not open");
 
 	FLEX_ALLOC_STR(update, refname, refname);
 	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
@@ -1019,7 +1019,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
 	if (!new_oid || is_null_oid(new_oid))
-		die("BUG: create called without valid new_oid");
+		BUG("create called without valid new_oid");
 	return ref_transaction_update(transaction, refname, new_oid,
 				      &null_oid, flags, msg, err);
 }
@@ -1031,7 +1031,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
 	if (old_oid && is_null_oid(old_oid))
-		die("BUG: delete called with old_oid set to zeros");
+		BUG("delete called with old_oid set to zeros");
 	return ref_transaction_update(transaction, refname,
 				      &null_oid, old_oid,
 				      flags, msg, err);
@@ -1044,7 +1044,7 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
 	if (!old_oid)
-		die("BUG: verify called with old_oid set to NULL");
+		BUG("verify called with old_oid set to NULL");
 	return ref_transaction_update(transaction, refname,
 				      NULL, old_oid,
 				      flags, NULL, err);
@@ -1645,7 +1645,7 @@ static struct ref_store *ref_store_init(const char *gitdir,
 	struct ref_store *refs;
 
 	if (!be)
-		die("BUG: reference backend %s is unknown", be_name);
+		BUG("reference backend %s is unknown", be_name);
 
 	refs = be->init(gitdir, flags);
 	return refs;
@@ -1673,7 +1673,7 @@ static void register_ref_store_map(struct hashmap *map,
 		hashmap_init(map, ref_store_hash_cmp, NULL, 0);
 
 	if (hashmap_put(map, alloc_ref_store_hash_entry(name, refs)))
-		die("BUG: %s ref_store '%s' initialized twice", type, name);
+		BUG("%s ref_store '%s' initialized twice", type, name);
 }
 
 struct ref_store *get_submodule_ref_store(const char *submodule)
@@ -1819,7 +1819,7 @@ int ref_update_reject_duplicates(struct string_list *refnames,
 				    refnames->items[i].string);
 			return 1;
 		} else if (cmp > 0) {
-			die("BUG: ref_update_reject_duplicates() received unsorted list");
+			BUG("ref_update_reject_duplicates() received unsorted list");
 		}
 	}
 	return 0;
@@ -1835,13 +1835,13 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 		/* Good. */
 		break;
 	case REF_TRANSACTION_PREPARED:
-		die("BUG: prepare called twice on reference transaction");
+		BUG("prepare called twice on reference transaction");
 		break;
 	case REF_TRANSACTION_CLOSED:
-		die("BUG: prepare called on a closed reference transaction");
+		BUG("prepare called on a closed reference transaction");
 		break;
 	default:
-		die("BUG: unexpected reference transaction state");
+		BUG("unexpected reference transaction state");
 		break;
 	}
 
@@ -1868,10 +1868,10 @@ int ref_transaction_abort(struct ref_transaction *transaction,
 		ret = refs->be->transaction_abort(refs, transaction, err);
 		break;
 	case REF_TRANSACTION_CLOSED:
-		die("BUG: abort called on a closed reference transaction");
+		BUG("abort called on a closed reference transaction");
 		break;
 	default:
-		die("BUG: unexpected reference transaction state");
+		BUG("unexpected reference transaction state");
 		break;
 	}
 
@@ -1896,10 +1896,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		/* Fall through to finish. */
 		break;
 	case REF_TRANSACTION_CLOSED:
-		die("BUG: commit called on a closed reference transaction");
+		BUG("commit called on a closed reference transaction");
 		break;
 	default:
-		die("BUG: unexpected reference transaction state");
+		BUG("unexpected reference transaction state");
 		break;
 	}
 
@@ -1980,7 +1980,7 @@ int refs_verify_refname_available(struct ref_store *refs,
 	}
 
 	if (ok != ITER_DONE)
-		die("BUG: error while iterating over references");
+		BUG("error while iterating over references");
 
 	extra_refname = find_descendant_ref(dirname.buf, extras, skip);
 	if (extra_refname)
diff --git a/remote.c b/remote.c
index 91eb010ca98..63c41787882 100644
--- a/remote.c
+++ b/remote.c
@@ -1819,7 +1819,7 @@ static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
 		}
 	}
 
-	die("BUG: unhandled push situation");
+	BUG("unhandled push situation");
 }
 
 const char *branch_get_push(struct branch *branch, struct strbuf *err)
diff --git a/revision.c b/revision.c
index b42c836d7a6..67f8e74cbb3 100644
--- a/revision.c
+++ b/revision.c
@@ -2107,7 +2107,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->ignore_missing = 1;
 	} else if (!strcmp(arg, "--exclude-promisor-objects")) {
 		if (fetch_if_missing)
-			die("BUG: exclude_promisor_objects can only be used when fetch_if_missing is 0");
+			BUG("exclude_promisor_objects can only be used when fetch_if_missing is 0");
 		revs->exclude_promisor_objects = 1;
 	} else {
 		int opts = diff_opt_parse(&revs->diffopt, argv, argc, revs->prefix);
@@ -2173,7 +2173,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		 * supported right now, so stick to single worktree.
 		 */
 		if (!revs->single_worktree)
-			die("BUG: --single-worktree cannot be used together with submodule");
+			BUG("--single-worktree cannot be used together with submodule");
 		refs = get_submodule_ref_store(submodule);
 	} else
 		refs = get_main_ref_store();
diff --git a/run-command.c b/run-command.c
index 0ad6f135d5a..84b883c2132 100644
--- a/run-command.c
+++ b/run-command.c
@@ -245,7 +245,7 @@ int sane_execvp(const char *file, char * const argv[])
 static const char **prepare_shell_cmd(struct argv_array *out, const char **argv)
 {
 	if (!argv[0])
-		die("BUG: shell command is empty");
+		BUG("shell command is empty");
 
 	if (strcspn(argv[0], "|&;<>()$`\\\"' \t\n*?[#~=%") != strlen(argv[0])) {
 #ifndef GIT_WINDOWS_NATIVE
@@ -383,7 +383,7 @@ static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
 static void prepare_cmd(struct argv_array *out, const struct child_process *cmd)
 {
 	if (!cmd->argv[0])
-		die("BUG: command is empty");
+		BUG("command is empty");
 
 	/*
 	 * Add SHELL_PATH so in the event exec fails with ENOEXEC we can
@@ -964,7 +964,7 @@ int run_command(struct child_process *cmd)
 	int code;
 
 	if (cmd->out < 0 || cmd->err < 0)
-		die("BUG: run_command with a pipe can cause deadlock");
+		BUG("run_command with a pipe can cause deadlock");
 
 	code = start_command(cmd);
 	if (code)
@@ -1554,7 +1554,7 @@ static void pp_init(struct parallel_processes *pp,
 
 	pp->data = data;
 	if (!get_next_task)
-		die("BUG: you need to specify a get_next_task function");
+		BUG("you need to specify a get_next_task function");
 	pp->get_next_task = get_next_task;
 
 	pp->start_failure = start_failure ? start_failure : default_start_failure;
@@ -1616,7 +1616,7 @@ static int pp_start_one(struct parallel_processes *pp)
 		if (pp->children[i].state == GIT_CP_FREE)
 			break;
 	if (i == pp->max_processes)
-		die("BUG: bookkeeping is hard");
+		BUG("bookkeeping is hard");
 
 	code = pp->get_next_task(&pp->children[i].process,
 				 &pp->children[i].err,
diff --git a/setup.c b/setup.c
index 3e03d442b6f..b24c811c1c3 100644
--- a/setup.c
+++ b/setup.c
@@ -539,7 +539,7 @@ void read_gitfile_error_die(int error_code, const char *path, const char *dir)
 	case READ_GITFILE_ERR_NOT_A_REPO:
 		die(_("not a git repository: %s"), dir);
 	default:
-		die("BUG: unknown error code");
+		BUG("unknown error code");
 	}
 }
 
@@ -1086,7 +1086,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		      "Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
 		    dir.buf);
 	default:
-		die("BUG: unhandled setup_git_directory_1() result");
+		BUG("unhandled setup_git_directory_1() result");
 	}
 
 	if (prefix)
diff --git a/sha1-lookup.c b/sha1-lookup.c
index 8d0b1db3e27..796ab68da83 100644
--- a/sha1-lookup.c
+++ b/sha1-lookup.c
@@ -81,7 +81,7 @@ int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
 				mi = (nr - 1) * (miv - lov) / (hiv - lov);
 				if (lo <= mi && mi < hi)
 					break;
-				die("BUG: assertion failed in binary search");
+				BUG("assertion failed in binary search");
 			}
 		}
 	}
diff --git a/sha1-name.c b/sha1-name.c
index 5b93bf8da36..60d04bf74e1 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -384,7 +384,7 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
 		return -1;
 
 	if (HAS_MULTI_BITS(flags & GET_OID_DISAMBIGUATORS))
-		die("BUG: multiple get_short_oid disambiguator flags");
+		BUG("multiple get_short_oid disambiguator flags");
 
 	if (flags & GET_OID_COMMIT)
 		ds.fn = disambiguate_commit_only;
@@ -1729,6 +1729,6 @@ void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
 int get_oid_with_context(const char *str, unsigned flags, struct object_id *oid, struct object_context *oc)
 {
 	if (flags & GET_OID_FOLLOW_SYMLINKS && flags & GET_OID_ONLY_TO_DIE)
-		die("BUG: incompatible flags for get_sha1_with_context");
+		BUG("incompatible flags for get_sha1_with_context");
 	return get_oid_with_context_1(str, flags, NULL, oid, oc);
 }
diff --git a/shallow.c b/shallow.c
index df4d44ea7a3..c7b6b3d9d8a 100644
--- a/shallow.c
+++ b/shallow.c
@@ -20,7 +20,7 @@ static char *alternate_shallow_file;
 void set_alternate_shallow_file(const char *path, int override)
 {
 	if (is_shallow != -1)
-		die("BUG: is_repository_shallow must not be called before set_alternate_shallow_file");
+		BUG("is_repository_shallow must not be called before set_alternate_shallow_file");
 	if (alternate_shallow_file && !override)
 		return;
 	free(alternate_shallow_file);
@@ -218,7 +218,7 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 static void check_shallow_file_for_update(void)
 {
 	if (is_shallow == -1)
-		die("BUG: shallow must be initialized by now");
+		BUG("shallow must be initialized by now");
 
 	if (!stat_validity_check(&shallow_stat, git_path_shallow()))
 		die("shallow file has changed since we read it");
@@ -446,7 +446,7 @@ static uint32_t *paint_alloc(struct paint_info *info)
 	void *p;
 	if (!info->pool_count || size > info->end - info->free) {
 		if (size > POOL_SIZE)
-			die("BUG: pool size too small for %d in paint_alloc()",
+			BUG("pool size too small for %d in paint_alloc()",
 			    size);
 		info->pool_count++;
 		REALLOC_ARRAY(info->pools, info->pool_count);
diff --git a/sigchain.c b/sigchain.c
index 2ac43bbd282..022677b6aba 100644
--- a/sigchain.c
+++ b/sigchain.c
@@ -13,7 +13,7 @@ static struct sigchain_signal signals[SIGCHAIN_MAX_SIGNALS];
 static void check_signum(int sig)
 {
 	if (sig < 1 || sig >= SIGCHAIN_MAX_SIGNALS)
-		die("BUG: signal out of range: %d", sig);
+		BUG("signal out of range: %d", sig);
 }
 
 int sigchain_push(int sig, sigchain_fun f)
diff --git a/strbuf.c b/strbuf.c
index 43a840c67b3..2954622c103 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -309,12 +309,12 @@ void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap)
 	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, cp);
 	va_end(cp);
 	if (len < 0)
-		die("BUG: your vsnprintf is broken (returned %d)", len);
+		BUG("your vsnprintf is broken (returned %d)", len);
 	if (len > strbuf_avail(sb)) {
 		strbuf_grow(sb, len);
 		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
 		if (len > strbuf_avail(sb))
-			die("BUG: your vsnprintf is broken (insatiable)");
+			BUG("your vsnprintf is broken (insatiable)");
 	}
 	strbuf_setlen(sb, sb->len + len);
 }
diff --git a/submodule.c b/submodule.c
index 9a50168b237..733db441714 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1398,7 +1398,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 		    buf.buf[0] == '2') {
 			/* T = line type, XY = status, SSSS = submodule state */
 			if (buf.len < strlen("T XY SSSS"))
-				die("BUG: invalid status --porcelain=2 line %s",
+				BUG("invalid status --porcelain=2 line %s",
 				    buf.buf);
 
 			if (buf.buf[5] == 'S' && buf.buf[8] == 'U')
@@ -1607,7 +1607,7 @@ int submodule_move_head(const char *path,
 	sub = submodule_from_path(&null_oid, path);
 
 	if (!sub)
-		die("BUG: could not get submodule information for '%s'", path);
+		BUG("could not get submodule information for '%s'", path);
 
 	if (old_head && !(flags & SUBMODULE_MOVE_HEAD_FORCE)) {
 		/* Check if the submodule has a dirty index. */
@@ -1965,7 +1965,7 @@ void absorb_git_dir_into_superproject(const char *prefix,
 		struct strbuf sb = STRBUF_INIT;
 
 		if (flags & ~ABSORB_GITDIR_RECURSE_SUBMODULES)
-			die("BUG: we don't know how to pass the flags down?");
+			BUG("we don't know how to pass the flags down?");
 
 		strbuf_addstr(&sb, get_super_prefix_or_empty());
 		strbuf_addstr(&sb, path);
diff --git a/t/helper/test-example-decorate.c b/t/helper/test-example-decorate.c
index 081115bf8eb..a20a6161e4f 100644
--- a/t/helper/test-example-decorate.c
+++ b/t/helper/test-example-decorate.c
@@ -30,10 +30,10 @@ int cmd__example_decorate(int argc, const char **argv)
 	two = lookup_unknown_object(two_oid.hash);
 	ret = add_decoration(&n, one, &decoration_a);
 	if (ret)
-		die("BUG: when adding a brand-new object, NULL should be returned");
+		BUG("when adding a brand-new object, NULL should be returned");
 	ret = add_decoration(&n, two, NULL);
 	if (ret)
-		die("BUG: when adding a brand-new object, NULL should be returned");
+		BUG("when adding a brand-new object, NULL should be returned");
 
 	/*
 	 * When re-adding an already existing object, the old decoration is
@@ -41,10 +41,10 @@ int cmd__example_decorate(int argc, const char **argv)
 	 */
 	ret = add_decoration(&n, one, NULL);
 	if (ret != &decoration_a)
-		die("BUG: when readding an already existing object, existing decoration should be returned");
+		BUG("when readding an already existing object, existing decoration should be returned");
 	ret = add_decoration(&n, two, &decoration_b);
 	if (ret)
-		die("BUG: when readding an already existing object, existing decoration should be returned");
+		BUG("when readding an already existing object, existing decoration should be returned");
 
 	/*
 	 * Lookup returns the added declarations, or NULL if the object was
@@ -52,14 +52,14 @@ int cmd__example_decorate(int argc, const char **argv)
 	 */
 	ret = lookup_decoration(&n, one);
 	if (ret)
-		die("BUG: lookup should return added declaration");
+		BUG("lookup should return added declaration");
 	ret = lookup_decoration(&n, two);
 	if (ret != &decoration_b)
-		die("BUG: lookup should return added declaration");
+		BUG("lookup should return added declaration");
 	three = lookup_unknown_object(three_oid.hash);
 	ret = lookup_decoration(&n, three);
 	if (ret)
-		die("BUG: lookup for unknown object should return NULL");
+		BUG("lookup for unknown object should return NULL");
 
 	/*
 	 * The user can also loop through all entries.
@@ -69,7 +69,7 @@ int cmd__example_decorate(int argc, const char **argv)
 			objects_noticed++;
 	}
 	if (objects_noticed != 2)
-		die("BUG: should have 2 objects");
+		BUG("should have 2 objects");
 
 	return 0;
 }
diff --git a/tmp-objdir.c b/tmp-objdir.c
index fea3f55545c..91c00567f4d 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -127,7 +127,7 @@ struct tmp_objdir *tmp_objdir_create(void)
 	struct tmp_objdir *t;
 
 	if (the_tmp_objdir)
-		die("BUG: only one tmp_objdir can be used at a time");
+		BUG("only one tmp_objdir can be used at a time");
 
 	t = xmalloc(sizeof(*t));
 	strbuf_init(&t->path, 0);
diff --git a/trailer.c b/trailer.c
index c508c9b7521..4e309460d13 100644
--- a/trailer.c
+++ b/trailer.c
@@ -298,7 +298,7 @@ static void apply_arg_if_exists(struct trailer_item *in_tok,
 			free_arg_item(arg_tok);
 		break;
 	default:
-		die("BUG: trailer.c: unhandled value %d",
+		BUG("trailer.c: unhandled value %d",
 		    arg_tok->conf.if_exists);
 	}
 }
@@ -323,7 +323,7 @@ static void apply_arg_if_missing(struct list_head *head,
 			list_add(&to_add->list, head);
 		break;
 	default:
-		die("BUG: trailer.c: unhandled value %d",
+		BUG("trailer.c: unhandled value %d",
 		    arg_tok->conf.if_missing);
 	}
 }
@@ -557,7 +557,7 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 			warning(_("unknown value '%s' for key '%s'"), value, conf_key);
 		break;
 	default:
-		die("BUG: trailer.c: unhandled type %d", type);
+		BUG("trailer.c: unhandled type %d", type);
 	}
 	return 0;
 }
diff --git a/transport.c b/transport.c
index 94eccf29aa3..969645ccb13 100644
--- a/transport.c
+++ b/transport.c
@@ -636,7 +636,7 @@ void transport_take_over(struct transport *transport,
 	struct git_transport_data *data;
 
 	if (!transport->smart_options)
-		die("BUG: taking over transport requires non-NULL "
+		BUG("taking over transport requires non-NULL "
 		    "smart_options field.");
 
 	data = xcalloc(1, sizeof(*data));
@@ -761,7 +761,7 @@ int is_transport_allowed(const char *type, int from_user)
 		return from_user;
 	}
 
-	die("BUG: invalid protocol_allow_config type");
+	BUG("invalid protocol_allow_config type");
 }
 
 void transport_check_allowed(const char *type)
diff --git a/unpack-trees.c b/unpack-trees.c
index e73745051e5..4239dfd285e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -398,7 +398,7 @@ static int check_updates(struct unpack_trees_options *o)
 
 		if (ce->ce_flags & CE_UPDATE) {
 			if (ce->ce_flags & CE_WT_REMOVE)
-				die("BUG: both update and delete flags are set on %s",
+				BUG("both update and delete flags are set on %s",
 				    ce->name);
 			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
diff --git a/worktree.c b/worktree.c
index 28989cf06ef..97cda5f97bb 100644
--- a/worktree.c
+++ b/worktree.c
@@ -338,7 +338,7 @@ void update_worktree_location(struct worktree *wt, const char *path_)
 	struct strbuf path = STRBUF_INIT;
 
 	if (is_main_worktree(wt))
-		die("BUG: can't relocate main worktree");
+		BUG("can't relocate main worktree");
 
 	strbuf_realpath(&path, path_, 1);
 	if (fspathcmp(wt->path, path.buf)) {
diff --git a/wrapper.c b/wrapper.c
index 1fd5e33ea8f..e4fa9d84cd0 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -643,9 +643,9 @@ int xsnprintf(char *dst, size_t max, const char *fmt, ...)
 	va_end(ap);
 
 	if (len < 0)
-		die("BUG: your snprintf is broken");
+		BUG("your snprintf is broken");
 	if (len >= max)
-		die("BUG: attempt to snprintf into too-small buffer");
+		BUG("attempt to snprintf into too-small buffer");
 	return len;
 }
 
diff --git a/wt-status.c b/wt-status.c
index 50815e5faff..26d037610ee 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -264,7 +264,7 @@ static const char *wt_status_unmerged_status_string(int stagemask)
 	case 7:
 		return _("both modified:");
 	default:
-		die("BUG: unhandled unmerged status %x", stagemask);
+		BUG("unhandled unmerged status %x", stagemask);
 	}
 }
 
@@ -377,7 +377,7 @@ static void wt_longstatus_print_change_data(struct wt_status *s,
 		status = d->worktree_status;
 		break;
 	default:
-		die("BUG: unhandled change_type %d in wt_longstatus_print_change_data",
+		BUG("unhandled change_type %d in wt_longstatus_print_change_data",
 		    change_type);
 	}
 
@@ -395,7 +395,7 @@ static void wt_longstatus_print_change_data(struct wt_status *s,
 	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
 	what = wt_status_diff_status_string(status);
 	if (!what)
-		die("BUG: unhandled diff status %c", status);
+		BUG("unhandled diff status %c", status);
 	len = label_width - utf8_strwidth(what);
 	assert(len >= 0);
 	if (one_name != two_name)
@@ -470,7 +470,7 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 		case DIFF_STATUS_COPIED:
 		case DIFF_STATUS_RENAMED:
 			if (d->rename_status)
-				die("BUG: multiple renames on the same target? how?");
+				BUG("multiple renames on the same target? how?");
 			d->rename_source = xstrdup(p->one->path);
 			d->rename_score = p->score * 100 / MAX_SCORE;
 			d->rename_status = p->status;
@@ -484,7 +484,7 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 			break;
 
 		default:
-			die("BUG: unhandled diff-files status '%c'", p->status);
+			BUG("unhandled diff-files status '%c'", p->status);
 			break;
 		}
 
@@ -547,7 +547,7 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
 		case DIFF_STATUS_COPIED:
 		case DIFF_STATUS_RENAMED:
 			if (d->rename_status)
-				die("BUG: multiple renames on the same target? how?");
+				BUG("multiple renames on the same target? how?");
 			d->rename_source = xstrdup(p->one->path);
 			d->rename_score = p->score * 100 / MAX_SCORE;
 			d->rename_status = p->status;
@@ -569,7 +569,7 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
 			break;
 
 		default:
-			die("BUG: unhandled diff-index status '%c'", p->status);
+			BUG("unhandled diff-index status '%c'", p->status);
 			break;
 		}
 	}
@@ -2158,7 +2158,7 @@ static void wt_porcelain_v2_print_unmerged_entry(
 	case 6: key = "AA"; break; /* both added */
 	case 7: key = "UU"; break; /* both modified */
 	default:
-		die("BUG: unhandled unmerged status %x", d->stagemask);
+		BUG("unhandled unmerged status %x", d->stagemask);
 	}
 
 	/*
@@ -2185,7 +2185,7 @@ static void wt_porcelain_v2_print_unmerged_entry(
 		sum |= (1 << (stage - 1));
 	}
 	if (sum != d->stagemask)
-		die("BUG: observed stagemask 0x%x != expected stagemask 0x%x", sum, d->stagemask);
+		BUG("observed stagemask 0x%x != expected stagemask 0x%x", sum, d->stagemask);
 
 	if (s->null_termination)
 		path_index = it->string;
@@ -2289,7 +2289,7 @@ void wt_status_print(struct wt_status *s)
 		wt_porcelain_v2_print(s);
 		break;
 	case STATUS_FORMAT_UNSPECIFIED:
-		die("BUG: finalize_deferred_config() should have been called");
+		BUG("finalize_deferred_config() should have been called");
 		break;
 	case STATUS_FORMAT_NONE:
 	case STATUS_FORMAT_LONG:
diff --git a/zlib.c b/zlib.c
index 4223f1a8c57..d594cba3fc9 100644
--- a/zlib.c
+++ b/zlib.c
@@ -52,9 +52,9 @@ static void zlib_post_call(git_zstream *s)
 	bytes_consumed = s->z.next_in - s->next_in;
 	bytes_produced = s->z.next_out - s->next_out;
 	if (s->z.total_out != s->total_out + bytes_produced)
-		die("BUG: total_out mismatch");
+		BUG("total_out mismatch");
 	if (s->z.total_in != s->total_in + bytes_consumed)
-		die("BUG: total_in mismatch");
+		BUG("total_in mismatch");
 
 	s->total_out = s->z.total_out;
 	s->total_in = s->z.total_in;
-- 
2.17.0.windows.1.36.gdf4ca5fb72a


