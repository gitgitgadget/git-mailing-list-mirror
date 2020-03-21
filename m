Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FC4C43332
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C16520753
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUu0kOKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgCUJWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:22:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32854 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgCUJWM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 05:22:12 -0400
Received: by mail-qt1-f195.google.com with SMTP id d22so7326476qtn.0
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 02:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nf4/HASrk2svbC0SUFJM+zzw5fe0264da5zxcykB6Ik=;
        b=GUu0kOKDVD4wh8/Mfo9qyyCszQnXGlqqNgtmdTSPqodr2q5Mo7RNYHCax1joRyxSU0
         kaTj70FcBqzUaXFWkwLHygRtZ8FV3TjKfRsc7sihMcTL2qesdr9N0t1D33YoYdEt2qbU
         bS6T0jrtW6p0WVIVxm1jZsg6d9ZVRkw7eo/Al42uU8PchsY4IF2i6IJvpnThkwlZvovJ
         f9yFAgy8LG2keMOXoZPM64Xx4bFjvEH3XHj53IBW3cIbrWEXO5PLMfd8a5/pOcteY4yS
         pK1+LIZxTOKZzP9mmKtv2fjPapDRLH44cyWzkLEpy9452NU6inUTbamvKuohnZ/xkcWl
         PvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nf4/HASrk2svbC0SUFJM+zzw5fe0264da5zxcykB6Ik=;
        b=BzlRTz/yP4+jC5dFkXC0YSOHbz7zS8AL5JJCG3au/FVneNXO3l9kADomwkIdGQcNru
         XTOL1REyZS5ZM9nBDeeySx5AElZeZSU89RGlQi5Igb+kSCVzDJmLf8xW9Bp+qBB1RxtL
         O6uN3ogMCRSTMAQcxxXuOOsjFaVCkQX3dXzlMZbrGMxjWPePftlG9nQlnS9Ognnkrvxv
         FW2DX7SxBhGM7ULz8+wQA5ywtp3xd2xWQM8jzhFTmf9zRHWeN1/4sQElkyX6QGWETrmR
         Yq28Hzp3KFkCPCEbenjZA/bDmASvhXPGPU6gVQ2fYa2WkfosVuppE8VpT0esey3XFKWU
         dAtg==
X-Gm-Message-State: ANhLgQ1oKWnBxBHGvLnn7GhdSVLtX4vZ33uXrzxMiKGRMaqiQ+bQNwOG
        HPgG6MaOosvTr8XTI6NsNJgImMNB
X-Google-Smtp-Source: ADFU+vutncnsHfDUyKBjuV5GBqKwjHw4ppFzs0rikOjRu6VFQuLYR7WYU5XRFja6PvDR2VDYOv0Mnw==
X-Received: by 2002:ac8:22b9:: with SMTP id f54mr5782584qta.173.1584782527800;
        Sat, 21 Mar 2020 02:22:07 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id z23sm6579890qkg.21.2020.03.21.02.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 02:22:06 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 00/19] merge: learn --autostash
Date:   Sat, 21 Mar 2020 05:21:19 -0400
Message-Id: <cover.1584782450.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1577185374.git.liu.denton@gmail.com>
References: <cover.1577185374.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the delay in rerolling this. It's been quite long since I've
had free time. This probaly requires a fresh review since quite a lot
has changed since I posted my last version.


Alban reported[1] that he expected merge to have an --autostash option,
just like rebase. Since there's not really any reason why merge can't
have it, let's implement it in this patchset.

The majority of this patchset is spent refactoring. This is so that the
actual implementation in merge is done as simply as possible.

Changes since v2:

* Change patch 1 to refer to ASCII order[2]

* Make read_oneliner() accept a collective flags arg instead of two
  separate args[3]

* `git reset --hard` now leaves the worktree clean[4]

* Rebased against 'master' since the base is quite old and a new release is
  coming out soon

Changes since v1:

* Completely changed how the refactoring was done

* More tests and documentation

[1]: https://github.com/gitgitgadget/git/issues/394
[2]: https://lore.kernel.org/git/xmqqwoadfq8n.fsf@gitster-ct.c.googlers.com/
[3]: https://lore.kernel.org/git/xmqqwoaikehz.fsf@gitster-ct.c.googlers.com/
[4]: https://lore.kernel.org/git/20200123042906.GA29009@generichostname/

Denton Liu (19):
  Makefile: ASCII-sort += lists
  t7600: use test_write_lines()
  sequencer: use file strbuf for read_oneliner()
  sequencer: make read_oneliner() accept flags
  sequencer: configurably warn on non-existent files
  sequencer: make read_oneliner() extern
  rebase: use read_oneliner()
  sequencer: make apply_rebase() accept a path
  rebase: use apply_autostash() from sequencer.c
  rebase: generify reset_head()
  reset: extract reset_head() from rebase
  rebase: extract create_autostash()
  rebase: generify create_autostash()
  sequencer: extract perform_autostash() from rebase
  sequencer: unlink autostash in apply_autostash()
  sequencer: implement save_autostash()
  merge: teach --autostash option
  t5520: make test_pull_autostash() accept expect_parent_num
  pull: pass --autostash to merge

 Documentation/config/merge.txt  |  10 ++
 Documentation/git-pull.txt      |   9 -
 Documentation/merge-options.txt |   8 +
 Makefile                        |  78 ++++----
 branch.c                        |   1 +
 builtin/commit.c                |   2 +
 builtin/merge.c                 |  17 ++
 builtin/pull.c                  |   9 +-
 builtin/rebase.c                | 304 +++++---------------------------
 builtin/reset.c                 |   7 +-
 path.c                          |   1 +
 path.h                          |   4 +-
 reset.c                         | 140 +++++++++++++++
 reset.h                         |  20 +++
 sequencer.c                     | 152 +++++++++++-----
 sequencer.h                     |  19 ++
 t/t3033-merge-toplevel.sh       |  22 +++
 t/t5520-pull.sh                 |  57 ++++--
 t/t7600-merge.sh                | 126 +++++++++++--
 19 files changed, 604 insertions(+), 382 deletions(-)
 create mode 100644 reset.c
 create mode 100644 reset.h

Range-diff against v2:
 1:  31055cdac4 !  1:  77506a39d0 Makefile: alphabetically sort += lists
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    Makefile: alphabetically sort += lists
    +    Makefile: ASCII-sort += lists
     
         There are many += lists in the Makefile and, over time, they have gotten
    -    slightly out of order, alphabetically. Alphabetically sort all += lists
    -    to bring them back in order.
    +    slightly out of ASCII order. Sort all += lists to bring them back in
    +    order.
     
    -    Note that if we omit file prefixes, the lists aren't sorted in strictly
    -    alphabetical order (e.g. archive.o comes after archive-zip.o instead of
    -    before archive-tar.o). This is intentional because the purpose of
    -    maintaining the sorted list is to ensure line insertions are
    -    deterministic. As a result, we want to ensure that anybody can easily
    -    reproduce the sort order and that is very simple when we don't have to
    -    treat the prefix specially.
    +    ASCII sorting was chosen over strict alphabetical order even though, if
    +    we omit file prefixes, the lists aren't sorted in strictly alphabetical
    +    order (e.g. archive.o comes after archive-zip.o instead of before
    +    archive-tar.o). This is intentional because the purpose of maintaining
    +    the sorted list is to ensure line insertions are deterministic. By using
    +    ASCII ordering, it is more easily mechanically reproducible in the
    +    future, such as by using :sort in Vim.
     
         This patch is best viewed with `--color-moved`.
     
    @@ Makefile: LIB_OBJS += mailinfo.o
      LIB_OBJS += patch-delta.o
      LIB_OBJS += patch-ids.o
      LIB_OBJS += path.o
    -@@ Makefile: LIB_OBJS += range-diff.o
    +@@ Makefile: LIB_OBJS += quote.o
    + LIB_OBJS += range-diff.o
      LIB_OBJS += reachable.o
      LIB_OBJS += read-cache.o
    +-LIB_OBJS += rebase.o
      LIB_OBJS += rebase-interactive.o
    ++LIB_OBJS += rebase.o
     +LIB_OBJS += ref-filter.o
      LIB_OBJS += reflog-walk.o
      LIB_OBJS += refs.o
 2:  2e0020b3e3 =  2:  70699b8b73 t7600: use test_write_lines()
 3:  de79e27c17 =  3:  7c37777f07 sequencer: use file strbuf for read_oneliner()
 4:  fd547aab49 <  -:  ---------- sequencer: configurably warn on non-existent files
 -:  ---------- >  4:  4f97086828 sequencer: make read_oneliner() accept flags
 -:  ---------- >  5:  e42f4bdd4d sequencer: configurably warn on non-existent files
 5:  819fb2203b !  6:  e4d0c2d902 sequencer: make read_oneliner() extern
    @@ sequencer.c: static int write_message(const void *buf, size_t len, const char *f
      	return 0;
      }
      
    +-#define READ_ONELINER_SKIP_IF_EMPTY (1 << 0)
    +-#define READ_ONELINER_WARN_NON_EXISTENCE (1 << 1)
    +-
     -/*
     - * Reads a file that was presumably written by a shell script, i.e. with an
     - * end-of-line marker that needs to be stripped.
    @@ sequencer.c: static int write_message(const void *buf, size_t len, const char *f
     - *
     - * Returns 1 if the file was read, 0 if it could not be read or does not exist.
     - */
    --static int read_oneliner(struct strbuf *buf, const char *path,
    --			 int skip_if_empty, int warn_nonexistence)
    -+int read_oneliner(struct strbuf *buf, const char *path,
    -+		  int skip_if_empty, int warn_nonexistence)
    +-static int read_oneliner(struct strbuf *buf,
    ++int read_oneliner(struct strbuf *buf,
    + 	const char *path, unsigned flags)
      {
      	int ret = 0;
    - 	struct strbuf file_buf = STRBUF_INIT;
     
      ## sequencer.h ##
     @@ sequencer.h: void print_commit_summary(struct repository *repo,
      			  const struct object_id *oid,
      			  unsigned int flags);
      
    ++#define READ_ONELINER_SKIP_IF_EMPTY (1 << 0)
    ++#define READ_ONELINER_WARN_NON_EXISTENCE (1 << 1)
    ++
     +/*
     + * Reads a file that was presumably written by a shell script, i.e. with an
     + * end-of-line marker that needs to be stripped.
    @@ sequencer.h: void print_commit_summary(struct repository *repo,
     + *
     + * Returns 1 if the file was read, 0 if it could not be read.
     + */
    -+int read_oneliner(struct strbuf *buf, const char *path,
    -+		  int skip_if_empty, int warn_nonexistence);
    ++int read_oneliner(struct strbuf *buf,
    ++	const char *path, unsigned flags);
      int read_author_script(const char *path, char **name, char **email, char **date,
      		       int allow_missing);
      void parse_strategy_opts(struct replay_opts *opts, char *raw_opts);
 6:  06c5bd48d7 !  7:  d07a50c5b2 rebase: use read_oneliner()
    @@ Commit message
         of read_oneliner(), reduce code duplication by replacing read_one() with
         read_oneliner().
     
    -    This was done with the following Coccinelle script:
    +    This was done with the following Coccinelle script
     
                 @@
                 expression a, b;
                 @@
                 - read_one(a, b)
    -            + !read_oneliner(b, a, 0, 1)
    +            + !read_oneliner(b, a, READ_ONELINER_WARN_NON_EXISTENCE)
    +
    +    and long lines were manually broken up.
     
      ## builtin/rebase.c ##
     @@ builtin/rebase.c: static const char *state_dir_path(const char *filename, struct rebase_options *o
    @@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
      
     -	if (read_one(state_dir_path("head-name", opts), &head_name) ||
     -	    read_one(state_dir_path("onto", opts), &buf))
    -+	if (!read_oneliner(&head_name, state_dir_path("head-name", opts), 0, 1) ||
    -+	    !read_oneliner(&buf, state_dir_path("onto", opts), 0, 1))
    ++	if (!read_oneliner(&head_name, state_dir_path("head-name", opts),
    ++			   READ_ONELINER_WARN_NON_EXISTENCE) ||
    ++	    !read_oneliner(&buf, state_dir_path("onto", opts),
    ++			   READ_ONELINER_WARN_NON_EXISTENCE))
      		return -1;
      	opts->head_name = starts_with(head_name.buf, "refs/") ?
      		xstrdup(head_name.buf) : NULL;
    @@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
      	strbuf_reset(&buf);
      	if (file_exists(state_dir_path("orig-head", opts))) {
     -		if (read_one(state_dir_path("orig-head", opts), &buf))
    -+		if (!read_oneliner(&buf, state_dir_path("orig-head", opts), 0, 1))
    ++		if (!read_oneliner(&buf, state_dir_path("orig-head", opts),
    ++				   READ_ONELINER_WARN_NON_EXISTENCE))
      			return -1;
     -	} else if (read_one(state_dir_path("head", opts), &buf))
    -+	} else if (!read_oneliner(&buf, state_dir_path("head", opts), 0, 1))
    ++	} else if (!read_oneliner(&buf, state_dir_path("head", opts),
    ++				  READ_ONELINER_WARN_NON_EXISTENCE))
      		return -1;
      	if (get_oid(buf.buf, &opts->orig_head))
      		return error(_("invalid orig-head: '%s'"), buf.buf);
    @@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
      		strbuf_reset(&buf);
     -		if (read_one(state_dir_path("allow_rerere_autoupdate", opts),
     -			    &buf))
    -+		if (!read_oneliner(&buf, state_dir_path("allow_rerere_autoupdate", opts), 0, 1))
    ++		if (!read_oneliner(&buf, state_dir_path("allow_rerere_autoupdate", opts),
    ++				   READ_ONELINER_WARN_NON_EXISTENCE))
      			return -1;
      		if (!strcmp(buf.buf, "--rerere-autoupdate"))
      			opts->allow_rerere_autoupdate = RERERE_AUTOUPDATE;
    @@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
      		strbuf_reset(&buf);
     -		if (read_one(state_dir_path("gpg_sign_opt", opts),
     -			    &buf))
    -+		if (!read_oneliner(&buf, state_dir_path("gpg_sign_opt", opts), 0, 1))
    ++		if (!read_oneliner(&buf, state_dir_path("gpg_sign_opt", opts),
    ++				   READ_ONELINER_WARN_NON_EXISTENCE))
      			return -1;
      		free(opts->gpg_sign_opt);
      		opts->gpg_sign_opt = xstrdup(buf.buf);
    @@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
      	if (file_exists(state_dir_path("strategy", opts))) {
      		strbuf_reset(&buf);
     -		if (read_one(state_dir_path("strategy", opts), &buf))
    -+		if (!read_oneliner(&buf, state_dir_path("strategy", opts), 0, 1))
    ++		if (!read_oneliner(&buf, state_dir_path("strategy", opts),
    ++				   READ_ONELINER_WARN_NON_EXISTENCE))
      			return -1;
      		free(opts->strategy);
      		opts->strategy = xstrdup(buf.buf);
    @@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
      	if (file_exists(state_dir_path("strategy_opts", opts))) {
      		strbuf_reset(&buf);
     -		if (read_one(state_dir_path("strategy_opts", opts), &buf))
    -+		if (!read_oneliner(&buf, state_dir_path("strategy_opts", opts), 0, 1))
    ++		if (!read_oneliner(&buf, state_dir_path("strategy_opts", opts),
    ++				   READ_ONELINER_WARN_NON_EXISTENCE))
      			return -1;
      		free(opts->strategy_opts);
      		opts->strategy_opts = xstrdup(buf.buf);
    @@ builtin/rebase.c: static int apply_autostash(struct rebase_options *opts)
      		return 0;
      
     -	if (read_one(path, &autostash))
    -+	if (!read_oneliner(&autostash, path, 0, 1))
    ++	if (!read_oneliner(&autostash, path, READ_ONELINER_WARN_NON_EXISTENCE))
      		return error(_("Could not read '%s'"), path);
      	/* Ensure that the hash is not mistaken for a number */
      	strbuf_addstr(&autostash, "^0");
 7:  12c37d11ba !  8:  5bce4aeb96 sequencer: make apply_rebase() accept a path
    @@ sequencer.c: static enum todo_command peek_command(struct todo_list *todo_list,
      	struct child_process child = CHILD_PROCESS_INIT;
      	int ret = 0;
      
    --	if (!read_oneliner(&stash_sha1, rebase_path_autostash(), 1, 0)) {
    -+	if (!read_oneliner(&stash_sha1, path, 1, 0)) {
    +-	if (!read_oneliner(&stash_sha1, rebase_path_autostash(),
    ++	if (!read_oneliner(&stash_sha1, path,
    + 			   READ_ONELINER_SKIP_IF_EMPTY)) {
      		strbuf_release(&stash_sha1);
      		return 0;
    - 	}
     @@ sequencer.c: static int checkout_onto(struct repository *r, struct replay_opts *opts,
      		return error(_("%s: not a valid OID"), orig_head);
      
 8:  893a2f9825 !  9:  03bdaeebc9 rebase: use apply_autostash() from sequencer.c
    @@ builtin/rebase.c: static int rebase_write_basic_state(struct rebase_options *opt
     -	if (!file_exists(path))
     -		return 0;
     -
    --	if (!read_oneliner(&autostash, path, 0, 1))
    +-	if (!read_oneliner(&autostash, path, READ_ONELINER_WARN_NON_EXISTENCE))
     -		return error(_("Could not read '%s'"), path);
     -	/* Ensure that the hash is not mistaken for a number */
     -	strbuf_addstr(&autostash, "^0");
    @@ sequencer.c: static enum todo_command peek_command(struct todo_list *todo_list,
     
      ## sequencer.h ##
     @@ sequencer.h: void commit_post_rewrite(struct repository *r,
    - int prepare_branch_to_be_rebased(struct repository *r, struct replay_opts *opts,
    - 				 const char *commit);
    + 			 const struct commit *current_head,
    + 			 const struct object_id *new_head);
      
     +int apply_autostash(const char *path);
     +
 9:  8e3c0c0aec ! 10:  c35c5bdb8c rebase: generify reset_head()
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      				strbuf_addf(&buf, "%s: checkout %s",
      					    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
      					    options.switch_to);
    --				if (reset_head(&oid, "checkout",
    -+				if (reset_head(the_repository, &oid, "checkout",
    +-				if (reset_head(&options.orig_head, "checkout",
    ++				if (reset_head(the_repository,
    ++					       &options.orig_head, "checkout",
      					       options.head_name,
      					       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
     -					       NULL, buf.buf) < 0) {
10:  981969d230 = 11:  a14a2e0849 reset: extract reset_head() from rebase
11:  1b5bbe66dc = 12:  1dbae3dfbf rebase: extract create_autostash()
12:  bba7586cba = 13:  fffc038cd6 rebase: generify create_autostash()
13:  2ff189692f ! 14:  bf55b86e2b sequencer: extract perform_autostash() from rebase
    @@ sequencer.c: static enum todo_command peek_command(struct todo_list *todo_list,
     
      ## sequencer.h ##
     @@ sequencer.h: void commit_post_rewrite(struct repository *r,
    - int prepare_branch_to_be_rebased(struct repository *r, struct replay_opts *opts,
    - 				 const char *commit);
    + 			 const struct commit *current_head,
    + 			 const struct object_id *new_head);
      
     +void create_autostash(struct repository *r, const char *path,
     +		      const char *default_reflog_action);
14:  2b16711680 = 15:  d5af261eb8 sequencer: unlink autostash in apply_autostash()
 -:  ---------- > 16:  e21e2c6416 sequencer: implement save_autostash()
15:  6e987052c0 ! 17:  9e3d4393ca merge: teach --autostash option
    @@ Commit message
                 git fetch ...
                 git merge --autostash FETCH_HEAD
     
    +    When `git reset --hard` is run to abort a merge, the working tree will
    +    be left in a clean state, as expected, with the autostash pushed onto
    +    the stash stack.
    +
         Suggested-by: Alban Gruin <alban.gruin@gmail.com>
     
      ## Documentation/config/merge.txt ##
    @@ builtin/merge.c: static void finish(struct commit *head_commit,
      		squash_message(head_commit, remoteheads);
      	} else {
     @@ builtin/merge.c: static int git_merge_config(const char *k, const char *v, void *cb)
    - 	} else if (!strcmp(k, "commit.gpgsign")) {
    - 		sign_commit = git_config_bool(k, v) ? "" : NULL;
      		return 0;
    + 	} else if (!strcmp(k, "gpg.mintrustlevel")) {
    + 		check_trust_level = 0;
     +	} else if (!strcmp(k, "merge.autostash")) {
     +		autostash = git_config_bool(k, v);
     +		return 0;
    @@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
      	git_committer_info(IDENT_STRICT);
      
     
    + ## builtin/reset.c ##
    +@@
    + #include "cache-tree.h"
    + #include "submodule.h"
    + #include "submodule-config.h"
    ++#include "sequencer.h"
    + 
    + #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
    + 
    +@@ builtin/reset.c: int cmd_reset(int argc, const char **argv, const char *prefix)
    + 		if (reset_type == HARD && !update_ref_status && !quiet)
    + 			print_new_head_line(lookup_commit_reference(the_repository, &oid));
    + 	}
    +-	if (!pathspec.nr)
    ++	if (!pathspec.nr) {
    ++		if (reset_type == HARD)
    ++			save_autostash(git_path_merge_autostash(the_repository));
    ++
    + 		remove_branch_state(the_repository, 0);
    ++	}
    + 
    + 	return update_ref_status;
    + }
    +
      ## path.c ##
     @@ path.c: REPO_GIT_PATH_FUNC(merge_msg, "MERGE_MSG")
      REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
    @@ t/t7600-merge.sh: test_expect_success 'refresh the index before merging' '
     +	test_cmp file.1 file
     +'
     +
    ++test_expect_success 'completed merge with --no-commit and --autostash' '
    ++	git reset --hard c1 &&
    ++	git merge-file file file.orig file.9 &&
    ++	git diff >expect &&
    ++	git merge --no-commit --autostash c2 &&
    ++	git stash show -p MERGE_AUTOSTASH >actual &&
    ++	test_cmp expect actual &&
    ++	git commit 2>err &&
    ++	test_i18ngrep "Applied autostash." err &&
    ++	git show HEAD:file >merge-result &&
    ++	test_cmp result.1-5 merge-result &&
    ++	test_cmp result.1-5-9 file
    ++'
    ++
    ++test_expect_success 'aborted merge (merge --abort) with --no-commit and --autostash' '
    ++	git reset --hard c1 &&
    ++	git merge-file file file.orig file.9 &&
    ++	git diff >expect &&
    ++	git merge --no-commit --autostash c2 &&
    ++	git stash show -p MERGE_AUTOSTASH >actual &&
    ++	test_cmp expect actual &&
    ++	git merge --abort 2>err &&
    ++	test_i18ngrep "Applied autostash." err &&
    ++	git diff >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'aborted merge (reset --hard) with --no-commit and --autostash' '
    ++	git reset --hard c1 &&
    ++	git merge-file file file.orig file.9 &&
    ++	git diff >expect &&
    ++	git merge --no-commit --autostash c2 &&
    ++	git stash show -p MERGE_AUTOSTASH >actual &&
    ++	test_cmp expect actual &&
    ++	git reset --hard 2>err &&
    ++	test_i18ngrep "Autostash exists; creating a new stash entry." err &&
    ++	git diff --exit-code
    ++'
    ++
     +test_expect_success 'merge with conflicted --autostash changes' '
     +	git reset --hard c1 &&
     +	git merge-file file file.orig file.9y &&
16:  c70643ca9f = 18:  72aa56516e t5520: make test_pull_autostash() accept expect_parent_num
17:  6ebae1d758 = 19:  17caf6d66f pull: pass --autostash to merge
-- 
2.25.0.114.g5b0ca878e0

