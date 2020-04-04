Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7522FC2BA15
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CEC20731
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NircwrZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgDDBMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:12:02 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36959 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgDDBMC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:12:02 -0400
Received: by mail-qk1-f195.google.com with SMTP id x3so10213236qki.4
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NKZ14skvSAXtlOLOMRzgGXJCB52FADk6hPyBpLjHnhY=;
        b=NircwrZLfspniWhuGQdYsB869+sRetDeHnhTDEs8Ya+qD30DK1Qg03QNTq93HTmqYF
         c8vODsALC4hhgHjsPkz6etMuIhawks5wrUzFAgyn5RMzHxDVlMobk4eEmeUs+HbsoJj3
         8cWzjI18rE4fyQf+gwQouj6jXZjFi98gbEZTr9d/CBBtYKGPh0CJdgiP7yP4RnJA02Av
         0DKgmkz8Mb2Zk7xlzEGLnMEMepV1IaNwd6JR7vFFULCobehBtE/NpeywAzty7F838yNK
         p/XxGGcwfCtrCVLLKdTMj7lw6ZMcSLLTX9cm91YZHiIlnft3wjo8KcS1xFgAyDgbvL0s
         6POQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NKZ14skvSAXtlOLOMRzgGXJCB52FADk6hPyBpLjHnhY=;
        b=Dg6CPKeSPghKU5ch4gfrIX63t2+7BwKASGXDh/xfpnxSuW4fETmXbKcQCXnPPLFaPj
         9FKoH9MQKxLhubOwx0Fgidnbvp3pU+RuztUjcT0iRZAISHwppCu7xU8AglG2Wrj5aOdq
         2wKTFxMNpQ9ekYhO+io+Ob+NAoTCKLL4k8EDQA+rrX0lKzciqR6IuIuXMmfK+UbHHhb1
         tChfLUAu33nH4U4C4r1bQox5HuUou44WYS0h8F+XLv3W+C2afOosHMfrpsABOWwamTBb
         MZGekRamniTrda9DRe06mtRx3LEyHus4c5z+7JBWpIjP0Y2ls4vHooLLYRTJv0WefUEw
         LviQ==
X-Gm-Message-State: AGi0PuaJ2+Vq6BD0WbgMfGdl6LXELrvMoHRptmstcDhaEvlqshXgtQgs
        7Iz0rwMdHpkC76rBYKEo3UvnkWH/
X-Google-Smtp-Source: APiQypIqauCzTgkNwEUnRPt9ODoogkqty1Px+iAWXqi1fiYDr16mFDesILg7G4IyX34rgTDymUb69Q==
X-Received: by 2002:a37:b7c3:: with SMTP id h186mr10704061qkf.428.1585962719178;
        Fri, 03 Apr 2020 18:11:59 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-143-128.dsl.bell.ca. [76.68.143.128])
        by smtp.gmail.com with ESMTPSA id a136sm3297503qkc.75.2020.04.03.18.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:11:58 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 00/23] merge: learn --autostash
Date:   Fri,  3 Apr 2020 21:11:13 -0400
Message-Id: <cover.1585962672.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1584782450.git.liu.denton@gmail.com>
References: <cover.1584782450.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

I implemented all of your comments. Patches 3-5, 11 need careful review as
they're new. 'merge: teach --autostash option' also probably needs some
more review as I've changed the callsites of apply_autostash() and
save_autostash().


Alban reported[1] that he expected merge to have an --autostash option,
just like rebase. Since there's not really any reason why merge can't
have it, let's implement it in this patchset.

The majority of this patchset is spent refactoring. This is so that the
actual implementation in merge is done as simply as possible.

Changes since v3:

* Replace 'sequencer: use file strbuf for read_oneliner()' with patches 3-5

* Rename flag to READ_ONELINER_WARN_MISSING

* Add 'sequencer: rename stash_sha1 to stash_oid'

* Many changes to 'merge: teach --autostash option'

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

Denton Liu (23):
  Makefile: ASCII-sort += lists
  t7600: use test_write_lines()
  sequencer: stop leaking buf
  sequencer: reuse strbuf_trim() in read_oneliner()
  sequencer: make file exists check more efficient
  sequencer: make read_oneliner() accept flags
  sequencer: configurably warn on non-existent files
  sequencer: make read_oneliner() extern
  rebase: use read_oneliner()
  sequencer: make apply_rebase() accept a path
  sequencer: rename stash_sha1 to stash_oid
  rebase: use apply_autostash() from sequencer.c
  rebase: generify reset_head()
  reset: extract reset_head() from rebase
  rebase: extract create_autostash()
  rebase: generify create_autostash()
  sequencer: extract perform_autostash() from rebase
  sequencer: unlink autostash in apply_autostash()
  sequencer: implement save_autostash()
  sequencer: implement apply_autostash_oid()
  merge: teach --autostash option
  t5520: make test_pull_autostash() accept expect_parent_num
  pull: pass --autostash to merge

 Documentation/config/merge.txt  |  10 +
 Documentation/git-merge.txt     |   6 +-
 Documentation/git-pull.txt      |   9 -
 Documentation/merge-options.txt |   8 +
 Makefile                        |  78 ++++----
 branch.c                        |   1 +
 builtin/commit.c                |   2 +
 builtin/merge.c                 |  27 +++
 builtin/pull.c                  |   9 +-
 builtin/rebase.c                | 312 +++++---------------------------
 builtin/reset.c                 |   4 +-
 parse-options.h                 |   1 +
 path.c                          |   1 +
 path.h                          |   4 +-
 reset.c                         | 140 ++++++++++++++
 reset.h                         |  20 ++
 sequencer.c                     | 187 +++++++++++++------
 sequencer.h                     |  20 ++
 t/t3033-merge-toplevel.sh       |  22 +++
 t/t5520-pull.sh                 |  57 ++++--
 t/t7600-merge.sh                | 140 ++++++++++++--
 21 files changed, 653 insertions(+), 405 deletions(-)
 create mode 100644 reset.c
 create mode 100644 reset.h

Range-diff against v3:
 1:  67511a47b2 =  1:  c26771e934 Makefile: ASCII-sort += lists
 2:  6d76cea5b4 =  2:  059e0e8e43 t7600: use test_write_lines()
 3:  7c254b34b0 <  -:  ---------- sequencer: use file strbuf for read_oneliner()
 -:  ---------- >  3:  76585e5b13 sequencer: stop leaking buf
 -:  ---------- >  4:  c7a3cfa200 sequencer: reuse strbuf_trim() in read_oneliner()
 -:  ---------- >  5:  58da8e9555 sequencer: make file exists check more efficient
 4:  dc88da2ebf !  6:  6ead240957 sequencer: make read_oneliner() accept flags
    @@ sequencer.c: static int write_message(const void *buf, size_t len, const char *f
     +#define READ_ONELINER_SKIP_IF_EMPTY (1 << 0)
     +
      /*
    -  * Reads a file that was presumably written by a shell script, i.e. with an
    -  * end-of-line marker that needs to be stripped.
    +  * Resets a strbuf then reads a file that was presumably written by a shell
    +  * script, i.e. with an end-of-line marker that needs to be stripped.
     @@ sequencer.c: static int write_message(const void *buf, size_t len, const char *filename,
       * Returns 1 if the file was read, 0 if it could not be read or does not exist.
       */
    @@ sequencer.c: static int write_message(const void *buf, size_t len, const char *f
     -	const char *path, int skip_if_empty)
     +	const char *path, unsigned flags)
      {
    - 	int ret = 0;
    - 	struct strbuf file_buf = STRBUF_INIT;
    + 	strbuf_reset(buf);
    + 	if (strbuf_read_file(buf, path, 0) < 0) {
     @@ sequencer.c: static int read_oneliner(struct strbuf *buf,
      
    - 	strbuf_trim_trailing_newline(&file_buf);
    + 	strbuf_trim(buf);
      
    --	if (skip_if_empty && !file_buf.len)
    -+	if ((flags & READ_ONELINER_SKIP_IF_EMPTY) && !file_buf.len)
    - 		goto done;
    +-	if (skip_if_empty && !buf->len)
    ++	if ((flags & READ_ONELINER_SKIP_IF_EMPTY) && !buf->len)
    + 		return 0;
      
    - 	strbuf_addbuf(buf, &file_buf);
    + 	return 1;
     @@ sequencer.c: static int read_populate_opts(struct replay_opts *opts)
    - 	if (is_rebase_i(opts)) {
      		struct strbuf buf = STRBUF_INIT;
    + 		int ret = 0;
      
     -		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1)) {
     +		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(),
    @@ sequencer.c: static int read_populate_opts(struct replay_opts *opts)
      				strbuf_reset(&buf);
      			else {
     @@ sequencer.c: static int read_populate_opts(struct replay_opts *opts)
    - 			strbuf_reset(&buf);
    + 			}
      		}
      
     -		if (read_oneliner(&buf, rebase_path_allow_rerere_autoupdate(), 1)) {
    @@ sequencer.c: static int read_populate_opts(struct replay_opts *opts)
      				opts->allow_rerere_auto = RERERE_AUTOUPDATE;
      			else if (!strcmp(buf.buf, "--no-rerere-autoupdate"))
     @@ sequencer.c: static int read_populate_opts(struct replay_opts *opts)
    - 		strbuf_release(&buf);
    + 		read_strategy_opts(opts, &buf);
      
      		if (read_oneliner(&opts->current_fixups,
     -				  rebase_path_current_fixups(), 1)) {
 5:  7702543d91 <  -:  ---------- sequencer: configurably warn on non-existent files
 -:  ---------- >  7:  2e7922b259 sequencer: configurably warn on non-existent files
 6:  361bc2e885 !  8:  6c3c37994b sequencer: make read_oneliner() extern
    @@ Commit message
         Instead of hiding it as a static function within sequencer.c, extern it
         so that it can be reused by others.
     
    +    This patch is best viewed with --color-moved.
    +
      ## sequencer.c ##
     @@ sequencer.c: static int write_message(const void *buf, size_t len, const char *filename,
      	return 0;
      }
      
     -#define READ_ONELINER_SKIP_IF_EMPTY (1 << 0)
    --#define READ_ONELINER_WARN_NON_EXISTENCE (1 << 1)
    +-#define READ_ONELINER_WARN_MISSING (1 << 1)
     -
     -/*
    -- * Reads a file that was presumably written by a shell script, i.e. with an
    -- * end-of-line marker that needs to be stripped.
    +- * Resets a strbuf then reads a file that was presumably written by a shell
    +- * script, i.e. with an end-of-line marker that needs to be stripped.
     - *
     - * Note that only the last end-of-line marker is stripped, consistent with the
     - * behavior of "$(cat path)" in a shell script.
    @@ sequencer.c: static int write_message(const void *buf, size_t len, const char *f
     +int read_oneliner(struct strbuf *buf,
      	const char *path, unsigned flags)
      {
    - 	int ret = 0;
    + 	strbuf_reset(buf);
     
      ## sequencer.h ##
     @@ sequencer.h: void print_commit_summary(struct repository *repo,
    @@ sequencer.h: void print_commit_summary(struct repository *repo,
      			  unsigned int flags);
      
     +#define READ_ONELINER_SKIP_IF_EMPTY (1 << 0)
    -+#define READ_ONELINER_WARN_NON_EXISTENCE (1 << 1)
    ++#define READ_ONELINER_WARN_MISSING (1 << 1)
     +
     +/*
    -+ * Reads a file that was presumably written by a shell script, i.e. with an
    -+ * end-of-line marker that needs to be stripped.
    ++ * Resets a strbuf then reads a file that was presumably written by a shell
    ++ * script, i.e. with an end-of-line marker that needs to be stripped.
     + *
     + * Note that only the last end-of-line marker is stripped, consistent with the
     + * behavior of "$(cat path)" in a shell script.
     + *
    -+ * Returns 1 if the file was read, 0 if it could not be read.
    ++ * Returns 1 if the file was read, 0 if it could not be read or does not exist.
     + */
     +int read_oneliner(struct strbuf *buf,
     +	const char *path, unsigned flags);
 7:  47816abff1 !  9:  689f34a2a5 rebase: use read_oneliner()
    @@ Commit message
     
         Since in sequencer.c, read_one() basically duplicates the functionality
         of read_oneliner(), reduce code duplication by replacing read_one() with
    -    read_oneliner().
    +    read_oneliner(). Also, delete strbuf_reset() calls prior to
    +    read_oneliner() as read_oneliner() already resets the strbuf.
     
    -    This was done with the following Coccinelle script
    +    This was mostly done with the following Coccinelle script
     
                 @@
                 expression a, b;
    @@ Commit message
                 - read_one(a, b)
                 + !read_oneliner(b, a, READ_ONELINER_WARN_NON_EXISTENCE)
     
    -    and long lines were manually broken up.
    +    Long lines were broken up and strbuf_reset()s were deleted manually.
     
      ## builtin/rebase.c ##
     @@ builtin/rebase.c: static const char *state_dir_path(const char *filename, struct rebase_options *o
    @@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
     -	if (read_one(state_dir_path("head-name", opts), &head_name) ||
     -	    read_one(state_dir_path("onto", opts), &buf))
     +	if (!read_oneliner(&head_name, state_dir_path("head-name", opts),
    -+			   READ_ONELINER_WARN_NON_EXISTENCE) ||
    ++			   READ_ONELINER_WARN_MISSING) ||
     +	    !read_oneliner(&buf, state_dir_path("onto", opts),
    -+			   READ_ONELINER_WARN_NON_EXISTENCE))
    ++			   READ_ONELINER_WARN_MISSING))
      		return -1;
      	opts->head_name = starts_with(head_name.buf, "refs/") ?
      		xstrdup(head_name.buf) : NULL;
     @@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
    + 	 * head. Fall back to reading from head to cover for the case that the
    + 	 * user upgraded git with an ongoing interactive rebase.
      	 */
    - 	strbuf_reset(&buf);
    +-	strbuf_reset(&buf);
      	if (file_exists(state_dir_path("orig-head", opts))) {
     -		if (read_one(state_dir_path("orig-head", opts), &buf))
     +		if (!read_oneliner(&buf, state_dir_path("orig-head", opts),
    -+				   READ_ONELINER_WARN_NON_EXISTENCE))
    ++				   READ_ONELINER_WARN_MISSING))
      			return -1;
     -	} else if (read_one(state_dir_path("head", opts), &buf))
     +	} else if (!read_oneliner(&buf, state_dir_path("head", opts),
    -+				  READ_ONELINER_WARN_NON_EXISTENCE))
    ++				  READ_ONELINER_WARN_MISSING))
      		return -1;
      	if (get_oid(buf.buf, &opts->orig_head))
      		return error(_("invalid orig-head: '%s'"), buf.buf);
     @@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
    + 	}
      
      	if (file_exists(state_dir_path("allow_rerere_autoupdate", opts))) {
    - 		strbuf_reset(&buf);
    +-		strbuf_reset(&buf);
     -		if (read_one(state_dir_path("allow_rerere_autoupdate", opts),
     -			    &buf))
     +		if (!read_oneliner(&buf, state_dir_path("allow_rerere_autoupdate", opts),
    -+				   READ_ONELINER_WARN_NON_EXISTENCE))
    ++				   READ_ONELINER_WARN_MISSING))
      			return -1;
      		if (!strcmp(buf.buf, "--rerere-autoupdate"))
      			opts->allow_rerere_autoupdate = RERERE_AUTOUPDATE;
     @@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
    + 	}
      
      	if (file_exists(state_dir_path("gpg_sign_opt", opts))) {
    - 		strbuf_reset(&buf);
    +-		strbuf_reset(&buf);
     -		if (read_one(state_dir_path("gpg_sign_opt", opts),
     -			    &buf))
     +		if (!read_oneliner(&buf, state_dir_path("gpg_sign_opt", opts),
    -+				   READ_ONELINER_WARN_NON_EXISTENCE))
    ++				   READ_ONELINER_WARN_MISSING))
      			return -1;
      		free(opts->gpg_sign_opt);
      		opts->gpg_sign_opt = xstrdup(buf.buf);
    -@@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
    + 	}
      
      	if (file_exists(state_dir_path("strategy", opts))) {
    - 		strbuf_reset(&buf);
    +-		strbuf_reset(&buf);
     -		if (read_one(state_dir_path("strategy", opts), &buf))
     +		if (!read_oneliner(&buf, state_dir_path("strategy", opts),
    -+				   READ_ONELINER_WARN_NON_EXISTENCE))
    ++				   READ_ONELINER_WARN_MISSING))
      			return -1;
      		free(opts->strategy);
      		opts->strategy = xstrdup(buf.buf);
    -@@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
    + 	}
      
      	if (file_exists(state_dir_path("strategy_opts", opts))) {
    - 		strbuf_reset(&buf);
    +-		strbuf_reset(&buf);
     -		if (read_one(state_dir_path("strategy_opts", opts), &buf))
     +		if (!read_oneliner(&buf, state_dir_path("strategy_opts", opts),
    -+				   READ_ONELINER_WARN_NON_EXISTENCE))
    ++				   READ_ONELINER_WARN_MISSING))
      			return -1;
      		free(opts->strategy_opts);
      		opts->strategy_opts = xstrdup(buf.buf);
    @@ builtin/rebase.c: static int apply_autostash(struct rebase_options *opts)
      		return 0;
      
     -	if (read_one(path, &autostash))
    -+	if (!read_oneliner(&autostash, path, READ_ONELINER_WARN_NON_EXISTENCE))
    ++	if (!read_oneliner(&autostash, path, READ_ONELINER_WARN_MISSING))
      		return error(_("Could not read '%s'"), path);
      	/* Ensure that the hash is not mistaken for a number */
      	strbuf_addstr(&autostash, "^0");
 8:  7e9a86c337 = 10:  e0b8e409af sequencer: make apply_rebase() accept a path
 -:  ---------- > 11:  a52583beff sequencer: rename stash_sha1 to stash_oid
 9:  76a486d8b0 ! 12:  389b17df33 rebase: use apply_autostash() from sequencer.c
    @@ Commit message
     
         The apply_autostash() function in builtin/rebase.c is similar enough to
         the apply_autostash() function in sequencer.c that they are almost
    -    interchangeable. Make the sequencer.c version extern and use it in
    -    rebase.
    +    interchangeable, except for the type of arg they accept. Make the
    +    sequencer.c version extern and use it in rebase.
     
         The rebase version was introduced in 6defce2b02 (builtin rebase: support
         `--autostash` option, 2018-09-04) as part of the shell to C conversion.
    @@ builtin/rebase.c: static int rebase_write_basic_state(struct rebase_options *opt
     -	if (!file_exists(path))
     -		return 0;
     -
    --	if (!read_oneliner(&autostash, path, READ_ONELINER_WARN_NON_EXISTENCE))
    +-	if (!read_oneliner(&autostash, path, READ_ONELINER_WARN_MISSING))
     -		return error(_("Could not read '%s'"), path);
     -	/* Ensure that the hash is not mistaken for a number */
     -	strbuf_addstr(&autostash, "^0");
    @@ sequencer.c: static enum todo_command peek_command(struct todo_list *todo_list,
     -static int apply_autostash(const char *path)
     +int apply_autostash(const char *path)
      {
    - 	struct strbuf stash_sha1 = STRBUF_INIT;
    + 	struct strbuf stash_oid = STRBUF_INIT;
      	struct child_process child = CHILD_PROCESS_INIT;
     
      ## sequencer.h ##
10:  6d37e8049b = 13:  fe57e21dbc rebase: generify reset_head()
11:  18e1900a16 = 14:  045668620d reset: extract reset_head() from rebase
12:  21e228920e = 15:  d5f51cd80e rebase: extract create_autostash()
13:  7e2eab5203 = 16:  9ab10d23d4 rebase: generify create_autostash()
14:  fddf506115 ! 17:  26cca49be6 sequencer: extract perform_autostash() from rebase
    @@ sequencer.c: static enum todo_command peek_command(struct todo_list *todo_list,
     +
      int apply_autostash(const char *path)
      {
    - 	struct strbuf stash_sha1 = STRBUF_INIT;
    + 	struct strbuf stash_oid = STRBUF_INIT;
     
      ## sequencer.h ##
     @@ sequencer.h: void commit_post_rewrite(struct repository *r,
15:  9394c7ae30 ! 18:  e703022fda sequencer: unlink autostash in apply_autostash()
    @@ sequencer.c: int apply_autostash(const char *path)
      	}
      
     +	unlink(path);
    - 	strbuf_release(&stash_sha1);
    + 	strbuf_release(&stash_oid);
      	return ret;
      }
16:  0035b84388 ! 19:  75dc3f10a1 sequencer: implement save_autostash()
    @@ Commit message
         apply_save_autostash() and use it to implement save_autostash(). This
         function will be used in a future commit.
     
    +    The difference between save_autostash() and apply_autostash() is that
    +    the latter does not try to apply the stash. It skips that step and
    +    just stores the created entry in the stash reflog.
    +
      ## sequencer.c ##
     @@ sequencer.c: void create_autostash(struct repository *r, const char *path,
      	strbuf_release(&buf);
    @@ sequencer.c: void create_autostash(struct repository *r, const char *path,
     -int apply_autostash(const char *path)
     +static int apply_save_autostash(const char *path, int attempt_apply)
      {
    - 	struct strbuf stash_sha1 = STRBUF_INIT;
    + 	struct strbuf stash_oid = STRBUF_INIT;
      	struct child_process child = CHILD_PROCESS_INIT;
     @@ sequencer.c: int apply_autostash(const char *path)
      	}
    - 	strbuf_trim(&stash_sha1);
    + 	strbuf_trim(&stash_oid);
      
     -	child.git_cmd = 1;
     -	child.no_stdout = 1;
     -	child.no_stderr = 1;
     -	argv_array_push(&child.args, "stash");
     -	argv_array_push(&child.args, "apply");
    --	argv_array_push(&child.args, stash_sha1.buf);
    +-	argv_array_push(&child.args, stash_oid.buf);
     -	if (!run_command(&child))
     +	if (attempt_apply) {
     +		child.git_cmd = 1;
    @@ sequencer.c: int apply_autostash(const char *path)
     +		child.no_stderr = 1;
     +		argv_array_push(&child.args, "stash");
     +		argv_array_push(&child.args, "apply");
    -+		argv_array_push(&child.args, stash_sha1.buf);
    ++		argv_array_push(&child.args, stash_oid.buf);
     +		ret = run_command(&child);
     +	}
     +
    @@ sequencer.c: int apply_autostash(const char *path)
      	else {
      		struct child_process store = CHILD_PROCESS_INIT;
     @@ sequencer.c: int apply_autostash(const char *path)
    - 			ret = error(_("cannot store %s"), stash_sha1.buf);
    + 			ret = error(_("cannot store %s"), stash_oid.buf);
      		else
      			fprintf(stderr,
     -				_("Applying autostash resulted in conflicts.\n"
 -:  ---------- > 20:  598ddea6c1 sequencer: implement apply_autostash_oid()
17:  085f8e0dd2 ! 21:  7adf794192 merge: teach --autostash option
    @@ Commit message
                 git fetch ...
                 git merge --autostash FETCH_HEAD
     
    -    When `git reset --hard` is run to abort a merge, the working tree will
    -    be left in a clean state, as expected, with the autostash pushed onto
    -    the stash stack.
    +    When an autostash is generated, it is automatically reapplied to the
    +    worktree only in three explicit situations:
    +
    +            1. An incomplete merge is commit using `git commit`.
    +            2. A merge completes successfully.
    +            3. A merge is aborted using `git merge --abort`.
    +
    +    In all other situations where the merge state is removed using
    +    remove_merge_branch_state() such as aborting a merge via
    +    `git reset --hard`, the autostash is saved into the stash reflog
    +    instead keeping the worktree clean.
     
         Suggested-by: Alban Gruin <alban.gruin@gmail.com>
     
    @@ Documentation/config/merge.txt: merge.stat::
     +merge.autoStash::
     +	When set to true, automatically create a temporary stash entry
     +	before the operation begins, and apply it after the operation
    -+	ends.  This means that you can run rebase on a dirty worktree.
    ++	ends.  This means that you can run merge on a dirty worktree.
     +	However, use with care: the final stash application after a
    -+	successful rebase might result in non-trivial conflicts.
    ++	successful merge might result in non-trivial conflicts.
     +	This option can be overridden by the `--no-autostash` and
     +	`--autostash` options of linkgit:git-merge[1].
     +	Defaults to false.
    @@ Documentation/config/merge.txt: merge.stat::
      	Controls which merge tool is used by linkgit:git-mergetool[1].
      	The list below shows the valid built-in values.
     
    + ## Documentation/git-merge.txt ##
    +@@ Documentation/git-merge.txt: will be appended to the specified message.
    + 
    + --abort::
    + 	Abort the current conflict resolution process, and
    +-	try to reconstruct the pre-merge state.
    ++	try to reconstruct the pre-merge state. If an autostash entry is
    ++	present, apply it back to the worktree.
    + +
    + If there were uncommitted worktree changes present when the merge
    + started, 'git merge --abort' will in some cases be unable to
    +@@ Documentation/git-merge.txt: reconstruct these changes. It is therefore recommended to always
    + commit or stash your changes before running 'git merge'.
    + +
    + 'git merge --abort' is equivalent to 'git reset --merge' when
    +-`MERGE_HEAD` is present.
    ++`MERGE_HEAD` is present unless `MERGE_AUTOSTASH` is also present where
    ++the stash entry is applied to the worktree.
    + 
    + --quit::
    + 	Forget about the current merge in progress. Leave the index
    +
      ## Documentation/merge-options.txt ##
     @@ Documentation/merge-options.txt: ifndef::git-pull[]
      	Note that not all merge strategies may support progress
    @@ Documentation/merge-options.txt: ifndef::git-pull[]
     +--no-autostash::
     +	Automatically create a temporary stash entry before the operation
     +	begins, and apply it after the operation ends.  This means
    -+	that you can run rebase on a dirty worktree.  However, use
    ++	that you can run the operation on a dirty worktree.  However, use
     +	with care: the final stash application after a successful
    -+	rebase might result in non-trivial conflicts.
    ++	merge might result in non-trivial conflicts.
     +
      endif::git-pull[]
      
    @@ branch.c: void remove_merge_branch_state(struct repository *r)
      	unlink(git_path_merge_rr(r));
      	unlink(git_path_merge_msg(r));
      	unlink(git_path_merge_mode(r));
    -+	apply_autostash(git_path_merge_autostash(r));
    ++	save_autostash(git_path_merge_autostash(r));
      }
      
      void remove_branch_state(struct repository *r, int verbose)
     
      ## builtin/commit.c ##
     @@ builtin/commit.c: int cmd_commit(int argc, const char **argv, const char *prefix)
    - 	unlink(git_path_merge_mode(the_repository));
    - 	unlink(git_path_squash_msg(the_repository));
    + 				     &oid, flags);
    + 	}
      
     +	apply_autostash(git_path_merge_autostash(the_repository));
     +
    - 	if (commit_index_files())
    - 		die(_("repository has been updated, but unable to write\n"
    - 		      "new_index file. Check that disk is not full and quota is\n"
    + 	UNLEAK(err);
    + 	UNLEAK(sb);
    + 	return 0;
     
      ## builtin/merge.c ##
     @@ builtin/merge.c: static int show_progress = -1;
    @@ builtin/merge.c: static struct option builtin_merge_options[] = {
      	OPT_SET_INT(0, "progress", &show_progress, N_("force progress reporting"), 1),
      	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
      	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
    -+	OPT_BOOL(0, "autostash", &autostash,
    -+	      N_("automatically stash/stash pop before and after")),
    ++	OPT_AUTOSTASH(&autostash),
      	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
      	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
      	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass pre-merge-commit and commit-msg hooks")),
     @@ builtin/merge.c: static void finish(struct commit *head_commit,
    - 		strbuf_addf(&reflog_message, "%s: %s",
    - 			getenv("GIT_REFLOG_ACTION"), msg);
    - 	}
    + 	/* Run a post-merge hook */
    + 	run_hook_le(NULL, "post-merge", squash ? "1" : "0", NULL);
    + 
     +	apply_autostash(git_path_merge_autostash(the_repository));
    - 	if (squash) {
    - 		squash_message(head_commit, remoteheads);
    - 	} else {
    + 	strbuf_release(&reflog_message);
    + }
    + 
     @@ builtin/merge.c: static int git_merge_config(const char *k, const char *v, void *cb)
      		return 0;
      	} else if (!strcmp(k, "gpg.mintrustlevel")) {
    @@ builtin/merge.c: static int git_merge_config(const char *k, const char *v, void
      
      	status = fmt_merge_msg_config(k, v, cb);
     @@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
    + 	if (abort_current_merge) {
    + 		int nargc = 2;
    + 		const char *nargv[] = {"reset", "--merge", NULL};
    ++		struct strbuf stash_oid = STRBUF_INIT;
      
    + 		if (orig_argc != 2)
    + 			usage_msg_opt(_("--abort expects no arguments"),
    +@@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
    + 		if (!file_exists(git_path_merge_head(the_repository)))
    + 			die(_("There is no merge to abort (MERGE_HEAD missing)."));
    + 
    ++		if (read_oneliner(&stash_oid, git_path_merge_autostash(the_repository),
    ++			   READ_ONELINER_SKIP_IF_EMPTY)) {
    ++			strbuf_trim(&stash_oid);
    ++			unlink(git_path_merge_autostash(the_repository));
    ++		}
    ++
      		/* Invoke 'git reset --merge' */
      		ret = cmd_reset(nargc, nargv, prefix);
    -+		apply_autostash(git_path_merge_autostash(the_repository));
    ++
    ++		if (stash_oid.len)
    ++			apply_autostash_oid(stash_oid.buf);
    ++
    ++		strbuf_release(&stash_oid);
      		goto done;
      	}
      
    @@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
      	git_committer_info(IDENT_STRICT);
      
     
    + ## builtin/rebase.c ##
    +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
    + 		{ OPTION_STRING, 'S', "gpg-sign", &gpg_sign, N_("key-id"),
    + 			N_("GPG-sign commits"),
    + 			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
    +-		OPT_BOOL(0, "autostash", &options.autostash,
    +-			 N_("automatically stash/stash pop before and after")),
    ++		OPT_AUTOSTASH(&options.autostash),
    + 		OPT_STRING_LIST('x', "exec", &exec, N_("exec"),
    + 				N_("add exec lines after each commit of the "
    + 				   "editable list")),
    +
      ## builtin/reset.c ##
     @@
      #include "cache-tree.h"
    @@ builtin/reset.c: int cmd_reset(int argc, const char **argv, const char *prefix)
      	}
     -	if (!pathspec.nr)
     +	if (!pathspec.nr) {
    -+		if (reset_type == HARD)
    -+			save_autostash(git_path_merge_autostash(the_repository));
    -+
      		remove_branch_state(the_repository, 0);
     +	}
      
      	return update_ref_status;
      }
     
    + ## parse-options.h ##
    +@@ parse-options.h: int parse_opt_passthru_argv(const struct option *, const char *, int);
    + #define OPT_CLEANUP(v) OPT_STRING(0, "cleanup", v, N_("mode"), N_("how to strip spaces and #comments from message"))
    + #define OPT_PATHSPEC_FROM_FILE(v) OPT_FILENAME(0, "pathspec-from-file", v, N_("read pathspec from file"))
    + #define OPT_PATHSPEC_FILE_NUL(v)  OPT_BOOL(0, "pathspec-file-nul", v, N_("with --pathspec-from-file, pathspec elements are separated with NUL character"))
    ++#define OPT_AUTOSTASH(v) OPT_BOOL(0, "autostash", v, N_("automatically stash/stash pop before and after"))
    + 
    + #endif
    +
      ## path.c ##
     @@ path.c: REPO_GIT_PATH_FUNC(merge_msg, "MERGE_MSG")
      REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
    @@ t/t7600-merge.sh: test_expect_success 'refresh the index before merging' '
     +	test_cmp file.1 file
     +'
     +
    -+test_expect_success 'completed merge with --no-commit and --autostash' '
    ++test_expect_success 'completed merge (git commit) with --no-commit and --autostash' '
     +	git reset --hard c1 &&
     +	git merge-file file file.orig file.9 &&
     +	git diff >expect &&
    @@ t/t7600-merge.sh: test_expect_success 'refresh the index before merging' '
     +	test_cmp result.1-5-9 file
     +'
     +
    ++test_expect_success 'completed merge (git merge --continue) with --no-commit and --autostash' '
    ++	git reset --hard c1 &&
    ++	git merge-file file file.orig file.9 &&
    ++	git diff >expect &&
    ++	git merge --no-commit --autostash c2 &&
    ++	git stash show -p MERGE_AUTOSTASH >actual &&
    ++	test_cmp expect actual &&
    ++	git merge --continue 2>err &&
    ++	test_i18ngrep "Applied autostash." err &&
    ++	git show HEAD:file >merge-result &&
    ++	test_cmp result.1-5 merge-result &&
    ++	test_cmp result.1-5-9 file
    ++'
    ++
     +test_expect_success 'aborted merge (merge --abort) with --no-commit and --autostash' '
     +	git reset --hard c1 &&
     +	git merge-file file file.orig file.9 &&
18:  4dabe214f2 = 22:  f1e54622fb t5520: make test_pull_autostash() accept expect_parent_num
19:  9b6f16f1bf ! 23:  177c7e537b pull: pass --autostash to merge
    @@ Documentation/merge-options.txt: ifndef::git-pull[]
      	Automatically create a temporary stash entry before the operation
     @@ Documentation/merge-options.txt: ifndef::git-pull[]
      	with care: the final stash application after a successful
    - 	rebase might result in non-trivial conflicts.
    + 	merge might result in non-trivial conflicts.
      
     -endif::git-pull[]
     -
-- 
2.26.0.159.g23e2136ad0

