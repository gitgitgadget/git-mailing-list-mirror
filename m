Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E0AC2BA80
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32B02078C
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R84CqPmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgDGO2W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:28:22 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38053 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbgDGO2V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:28:21 -0400
Received: by mail-qt1-f194.google.com with SMTP id 13so893811qtt.5
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ygTu0NbJSjn1AGFMG8aEkeuvFoKF2jC0AoW9cQM3rvM=;
        b=R84CqPmNFF46puY5akUKgZcv2Np2qT4V8/AiFlENYplsdi0VxthoZLj/Kz7PGjDMy7
         sQ4vno/gYMdP3/xp2nYQMnZeZtFZnQgs28vtno79n7cUNOydIOU5CwtdetH9fnGyVCbp
         SeFz8mWlF70BA9H0s0B7o5s0gGlmO56gpGrtoyz6Sjq0v3KRQQ5qrnxEo8fdqmKQ2Hwq
         gX+CVM8YuchvJUyynKr35IwRabCHKoDTFJIwGrxY5DxWkOigeNPhdtQqlx3f8+RWZ0Jb
         ZMbHjI/xoxVz0nZScBr+UvM1MiFyW2PQ2uN58i/unfZEZczC/ETXsVRJSnGFgzYdNXqp
         IONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ygTu0NbJSjn1AGFMG8aEkeuvFoKF2jC0AoW9cQM3rvM=;
        b=KA5Ly0NHG4TX7BDetsYq3dnpoPC46MEBEXyI3x9ef0n8eHq9/QsQEiZesNXtQ7VxbI
         D94sTphpw71laIfdRyoCV2ikT24Lpm9Q7TI1A+UPbztNw0Eg3v+PVuowpiiecfFYmVfS
         w7h5Av/uvSlET7idtjBCq9swr77gkDf+tb8kSDluptwiPFG9Ia5cNvXb34YWZMZbcRq1
         o7ZW+eVv1qQemTQX9WeY2z8alYXtIilpMQrzmcyPfNKcfDA3KvxX4B7HGS4dgLK8+wvV
         aOkNAfdv9rxuRcWtrTs0A+5RCgQvo9NhHCB6dAfHd0FUhnqC8gpNIBOuljX5JEIcQb+y
         bM6w==
X-Gm-Message-State: AGi0PuZkoUvRqN4lA8EY93DVtveilQH6BNonZFINeT8CemWJqZzwn0JD
        T4sBqdlEGr0zrQKFIfithCpghP1q
X-Google-Smtp-Source: APiQypIR5sngn8PvDApVvW225yktkEn75CZN7nUYmgZvgoiRu3afCWBzd0pK7Q7d6NnZbF8s08il0A==
X-Received: by 2002:ac8:10f:: with SMTP id e15mr2500107qtg.355.1586269698634;
        Tue, 07 Apr 2020 07:28:18 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id j6sm17051736qti.25.2020.04.07.07.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:28:17 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 00/22] merge: learn --autostash
Date:   Tue,  7 Apr 2020 10:27:47 -0400
Message-Id: <cover.1586269542.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585962672.git.liu.denton@gmail.com>
References: <cover.1585962672.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban reported[1] that he expected merge to have an --autostash option,
just like rebase. Since there's not really any reason why merge can't
have it, let's implement it in this patchset.

The majority of this patchset is spent refactoring. This is so that the
actual implementation in merge is done as simply as possible.

Chagnes since v4:

* Drop 'sequencer: reuse strbuf_trim() in read_oneliner()'

* Fix commit message in 'sequencer: make apply_autostash() accept a path'

* Add more detail in commit message 'sequencer: implement save_autostash()'

* In 'merge: teach --autostash option', improve documentation, remove
  builtin/reset.c changes, add a `git merge --quit` test case

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

Denton Liu (22):
  Makefile: ASCII-sort += lists
  t7600: use test_write_lines()
  sequencer: stop leaking buf
  sequencer: make file exists check more efficient
  sequencer: make read_oneliner() accept flags
  sequencer: configurably warn on non-existent files
  sequencer: make read_oneliner() extern
  rebase: use read_oneliner()
  sequencer: make apply_autostash() accept a path
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

 Documentation/config/merge.txt  |  10 ++
 Documentation/git-merge.txt     |  11 +-
 Documentation/git-pull.txt      |   9 -
 Documentation/merge-options.txt |   8 +
 Makefile                        |  78 ++++----
 branch.c                        |   1 +
 builtin/commit.c                |   2 +
 builtin/merge.c                 |  25 +++
 builtin/pull.c                  |   9 +-
 builtin/rebase.c                | 307 +++++---------------------------
 parse-options.h                 |   1 +
 path.c                          |   1 +
 path.h                          |   4 +-
 reset.c                         | 140 +++++++++++++++
 reset.h                         |  20 +++
 sequencer.c                     | 176 +++++++++++++-----
 sequencer.h                     |  20 +++
 t/t3033-merge-toplevel.sh       |  22 +++
 t/t5520-pull.sh                 |  57 ++++--
 t/t7600-merge.sh                | 154 ++++++++++++++--
 20 files changed, 665 insertions(+), 390 deletions(-)
 create mode 100644 reset.c
 create mode 100644 reset.h

Range-diff against v4:
 1:  c26771e934 =  1:  c26771e934 Makefile: ASCII-sort += lists
 2:  059e0e8e43 =  2:  059e0e8e43 t7600: use test_write_lines()
 3:  76585e5b13 =  3:  76585e5b13 sequencer: stop leaking buf
 4:  c7a3cfa200 <  -:  ---------- sequencer: reuse strbuf_trim() in read_oneliner()
 5:  58da8e9555 !  4:  dc4674d222 sequencer: make file exists check more efficient
    @@ Commit message
         check `errno` to see if the file doesn't exist.
     
      ## sequencer.c ##
    -@@ sequencer.c: static int write_message(const void *buf, size_t len, const char *filename,
    - static int read_oneliner(struct strbuf *buf,
    - 	const char *path, int skip_if_empty)
    +@@ sequencer.c: static int read_oneliner(struct strbuf *buf,
      {
    --
    + 	int orig_len = buf->len;
    + 
     -	if (!file_exists(path))
     -		return 0;
     -
    - 	strbuf_reset(buf);
      	if (strbuf_read_file(buf, path, 0) < 0) {
     -		warning_errno(_("could not read '%s'"), path);
     +		if (errno != ENOENT && errno != ENOTDIR)
 6:  6ead240957 !  5:  f30ad07823 sequencer: make read_oneliner() accept flags
    @@ sequencer.c: static int write_message(const void *buf, size_t len, const char *f
     +#define READ_ONELINER_SKIP_IF_EMPTY (1 << 0)
     +
      /*
    -  * Resets a strbuf then reads a file that was presumably written by a shell
    -  * script, i.e. with an end-of-line marker that needs to be stripped.
    +  * Reads a file that was presumably written by a shell script, i.e. with an
    +  * end-of-line marker that needs to be stripped.
     @@ sequencer.c: static int write_message(const void *buf, size_t len, const char *filename,
       * Returns 1 if the file was read, 0 if it could not be read or does not exist.
       */
    @@ sequencer.c: static int write_message(const void *buf, size_t len, const char *f
     -	const char *path, int skip_if_empty)
     +	const char *path, unsigned flags)
      {
    - 	strbuf_reset(buf);
    - 	if (strbuf_read_file(buf, path, 0) < 0) {
    + 	int orig_len = buf->len;
    + 
     @@ sequencer.c: static int read_oneliner(struct strbuf *buf,
    + 		buf->buf[buf->len] = '\0';
    + 	}
      
    - 	strbuf_trim(buf);
    - 
    --	if (skip_if_empty && !buf->len)
    -+	if ((flags & READ_ONELINER_SKIP_IF_EMPTY) && !buf->len)
    +-	if (skip_if_empty && buf->len == orig_len)
    ++	if ((flags & READ_ONELINER_SKIP_IF_EMPTY) && buf->len == orig_len)
      		return 0;
      
      	return 1;
    @@ sequencer.c: static int read_populate_opts(struct replay_opts *opts)
      				strbuf_reset(&buf);
      			else {
     @@ sequencer.c: static int read_populate_opts(struct replay_opts *opts)
    - 			}
    + 			strbuf_reset(&buf);
      		}
      
     -		if (read_oneliner(&buf, rebase_path_allow_rerere_autoupdate(), 1)) {
    @@ sequencer.c: static int read_populate_opts(struct replay_opts *opts)
      				opts->allow_rerere_auto = RERERE_AUTOUPDATE;
      			else if (!strcmp(buf.buf, "--no-rerere-autoupdate"))
     @@ sequencer.c: static int read_populate_opts(struct replay_opts *opts)
    - 		read_strategy_opts(opts, &buf);
    + 		strbuf_reset(&buf);
      
      		if (read_oneliner(&opts->current_fixups,
     -				  rebase_path_current_fixups(), 1)) {
 7:  2e7922b259 !  6:  8c504427e3 sequencer: configurably warn on non-existent files
    @@ Commit message
         read_oneliner() will want the ability to output warnings in the event
         that the `path` doesn't exist. Introduce the
         `READ_ONELINER_WARN_MISSING` flag which, if active, would issue a
    -    warning when a file doesn't exist by skipping the `!file_exists()` check
    -    and letting `strbuf_read_file()` handle that case.
    +    warning when a file doesn't exist by always executing warning_errno()
    +    in the case where strbuf_read_file() fails.
     
      ## sequencer.c ##
     @@ sequencer.c: static int write_message(const void *buf, size_t len, const char *filename,
    @@ sequencer.c: static int write_message(const void *buf, size_t len, const char *f
     +#define READ_ONELINER_WARN_MISSING (1 << 1)
      
      /*
    -  * Resets a strbuf then reads a file that was presumably written by a shell
    +  * Reads a file that was presumably written by a shell script, i.e. with an
     @@ sequencer.c: static int read_oneliner(struct strbuf *buf,
    - {
    - 	strbuf_reset(buf);
    + 	int orig_len = buf->len;
    + 
      	if (strbuf_read_file(buf, path, 0) < 0) {
     -		if (errno != ENOENT && errno != ENOTDIR)
     +		if ((flags & READ_ONELINER_WARN_MISSING) ||
    -+				(errno != ENOENT && errno != ENOTDIR))
    ++		    (errno != ENOENT && errno != ENOTDIR))
      			warning_errno(_("could not read '%s'"), path);
      		return 0;
      	}
 8:  6c3c37994b !  7:  50e93770e7 sequencer: make read_oneliner() extern
    @@ sequencer.c: static int write_message(const void *buf, size_t len, const char *f
     -#define READ_ONELINER_WARN_MISSING (1 << 1)
     -
     -/*
    -- * Resets a strbuf then reads a file that was presumably written by a shell
    -- * script, i.e. with an end-of-line marker that needs to be stripped.
    +- * Reads a file that was presumably written by a shell script, i.e. with an
    +- * end-of-line marker that needs to be stripped.
     - *
     - * Note that only the last end-of-line marker is stripped, consistent with the
     - * behavior of "$(cat path)" in a shell script.
    @@ sequencer.c: static int write_message(const void *buf, size_t len, const char *f
     +int read_oneliner(struct strbuf *buf,
      	const char *path, unsigned flags)
      {
    - 	strbuf_reset(buf);
    + 	int orig_len = buf->len;
     
      ## sequencer.h ##
     @@ sequencer.h: void print_commit_summary(struct repository *repo,
    @@ sequencer.h: void print_commit_summary(struct repository *repo,
     +#define READ_ONELINER_WARN_MISSING (1 << 1)
     +
     +/*
    -+ * Resets a strbuf then reads a file that was presumably written by a shell
    -+ * script, i.e. with an end-of-line marker that needs to be stripped.
    ++ * Reads a file that was presumably written by a shell script, i.e. with an
    ++ * end-of-line marker that needs to be stripped.
     + *
     + * Note that only the last end-of-line marker is stripped, consistent with the
     + * behavior of "$(cat path)" in a shell script.
 9:  689f34a2a5 !  8:  0cc279fc14 rebase: use read_oneliner()
    @@ Commit message
     
         Since in sequencer.c, read_one() basically duplicates the functionality
         of read_oneliner(), reduce code duplication by replacing read_one() with
    -    read_oneliner(). Also, delete strbuf_reset() calls prior to
    -    read_oneliner() as read_oneliner() already resets the strbuf.
    +    read_oneliner().
     
    -    This was mostly done with the following Coccinelle script
    +    This was done with the following Coccinelle script
     
                 @@
                 expression a, b;
    @@ Commit message
                 - read_one(a, b)
                 + !read_oneliner(b, a, READ_ONELINER_WARN_NON_EXISTENCE)
     
    -    Long lines were broken up and strbuf_reset()s were deleted manually.
    +    and long lines were manually broken up.
     
      ## builtin/rebase.c ##
     @@ builtin/rebase.c: static const char *state_dir_path(const char *filename, struct rebase_options *o
    @@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
      	opts->head_name = starts_with(head_name.buf, "refs/") ?
      		xstrdup(head_name.buf) : NULL;
     @@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
    - 	 * head. Fall back to reading from head to cover for the case that the
    - 	 * user upgraded git with an ongoing interactive rebase.
      	 */
    --	strbuf_reset(&buf);
    + 	strbuf_reset(&buf);
      	if (file_exists(state_dir_path("orig-head", opts))) {
     -		if (read_one(state_dir_path("orig-head", opts), &buf))
     +		if (!read_oneliner(&buf, state_dir_path("orig-head", opts),
    @@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
      	if (get_oid(buf.buf, &opts->orig_head))
      		return error(_("invalid orig-head: '%s'"), buf.buf);
     @@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
    - 	}
      
      	if (file_exists(state_dir_path("allow_rerere_autoupdate", opts))) {
    --		strbuf_reset(&buf);
    + 		strbuf_reset(&buf);
     -		if (read_one(state_dir_path("allow_rerere_autoupdate", opts),
     -			    &buf))
     +		if (!read_oneliner(&buf, state_dir_path("allow_rerere_autoupdate", opts),
    @@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
      		if (!strcmp(buf.buf, "--rerere-autoupdate"))
      			opts->allow_rerere_autoupdate = RERERE_AUTOUPDATE;
     @@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
    - 	}
      
      	if (file_exists(state_dir_path("gpg_sign_opt", opts))) {
    --		strbuf_reset(&buf);
    + 		strbuf_reset(&buf);
     -		if (read_one(state_dir_path("gpg_sign_opt", opts),
     -			    &buf))
     +		if (!read_oneliner(&buf, state_dir_path("gpg_sign_opt", opts),
    @@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
      			return -1;
      		free(opts->gpg_sign_opt);
      		opts->gpg_sign_opt = xstrdup(buf.buf);
    - 	}
    +@@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
      
      	if (file_exists(state_dir_path("strategy", opts))) {
    --		strbuf_reset(&buf);
    + 		strbuf_reset(&buf);
     -		if (read_one(state_dir_path("strategy", opts), &buf))
     +		if (!read_oneliner(&buf, state_dir_path("strategy", opts),
     +				   READ_ONELINER_WARN_MISSING))
      			return -1;
      		free(opts->strategy);
      		opts->strategy = xstrdup(buf.buf);
    - 	}
    +@@ builtin/rebase.c: static int read_basic_state(struct rebase_options *opts)
      
      	if (file_exists(state_dir_path("strategy_opts", opts))) {
    --		strbuf_reset(&buf);
    + 		strbuf_reset(&buf);
     -		if (read_one(state_dir_path("strategy_opts", opts), &buf))
     +		if (!read_oneliner(&buf, state_dir_path("strategy_opts", opts),
     +				   READ_ONELINER_WARN_MISSING))
10:  e0b8e409af !  9:  3dbed2a832 sequencer: make apply_rebase() accept a path
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    sequencer: make apply_rebase() accept a path
    +    sequencer: make apply_autostash() accept a path
     
    -    In order to make apply_rebase() more generic for future extraction, make
    +    In order to make apply_autostash() more generic for future extraction, make
         it accept a `path` argument so that the location from where to read the
         reference to the autostash commit can be customized. Remove the `opts`
         argument since it was unused before anyway.
11:  a52583beff = 10:  937b4964d1 sequencer: rename stash_sha1 to stash_oid
12:  389b17df33 = 11:  98a7f5280c rebase: use apply_autostash() from sequencer.c
13:  fe57e21dbc = 12:  67f3b5c225 rebase: generify reset_head()
14:  045668620d = 13:  af5e808667 reset: extract reset_head() from rebase
15:  d5f51cd80e = 14:  114d9a7655 rebase: extract create_autostash()
16:  9ab10d23d4 = 15:  c2ed4cd39d rebase: generify create_autostash()
17:  26cca49be6 = 16:  3be4a27dfe sequencer: extract perform_autostash() from rebase
18:  e703022fda = 17:  129d5d97ae sequencer: unlink autostash in apply_autostash()
19:  75dc3f10a1 ! 18:  7e04ce8d8e sequencer: implement save_autostash()
    @@ Commit message
         function will be used in a future commit.
     
         The difference between save_autostash() and apply_autostash() is that
    -    the latter does not try to apply the stash. It skips that step and
    +    the former does not try to apply the stash. It skips that step and
         just stores the created entry in the stash reflog.
     
    +    This is useful in the case where we abort an operation when an autostash
    +    is present but we don't want to dirty the worktree with the application
    +    of the stash. For example, in a future commit, we will implement
    +    `git merge --autostash`. Since merges can be aborted using
    +    `git reset --hard`, we'd make use of save_autostash() to save the
    +    autostash entry instead of applying it to the worktree thus keeping the
    +    worktree undirtied.
    +
      ## sequencer.c ##
     @@ sequencer.c: void create_autostash(struct repository *r, const char *path,
      	strbuf_release(&buf);
20:  598ddea6c1 = 19:  732b3f9945 sequencer: implement apply_autostash_oid()
21:  7adf794192 ! 20:  f9f698b79a merge: teach --autostash option
    @@ Commit message
         `git reset --hard`, the autostash is saved into the stash reflog
         instead keeping the worktree clean.
     
    +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
         Suggested-by: Alban Gruin <alban.gruin@gmail.com>
     
      ## Documentation/config/merge.txt ##
    @@ Documentation/git-merge.txt: will be appended to the specified message.
      	Abort the current conflict resolution process, and
     -	try to reconstruct the pre-merge state.
     +	try to reconstruct the pre-merge state. If an autostash entry is
    -+	present, apply it back to the worktree.
    ++	present, apply it to the worktree.
      +
      If there were uncommitted worktree changes present when the merge
      started, 'git merge --abort' will in some cases be unable to
    @@ Documentation/git-merge.txt: reconstruct these changes. It is therefore recommen
      +
      'git merge --abort' is equivalent to 'git reset --merge' when
     -`MERGE_HEAD` is present.
    -+`MERGE_HEAD` is present unless `MERGE_AUTOSTASH` is also present where
    -+the stash entry is applied to the worktree.
    ++`MERGE_HEAD` is present unless `MERGE_AUTOSTASH` is also present in
    ++which case 'git merge --abort' applies the stash entry to the worktree
    ++whereas 'git reset --merge' will save the stashed changes in the stash
    ++reflog.
      
      --quit::
      	Forget about the current merge in progress. Leave the index
    +-	and the working tree as-is.
    ++	and the working tree as-is. If `MERGE_AUTOSTASH` is present, the
    ++	stash entry will be saved to the stash reflog.
    + 
    + --continue::
    + 	After a 'git merge' stops due to conflicts you can conclude the
     
      ## Documentation/merge-options.txt ##
     @@ Documentation/merge-options.txt: ifndef::git-pull[]
    @@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
      			die(_("There is no merge to abort (MERGE_HEAD missing)."));
      
     +		if (read_oneliner(&stash_oid, git_path_merge_autostash(the_repository),
    -+			   READ_ONELINER_SKIP_IF_EMPTY)) {
    -+			strbuf_trim(&stash_oid);
    ++		    READ_ONELINER_SKIP_IF_EMPTY))
     +			unlink(git_path_merge_autostash(the_repository));
    -+		}
     +
      		/* Invoke 'git reset --merge' */
      		ret = cmd_reset(nargc, nargv, prefix);
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      				N_("add exec lines after each commit of the "
      				   "editable list")),
     
    - ## builtin/reset.c ##
    -@@
    - #include "cache-tree.h"
    - #include "submodule.h"
    - #include "submodule-config.h"
    -+#include "sequencer.h"
    - 
    - #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
    - 
    -@@ builtin/reset.c: int cmd_reset(int argc, const char **argv, const char *prefix)
    - 		if (reset_type == HARD && !update_ref_status && !quiet)
    - 			print_new_head_line(lookup_commit_reference(the_repository, &oid));
    - 	}
    --	if (!pathspec.nr)
    -+	if (!pathspec.nr) {
    - 		remove_branch_state(the_repository, 0);
    -+	}
    - 
    - 	return update_ref_status;
    - }
    -
      ## parse-options.h ##
     @@ parse-options.h: int parse_opt_passthru_argv(const struct option *, const char *, int);
      #define OPT_CLEANUP(v) OPT_STRING(0, "cleanup", v, N_("mode"), N_("how to strip spaces and #comments from message"))
    @@ t/t7600-merge.sh: test_expect_success 'refresh the index before merging' '
     +	git diff --exit-code
     +'
     +
    ++test_expect_success 'quit merge with --no-commit and --autostash' '
    ++	git reset --hard c1 &&
    ++	git merge-file file file.orig file.9 &&
    ++	git diff >expect &&
    ++	git merge --no-commit --autostash c2 &&
    ++	git stash show -p MERGE_AUTOSTASH >actual &&
    ++	test_cmp expect actual &&
    ++	git diff HEAD >expect &&
    ++	git merge --quit 2>err &&
    ++	test_i18ngrep "Autostash exists; creating a new stash entry." err &&
    ++	git diff HEAD >actual &&
    ++	test_cmp expect actual
    ++'
    ++
     +test_expect_success 'merge with conflicted --autostash changes' '
     +	git reset --hard c1 &&
     +	git merge-file file file.orig file.9y &&
22:  f1e54622fb = 21:  13f3fadbef t5520: make test_pull_autostash() accept expect_parent_num
23:  177c7e537b = 22:  f4fec1e780 pull: pass --autostash to merge
-- 
2.26.0.159.g23e2136ad0

