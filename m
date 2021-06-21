Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8F5C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82D35610C7
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFUPMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhFUPMg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 11:12:36 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FAAC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:10:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j2so9539079wrs.12
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dKxEorDgYJAEpcXzJCDJ/f63iorc2xXrSa53i0JX84I=;
        b=S20nkzeXIkPcHspVYC4mTcz78X7tjCYGBcYSQAkrJm3EtsO2a4uUMR0DdB4bQYb+XY
         N+6PLoy6Vs+NCd58H0ZIJBbJ5C5JMQTp9OsHeQY7U6Ru84weDBFbyKDAzcYfp4ex2XBO
         NKNyK8fr2txIuXVj+oH5ZWscktPwQ7HTCeWlyeGW9zVjFuYBRz/zDCotAf/DoqfZpprG
         oSqRw7Frfn7JVW8szShweUUsnA13RWnOaJ6vI9dYXsKGKaNpmRrB5FxIT3EHanKYWZ1G
         5RjSyVXjXfQErZMN+rlCkYsQPQXOU8uHd1iQgfWzqI4ud2TDUTfjqfjdoEEDdcfiRbXK
         xVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dKxEorDgYJAEpcXzJCDJ/f63iorc2xXrSa53i0JX84I=;
        b=aU3vWiPBmEk6qPzhmbQS7uy96uCQUtCEANB5uiWhZdfnW5BRE23gMN03J3fdqD43s/
         l3w8NCryfXzFNyrJhKnGLHvZxNetbC6EAjKSqvdzmklSldYPz3nCEDaVOIibLkTJlcVj
         K7dto4wiOAPIlgJz7N5YBvuy2OKctffP7My0q1Sm0+/gBi1FfFVwhiykoB7RCPWi5UbS
         lvRJbYbAFVgYdDplmOxoGTkKbKSEPsgVg1ldstCmtZmBhBQJWujAJ9Hwx+lmyIbZp3+O
         IRdprWEXo4F3xgtY0n1W1i082OqXoUqqFdqPWeK8pTl4sKglj6xocEnNUtzB6IdpScz+
         2q1g==
X-Gm-Message-State: AOAM531EAE7q4GkxepBOQydK8siq1TRHlW0eMY1RBNZVCEDRWzqn5o9E
        4qMWOaj/A3WKJ6o8vY5+CjgbfXUIec6CMw==
X-Google-Smtp-Source: ABdhPJzLNouxJHLOQM5vnxMuXTFD4DwgS/MZY1qJcMk3CiteQp1POaxjpmBadPzNDg06uctEa4Q5eQ==
X-Received: by 2002:adf:de87:: with SMTP id w7mr29121803wrl.333.1624288219704;
        Mon, 21 Jun 2021 08:10:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t17sm16676383wmi.47.2021.06.21.08.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 08:10:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/4] pack-objects: use revision.c's --stdin parsing
Date:   Mon, 21 Jun 2021 17:10:12 +0200
Message-Id: <cover-0.4-00000000000-20210621T150651Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-0.4-0000000000-20210617T105537Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210617T105537Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This v3 fixes issues noted by Emily Shaffer & Jonathan Tan on v2,
thanks both!

The REV_INFO_STDIN_LINE_BREAK is gone, it was just a result of some
WIP hacking, but I was too close to the code to notice. The "!len"
check in pack-objects.c was also redundant by moving to the revision.c
API. I have a parallel just-submitted series[1] that tests for that,
this version passes tests when combined with those more exhaustive
tests.

There were various other nits & suggestions that I either addressed by
changing the relevant code / documentation as suggested, or (e.g. in
the case of the "--not" parsing) explained in commit message(s) why it
made sense to leave those special-cases in place.

1. https://lore.kernel.org/git/cover-0.2-00000000000-20210621T145819Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (4):
  upload-pack: run is_repository_shallow() before setup_revisions()
  revision.h: refactor "disable_stdin" and "read_from_stdin"
  pack-objects.c: do stdin parsing via revision.c's API
  pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS

 builtin/am.c           |  4 +--
 builtin/blame.c        |  2 +-
 builtin/diff-tree.c    |  2 +-
 builtin/pack-objects.c | 61 +++++++++++++++++++-----------------------
 builtin/rev-list.c     |  2 +-
 revision.c             | 38 +++++++++++++++++++++-----
 revision.h             | 59 ++++++++++++++++++++++++++++++++++++----
 sequencer.c            |  4 +--
 8 files changed, 119 insertions(+), 53 deletions(-)

Range-diff against v2:
1:  6a8b20a7cf3 = 1:  3840ac28e8d upload-pack: run is_repository_shallow() before setup_revisions()
2:  d88b2c04102 ! 2:  6f69644b808 revision.h: unify "disable_stdin" and "read_from_stdin"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    revision.h: unify "disable_stdin" and "read_from_stdin"
    +    revision.h: refactor "disable_stdin" and "read_from_stdin"
     
    -    In 8b3dce56508 (Teach --stdin option to "log" family, 2009-11-03) we
    -    added the "disable_stdin" flag, and then much later in
    -    a12cbe23ef7 (rev-list: make empty --stdin not an error, 2018-08-22) we
    -    gained a "read_from_stdin" flag.
    +    Change the two "disable_stdin" and "read_from_stdin" flags to an enum,
    +    in preparation for a subsequent commit adding more flags.
     
         The interaction between these is more subtle than they might appear at
         first sight, as noted in a12cbe23ef7. "read_stdin" is not the inverse
    @@ Commit message
         read it". Let's avoid this confusion by using "consume" and "consumed"
         instead, i.e. a word whose present and past tense isn't the same.
     
    +    See 8b3dce56508 (Teach --stdin option to "log" family, 2009-11-03)
    +    where we added the "disable_stdin" flag, and a12cbe23ef7 (rev-list:
    +    make empty --stdin not an error, 2018-08-22) for the addition of the
    +    "read_from_stdin" flag.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/am.c ##
    @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *pr
      	     (!(revs.tag_objects || revs.tree_objects || revs.blob_objects) &&
      	      !revs.pending.nr) &&
     -	     !revs.rev_input_given && !revs.read_from_stdin) ||
    -+	     !revs.rev_input_given && !revs.consumed_stdin_per_option) ||
    ++	     !revs.rev_input_given && !revs.consumed_stdin) ||
      	    revs.diff)
      		usage(rev_list_usage);
      
    @@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *re
      
      			if (!strcmp(arg, "--stdin")) {
     -				if (revs->disable_stdin) {
    -+				if (revs->stdin_handling == REV_INFO_STDIN_IGNORE) {
    ++				switch (revs->stdin_handling) {
    ++				case REV_INFO_STDIN_IGNORE:
      					argv[left++] = arg;
      					continue;
    ++				case REV_INFO_STDIN_CONSUME_ON_OPTION:
    ++					if (revs->consumed_stdin++)
    ++						die("--stdin given twice?");
    ++					read_revisions_from_stdin(revs, &prune_data);
    ++					continue;
      				}
     -				if (revs->read_from_stdin++)
    -+				if (revs->consumed_stdin_per_option++)
    - 					die("--stdin given twice?");
    - 				read_revisions_from_stdin(revs, &prune_data);
    - 				continue;
    +-					die("--stdin given twice?");
    +-				read_revisions_from_stdin(revs, &prune_data);
    +-				continue;
    + 			}
    + 
    + 			if (!strcmp(arg, "--end-of-options")) {
     
      ## revision.h ##
     @@ revision.h: struct rev_cmdline_info {
    @@ revision.h: struct rev_info {
     -	 * Whether we read from stdin due to the --stdin option.
     +	 * How should we handle seeing --stdin?
     +	 *
    -+	 * Defaults to reading if we see it with
    -+	 * REV_INFO_STDIN_CONSUME_ON_OPTION.
    ++	 * Defaults to REV_INFO_STDIN_CONSUME_ON_OPTION where we'll
    ++	 * attempt to read it if we see the --stdin option.
     +	 *
    -+	 * Can be set to REV_INFO_STDIN_IGNORE to ignore any provided
    -+	 * --stdin option.
    ++	 * Can be set to REV_INFO_STDIN_IGNORE to ignore the --stdin
    ++	 * option.
     +	 */
     +	enum rev_info_stdin stdin_handling;
     +
    @@ revision.h: struct rev_info {
     +	 * option?
      	 */
     -	int read_from_stdin;
    -+	int consumed_stdin_per_option;
    ++	int consumed_stdin;
      
      	/* topo-sort */
      	enum rev_sort_order sort_order;
3:  d433d7b24a3 ! 3:  943b1b4c12a pack-objects.c: do stdin parsing via revision.c's API
    @@ Metadata
      ## Commit message ##
         pack-objects.c: do stdin parsing via revision.c's API
     
    -    Change the fgets(..., stdin) parsing in pack-objects.c to use a
    -    now-extended version of the rev_info stdin parsing API.
    +    Extend the rev_info stdin parsing API to support hooking into its
    +    read_revisions_from_stdin() function, and change the custom stdin
    +    parsing in pack-objects.c to use it.
     
    -    The fgets() loop being refactored away here was first added in Linus's
    -    c323ac7d9c5 (git-pack-objects: create a packed object representation.,
    -    2005-06-25).
    +    The pack-objects.c code being refactored away here was first added in
    +    Linus's c323ac7d9c5 (git-pack-objects: create a packed object
    +    representation., 2005-06-25).
     
         Later on rev-list started doing similar parsing in 42cabc341c4 (Teach
    -    rev-list an option to read revs from the standard input., 2006-09-05),
    -    and that code was promoted to a more general API in 1fc561d169a (Move
    +    rev-list an option to read revs from the standard input., 2006-09-05).
    +    That code was promoted to a more general API in 1fc561d169a (Move
         read_revisions_from_stdin from builtin-rev-list.c to revision.c,
         2008-07-05).
     
    @@ builtin/pack-objects.c: static void mark_bitmap_preferred_tips(void)
     +{
     +	int *flags = stdin_line_priv;
     +	char *line = line_sb->buf;
    -+	size_t len = line_sb->len;
     +
    -+	if (!len)
    -+		return REV_INFO_STDIN_LINE_BREAK;
     +	if (*line == '-') {
     +		if (!strcmp(line, "--not")) {
     +			*flags ^= UNINTERESTING;
    @@ revision.c: static void read_revisions_from_stdin(struct rev_info *revs,
      			break;
     +
     +		if (revs->handle_stdin_line) {
    -+			int do_break = 0;
     +			enum rev_info_stdin_line ret = revs->handle_stdin_line(
     +				revs, &sb, revs->stdin_line_priv);
     +
     +			switch (ret) {
     +			case REV_INFO_STDIN_LINE_PROCESS:
     +				break;
    -+			case REV_INFO_STDIN_LINE_BREAK:
    -+				do_break = 1;
    -+				break;
     +			case REV_INFO_STDIN_LINE_CONTINUE:
     +				continue;
     +			}
    -+			if (do_break)
    -+				break;
     +		}
     +
      		if (sb.buf[0] == '-') {
      			if (len == 2 && sb.buf[1] == '-') {
      				seen_dashdash = 1;
     @@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
    + 
    + 			if (!strcmp(arg, "--stdin")) {
    + 				switch (revs->stdin_handling) {
    ++				case REV_INFO_STDIN_ALWAYS_READ:
    + 				case REV_INFO_STDIN_IGNORE:
    + 					argv[left++] = arg;
    + 					continue;
    +@@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
      		}
      	}
      
     +	/*
    -+	 * We've got always_read_from_stdin but no --stdin (or
    -+	 * "consumed_stdin_per_option" would be set).
    ++	 * We're asked to ALWAYS_READ from stdin, but no --stdin
    ++	 * option (or "consumed_stdin" would be set).
     +	 */
    -+	if (revs->stdin_handling == REV_INFO_STDIN_ALWAYS_READ &&
    -+	    !revs->consumed_stdin_per_option)
    ++	if (!revs->consumed_stdin &&
    ++	    revs->stdin_handling == REV_INFO_STDIN_ALWAYS_READ)
     +		read_revisions_from_stdin(revs, &prune_data);
     +
      	if (prune_data.nr) {
    @@ revision.h: struct topo_walk_info;
      
     +enum rev_info_stdin_line {
     +	REV_INFO_STDIN_LINE_PROCESS,
    -+	REV_INFO_STDIN_LINE_BREAK,
     +	REV_INFO_STDIN_LINE_CONTINUE,
     +};
     +
    @@ revision.h: struct topo_walk_info;
      	struct commit_list *commits;
     @@ revision.h: struct rev_info {
      	 *
    - 	 * Can be set to REV_INFO_STDIN_IGNORE to ignore any provided
    - 	 * --stdin option.
    + 	 * Can be set to REV_INFO_STDIN_IGNORE to ignore the --stdin
    + 	 * option.
     +	 *
     +	 * Set it to REV_INFO_STDIN_ALWAYS_READ if there's always data
     +	 * on stdin to be read, even if no --stdin option is provided.
    @@ revision.h: struct rev_info {
      
     @@ revision.h: struct rev_info {
      	 */
    - 	int consumed_stdin_per_option;
    + 	int consumed_stdin;
      
     +	/*
     +	 * When reading from stdin (see "stdin_handling" above) define
    @@ revision.h: struct rev_info {
     +	 *   revision.c's normal processing of the line (after
     +	 *   possibly munging the provided strbuf).
     +	 *
    -+	 * - Return REV_INFO_STDIN_LINE_BREAK to process no further
    -+	 *   lines, or anything further from the current line (just
    -+	 *   like REV_INFO_STDIN_LINE_CONTINUE).
    -+	 *
     +	 * - Return REV_INFO_STDIN_LINE_CONTINUE to indicate that the
     +	 *   line is fully processed, moving onto the next line (if
     +	 *   any)
4:  e59a06c3148 ! 4:  34750ab81cf pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
    @@ Commit message
         REV_INFO_STDIN_LINE_CONTINUE, as read_revisions_from_stdin() will now
         pass down the right flag for us.
     
    -    This also means that we can make the handle_revision_arg() function
    -    static. Now that the only external user of the API has been migrated
    -    over to the callback mechanism nothing external to revision.c needs to
    -    call handle_revision_arg() anymore.
    +    I considered making the "--not" parsing be another flag handled by the
    +    revision.c API itself, but since there's only one caller who wants
    +    this, and the "write_bitmap_index = 0" case is more specific than
    +    marking things UNINTERESTING I think it's better to handle it with a
    +    more general mechanism.
    +
    +    These changes means that we can make the handle_revision_arg()
    +    function static. Now that the only external user of the API has been
    +    migrated over to the callback mechanism nothing external to revision.c
    +    needs to call handle_revision_arg() anymore.
     
         That handle_revision_arg() function was made public in a combination
         of 5d6f0935e6d (revision.c: allow injecting revision parameters after
    @@ builtin/pack-objects.c: static void mark_bitmap_preferred_tips(void)
      {
     -	int *flags = stdin_line_priv;
      	char *line = line_sb->buf;
    - 	size_t len = line_sb->len;
      
    -@@ builtin/pack-objects.c: static enum rev_info_stdin_line get_object_list_handle_stdin_line(
    - 		return REV_INFO_STDIN_LINE_BREAK;
    - 	if (*line == '-') {
    - 		if (!strcmp(line, "--not")) {
    +-	if (*line == '-') {
    +-		if (!strcmp(line, "--not")) {
     -			*flags ^= UNINTERESTING;
    -+			revs->revarg_flags ^= UNINTERESTING;
    - 			write_bitmap_index = 0;
    - 			return REV_INFO_STDIN_LINE_CONTINUE;
    - 		}
    -@@ builtin/pack-objects.c: static enum rev_info_stdin_line get_object_list_handle_stdin_line(
    - 		}
    +-			write_bitmap_index = 0;
    +-			return REV_INFO_STDIN_LINE_CONTINUE;
    +-		}
    +-		if (starts_with(line, "--shallow ")) {
    +-			struct object_id oid;
    +-			if (get_oid_hex(line + 10, &oid))
    +-				die("not an object name '%s'", line + 10);
    +-			register_shallow(the_repository, &oid);
    +-			use_bitmap_index = 0;
    +-			return REV_INFO_STDIN_LINE_CONTINUE;
    +-		}
    ++	if (*line != '-')
    ++		return REV_INFO_STDIN_LINE_PROCESS;
    ++
    ++	if (!strcmp(line, "--not")) {
    ++		revs->revarg_flags ^= UNINTERESTING;
    ++		write_bitmap_index = 0;
    ++		return REV_INFO_STDIN_LINE_CONTINUE;
    ++	} else if (starts_with(line, "--shallow ")) {
    ++		struct object_id oid;
    ++		if (get_oid_hex(line + 10, &oid))
    ++			die("not an object name '%s'", line + 10);
    ++		register_shallow(the_repository, &oid);
    ++		use_bitmap_index = 0;
    ++		return REV_INFO_STDIN_LINE_CONTINUE;
    ++	} else {
      		die(_("not a rev '%s'"), line);
      	}
     -	if (handle_revision_arg(line, revs, *flags, REVARG_CANNOT_BE_FILENAME))
     -			die(_("bad revision '%s'"), line);
     -	return REV_INFO_STDIN_LINE_CONTINUE;
    -+	return REV_INFO_STDIN_LINE_PROCESS;
      }
      
      static void get_object_list(int ac, const char **av)
    @@ revision.h: struct rev_info {
     +	 *   Change "revarg_flags" to affect the subsequent handling
     +	 *   in handle_revision_arg()
     +	 *
    - 	 * - Return REV_INFO_STDIN_LINE_BREAK to process no further
    - 	 *   lines, or anything further from the current line (just
    - 	 *   like REV_INFO_STDIN_LINE_CONTINUE).
    - 	 *
      	 * - Return REV_INFO_STDIN_LINE_CONTINUE to indicate that the
    -+	 *
    -+	 * - Return REV_INFO_STDIN_LINE_BREAK to indicate that the
      	 *   line is fully processed, moving onto the next line (if
      	 *   any)
    - 	 *
     @@ revision.h: struct rev_info {
      	 * around.
      	 */
-- 
2.32.0.599.g3967b4fa4ac

