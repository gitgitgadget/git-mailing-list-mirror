Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4843FC7618A
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 06:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjCTGAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 02:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCTGAG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 02:00:06 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9011CAFE
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 23:00:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id h8so11310042plf.10
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 23:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679292004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/j/YVHwyH21t0gRxZZ8CS2ht3pzVM1AkLbruEOdDhc=;
        b=ltxw39lkZ1wD2LBASIvewAuEsuhBi3yWhMFHqpqLyKeTTGpHTkVY8ly2Qo612eioCJ
         Ard6ijwgGwCM/BzZltToIZRNrTPeFUdPR9z6puHrs63SSkXzgqCRlsnilsEwQ/eIJz2K
         PHGzAiTrx/e7wTffytb6uZKaCQO3LMtD58/3D+mGLPEZxFqsfIziHVGhKa121datVkSR
         90DSRd+coH8eaUza7GBvMYcpKz9TXe+0uken7wRtZ04iO7pjyx5ISXEQF8NINDZp6JhJ
         03g4bpRHwrkl/WkYI4NE9YJkn8kfpW8YHv6hcPrDcpq0gpW1CYkd5X7kuhV53Tr+eZLF
         gNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679292004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/j/YVHwyH21t0gRxZZ8CS2ht3pzVM1AkLbruEOdDhc=;
        b=Ir3+ZrK+0BIvvgVdZmJhNmon+BotL8tjF82c3UBbzdsBNDMGshVmBlzp2mDe8/7fow
         NLWQDkAoHSwGlyP/62WtwJy13Tn2NbX8fHK9gsboFrtx4CEv+wjEQYoxq+zzCkZZHwey
         2/jYqykr4K9t6w0aIoSlfMkvzPrwUvQ5UOY4AQsE4V/Bl0RD5Ow1nUzSRkng+NMDXS+4
         NF2GCgLSFIPMH0iYAn2ZQhq6O/4Cbm033jwvomoW20G0BwQf38OyFY+nILF9V7spPuqF
         JurfRVe9cxuqJkCIoHu1dHkrVteszT2DAiGM4x0TR9NHFMOP72pXpRsvIUxO956ghTRu
         KLfQ==
X-Gm-Message-State: AO0yUKXeoUrHd1bHOOIzbBjJLI3a+U52+tpakhnJr9CBPlO0mzbUXqnH
        KC7k31rVxPlt0fmv9g+GF+a0O/67k/Ax9w==
X-Google-Smtp-Source: AK7set+BOWsVE9Fy7rkAY/XypV96A63hAziez/wUJl+o2HnHKf9yGlIXhQUfM+U/q60MjndXpQnoaw==
X-Received: by 2002:a17:90b:4d07:b0:23b:355f:b26c with SMTP id mw7-20020a17090b4d0700b0023b355fb26cmr17852431pjb.23.1679292003786;
        Sun, 19 Mar 2023 23:00:03 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id cc13-20020a17090af10d00b002353082958csm7814075pjb.10.2023.03.19.23.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 23:00:03 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        chooglen@google.com, calvinwan@google.com,
        jonathantanmy@google.com, felipe.contreras@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v8 0/3] rebase: document, clean up, and introduce a config option for --rebase-merges
Date:   Sun, 19 Mar 2023 23:59:52 -0600
Message-Id: <20230320055955.461138-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230312210456.92364-1-alexhenrie24@gmail.com>
References: <20230312210456.92364-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series introduces a rebase.rebaseMerges config option to
accommodate users who would like --rebase-merges to be on by default and
to facilitate turning on --rebase-merges by default without
configuration in a future version of Git. It also cleans up and
documents the behavior of the --rebase-merges command line option to
avoid confusion about how the config option and the command line option
interact.

Changes from v7:
- Make --rebase-merges without an argument clobber the mode specified in
  rebase.rebaseMerges
- Replace the test for --rebase-merges not overriding
  rebase.rebaseMerges=rebase-cousins and the test for --rebase-merges
  overriding rebase.rebaseMerges=false with a single test that
  --rebase-merges does override rebase.rebaseMerges=rebase-cousins

Thanks to Phillip, Felipe, Junio, and Glen for your feedback on v7.

Alex Henrie (3):
  rebase: add documentation and test for --no-rebase-merges
  rebase: deprecate --rebase-merges=""
  rebase: add a config option for --rebase-merges

 Documentation/config/rebase.txt        | 10 ++++
 Documentation/git-rebase.txt           | 19 ++++---
 builtin/rebase.c                       | 77 +++++++++++++++++++-------
 t/t3422-rebase-incompatible-options.sh | 17 ++++++
 t/t3430-rebase-merges.sh               | 44 +++++++++++++++
 5 files changed, 141 insertions(+), 26 deletions(-)

Range-diff against v7:
1:  3aee0c2277 = 1:  09fb7c1b74 rebase: add documentation and test for --no-rebase-merges
2:  e57843d8b5 = 2:  a846716a4a rebase: deprecate --rebase-merges=""
3:  b0c1a4dcb2 ! 3:  b12a3610ba rebase: add a config option for --rebase-merges
    @@ Commit message
         to be clear when scrolling through values in the [rebase] section of
         .gitconfig.
     
    -    In the future, the default rebase-merges mode may change from
    -    no-rebase-cousins to some other mode that doesn't exist yet. Support
    -    setting rebase.rebaseMerges to the nonspecific value "true" for users
    -    who do not need or want to care about the default changing in the
    -    future. Similarly, for users who have --rebase-merges in an alias and
    -    want to get the future behavior now, use the specific rebase-merges mode
    -    from the config if a specific mode is not given on the command line.
    +    Support setting rebase.rebaseMerges to the nonspecific value "true" for
    +    users who don't need to or don't want to learn about the difference
    +    between rebase-cousins and no-rebase-cousins.
    +
    +    Make --rebase-merges without an argument on the command line override
    +    any value of rebase.rebaseMerges in the configuration, for consistency
    +    with other command line flags with optional arguments that have an
    +    associated config option.
     
         Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
     
    @@ Documentation/config/rebase.txt: rebase.rescheduleFailedExec::
     +	`--rebase-merges=no-rebase-cousins`, setting to `rebase-cousins` is
     +	equivalent to `--rebase-merges=rebase-cousins`, and setting to false is
     +	equivalent to `--no-rebase-merges`. Passing `--rebase-merges` on the
    -+	command line without an argument overrides a `rebase.rebaseMerges=false`
    -+	configuration, but the absence of a specific rebase-merges mode on the
    -+	command line does not counteract a specific mode set in the configuration.
    ++	command line, with or without an argument, overrides any
    ++	`rebase.rebaseMerges` configuration.
     
      ## Documentation/git-rebase.txt ##
     @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
    @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
     +	`--rebase-merges`.
      +
      When rebasing merges, there are two modes: `rebase-cousins` and
    --`no-rebase-cousins`. If the mode is not specified, it defaults to
    --`no-rebase-cousins`. In `no-rebase-cousins` mode, commits which do not have
    --`<upstream>` as direct ancestor will keep their original branch point, i.e.
    --commits that would be excluded by linkgit:git-log[1]'s `--ancestry-path`
    --option will keep their original ancestry by default. In `rebase-cousins` mode,
    --such commits are instead rebased onto `<upstream>` (or `<onto>`, if
    --specified).
    -+`no-rebase-cousins`. If the mode is not specified on the command line or in
    -+the `rebase.rebaseMerges` config option (see linkgit:git-config[1] or
    -+"CONFIGURATION" below), it defaults to `no-rebase-cousins`. In
    -+`no-rebase-cousins` mode, commits which do not have `<upstream>` as direct
    -+ancestor will keep their original branch point, i.e. commits that would be
    -+excluded by linkgit:git-log[1]'s `--ancestry-path` option will keep their
    -+original ancestry by default. In `rebase-cousins` mode, such commits are
    -+instead rebased onto `<upstream>` (or `<onto>`, if specified).
    - +
    - It is currently only possible to recreate the merge commits using the
    - `ort` merge strategy; different merge strategies can be used only via
    + `no-rebase-cousins`. If the mode is not specified, it defaults to
     
      ## builtin/rebase.c ##
     @@ builtin/rebase.c: struct rebase_options {
    @@ builtin/rebase.c: static int parse_opt_empty(const struct option *opt, const cha
     +	struct rebase_options *options = opt->value;
     +
     +	options->rebase_merges = !unset;
    ++	options->rebase_cousins = 0;
     +
     +	if (arg) {
     +		if (!*arg) {
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
     -					  "cannot be used together"));
     -			else if (options.autosquash == -1 && options.config_autosquash == 1)
     +			if (options.autosquash == -1 && options.config_autosquash == 1)
    - 				die(_("apply options are incompatible with rebase.autosquash.  Consider adding --no-autosquash"));
    + 				die(_("apply options are incompatible with rebase.autoSquash.  Consider adding --no-autosquash"));
     +			else if (options.rebase_merges == -1 && options.config_rebase_merges == 1)
     +				die(_("apply options are incompatible with rebase.rebaseMerges.  Consider adding --no-rebase-merges"));
      			else if (options.update_refs == -1 && options.config_update_refs == 1)
    @@ t/t3430-rebase-merges.sh: test_expect_success 'do not rebase cousins unless aske
     +	EOF
     +'
     +
    -+test_expect_success '--rebase-merges overrides rebase.rebaseMerges=false' '
    -+	test_config rebase.rebaseMerges false &&
    -+	git checkout -b override-config-merges-false E &&
    ++test_expect_success '--rebase-merges overrides rebase.rebaseMerges=rebase-cousins' '
    ++	test_config rebase.rebaseMerges rebase-cousins &&
    ++	git checkout -b override-config-rebase-cousins E &&
     +	before="$(git rev-parse --verify HEAD)" &&
     +	test_tick &&
     +	git rebase --rebase-merges C &&
     +	test_cmp_rev HEAD $before
     +'
    -+
    -+test_expect_success '--rebase-merges does not override rebase.rebaseMerges=rebase-cousins' '
    -+	test_config rebase.rebaseMerges rebase-cousins &&
    -+	git checkout -b no-override-config-rebase-cousins main &&
    -+	git rebase --rebase-merges HEAD^ &&
    -+	test_cmp_graph HEAD^.. <<-\EOF
    -+	*   Merge the topic branch '\''onebranch'\''
    -+	|\
    -+	| * D
    -+	| * G
    -+	|/
    -+	o H
    -+	EOF
    -+'
     +
      test_expect_success 'refs/rewritten/* is worktree-local' '
      	git worktree add wt &&
-- 
2.40.0

