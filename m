Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EB2C433E6
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 13:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04E9664F2D
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 13:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhCMNmy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 08:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhCMNmX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 08:42:23 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7706C061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 05:42:23 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id l2so17676374pgb.1
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 05:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wNgfzIqn60rYTZpSjBm0VHfqLuiCTysGjPoQ2TMG/8Q=;
        b=veaSFZE6IgwTCPt9ZDAZHPtYcjitLecwuOO1kJf+szT8VBYMPf3M/ucaZIrq0rhBCa
         oEeJj77qw75zwamOmq/s+gWI7cC/H4Y8SG1D/gVO3V8bCFmRDhkxuBDo0Ny8Ypz04w2Q
         FlA8hln7YJ+HBv9mmCxbBoMLrtZ1YM2UuWGmEWDqRtgHiceQsYQh9lALBkihScwXEFz/
         BFagtwv/3za5UtkvbESqLNdLqFSY+Bwdylz5SrWrD5/jYt8+gkl2UNOc7l08L9aapQ93
         TmRwFQr+62Yb1JlzlDdGOmIVaBdXfwdG/0oVqmlAdb8sPkx78tXjnjjn4EeT+S9RJscN
         jmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wNgfzIqn60rYTZpSjBm0VHfqLuiCTysGjPoQ2TMG/8Q=;
        b=htfAa5rspuKv/BuD66PGkQHAzLS7fj4xCsPvla5bVD0ebPrYkIia/dIwE60U4qWE0g
         Udn1oww6qf97yNO0Fn68uqbyYcacHDaniOnmUHS3VQgLciO4EubqGguAMRMKL95kQdYc
         fQjApVIan8U8abEeTZAe/CS+RPpsrnZoEO7KaSpdncxoGMJysRWwUvbZvsgzpqX1AWR7
         Vp9WOHVC4GG489KpPTOR7Ql1NOO/7hTI446w242vjsgCrlRtehhg6qnwNWiBlDd/zWs5
         OoeQ87yGbCy/vVwSDJL9WogFhpIEubL/eQGX2Ugb2frs02Yk20WnUDcH7Pq2Pd/LUauy
         00Bw==
X-Gm-Message-State: AOAM533TZfalKMv5IIDkgB8WgyGoGhUGtNKzu7xkomoWcL+wCTZHqy3E
        rS1dC8bAOPAUleQa3rZUlo1WI7Mlr3n65g==
X-Google-Smtp-Source: ABdhPJxzYaLanLywEHXiqKhH8na4LnmCq+TzxpjB8KoNgtA/609qEM43rjr0QNnNqcUJpcsA5DNR3w==
X-Received: by 2002:a63:ff21:: with SMTP id k33mr15581760pgi.379.1615642942766;
        Sat, 13 Mar 2021 05:42:22 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d98:f55e:3466:3377:eaba:8d02])
        by smtp.googlemail.com with ESMTPSA id y20sm8657809pfo.210.2021.03.13.05.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 05:42:22 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, sunshine@sunshineco.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v5 0/6][Outreachy] commit: Implementation of "amend!" commit
Date:   Sat, 13 Mar 2021 19:10:07 +0530
Message-Id: <20210313134012.20658-1-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210310194306.32565-1-charvi077@gmail.com>
References: <20210310194306.32565-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series teaches `git commit --fixup` to create "amend!" commit
as an alternative that works with `git rebase --autosquash`. It allows to
fixup both the content and the commit message of the specified commit.
Here we add two suboptions to the `--fixup`, first `amend` suboption that
creates an "amend!" commit. It takes the staged changes and also allows to
edit the commit message of the commit we are fixing.
Example usuage:
git commit --fixup=amend:<commit>

Secondly, `reword` suboption that creates an empty "amend!" commit i.e it
ignores the staged changes and only allows to reword/edit the commit message
of the commit we are fixing. `--fixup=reword:<commit>` is a short-hand of
`--fixup=amend:<commit> --only`.
Example usuage:
git commit --fixup=reword:<commit>

** This work is rebased on the top of cm/rebase-i-updates.

Charvi Mendiratta (6):
  sequencer: export and rename subject_length()
  commit: add amend suboption to --fixup to create amend! commit
  commit: add a reword suboption to --fixup
  t7500: add tests for --fixup=[amend|reword] options
  t3437: use --fixup with options to create amend! commit
  doc/git-commit: add documentation for fixup=[amend|reword] options

 Documentation/git-commit.txt              |  45 +++++-
 Documentation/git-rebase.txt              |  21 +--
 builtin/commit.c                          | 126 +++++++++++++++--
 commit.c                                  |  14 ++
 commit.h                                  |   3 +
 sequencer.c                               |  16 +--
 t/t3437-rebase-fixup-options.sh           |  30 +---
 t/t7500-commit-template-squash-signoff.sh | 159 ++++++++++++++++++++++
 8 files changed, 346 insertions(+), 68 deletions(-)

Range-diff against v4:
-:  ---------- > 1:  a2e89540ec sequencer: export and rename subject_length()
1:  492ab8ec08 ! 2:  be2808a255 commit: add amend suboption to --fixup to create amend! commit
    @@ builtin/commit.c: static void adjust_comment_line_char(const struct strbuf *sb)
      	comment_line_char = *p;
      }

    -+static int prepare_amend_commit(struct commit *commit, struct strbuf *sb,
    -+				struct pretty_print_context *ctx) {
    -+
    ++static void prepare_amend_commit(struct commit *commit, struct strbuf *sb,
    ++				struct pretty_print_context *ctx)
    ++{
     +	const char *buffer, *subject, *fmt;
     +
     +	buffer = get_commit_buffer(commit, NULL);
    @@ builtin/commit.c: static void adjust_comment_line_char(const struct strbuf *sb)
     +	fmt = starts_with(subject, "amend!") ? "%b" : "%B";
     +	format_commit_message(commit, fmt, sb, ctx);
     +	unuse_commit_buffer(commit, buffer);
    -+	return 0;
     +}
     +
      static int prepare_to_commit(const char *index_file, const char *prefix,
    @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
      		struct pretty_print_context ctx = {0};
      		struct commit *commit;
     -		commit = lookup_commit_reference_by_name(fixup_message);
    -+		char *fmt = xstrfmt("%s! %%s\n\n", fixup_prefix);
    ++		char *fmt;
     +		commit = lookup_commit_reference_by_name(fixup_commit);
      		if (!commit)
     -			die(_("could not lookup commit %s"), fixup_message);
    @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
     -				      &sb, &ctx);
     -		if (have_option_m)
     -			strbuf_addbuf(&sb, &message);
    ++		fmt = xstrfmt("%s! %%s\n\n", fixup_prefix);
     +		format_commit_message(commit, fmt, &sb, &ctx);
     +		free(fmt);
      		hook_arg1 = "message";
    @@ builtin/commit.c: static void finalize_deferred_config(struct wt_status *s)
      }

     +/* returns the length of intial segment of alpha characters only */
    -+static size_t get_alpha_len(char *fixup_message) {
    ++static size_t skip_suboption(char *fixup_message) {
     +	const char alphas[] = "abcdefghijklmnopqrstuvwxyz";
     +	return strspn(fixup_message, alphas);
     +}
    @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *ar
     +
     +	if (fixup_message) {
     +		/*
    -+		 * To check if fixup_message that contains ':' is a commit
    -+		 * reference for example: --fixup="HEAD^{/^area: string}" or
    -+		 * a suboption of `--fixup`.
    ++		 * We limit --fixup's suboptions to only alpha characters.
    ++		 * If the first character after a run of alpha is colon,
    ++		 * then the part before the colon may be a known suboption
    ++		 * name `amend` or a misspelt suboption name. In this case,
    ++		 * we treat it as --fixup=<suboption>:<arg>.
     +		 *
    -+		 * As `amend` suboption contains only alpha character.
    -+		 * So check if first non alpha character in fixup_message
    -+		 * is ':'.
    ++		 * Otherwise, we are dealing with --fixup=<commit>.
     +		 */
    -+		size_t len = get_alpha_len(fixup_message);
    ++		size_t len = skip_suboption(fixup_message);
     +		if (len && fixup_message[len] == ':') {
     +			fixup_message[len++] = '\0';
     +			fixup_commit = fixup_message + len;
2:  a20b85c3a1 ! 3:  f6217338c1 commit: add a reword suboption to --fixup
    @@ builtin/commit.c: static void finalize_deferred_config(struct wt_status *s)
     +}
     +
      /* returns the length of intial segment of alpha characters only */
    - static size_t get_alpha_len(char *fixup_message) {
    + static size_t skip_suboption(char *fixup_message) {
      	const char alphas[] = "abcdefghijklmnopqrstuvwxyz";
     @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
    - 		 * reference for example: --fixup="HEAD^{/^area: string}" or
    - 		 * a suboption of `--fixup`.
    + 		 * We limit --fixup's suboptions to only alpha characters.
    + 		 * If the first character after a run of alpha is colon,
    + 		 * then the part before the colon may be a known suboption
    +-		 * name `amend` or a misspelt suboption name. In this case,
    +-		 * we treat it as --fixup=<suboption>:<arg>.
    ++		 * name like `amend` or `reword`, or a misspelt suboption
    ++		 * name. In either case, we treat it as
    ++		 * --fixup=<suboption>:<arg>.
      		 *
    --		 * As `amend` suboption contains only alpha character.
    --		 * So check if first non alpha character in fixup_message
    --		 * is ':'.
    -+		 * As `amend`/`reword` suboptions contains only alpha
    -+		 * characters. So check if first non alpha character
    -+		 * in fixup_message is ':'.
    + 		 * Otherwise, we are dealing with --fixup=<commit>.
      		 */
    - 		size_t len = get_alpha_len(fixup_message);
    +@@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
      		if (len && fixup_message[len] == ':') {
      			fixup_message[len++] = '\0';
      			fixup_commit = fixup_message + len;
3:  41297d7e8e = 4:  1a127dc0b3 t7500: add tests for --fixup=[amend|reword] options
4:  7ae75dc27d = 5:  be6f4fa0d1 t3437: use --fixup with options to create amend! commit
5:  533fed36ca ! 6:  79c098df2c doc/git-commit: add documentation for fixup=[amend|reword] options
    @@ Commit message
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
         Helped-by: Junio C Hamano <gitster@pobox.com>
    -    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
    +    Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>

      ## Documentation/git-commit.txt ##
    @@ Documentation/git-commit.txt: OPTIONS
     -	commit with a prefix of "fixup! ".  See linkgit:git-rebase[1]
     -	for details.
     +--fixup=[(amend|reword):]<commit>::
    -+	Construct a new commit for use with `rebase --autosquash`,
    -+	which fixes the specified commit. The plain form
    -+	`--fixup=<commit>` creates a "fixup!" commit, that allows
    -+	to fixup only the content of the specified commit and leave
    -+	it's commit log message untouched. When used with `amend:`
    -+	or `reword:`, it creates "amend!" commit that is like "fixup!"
    -+	commit but it allows to fixup both the content and the commit
    -+	log message of the specified commit. The commit log message of
    -+	the specified commit is fixed implicitly by replacing it with
    -+	the "amend!" commit's message body upon `rebase --autosquash`.
    ++	Create a new commit which "fixes up" `<commit>` when applied with
    ++	`git rebase --autosquash`. Plain `--fixup=<commit>` creates a
    ++	"fixup!" commit which changes the content of `<commit>` but leaves
    ++	its log message untouched. `--fixup=amend:<commit>` is similar but
    ++	creates an "amend!" commit which also replaces the log message of
    ++	`<commit>` with the log message of the "amend!" commit.
    ++	`--fixup=reword:<commit>` creates an "amend!" commit which
    ++	replaces the log message of `<commit>` with its own log message
    ++	but makes no changes to the content of `<commit>`.
     ++
    -+The resulting "fixup!" commit message will be the subject line
    -+from the specified commit with a prefix of "fixup!". Can be used
    -+with additional commit message option `-m`.
    ++The commit created by plain `--fixup=<commit>` has a subject
    ++composed of "fixup!" followed by the subject line from <commit>,
    ++and is recognized specially by `git rebase --autosquash`. The `-m`
    ++option may be used to supplement the log message of the created
    ++commit, but the additional commentary will be thrown away once the
    ++"fixup!" commit is squashed into `<commit>` by
    ++`git rebase --autosquash`.
     ++
    -+The `--fixup=amend:<commit>` form creates an "amend!" commit where
    -+its commit message subject will be the subject line from the
    -+specified commit with a prefix of "amend!" and the message body
    -+will be commit log message of the specified commit. It also invokes
    -+an editor seeded with the log message of the "amend!" commit to
    -+allow to edit further. It refuses to create "amend!" commit if it's
    -+commit message body is empty unless used with the
    -+`--allow-empty-message` option.
    ++The commit created by `--fixup=amend:<commit>` is similar but its
    ++subject is instead prefixed with "amend!". The log message of
    ++<commit> is copied into the log message of the "amend!" commit and
    ++opened in an editor so it can be refined. When `git rebase
    ++--autosquash` squashes the "amend!" commit into `<commit>`, the
    ++log message of `<commit>` is replaced by the refined log message
    ++from the "amend!" commit. It is an error for the "amend!" commit's
    ++log message to be empty unless `--allow-empty-message` is
    ++specified.
     ++
    -+The `--fixup=reword:<commit>` aliases `--fixup=amend:<commit> --only`
    -+and it also creates an "amend!" commit, but here it records the same
    -+tree as `HEAD`, i.e. it does not take any staged changes and only allows
    -+to fixup the commit message of the specified commit. It will reword the
    -+specified commit when it is rebased with `--autosquash`.
    ++`--fixup=reword:<commit>` is shorthand for `--fixup=amend:<commit>
    ++--only`. It creates an "amend!" commit with only a log message
    ++(ignoring any changes staged in the index). When squashed by `git
    ++rebase --autosquash`, it replaces the log message of `<commit>`
    ++without making any other changes.
     ++
    -+Also, after fixing the commit using `--fixup`, with or without option
    -+and rebased with `--autosquash`, the authorship of the original commit
    -+remains unchanged. See linkgit:git-rebase[1] for details.
    ++Neither "fixup!" nor "amend!" commits change authorship of
    ++`<commit>` when applied by `git rebase --autosquash`.
    ++See linkgit:git-rebase[1] for details.

      --squash=<commit>::
      	Construct a commit message for use with `rebase --autosquash`.
--
2.29.0.rc1

