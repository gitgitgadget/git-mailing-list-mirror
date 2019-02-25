Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DFA920248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfBYXQs (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:16:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39424 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfBYXQs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:16:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id l5so11832298wrw.6
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LWwaXQAnwmAweuV0IPjYMIG5sCeQV9Kjh3pizX4pwgE=;
        b=nr+t9C9OlZQIupfpz9NwaQOyqY5kmYz5L4AvsO+PlhJj4JgFGd/DjtcnK4ksyrmZk8
         qLEnmAguImZCsR9RphurVuDjDMULRB6MFv8iMM1dze9QblIv0ZQVpF4QuA7F0BcXV4oB
         YYE4cz/FfEufOW3B9w3kbS8uLOnYZcZTSrz36KL/Mi1Wxcmq1T5c9NzRhCy2omID/RCa
         pvkVqOPmTROFDGdxGyRFuZz4YJhCiGpwtevQz1g3ofOj+qqbNlEdJ28Zmd98Ws0Bqb9j
         zw8ECShxmIqe8ac2wRvvB7y8ddFAbjLybwNzGmr6OL/1LCBRSe74ebVKmwkGZkLz1BUw
         x6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LWwaXQAnwmAweuV0IPjYMIG5sCeQV9Kjh3pizX4pwgE=;
        b=WM0CYd7AhXm7ohVDtPtz9J4drx0h6UimeEC+FkW8yBHu4g+C2rdyEm8n56xIGny/yC
         MsUlSegEDDOd4uFX9BEdJcEB5fn/Kdamzjim56SrUfkEsUVljQOLOY06ZVy4Ww2o46AU
         a2I2f2mTY3gixlZ15we6v77NZLdkn56xOywFEsHRf1oY8MYlWmhD6SccBI0aDdqdYlny
         Rp0nEHYrsxJDdQpnxicWSVazt6+IplPsAByP11rGGGJYmr1TAsduQz7kI9EA3l8AfWe2
         7/HVtNN2iYcEdDYT3a1DKvWEUDNpDXrfSvrn7hqhgTtHLJIveUfLhH1ZWV+QG6FxRkQF
         rYnw==
X-Gm-Message-State: AHQUAuZUMcJMWghHx8ZmwN2E/QSH+z06RRwtFjWq0bVsiPUW5mNQ+XlI
        darUMyQsBCRl/f3eISR3sI+K/jxh
X-Google-Smtp-Source: AHgI3Ib4BjyoN232lRbOkYKsUsUOr2liNIiZQ5OlkK4j+9q4I1BbLgDY8IBsokxAFn1SLU583X8Z/Q==
X-Received: by 2002:a5d:44c3:: with SMTP id z3mr13720017wrr.329.1551136603935;
        Mon, 25 Feb 2019 15:16:43 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id w4sm17852786wrk.85.2019.02.25.15.16.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:16:41 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 00/27] Convert "git stash" to C builtin
Date:   Mon, 25 Feb 2019 23:16:04 +0000
Message-Id: <20190225231631.30507-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.291.g17236886c5
In-Reply-To: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As I was advocating for this series to go into 'next' without a large
refactor of this series, I'll put my money were my mouth is and try to
make the cleanups and fixes required, though without trying to avoid
further external process calls, or changing the series around too
much.

One thing to consider here is that we have a GSoC project planned
based on 'git stash'.  If we can't get this to 'next' soon, I'd vote
for taking that project out of this years GSoC, and maybe try again
next year, if nobody implemented the feature in the meantime.

One thing that came up in the latest reviews, was to keep the stash
script intact throughout the series, and to not re-introduce it after
deleting it.  I did however not do that, as that would make the
range-diff quite a bit harder to read.  In addition removing the
script bit by bit also allowed us to find the precise commit in which
the missing 'discard_cache()' bug was introduced, which made it a bit
easier to pinpoint where the bug comes from imo.

Additionally now that we established that we re-introduce the same
shell script in a previous review, it's now easy to see that we're
still doing the right thing in this patch series.

So what did change in this round?
- Squashed Johannes Sixt patch into the relevant patch
- Pulled out the test from Matthew Kraai into a separate patch, and
  squashed the rest of the patch into the relevant commit
(The two changes above were credited by adding Helped-by trailers)
- Fixed the missing discard_cache before reset --hard and apply
  --index -R.  t3903-stash.sh --stress now passed more than 250
  iterations without error.
- Addressed my and Junios review comments on the previous round
- Some small fixups

range-diff below:

 1:  0c1599c33c !  1:  baa5d369e4 strbuf.c: add `strbuf_join_argv()`
    @@ -6,7 +6,7 @@
         into a strbuf.
     
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/strbuf.c b/strbuf.c
      --- a/strbuf.c
 2:  bfc3fe33f6 !  2:  08bb77502c strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
    @@ -7,7 +7,8 @@
     
         Original-idea-by: Johannes Schindelin <johannes.schindelin@gmx.de>
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Helped-by: Johannes Sixt <j6t@kdbg.org>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/strbuf.c b/strbuf.c
      --- a/strbuf.c
    @@ -37,7 +38,7 @@
     +	memmove(sb->buf + pos + len, sb->buf + pos, sb->len - pos);
     +	/* vsnprintf() will append a NUL, overwriting one of our characters */
     +	save = sb->buf[pos + len];
    -+	len2 = vsnprintf(sb->buf + pos, sb->alloc - sb->len, fmt, ap);
    ++	len2 = vsnprintf(sb->buf + pos, len + 1, fmt, ap);
     +	sb->buf[pos + len] = save;
     +	if (len2 != len)
     +		BUG("your vsnprintf is broken (returns inconsistent lengths)");
 3:  97f56073ce !  3:  2956b2bd27 ident: add the ability to provide a "fallback identity"
    @@ -12,7 +12,9 @@
         function.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    [tg: add docs; make it a bug to call the function before other
    +    functions in the ident API]
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/cache.h b/cache.h
      --- a/cache.h
    @@ -21,6 +23,10 @@
      extern const char *git_pager(int stdout_is_tty);
      extern int is_terminal_dumb(void);
      extern int git_ident_config(const char *, const char *, void *);
    ++/*
    ++ * Prepare an ident to fall back on if the user didn't configure it.
    ++ * Must be called before any other function from the ident API.
    ++ */
     +void prepare_fallback_ident(const char *name, const char *email);
      extern void reset_ident_date(void);
      
    @@ -35,7 +41,9 @@
      
     +static void set_env_if(const char *key, const char *value, int *given, int bit)
     +{
    -+	if ((*given & bit) || getenv(key))
    ++	if (*given & bit)
    ++		BUG("%s was checked before prepare_fallback got called", key);
    ++	if (getenv(key))
     +		return; /* nothing to do */
     +	setenv(key, value, 0);
     +	*given |= bit;
 4:  0654fe70a8 !  4:  55db527e68 stash: improve option parsing test coverage
    @@ -8,7 +8,7 @@
     
         Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
      --- a/t/t3903-stash.sh
 5:  caf7bc3cc6 !  5:  7a5eb3a9e8 t3903: modernize style
    @@ -6,7 +6,7 @@
         long lines.
     
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
      --- a/t/t3903-stash.sh
26:  ed5d77f7d3 !  6:  453543916d stash: fix segmentation fault when files were added with intent
    @@ -1,45 +1,17 @@
     Author: Matthew Kraai <mkraai@its.jnj.com>
     
    -    stash: fix segmentation fault when files were added with intent
    +    t3903: add test for --intent-to-add file
     
    -    After `git add -N <file>`, the index is in a special state. A state for
    -    which the built-in stash was not prepared, as it failed to initialize
    -    the `rev` structure in that case before using `&rev.pending`.  If
    -    `reset_tree()` returns a non-zero value, `stash_working_tree()`
    -    calls `object_array_clear()` with `&rev.pending`.  If `rev` is not
    -    initialized, this causes a segmentation fault.
    +    Add a test showing the 'git stash' behaviour with a file that has been
    +    added with 'git add --intent-to-add'.  Stash fails to stash the file,
    +    so the purpose of this test is mainly to make sure git doesn't crash,
    +    but exits normally in this situation.
     
    -    Prevent this by initializing `rev` before calling `reset_tree()`.
    -
    -    This fixes https://github.com/git-for-windows/git/issues/2006.
    -
    -    [jes: modified the commit message in preparation for sending this patch
    -    to the Git mailing list.]
    +    [tg: pulled the test out into a separate commit]
     
         Signed-off-by: Matthew Kraai <mkraai@its.jnj.com>
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -
    - diff --git a/builtin/stash.c b/builtin/stash.c
    - --- a/builtin/stash.c
    - +++ b/builtin/stash.c
    -@@
    - 	struct strbuf diff_output = STRBUF_INIT;
    - 	struct index_state istate = { NULL };
    - 
    -+	init_revisions(&rev, NULL);
    -+
    - 	set_alternate_index_output(stash_index_path.buf);
    - 	if (reset_tree(&info->i_tree, 0, 0)) {
    - 		ret = -1;
    -@@
    - 	}
    - 	set_alternate_index_output(NULL);
    - 
    --	init_revisions(&rev, NULL);
    - 	rev.prune_data = ps;
    - 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
    - 	rev.diffopt.format_callback = add_diff_to_buf;
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
      --- a/t/t3903-stash.sh
 6:  ee77c6a603 !  7:  587d3e8e49 stash: rename test cases to be more descriptive
    @@ -6,7 +6,7 @@
         characters per line.
     
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
      --- a/t/t3903-stash.sh
 7:  cb2152ebce !  8:  b03c17e744 stash: add tests for `git stash show` config
    @@ -7,7 +7,7 @@
         and `stash.showPatch` are unset or set to true / false.
     
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/t/t3907-stash-show-config.sh b/t/t3907-stash-show-config.sh
      new file mode 100755
 8:  983084d9ec !  9:  010c5f4ce2 stash: mention options in `show` synopsis
    @@ -6,7 +6,7 @@
         option known to `git diff`.
     
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
      --- a/Documentation/git-stash.txt
 9:  f6bbd78127 ! 10:  45670448e8 stash: convert apply to builtin
    @@ -17,7 +17,7 @@
     
         Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/.gitignore b/.gitignore
      --- a/.gitignore
    @@ -96,7 +96,6 @@
     + * i_tree is set to the index tree
     + * u_tree is set to the untracked files tree
     + */
    -+
     +struct stash_info {
     +	struct object_id w_commit;
     +	struct object_id b_commit;
    @@ -357,7 +356,7 @@
     +	if (refresh_cache(REFRESH_QUIET))
     +		return -1;
     +
    -+	if (write_cache_as_tree(&c_tree, 0, NULL) || reset_tree(&c_tree, 0, 0))
    ++	if (write_cache_as_tree(&c_tree, 0, NULL))
     +		return error(_("cannot apply a stash in the middle of a merge"));
     +
     +	if (index) {
10:  cdca49bc4c ! 11:  cea038dd3c stash: convert drop and clear to builtin
    @@ -13,7 +13,7 @@
     
         Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
      --- a/builtin/stash--helper.c
    @@ -128,9 +128,9 @@
     +static void assert_stash_ref(struct stash_info *info)
     +{
     +	if (!info->is_stash_ref) {
    -+		free_stash_info(info);
     +		error(_("'%s' is not a stash reference"), info->revision.buf);
    -+		exit(128);
    ++		free_stash_info(info);
    ++		exit(1);
     +	}
     +}
     +
11:  f596f3366c ! 12:  deb4f6cee9 stash: convert branch to builtin
    @@ -11,7 +11,7 @@
     
         Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
      --- a/builtin/stash--helper.c
12:  e1d01876a4 ! 13:  75f9431abf stash: convert pop to builtin
    @@ -8,7 +8,7 @@
     
         Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
      --- a/builtin/stash--helper.c
13:  9b77b07ba4 ! 14:  f6814704ee stash: convert list to builtin
    @@ -6,7 +6,7 @@
         from the shell script.
     
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
      --- a/builtin/stash--helper.c
14:  b4493f269e ! 15:  d1098f2c8e stash: convert show to builtin
    @@ -11,7 +11,7 @@
         further to `git diff`.
     
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
      --- a/builtin/stash--helper.c
15:  847eb0b0a8 ! 16:  9706cab487 stash: convert store to builtin
    @@ -6,7 +6,7 @@
         from the shell script.
     
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
      --- a/builtin/stash--helper.c
16:  1f5a011d90 ! 17:  a5d6a3bd14 stash: convert create to builtin
    @@ -5,7 +5,8 @@
         Add stash create to the helper.
     
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Helped-by: Matthew Kraai <mkraai@its.jnj.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
      --- a/builtin/stash--helper.c
    @@ -45,11 +46,7 @@
     +	for (i = 0; i < q->nr; i++) {
     +		strbuf_addstr(data, q->queue[i]->one->path);
     +
    -+		/*
    -+		 * The reason we add "0" at the end of this strbuf
    -+		 * is because we will pass the output further to
    -+		 * "git update-index -z ...".
    -+		 */
    ++		/* NUL-terminate: will be fed to update-index -z */
     +		strbuf_addch(data, '\0');
     +	}
     +}
    @@ -98,7 +95,7 @@
     +			found++;
     +			strbuf_addstr(untracked_files, ent->name);
     +			/* NUL-terminate: will be fed to update-index -z */
    -+			strbuf_addch(untracked_files, 0);
    ++			strbuf_addch(untracked_files, '\0');
     +		}
     +		free(ent);
     +	}
    @@ -278,6 +275,8 @@
     +	struct strbuf out = STRBUF_INIT;
     +	struct strbuf diff_output = STRBUF_INIT;
     +
    ++	init_revisions(&rev, NULL);
    ++
     +	set_alternate_index_output(stash_index_path.buf);
     +	if (reset_tree(&info->i_tree, 0, 0)) {
     +		ret = -1;
    @@ -285,7 +284,6 @@
     +	}
     +	set_alternate_index_output(NULL);
     +
    -+	init_revisions(&rev, NULL);
     +	rev.prune_data = ps;
     +	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
     +	rev.diffopt.format_callback = add_diff_to_buf;
    @@ -471,7 +469,6 @@
     +	memset(&ps, 0, sizeof(ps));
     +	strbuf_addstr(&stash_msg_buf, stash_msg);
     +	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info);
    -+
     +	if (!ret)
     +		printf_ln("%s", oid_to_hex(&info.w_commit));
     +
17:  fa38428f76 ! 18:  3065f08c65 stash: convert push to builtin
    @@ -5,7 +5,7 @@
         Add stash push to the helper.
     
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
      --- a/builtin/stash--helper.c
    @@ -67,9 +67,9 @@
     -	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info);
     +	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info,
     +			      NULL);
    - 
      	if (!ret)
      		printf_ln("%s", oid_to_hex(&info.w_commit));
    + 
     @@
      	return ret < 0;
      }
    @@ -158,6 +158,7 @@
     +				goto done;
     +			}
     +		}
    ++		discard_cache();
     +		if (ps.nr) {
     +			struct child_process cp_add = CHILD_PROCESS_INIT;
     +			struct child_process cp_diff = CHILD_PROCESS_INIT;
18:  9a95010a11 ! 19:  31dd0edc0c stash: make push -q quiet
    @@ -8,7 +8,7 @@
         `--quiet` or `-q` is specified. Add tests for `--quiet`.
     
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
      --- a/builtin/stash--helper.c
    @@ -118,9 +118,9 @@
      	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info,
     -			      NULL);
     +			      NULL, 0);
    - 
      	if (!ret)
      		printf_ln("%s", oid_to_hex(&info.w_commit));
    + 
     @@
      
      	if (!reflog_exists(ref_stash) && do_clear_stash()) {
19:  cf5b27d699 ! 20:  f5644a4fdc stash: convert save to builtin
    @@ -8,7 +8,7 @@
         `no_changes()`).
     
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
      --- a/builtin/stash--helper.c
20:  168e6cff5e ! 21:  367511ab8f stash: optimize `get_untracked_files()` and `check_changes()`
    @@ -29,10 +29,8 @@
         This way `check_changes()` and `get_untracked files()` are called
         only one time.
     
    -    https://public-inbox.org/git/20180818223329.GJ11326@hank.intra.tgummerer.com/
    -
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
      --- a/builtin/stash--helper.c
    @@ -49,7 +47,6 @@
       * > 0 if there are changes.
       */
     -static int check_changes(struct pathspec ps, int include_untracked)
    -+
     +static int check_changes_tracked_files(struct pathspec ps)
      {
      	int result;
    @@ -70,7 +67,6 @@
     + * The function will fill `untracked_files` with the names of untracked files
     + * It will return 1 if there were any changes and 0 if there were not.
     + */
    -+
     +static int check_changes(struct pathspec ps, int include_untracked,
     +			 struct strbuf *untracked_files)
     +{
    @@ -115,15 +111,13 @@
      			     0);
      
      	memset(&ps, 0, sizeof(ps));
    --	strbuf_addstr(&stash_msg_buf, stash_msg);
    --	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info,
    --			      NULL, 0);
     +	if (!check_changes_tracked_files(ps))
     +		return 0;
    - 
    --	if (!ret)
    -+	strbuf_addstr(&stash_msg_buf, stash_msg);
    -+	if (!(ret = do_create_stash(ps, &stash_msg_buf, 0, 0, &info, NULL, 0)))
    ++
    + 	strbuf_addstr(&stash_msg_buf, stash_msg);
    + 	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info,
    + 			      NULL, 0);
    +@@
      		printf_ln("%s", oid_to_hex(&info.w_commit));
      
      	strbuf_release(&stash_msg_buf);
21:  559edead8f ! 22:  376bb4adc9 stash: replace all `write-tree` child processes with API calls
    @@ -2,10 +2,11 @@
     
         stash: replace all `write-tree` child processes with API calls
     
    -    This commit replaces spawning `git write-tree` with API calls.
    +    Avoid spawning write-tree child processes by replacing the calls with
    +    in-core API calls.
     
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
      --- a/builtin/stash--helper.c
    @@ -100,8 +101,8 @@
      	struct strbuf diff_output = STRBUF_INIT;
     +	struct index_state istate = { NULL };
      
    - 	set_alternate_index_output(stash_index_path.buf);
    - 	if (reset_tree(&info->i_tree, 0, 0)) {
    + 	init_revisions(&rev, NULL);
    + 
     @@
      		goto done;
      	}
22:  51809c70ca ! 23:  56a5ce2aeb stash: convert `stash--helper.c` into `stash.c`
    @@ -13,7 +13,7 @@
         called directly and not by a shell script.
     
         Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/.gitignore b/.gitignore
      --- a/.gitignore
    @@ -273,9 +273,11 @@
      		return 0;
      
     -	strbuf_addstr(&stash_msg_buf, stash_msg);
    - 	if (!(ret = do_create_stash(ps, &stash_msg_buf, 0, 0, &info, NULL, 0)))
    +-	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info,
    ++	ret = do_create_stash(ps, &stash_msg_buf, 0, 0, &info,
    + 			      NULL, 0);
    + 	if (!ret)
      		printf_ln("%s", oid_to_hex(&info.w_commit));
    - 
     @@
      		OPT_END()
      	};
23:  c907fe1cd6 ! 24:  830c1d6dbe stash: add back the original, scripted `git stash`
    @@ -9,7 +9,7 @@
         scripted `git stash` when `stash.useBuiltin=false`.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/git-stash.sh b/git-stash.sh
      new file mode 100755
24:  26799a208f ! 25:  00fb753d5e stash: optionally use the scripted version again
    @@ -17,7 +17,7 @@
         code 129 for `git stash -h`.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/.gitignore b/.gitignore
      --- a/.gitignore
25:  bec65d5b78 ! 26:  49b7f82db9 tests: add a special setup where stash.useBuiltin is off
    @@ -12,7 +12,7 @@
         2018-11-14).
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      diff --git a/builtin/stash.c b/builtin/stash.c
      --- a/builtin/stash.c
27:  8187099d9c <  -:  ---------- strbuf_vinsertf: provide the correct buffer size to vsnprintf


Joel Teichroeb (5):
  stash: improve option parsing test coverage
  stash: convert apply to builtin
  stash: convert drop and clear to builtin
  stash: convert branch to builtin
  stash: convert pop to builtin

Johannes Schindelin (4):
  ident: add the ability to provide a "fallback identity"
  stash: add back the original, scripted `git stash`
  stash: optionally use the scripted version again
  tests: add a special setup where stash.useBuiltin is off

Matthew Kraai (1):
  t3903: add test for --intent-to-add file

Paul-Sebastian Ungureanu (17):
  sha1-name.c: add `get_oidf()` which acts like `get_oid()`
  strbuf.c: add `strbuf_join_argv()`
  strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
  t3903: modernize style
  stash: rename test cases to be more descriptive
  stash: add tests for `git stash show` config
  stash: mention options in `show` synopsis
  stash: convert list to builtin
  stash: convert show to builtin
  stash: convert store to builtin
  stash: convert create to builtin
  stash: convert push to builtin
  stash: make push -q quiet
  stash: convert save to builtin
  stash: optimize `get_untracked_files()` and `check_changes()`
  stash: replace all `write-tree` child processes with API calls
  stash: convert `stash--helper.c` into `stash.c`

 .gitignore                          |    1 +
 Documentation/git-stash.txt         |    4 +-
 Makefile                            |    3 +-
 builtin.h                           |    1 +
 builtin/stash.c                     | 1633 +++++++++++++++++++++++++++
 cache.h                             |    6 +
 git-stash.sh => git-legacy-stash.sh |   34 +-
 git-sh-setup.sh                     |    1 +
 git.c                               |    6 +
 ident.c                             |   22 +
 sha1-name.c                         |   19 +
 strbuf.c                            |   51 +
 strbuf.h                            |   16 +
 t/README                            |    4 +
 t/t3903-stash.sh                    |  200 ++--
 t/t3907-stash-show-config.sh        |   83 ++
 16 files changed, 2012 insertions(+), 72 deletions(-)
 create mode 100644 builtin/stash.c
 rename git-stash.sh => git-legacy-stash.sh (97%)
 create mode 100755 t/t3907-stash-show-config.sh

-- 
2.21.0.rc2.291.g17236886c5
