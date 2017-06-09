Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17D6A1F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 22:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751724AbdFIWEr (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 18:04:47 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:33054 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbdFIWEo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 18:04:44 -0400
Received: by mail-qt0-f178.google.com with SMTP id u12so90814483qth.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 15:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aeEdA3NaOXm819hlvI8bDR2Dy1mIGiKhVGn0+hgbFxs=;
        b=hOamBsWlyUElLnk/cvJT+ZSOzW/omDwu1kZq4JDJ0Jw/NpslpJucURPBm3fCZV+DsQ
         FmLWDz5j1zb1g2iZhhShN+ySvBs3hOoDLZgarWBaMoPeYwvpm9NkFjlGYjKpwcKSqdnV
         2WO9e5DPrrGIG8/+mpKflVjzleICwktIiFX5gaM+tTZ48hWTVyFIQAzzkUr6A2qitHrg
         xljR+UniMa+zIin+R0JAS3mg2OT55tCDPloaFsEZrFsdo4TKc/IHdX4emwkj3oIB5TcU
         /Vq0LDm0pPbZUd/EZb/rKWdyIf4bPbu5CTzatZ2iWHD4DA91zqjKmSKBthSYOh0vKMWD
         JInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aeEdA3NaOXm819hlvI8bDR2Dy1mIGiKhVGn0+hgbFxs=;
        b=uBtQGWGkznrG7OTa8rSXG+e4ZuYDnwaLxZWUSsOUQarVN4V0LXMKykrK3sXQK/vg4a
         D0RpzPEMNBcz3AdlRf3QXa239Nl3F1Ene6rgs8PCLRFvh/EAyknKPH3TyIfmxsJ7qOiF
         tR540zwXWR+nU22R+mMYGP3o9z5SGyKPxjV3LEuepxczC3RI+z/tCeEHjvzJ7XQ5QowA
         1e3Cocs5xxXAFVL1JkMa0kQRv58+3KoPp5n2S/KqXzLJlo4M53wcsrXOcXZCqfFFDc7s
         d2EXNbk2uimT85G2JlyyZ68z6+JEXwVwxeGD07B2jz5O+GHxNE5Mfnr2oNm8WCwXI2Jn
         f7Xw==
X-Gm-Message-State: AKS2vOxr1OgB7AaQ/yYyHLLGGWf1AIPCd2OCUkKhEhRG1HXsjz4TMoEV
        CwMHdlzbg73hoQkHvK0=
X-Received: by 10.55.215.153 with SMTP id t25mr52085100qkt.6.1497045882571;
        Fri, 09 Jun 2017 15:04:42 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j65sm1523444qkf.38.2017.06.09.15.04.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2017 15:04:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] *.[ch] refactoring: make use of the FREEZ() macro
Date:   Fri,  9 Jun 2017 22:04:20 +0000
Message-Id: <20170609220420.4910-3-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc
In-Reply-To: <20170609220420.4910-1-avarab@gmail.com>
References: <20170609220420.4910-1-avarab@gmail.com>
In-Reply-To: <20170609085346.19974-1-avarab@gmail.com>
References: <20170609085346.19974-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace occurrences of `free(ptr); ptr = NULL` with `FREEZ(ptr)`. This
introduces no functional changes, but reduces the line count and
establishes this pattern as a common idiom with a wrapper macro.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 alias.c                  |  6 ++----
 apply.c                  |  3 +--
 attr.c                   |  6 ++----
 blame.c                  |  3 +--
 branch.c                 |  3 +--
 builtin/am.c             | 18 +++++-------------
 builtin/clean.c          |  6 ++----
 builtin/config.c         |  6 ++----
 builtin/index-pack.c     |  6 ++----
 builtin/pack-objects.c   | 12 ++++--------
 builtin/unpack-objects.c |  3 +--
 builtin/worktree.c       |  6 ++----
 commit-slab.h            |  3 +--
 commit.c                 |  3 +--
 config.c                 |  3 +--
 credential.c             |  9 +++------
 diff-lib.c               |  3 +--
 diff.c                   |  6 ++----
 diffcore-rename.c        |  6 ++----
 dir.c                    |  9 +++------
 fast-import.c            |  6 ++----
 gpg-interface.c          | 15 +++++----------
 grep.c                   | 12 ++++--------
 help.c                   |  3 +--
 http-push.c              | 24 ++++++++----------------
 http.c                   | 15 +++++----------
 imap-send.c              |  3 +--
 line-log.c               |  6 ++----
 ll-merge.c               |  3 +--
 mailinfo.c               |  3 +--
 object.c                 |  3 +--
 pathspec.c               |  3 +--
 prio-queue.c             |  3 +--
 read-cache.c             |  6 ++----
 ref-filter.c             |  3 +--
 refs/files-backend.c     |  3 +--
 refs/ref-cache.c         |  3 +--
 remote-testsvn.c         |  3 +--
 rerere.c                 |  3 +--
 sequencer.c              |  3 +--
 sha1-array.c             |  3 +--
 sha1_file.c              |  3 +--
 split-index.c            |  3 +--
 transport-helper.c       | 27 +++++++++------------------
 transport.c              |  3 +--
 tree-diff.c              |  6 ++----
 tree-walk.c              |  3 +--
 tree.c                   |  3 +--
 48 files changed, 97 insertions(+), 197 deletions(-)

diff --git a/alias.c b/alias.c
index 3b90397a99..a8cef09650 100644
--- a/alias.c
+++ b/alias.c
@@ -47,8 +47,7 @@ int split_cmdline(char *cmdline, const char ***argv)
 				src++;
 				c = cmdline[src];
 				if (!c) {
-					free(*argv);
-					*argv = NULL;
+					FREEZ(*argv);
 					return -SPLIT_CMDLINE_BAD_ENDING;
 				}
 			}
@@ -60,8 +59,7 @@ int split_cmdline(char *cmdline, const char ***argv)
 	cmdline[dst] = 0;
 
 	if (quoted) {
-		free(*argv);
-		*argv = NULL;
+		FREEZ(*argv);
 		return -SPLIT_CMDLINE_UNCLOSED_QUOTE;
 	}
 
diff --git a/apply.c b/apply.c
index c49cef0637..f11330bbfe 100644
--- a/apply.c
+++ b/apply.c
@@ -3705,8 +3705,7 @@ static int check_preimage(struct apply_state *state,
  is_new:
 	patch->is_new = 1;
 	patch->is_delete = 0;
-	free(patch->old_name);
-	patch->old_name = NULL;
+	FREEZ(patch->old_name);
 	return 0;
 }
 
diff --git a/attr.c b/attr.c
index 7e2134471c..0b550695d5 100644
--- a/attr.c
+++ b/attr.c
@@ -638,13 +638,11 @@ void attr_check_reset(struct attr_check *check)
 
 void attr_check_clear(struct attr_check *check)
 {
-	free(check->items);
-	check->items = NULL;
+	FREEZ(check->items);
 	check->alloc = 0;
 	check->nr = 0;
 
-	free(check->all_attrs);
-	check->all_attrs = NULL;
+	FREEZ(check->all_attrs);
 	check->all_attrs_nr = 0;
 
 	drop_attr_stack(&check->stack);
diff --git a/blame.c b/blame.c
index 843c845cba..5b2eac3915 100644
--- a/blame.c
+++ b/blame.c
@@ -314,8 +314,7 @@ static void fill_origin_blob(struct diff_options *opt,
 static void drop_origin_blob(struct blame_origin *o)
 {
 	if (o->file.ptr) {
-		free(o->file.ptr);
-		o->file.ptr = NULL;
+		FREEZ(o->file.ptr);
 	}
 }
 
diff --git a/branch.c b/branch.c
index 985316eb76..b2fce80706 100644
--- a/branch.c
+++ b/branch.c
@@ -24,8 +24,7 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 		} else {
 			free(tracking->spec.src);
 			if (tracking->src) {
-				free(tracking->src);
-				tracking->src = NULL;
+				FREEZ(tracking->src);
 			}
 		}
 		tracking->spec.src = NULL;
diff --git a/builtin/am.c b/builtin/am.c
index 5ee146bfb3..f665239dc3 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -483,8 +483,7 @@ static int run_applypatch_msg_hook(struct am_state *state)
 	ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
 
 	if (!ret) {
-		free(state->msg);
-		state->msg = NULL;
+		FREEZ(state->msg);
 		if (read_commit_msg(state) < 0)
 			die(_("'%s' was deleted by the applypatch-msg hook"),
 				am_path(state, "final-commit"));
@@ -1073,17 +1072,10 @@ static void am_next(struct am_state *state)
 {
 	struct object_id head;
 
-	free(state->author_name);
-	state->author_name = NULL;
-
-	free(state->author_email);
-	state->author_email = NULL;
-
-	free(state->author_date);
-	state->author_date = NULL;
-
-	free(state->msg);
-	state->msg = NULL;
+	FREEZ(state->author_name);
+	FREEZ(state->author_email);
+	FREEZ(state->author_date);
+	FREEZ(state->msg);
 	state->msg_len = 0;
 
 	unlink(am_path(state, "author-script"));
diff --git a/builtin/clean.c b/builtin/clean.c
index 142bf668cf..027ce46505 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -837,8 +837,7 @@ static void interactive_main_loop(void)
 			int ret;
 			ret = menus[*chosen].fn();
 			if (ret != MENU_RETURN_NO_LOOP) {
-				free(chosen);
-				chosen = NULL;
+				FREEZ(chosen);
 				if (!del_list.nr) {
 					clean_print_color(CLEAN_COLOR_ERROR);
 					printf_ln(_("No more files to clean, exiting."));
@@ -851,8 +850,7 @@ static void interactive_main_loop(void)
 			quit_cmd();
 		}
 
-		free(chosen);
-		chosen = NULL;
+		FREEZ(chosen);
 		break;
 	}
 }
diff --git a/builtin/config.c b/builtin/config.c
index 7f6c25d4d9..f2b698971c 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -214,8 +214,7 @@ static int get_value(const char *key_, const char *regex_)
 		key_regexp = (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(key_regexp, key, REG_EXTENDED)) {
 			error("invalid key pattern: %s", key_);
-			free(key_regexp);
-			key_regexp = NULL;
+			FREEZ(key_regexp);
 			ret = CONFIG_INVALID_PATTERN;
 			goto free_strings;
 		}
@@ -235,8 +234,7 @@ static int get_value(const char *key_, const char *regex_)
 		regexp = (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(regexp, regex_, REG_EXTENDED)) {
 			error("invalid pattern: %s", regex_);
-			free(regexp);
-			regexp = NULL;
+			FREEZ(regexp);
 			ret = CONFIG_INVALID_PATTERN;
 			goto free_strings;
 		}
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 04b9dcaf0f..17c86168fb 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -388,8 +388,7 @@ static struct base_data *alloc_base_data(void)
 static void free_base_data(struct base_data *c)
 {
 	if (c->data) {
-		free(c->data);
-		c->data = NULL;
+		FREEZ(c->data);
 		get_thread_data()->base_cache_used -= c->size;
 	}
 }
@@ -605,8 +604,7 @@ static void *unpack_data(struct object_entry *obj,
 	git_inflate_end(&stream);
 	free(inbuf);
 	if (consume) {
-		free(data);
-		data = NULL;
+		FREEZ(data);
 	}
 	return data;
 }
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f672225def..451079b2f2 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -264,8 +264,7 @@ static unsigned long write_no_reuse_object(struct sha1file *f, struct object_ent
 		 * make sure no cached delta data remains from a
 		 * previous attempt before a pack split occurred.
 		 */
-		free(entry->delta_data);
-		entry->delta_data = NULL;
+		FREEZ(entry->delta_data);
 		entry->z_delta_size = 0;
 	} else if (entry->delta_data) {
 		size = entry->delta_size;
@@ -1375,12 +1374,10 @@ static void cleanup_preferred_base(void)
 		if (!pbase_tree_cache[i])
 			continue;
 		free(pbase_tree_cache[i]->tree_data);
-		free(pbase_tree_cache[i]);
-		pbase_tree_cache[i] = NULL;
+		FREEZ(pbase_tree_cache[i]);
 	}
 
-	free(done_pbase_paths);
-	done_pbase_paths = NULL;
+	FREEZ(done_pbase_paths);
 	done_pbase_paths_num = done_pbase_paths_alloc = 0;
 }
 
@@ -1970,8 +1967,7 @@ static unsigned long free_unpacked(struct unpacked *n)
 	n->index = NULL;
 	if (n->data) {
 		freed_mem += n->entry->size;
-		free(n->data);
-		n->data = NULL;
+		FREEZ(n->data);
 	}
 	n->entry = NULL;
 	n->depth = 0;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 8bc9997767..402232dc4d 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -112,8 +112,7 @@ static void *get_data(unsigned long size)
 			break;
 		if (ret != Z_OK) {
 			error("inflate returned %d", ret);
-			free(buf);
-			buf = NULL;
+			FREEZ(buf);
 			if (!recover)
 				exit(1);
 			has_errors = 1;
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 793306ea51..2371fef396 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -299,10 +299,8 @@ static int add_worktree(const char *path, const char *refname,
 	}
 
 	is_junk = 0;
-	free(junk_work_tree);
-	free(junk_git_dir);
-	junk_work_tree = NULL;
-	junk_git_dir = NULL;
+	FREEZ(junk_work_tree);
+	FREEZ(junk_git_dir);
 
 done:
 	if (ret || !opts->keep_locked) {
diff --git a/commit-slab.h b/commit-slab.h
index 42d16dcded..a239112360 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -82,8 +82,7 @@ static MAYBE_UNUSED void clear_ ##slabname(struct slabname *s)		\
 	for (i = 0; i < s->slab_count; i++)				\
 		free(s->slab[i]);					\
 	s->slab_count = 0;						\
-	free(s->slab);							\
-	s->slab = NULL;							\
+	FREEZ(s->slab);							\
 }									\
 									\
 static MAYBE_UNUSED elemtype *slabname## _at_peek(struct slabname *s,	\
diff --git a/commit.c b/commit.c
index 713f09feb0..82c80fdd5e 100644
--- a/commit.c
+++ b/commit.c
@@ -287,8 +287,7 @@ void free_commit_buffer(struct commit *commit)
 {
 	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
 	if (v) {
-		free(v->buffer);
-		v->buffer = NULL;
+		FREEZ(v->buffer);
 		v->size = 0;
 	}
 }
diff --git a/config.c b/config.c
index 146cb3452a..fa366d1c18 100644
--- a/config.c
+++ b/config.c
@@ -395,8 +395,7 @@ static int git_config_parse_key_1(const char *key, char **store_key, int *basele
 
 out_free_ret_1:
 	if (store_key) {
-		free(*store_key);
-		*store_key = NULL;
+		FREEZ(*store_key);
 	}
 	return -CONFIG_INVALID_KEY;
 }
diff --git a/credential.c b/credential.c
index aa996669fc..73650483b6 100644
--- a/credential.c
+++ b/credential.c
@@ -93,8 +93,7 @@ static void credential_apply_config(struct credential *c)
 	c->configured = 1;
 
 	if (!c->use_http_path && proto_is_http(c->protocol)) {
-		free(c->path);
-		c->path = NULL;
+		FREEZ(c->path);
 	}
 }
 
@@ -314,10 +313,8 @@ void credential_reject(struct credential *c)
 	for (i = 0; i < c->helpers.nr; i++)
 		credential_do(c, c->helpers.items[i].string, "erase");
 
-	free(c->username);
-	c->username = NULL;
-	free(c->password);
-	c->password = NULL;
+	FREEZ(c->username);
+	FREEZ(c->password);
 	c->approved = 0;
 }
 
diff --git a/diff-lib.c b/diff-lib.c
index 2982bf055a..1130a9c9d9 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -179,8 +179,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				free(dpath);
 				continue;
 			}
-			free(dpath);
-			dpath = NULL;
+			FREEZ(dpath);
 
 			/*
 			 * Show the diff for the 'ce' if we found the one
diff --git a/diff.c b/diff.c
index 5275c4b780..db9282d731 100644
--- a/diff.c
+++ b/diff.c
@@ -1218,8 +1218,7 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
 			regfree(ecbdata->diff_words->word_regex);
 			free(ecbdata->diff_words->word_regex);
 		}
-		free(ecbdata->diff_words);
-		ecbdata->diff_words = NULL;
+		FREEZ(ecbdata->diff_words);
 	}
 }
 
@@ -2951,8 +2950,7 @@ void diff_free_filespec_blob(struct diff_filespec *s)
 void diff_free_filespec_data(struct diff_filespec *s)
 {
 	diff_free_filespec_blob(s);
-	free(s->cnt_data);
-	s->cnt_data = NULL;
+	FREEZ(s->cnt_data);
 }
 
 static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
diff --git a/diffcore-rename.c b/diffcore-rename.c
index f7444c86bd..f9428082bc 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -667,11 +667,9 @@ void diffcore_rename(struct diff_options *options)
 	for (i = 0; i < rename_dst_nr; i++)
 		free_filespec(rename_dst[i].two);
 
-	free(rename_dst);
-	rename_dst = NULL;
+	FREEZ(rename_dst);
 	rename_dst_nr = rename_dst_alloc = 0;
-	free(rename_src);
-	rename_src = NULL;
+	FREEZ(rename_src);
 	rename_src_nr = rename_src_alloc = 0;
 	return;
 }
diff --git a/dir.c b/dir.c
index 9efcf1eab6..0d4e7e6bfa 100644
--- a/dir.c
+++ b/dir.c
@@ -2117,8 +2117,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 		for (i = j = 0; j < dir->nr; j++) {
 			if (i &&
 			    check_dir_entry_contains(dir->entries[i - 1], dir->entries[j])) {
-				free(dir->entries[j]);
-				dir->entries[j] = NULL;
+				FREEZ(dir->entries[j]);
 			} else {
 				dir->entries[i++] = dir->entries[j];
 			}
@@ -2144,8 +2143,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 		     dir->untracked->dir_invalidated))
 			istate->cache_changed |= UNTRACKED_CHANGED;
 		if (dir->untracked != istate->untracked) {
-			free(dir->untracked);
-			dir->untracked = NULL;
+			FREEZ(dir->untracked);
 		}
 	}
 	return dir->nr;
@@ -2488,8 +2486,7 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
 	strbuf_addbuf(out, &untracked->ident);
 
 	strbuf_add(out, ouc, ouc_size(len));
-	free(ouc);
-	ouc = NULL;
+	FREEZ(ouc);
 
 	if (!untracked->root) {
 		varint_len = encode_varint(0, varbuf);
diff --git a/fast-import.c b/fast-import.c
index e69d219682..4e23caeaad 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1063,8 +1063,7 @@ static void end_packfile(void)
 		close(pack_data->pack_fd);
 		unlink_or_warn(pack_data->pack_name);
 	}
-	free(pack_data);
-	pack_data = NULL;
+	FREEZ(pack_data);
 	running = 0;
 
 	/* We can't carry a delta across packfiles. */
@@ -1149,8 +1148,7 @@ static int store_object(
 
 		/* We cannot carry a delta into the new pack. */
 		if (delta) {
-			free(delta);
-			delta = NULL;
+			FREEZ(delta);
 
 			git_deflate_init(&s, pack_compression_level);
 			s.next_in = (void *)dat->buf;
diff --git a/gpg-interface.c b/gpg-interface.c
index e44cc27da1..93739787f9 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -13,16 +13,11 @@ static const char *gpg_program = "gpg";
 
 void signature_check_clear(struct signature_check *sigc)
 {
-	free(sigc->payload);
-	free(sigc->gpg_output);
-	free(sigc->gpg_status);
-	free(sigc->signer);
-	free(sigc->key);
-	sigc->payload = NULL;
-	sigc->gpg_output = NULL;
-	sigc->gpg_status = NULL;
-	sigc->signer = NULL;
-	sigc->key = NULL;
+	FREEZ(sigc->payload);
+	FREEZ(sigc->gpg_output);
+	FREEZ(sigc->gpg_status);
+	FREEZ(sigc->signer);
+	FREEZ(sigc->key);
 }
 
 static struct {
diff --git a/grep.c b/grep.c
index d03d424e5c..2ec0f7800d 100644
--- a/grep.c
+++ b/grep.c
@@ -1763,12 +1763,9 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
 
 void grep_source_clear(struct grep_source *gs)
 {
-	free(gs->name);
-	gs->name = NULL;
-	free(gs->path);
-	gs->path = NULL;
-	free(gs->identifier);
-	gs->identifier = NULL;
+	FREEZ(gs->name);
+	FREEZ(gs->path);
+	FREEZ(gs->identifier);
 	grep_source_clear_data(gs);
 }
 
@@ -1778,8 +1775,7 @@ void grep_source_clear_data(struct grep_source *gs)
 	case GREP_SOURCE_FILE:
 	case GREP_SOURCE_SHA1:
 	case GREP_SOURCE_SUBMODULE:
-		free(gs->buf);
-		gs->buf = NULL;
+		FREEZ(gs->buf);
 		gs->size = 0;
 		break;
 	case GREP_SOURCE_BUF:
diff --git a/help.c b/help.c
index db7f3d79a0..90d1ff6a48 100644
--- a/help.c
+++ b/help.c
@@ -267,9 +267,8 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 
 	for (i = 0; i < old->cnt; i++)
 		cmds->names[cmds->cnt++] = old->names[i];
-	free(old->names);
+	FREEZ(old->names);
 	old->cnt = 0;
-	old->names = NULL;
 }
 
 /* An empirically derived magic number */
diff --git a/http-push.c b/http-push.c
index 67c4d4b472..eda9725f14 100644
--- a/http-push.c
+++ b/http-push.c
@@ -291,8 +291,7 @@ static void start_mkcol(struct transfer_request *request)
 		request->state = RUN_MKCOL;
 	} else {
 		request->state = ABORTED;
-		free(request->url);
-		request->url = NULL;
+		FREEZ(request->url);
 	}
 }
 #endif
@@ -409,8 +408,7 @@ static void start_put(struct transfer_request *request)
 		request->state = RUN_PUT;
 	} else {
 		request->state = ABORTED;
-		free(request->url);
-		request->url = NULL;
+		FREEZ(request->url);
 	}
 }
 
@@ -432,8 +430,7 @@ static void start_move(struct transfer_request *request)
 		request->state = RUN_MOVE;
 	} else {
 		request->state = ABORTED;
-		free(request->url);
-		request->url = NULL;
+		FREEZ(request->url);
 	}
 }
 
@@ -526,8 +523,7 @@ static void finish_request(struct transfer_request *request)
 
 	/* URL is reused for MOVE after PUT */
 	if (request->state != RUN_PUT) {
-		free(request->url);
-		request->url = NULL;
+		FREEZ(request->url);
 	}
 
 	if (request->state == RUN_MKCOL) {
@@ -803,8 +799,7 @@ xml_start_tag(void *userData, const char *name, const char **atts)
 	}
 	xsnprintf(ctx->name + old_namelen, ctx->len - old_namelen, ".%s", c);
 
-	free(ctx->cdata);
-	ctx->cdata = NULL;
+	FREEZ(ctx->cdata);
 
 	ctx->userFunc(ctx, 0);
 }
@@ -932,8 +927,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 		free(lock->token);
 		free(lock->owner);
 		free(url);
-		free(lock);
-		lock = NULL;
+		FREEZ(lock);
 	} else {
 		lock->url = url;
 		lock->start_time = time(NULL);
@@ -1105,8 +1099,7 @@ static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
 			ls->dentry_flags |= IS_DIR;
 		}
 	} else if (!strcmp(ctx->name, DAV_PROPFIND_RESP)) {
-		free(ls->dentry_name);
-		ls->dentry_name = NULL;
+		FREEZ(ls->dentry_name);
 		ls->dentry_flags = 0;
 	}
 }
@@ -1547,8 +1540,7 @@ static void fetch_symref(const char *path, char **symref, struct object_id *oid)
 		    curl_errorstr);
 	free(url);
 
-	free(*symref);
-	*symref = NULL;
+	FREEZ(*symref);
 	oidclr(oid);
 
 	if (buffer.len == 0)
diff --git a/http.c b/http.c
index d2e11ec6f0..4ce761f9a0 100644
--- a/http.c
+++ b/http.c
@@ -1026,8 +1026,7 @@ void http_cleanup(void)
 
 	if (proxy_auth.password) {
 		memset(proxy_auth.password, 0, strlen(proxy_auth.password));
-		free(proxy_auth.password);
-		proxy_auth.password = NULL;
+		FREEZ(proxy_auth.password);
 	}
 
 	free((void *)curl_proxyuserpwd);
@@ -1038,13 +1037,11 @@ void http_cleanup(void)
 
 	if (cert_auth.password != NULL) {
 		memset(cert_auth.password, 0, strlen(cert_auth.password));
-		free(cert_auth.password);
-		cert_auth.password = NULL;
+		FREEZ(cert_auth.password);
 	}
 	ssl_cert_password_required = 0;
 
-	free(cached_accept_language);
-	cached_accept_language = NULL;
+	FREEZ(cached_accept_language);
 }
 
 struct active_request_slot *get_active_slot(void)
@@ -1896,8 +1893,7 @@ static char *fetch_pack_index(unsigned char *sha1, const char *base_url)
 
 	if (http_get_file(url, tmp, NULL) != HTTP_OK) {
 		error("Unable to get pack index %s", url);
-		free(tmp);
-		tmp = NULL;
+		FREEZ(tmp);
 	}
 
 	free(url);
@@ -2328,8 +2324,7 @@ void release_http_object_request(struct http_object_request *freq)
 		freq->localfile = -1;
 	}
 	if (freq->url != NULL) {
-		free(freq->url);
-		freq->url = NULL;
+		FREEZ(freq->url);
 	}
 	if (freq->slot != NULL) {
 		freq->slot->callback_func = NULL;
diff --git a/imap-send.c b/imap-send.c
index 857591660f..b4b29c30c8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -776,8 +776,7 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 			       offsetof(struct imap_cmd, next));
 			if (cmdp->cb.data) {
 				n = socket_write(&imap->buf.sock, cmdp->cb.data, cmdp->cb.dlen);
-				free(cmdp->cb.data);
-				cmdp->cb.data = NULL;
+				FREEZ(cmdp->cb.data);
 				if (n != (int)cmdp->cb.dlen)
 					return RESP_BAD;
 			} else if (cmdp->cb.cont) {
diff --git a/line-log.c b/line-log.c
index b9087814b8..272c853ede 100644
--- a/line-log.c
+++ b/line-log.c
@@ -34,9 +34,8 @@ void range_set_init(struct range_set *rs, size_t prealloc)
 
 void range_set_release(struct range_set *rs)
 {
-	free(rs->ranges);
+	FREEZ(rs->ranges);
 	rs->alloc = rs->nr = 0;
-	rs->ranges = NULL;
 }
 
 /* dst must be uninitialized! */
@@ -610,8 +609,7 @@ parse_lines(struct commit *commit, const char *prefix, struct string_list *args)
 		line_log_data_insert(&ranges, full_name, begin, end);
 
 		free_filespec(spec);
-		free(ends);
-		ends = NULL;
+		FREEZ(ends);
 	}
 
 	for (p = ranges; p; p = p->next)
diff --git a/ll-merge.c b/ll-merge.c
index ac0d4a5d78..65067a6a1a 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -209,8 +209,7 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 	result->size = st.st_size;
 	result->ptr = xmallocz(result->size);
 	if (read_in_full(fd, result->ptr, result->size) != result->size) {
-		free(result->ptr);
-		result->ptr = NULL;
+		FREEZ(result->ptr);
 		result->size = 0;
 	}
  close_bad:
diff --git a/mailinfo.c b/mailinfo.c
index f92cb9f729..4531ccad58 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -919,8 +919,7 @@ static int handle_boundary(struct mailinfo *mi, struct strbuf *line)
 		/* we hit an end boundary */
 		/* pop the current boundary off the stack */
 		strbuf_release(*(mi->content_top));
-		free(*(mi->content_top));
-		*(mi->content_top) = NULL;
+		FREEZ(*(mi->content_top));
 
 		/* technically won't happen as is_multipart_boundary()
 		   will fail first.  But just in case..
diff --git a/object.c b/object.c
index 06ba3a11d8..156931f735 100644
--- a/object.c
+++ b/object.c
@@ -377,8 +377,7 @@ void object_array_clear(struct object_array *array)
 	int i;
 	for (i = 0; i < array->nr; i++)
 		object_array_release_entry(&array->objects[i]);
-	free(array->objects);
-	array->objects = NULL;
+	FREEZ(array->objects);
 	array->nr = array->alloc = 0;
 }
 
diff --git a/pathspec.c b/pathspec.c
index 828405021f..ff131a3c02 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -662,7 +662,6 @@ void clear_pathspec(struct pathspec *pathspec)
 			attr_check_free(pathspec->items[i].attr_check);
 	}
 
-	free(pathspec->items);
-	pathspec->items = NULL;
+	FREEZ(pathspec->items);
 	pathspec->nr = 0;
 }
diff --git a/prio-queue.c b/prio-queue.c
index fc3860fdcb..2c16240104 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -27,10 +27,9 @@ void prio_queue_reverse(struct prio_queue *queue)
 
 void clear_prio_queue(struct prio_queue *queue)
 {
-	free(queue->array);
+	FREEZ(queue->array);
 	queue->nr = 0;
 	queue->alloc = 0;
-	queue->array = NULL;
 	queue->insertion_ctr = 0;
 }
 
diff --git a/read-cache.c b/read-cache.c
index bc156a133e..5d3447d618 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1888,8 +1888,7 @@ int discard_index(struct index_state *istate)
 	free_name_hash(istate);
 	cache_tree_free(&(istate->cache_tree));
 	istate->initialized = 0;
-	free(istate->cache);
-	istate->cache = NULL;
+	FREEZ(istate->cache);
 	istate->cache_alloc = 0;
 	discard_split_index(istate);
 	free_untracked_cache(istate->untracked);
@@ -2603,8 +2602,7 @@ void *read_blob_data_from_index(const struct index_state *istate,
 
 void stat_validity_clear(struct stat_validity *sv)
 {
-	free(sv->sd);
-	sv->sd = NULL;
+	FREEZ(sv->sd);
 }
 
 int stat_validity_check(struct stat_validity *sv, const char *path)
diff --git a/ref-filter.c b/ref-filter.c
index ab32bc9c31..c9ca76d0d9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1891,8 +1891,7 @@ void ref_array_clear(struct ref_array *array)
 
 	for (i = 0; i < array->nr; i++)
 		free_array_item(array->items[i]);
-	free(array->items);
-	array->items = NULL;
+	FREEZ(array->items);
 	array->nr = array->alloc = 0;
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d8b3f73147..f088c7b9fa 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2944,8 +2944,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 				       head_oid.hash, &head_type);
 
 	if (head_ref && !(head_type & REF_ISSYMREF)) {
-		free(head_ref);
-		head_ref = NULL;
+		FREEZ(head_ref);
 	}
 
 	/*
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index af2fcb2c12..2726d5fd77 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -82,9 +82,8 @@ static void clear_ref_dir(struct ref_dir *dir)
 	int i;
 	for (i = 0; i < dir->nr; i++)
 		free_ref_entry(dir->entries[i]);
-	free(dir->entries);
+	FREEZ(dir->entries);
 	dir->sorted = dir->nr = dir->alloc = 0;
-	dir->entries = NULL;
 }
 
 struct ref_entry *create_dir_entry(struct ref_cache *cache,
diff --git a/remote-testsvn.c b/remote-testsvn.c
index f87bf851ba..79bfb2a1b7 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -66,8 +66,7 @@ static char *read_ref_note(const unsigned char sha1[20])
 	else if (!msglen || type != OBJ_BLOB) {
 		error("Note contains unusable content. "
 			"Is something else using this notes tree? %s", notes_ref);
-		free(msg);
-		msg = NULL;
+		FREEZ(msg);
 	}
 	free_notes(NULL);
 	return msg;
diff --git a/rerere.c b/rerere.c
index 3bd55caf3b..7dbb29f224 100644
--- a/rerere.c
+++ b/rerere.c
@@ -39,9 +39,8 @@ static void free_rerere_dirs(void)
 		free(rerere_dir[i]->status);
 		free(rerere_dir[i]);
 	}
-	free(rerere_dir);
+	FREEZ(rerere_dir);
 	rerere_dir_nr = rerere_dir_alloc = 0;
-	rerere_dir = NULL;
 }
 
 static void free_rerere_id(struct string_list_item *item)
diff --git a/sequencer.c b/sequencer.c
index 924fb1d0c3..c3f83e3a01 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1211,8 +1211,7 @@ struct todo_list {
 static void todo_list_release(struct todo_list *todo_list)
 {
 	strbuf_release(&todo_list->buf);
-	free(todo_list->items);
-	todo_list->items = NULL;
+	FREEZ(todo_list->items);
 	todo_list->nr = todo_list->alloc = 0;
 }
 
diff --git a/sha1-array.c b/sha1-array.c
index 7d646ab5b8..a683198cd7 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -35,8 +35,7 @@ int oid_array_lookup(struct oid_array *array, const struct object_id *oid)
 
 void oid_array_clear(struct oid_array *array)
 {
-	free(array->oid);
-	array->oid = NULL;
+	FREEZ(array->oid);
 	array->nr = 0;
 	array->alloc = 0;
 	array->sorted = 0;
diff --git a/sha1_file.c b/sha1_file.c
index 59a4ed2ed3..7758a34ff4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -610,8 +610,7 @@ char *compute_alternate_path(const char *path, struct strbuf *err)
 
 out:
 	if (seen_error) {
-		free(ref_git);
-		ref_git = NULL;
+		FREEZ(ref_git);
 	}
 
 	return ref_git;
diff --git a/split-index.c b/split-index.c
index 49bd197f71..cbcb6eb63f 100644
--- a/split-index.c
+++ b/split-index.c
@@ -174,10 +174,9 @@ void merge_base_index(struct index_state *istate)
 
 	ewah_free(si->delete_bitmap);
 	ewah_free(si->replace_bitmap);
-	free(si->saved_cache);
+	FREEZ(si->saved_cache);
 	si->delete_bitmap  = NULL;
 	si->replace_bitmap = NULL;
-	si->saved_cache	   = NULL;
 	si->saved_cache_nr = 0;
 }
 
diff --git a/transport-helper.c b/transport-helper.c
index 36408046eb..c20725777d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -242,8 +242,7 @@ static int disconnect_helper(struct transport *transport)
 		close(data->helper->out);
 		fclose(data->out);
 		res = finish_command(data->helper);
-		free(data->helper);
-		data->helper = NULL;
+		FREEZ(data->helper);
 	}
 	return res;
 }
@@ -711,43 +710,35 @@ static int push_update_ref_status(struct strbuf *buf,
 
 		if (!strcmp(msg, "no match")) {
 			status = REF_STATUS_NONE;
-			free(msg);
-			msg = NULL;
+			FREEZ(msg);
 		}
 		else if (!strcmp(msg, "up to date")) {
 			status = REF_STATUS_UPTODATE;
-			free(msg);
-			msg = NULL;
+			FREEZ(msg);
 		}
 		else if (!strcmp(msg, "non-fast forward")) {
 			status = REF_STATUS_REJECT_NONFASTFORWARD;
-			free(msg);
-			msg = NULL;
+			FREEZ(msg);
 		}
 		else if (!strcmp(msg, "already exists")) {
 			status = REF_STATUS_REJECT_ALREADY_EXISTS;
-			free(msg);
-			msg = NULL;
+			FREEZ(msg);
 		}
 		else if (!strcmp(msg, "fetch first")) {
 			status = REF_STATUS_REJECT_FETCH_FIRST;
-			free(msg);
-			msg = NULL;
+			FREEZ(msg);
 		}
 		else if (!strcmp(msg, "needs force")) {
 			status = REF_STATUS_REJECT_NEEDS_FORCE;
-			free(msg);
-			msg = NULL;
+			FREEZ(msg);
 		}
 		else if (!strcmp(msg, "stale info")) {
 			status = REF_STATUS_REJECT_STALE;
-			free(msg);
-			msg = NULL;
+			FREEZ(msg);
 		}
 		else if (!strcmp(msg, "forced update")) {
 			forced = 1;
-			free(msg);
-			msg = NULL;
+			FREEZ(msg);
 		}
 	}
 
diff --git a/transport.c b/transport.c
index 9bfcf870f9..e0fd45f614 100644
--- a/transport.c
+++ b/transport.c
@@ -1145,8 +1145,7 @@ void transport_unlock_pack(struct transport *transport)
 {
 	if (transport->pack_lockfile) {
 		unlink_or_warn(transport->pack_lockfile);
-		free(transport->pack_lockfile);
-		transport->pack_lockfile = NULL;
+		FREEZ(transport->pack_lockfile);
 	}
 }
 
diff --git a/tree-diff.c b/tree-diff.c
index e164e532b2..36d7455aa4 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -140,8 +140,7 @@ static struct combine_diff_path *path_appendnew(struct combine_diff_path *last,
 	/* if last->next is !NULL - it is a pre-allocated memory, we can reuse */
 	p = last->next;
 	if (p && (alloclen > (intptr_t)p->next)) {
-		free(p);
-		p = NULL;
+		FREEZ(p);
 	}
 
 	if (!p) {
@@ -559,8 +558,7 @@ struct combine_diff_path *diff_tree_paths(
 	 * (see path_appendnew() for details about why)
 	 */
 	if (p->next) {
-		free(p->next);
-		p->next = NULL;
+		FREEZ(p->next);
 	}
 
 	return p;
diff --git a/tree-walk.c b/tree-walk.c
index 6a42e402b0..26640e00fa 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -479,8 +479,7 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 	for (i = 0; i < n; i++)
 		free_extended_entry(tx + i);
 	free(tx);
-	free(traverse_path);
-	info->traverse_path = NULL;
+	FREEZ(traverse_path);
 	strbuf_release(&base);
 	return error;
 }
diff --git a/tree.c b/tree.c
index 603b29ee80..1bf175d13d 100644
--- a/tree.c
+++ b/tree.c
@@ -226,8 +226,7 @@ int parse_tree_gently(struct tree *item, int quiet_on_missing)
 
 void free_tree_buffer(struct tree *tree)
 {
-	free(tree->buffer);
-	tree->buffer = NULL;
+	FREEZ(tree->buffer);
 	tree->size = 0;
 	tree->object.parsed = 0;
 }
-- 
2.13.1.508.gb3defc5cc

