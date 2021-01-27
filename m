Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB6AC433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 08:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BAD520724
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 08:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbhA0IGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 03:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbhA0IE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 03:04:28 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8F8C0613ED
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 00:03:29 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a1so894076wrq.6
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 00:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hHMf05Uxs9sQ8rKk5WJvaDM+V2OJFG7jF72wGaxaFSw=;
        b=k5OjL2NFzN3uIXZx8GOz3hLlGutJMPzdy3wFTNtQrvoWZDUI3k6IkGO8FkYlG+kEAk
         wGaF9svrgXL/p1WK45fcydbk8r95UuqRRMFpQ3oa12kFMeElI5o6wLBnJ4Alfdpdwxoc
         5DzHQHtK0rLtLkXvYex2dmjs7S/5DGKOxhBWVU+lOnXZG+1CTFsjXVZAxgnoATHjqzcX
         Imlq18RnDDH9PwPJg6e36k1gEydtN3cxebsuYkBzjkZH57PKHz/UXtXGUxo2hk6XwkBI
         1mrtrpLjVKQzBhwaj+Z8YtizDQX02XCuR4RTH0k0LaC5zTx2s3Sgvr8KBitfMNJGYznz
         pz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hHMf05Uxs9sQ8rKk5WJvaDM+V2OJFG7jF72wGaxaFSw=;
        b=pFR72rfv/3SOJywgg3ec+Ft5Lh1UDeFsssiBnxav73udw/rbOJ/+aB3Jy+8knT1R7F
         TOKfUpNIWSkayic3JwZwq81oGOJO4Npq39NWyps/r9rUHERnURw4zdIvMFSSr3o6s7vd
         +qK8kpSufIjl0vq5nEe49MPd323ejd+kZwPWDWrctKCP9uaFZjAujoQaMOp+WjzBymKR
         i/l3pao0PXCQQ54Aw8/kKXcZ5WpGBfvLeixO7XkybhRl1GAWW8mZJSck2kdRAR9onWpd
         mQ/Q11fwNWVAYl41cpj7pclbSgwu7nTu+u4oNsv+Ne1L9VaiSUutV7/QybLr6f+vO8th
         mcBg==
X-Gm-Message-State: AOAM531+IxHTlO1E58wYrvxoIxwcEVyOxhO0FgHK2jCenwfy8+sCCvuX
        0VacyPzL2IJis+e1hMqrRiW+w5GIiYtEqp4L
X-Google-Smtp-Source: ABdhPJwyZgwWqtM12AmkfqLso2THL/0a/gVpJsN9Q/mAEsQdDmV3k8iN32NW//CZlhdMhjjtoPPq7A==
X-Received: by 2002:adf:a3c1:: with SMTP id m1mr9826644wrb.357.1611734607976;
        Wed, 27 Jan 2021 00:03:27 -0800 (PST)
Received: from localhost.localdomain ([79.140.115.116])
        by smtp.gmail.com with ESMTPSA id m8sm1850237wrv.37.2021.01.27.00.03.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 00:03:26 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v3 0/7] teach `worktree list` verbose mode and prunable annotations
Date:   Wed, 27 Jan 2021 09:03:03 +0100
Message-Id: <20210127080310.89639-1-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.395.g7821b4e95a
In-Reply-To: <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
References: <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In c57b3367be (worktree: teach `list` to annotate locked worktree,
2020-10-11) we taught `git worktree list` to annotate working trees that
is locked by appending "locked" text in order to signalize to the user
that a working tree is locked.  During the review, there was some
discussion about additional annotations and information that `list`
command could provide to the user that has long been envisioned and
mentioned in [2], [3] and [4].

This patch series addresses some of these changes by teaching
`worktree list` to show "prunable" annotation, adding verbose mode and
extending the --porcelain format with prunable and locked annotation as
follow up from [1]. Additionally, it addresses one shortcoming for porcelain
format to escape any newline characters (LF or CRLF) and quote the lock
reason to prevent breaking the format that is mentioned in [4] and [1] during
the review cycle.

This patch series includes:

1. The first patch moves the should_prune_worktree() machinery to the top-level
   worktree.c exposing the function as general API, that will be reference
   by should_prune_worktree() wrapper implemented on the second patch.

   The original idea was to not only move should_prune_worktree() but also
   refactor to accept a "struct worktree" and load the information directly,
   which allows simplify the `prune` command by reusing get_worktrees().
   However this seems to also require refactoring get_worktrees() itself
   to return "non-valid" working trees that can/should be pruned. This is
   also mentioned in [5]. Having the wrapper function makes it easier to add
   the prunable annotation without touching the get_worktrees() and the
   other worktree sub commands. The refactoring can be addressed in a
   future patch, if this turns out to be good idea. One possible approach
   is to teach get_worktrees() to take additional flags that will tell
   whether to return only valid or all worktrees in GIT_DIR/worktrees/
   directory and address its own possible shortcoming.

2. Introduces the worktree_prune_reason() to discovery whether a worktree
   is prunable along with two new fields in the `worktree` structure. The
   function mimics the workree_lock_reason() API.

3. The third patch changes worktree_lock_reason() to be more gentle for
   the main working tree to simply returning NULL instead of aborting the
   program via assert() macro. This allow us to simplify the code that
   checks if the working tree is locked for default and porcelain format.
   This changes is also mentioned in [6].

4. Fix t2402 added in [1] to ensure the locked worktree is properly cleaned up.

5. The fourth patch adds the "locked" attribute for the porcelain format
   in order to make both default and --porcelain format consistent.

6. The fifth patch introduces "prunable" annotation for both default
   and --porcelain format.

7. The sixth patch introduces verbose mode to expand the `list` default
   format and show each annotation reason when its available.

Series is built on top of 66e871b664 (The third batch, 2021-01-15).

[1] https://lore.kernel.org/git/20200928154953.30396-1-rafaeloliveira.cs@gmail.com/
[2] https://lore.kernel.org/git/CAPig+cQF6V8HNdMX5AZbmz3_w2WhSfA4SFfNhQqxXBqPXTZL+w@mail.gmail.com/
[3] https://lore.kernel.org/git/CAPig+cSGXqJuaZPhUhOVX5X=LMrjVfv8ye_6ncMUbyKox1i7QA@mail.gmail.com/
[4] https://lore.kernel.org/git/CAPig+cTitWCs5vB=0iXuUyEY22c0gvjXvY1ZtTT90s74ydhE=A@mail.gmail.com/
[5] https://lore.kernel.org/git/CACsJy8ChM99n6skQCv-GmFiod19mnwwH4j-6R+cfZSiVFAxjgA@mail.gmail.com/
[6] https://lore.kernel.org/git/xmqq8sctlgzx.fsf@gitster.c.googlers.com/

Changes in v4
=============

Thanks Eric Sunshine and Phillip Wood for the review and suggestions.

 * Added documentation to explain that the lock reason is quoted with
   the same rules as described for `core.quotePath`.

 * The `worktree unlock` issued in the test cleanup is splitted and
   executed after each `worktree lock` to ensure the unlock is only
   done after we know each locked command was successful.  

 * Fix a couple of grammos in the [4/7] commit message.

Changes in v3
=============

v3 is 1-patch bigger than v2 and it includes the changes:

 * Dropped CQUOTE_NODQ flag in the the locked reason to return a string
   enclosed with double quotes if the text reason contains especial
   characters, like newlines.

 * fix in t2402 to ensure the locked worktree is properly cleaned up,
   is move to its own patch.

 * In worktree_prune_reason(), the `path` variable is initialize
   with NULL to make the code easier to follow.

 * The removal of `is_main_worktree()` before `worktree_lock_reason()`
   is moved to the patch that actually changes the API to be more gentle
   with the main worktree instead of refactoring the code in the next
   patches that adds the annotations.

 * Drop the `*reason` in `(reason && *reason)` as we know that
   worktree_prune_reason() is either going to return a non-empty string
   or NULL which makes the code easier to follow.

 * The --verbose test for the locked annotation now tests that "locked"
   annotation stays on the same line when there is no locked reason.

 * Small documentation updates and make the "git worktree --verbose"
   example a little consistent with the worktree path.

Changes in v2
=============

v2 changes considerably from v1 taking into account several comments
suggested by Eric Sunshine and Phillip Wood (thanks guys for the
insightful comments and patience reviewing my patches :) ).

 * The biggest change are the way the series is organized. In v1 all the
   code was implemented in the fourth patch, all the tests and documentation
   updates was added in sixth and seventh patch respectfully, in v2 each
   patch introduces the annotations and verbose mode together with theirs
   respective test and documentation updates.

 * Several rewrite of the commit messages

 * In v1 the fifth patch was introducing a new function to escape newline
   characters for the "locked" attribute. However, we already have this
   feature from the quote.h API. So the new function is dropped and the
   changes are squashed into v2's fourth patch.

 * The new prunable annotation and locked annotation that was introduced
   by [1] was refactor to not poke around the worktree private fields.

 * Refactoring of the worktree_prune_reason() to cache the prune_reason
   and refactor to early return the use cases following the more common
   pattern used on Git's codebase.

 * Few documentation rewrites, most notably the `--verbose` and `--expire`
   doc sentences for the list command are moved to its own line to clearly
   separate the description from the others commands instead of continuing 
   on the same paragraph.

 * The `git unlock <worktree>` used in the test's cleanup is moved to after
   we know the `git worktree locked` is executed successfully. This ensures
   the unlock doesn't error in the cleanup stage which will make it harder
   to debug the tests.

Rafael Silva (7):
  worktree: libify should_prune_worktree()
  worktree: teach worktree to lazy-load "prunable" reason
  worktree: teach worktree_lock_reason() to gently handle main worktree
  t2402: ensure locked worktree is properly cleaned up
  worktree: teach `list --porcelain` to annotate locked worktree
  worktree: teach `list` to annotate prunable worktree
  worktree: teach `list` verbose mode

 Documentation/git-worktree.txt |  74 ++++++++++++++++++++--
 builtin/worktree.c             | 110 +++++++++++----------------------
 t/t2402-worktree-list.sh       |  96 ++++++++++++++++++++++++++++
 worktree.c                     |  91 ++++++++++++++++++++++++++-
 worktree.h                     |  23 +++++++
 5 files changed, 314 insertions(+), 80 deletions(-)

Range-diff against v3:
1:  fc4252c129 = 1:  66cd83ba42 worktree: libify should_prune_worktree()
2:  664d84155b = 2:  81f4824028 worktree: teach worktree to lazy-load "prunable" reason
3:  cf334da2f0 = 3:  c62ecf60d6 worktree: teach worktree_lock_reason() to gently handle main worktree
4:  ecb11793d9 ! 4:  d2ea467927 t2402: ensure locked worktree is properly cleaned up
    @@ Metadata
      ## Commit message ##
         t2402: ensure locked worktree is properly cleaned up
     
    -    In c57b3367be (worktree: teach `list` to annotate locked worktree,
    +    c57b3367be (worktree: teach `list` to annotate locked worktree,
         2020-10-11) introduced a new test to ensure locked worktrees are listed
         with "locked" annotation. However, the test does not clean up after
         itself as "git worktree prune" is not going to remove the locked worktree
         in the first place. This not only leaves the test in an unclean state it
    -    also potentially breaks following tests that relies on the
    +    also potentially breaks following tests that rely on the
         "git worktree list" output.
     
         Let's fix that by unlocking the worktree before the "prune" command.
5:  1fb68562f6 ! 5:  1b7661a0b3 worktree: teach `list --porcelain` to annotate locked worktree
    @@ Commit message
         with its value depending whether the value is available or not. Thus
         documenting the case of the new "locked" attribute.
     
    +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
         Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
     
    @@ Documentation/git-worktree.txt: worktree /path/to/other-linked-worktree
     +branch refs/heads/locked-with-reason
     +locked reason why is locked
     +
    ++------------
    ++
    ++If the lock reason contains "unusual" characters such as newline, they
    ++are escaped and the entire reason is quoted as explained for the
    ++configuration variable `core.quotePath` (see linkgit:git-config[1]).
    ++For Example:
    ++
    ++------------
    ++$ git worktree list --porcelain
    ++...
    ++locked "reason\nwhy is locked"
    ++...
      ------------
      
      EXAMPLES
    @@ t/t2402-worktree-list.sh: test_expect_success '"list" all worktrees with locked
     +	# unlocked worktree should not be annotated with "locked"
     +	git worktree add --detach unlocked &&
     +	git worktree lock locked1 &&
    ++	test_when_finished "git worktree unlock locked1" &&
     +	git worktree lock locked2 --reason "with reason" &&
    -+	test_when_finished "git worktree unlock locked1 && git worktree unlock locked2" &&
    ++	test_when_finished "git worktree unlock locked2" &&
     +	git worktree list --porcelain >out &&
     +	grep "^locked" out >actual &&
     +	test_cmp expect actual
    @@ t/t2402-worktree-list.sh: test_expect_success '"list" all worktrees with locked
     +	git worktree add --detach locked_lf &&
     +	git worktree add --detach locked_crlf &&
     +	git worktree lock locked_lf --reason "$(printf "locked\nreason")" &&
    ++	test_when_finished "git worktree unlock locked_lf" &&
     +	git worktree lock locked_crlf --reason "$(printf "locked\r\nreason")" &&
    -+	test_when_finished "git worktree unlock locked_lf && git worktree unlock locked_crlf" &&
    ++	test_when_finished "git worktree unlock locked_crlf" &&
     +	git worktree list --porcelain >out &&
     +	grep "^locked" out >actual &&
     +	test_cmp expect actual
6:  834584f826 = 6:  c29ad7ffb1 worktree: teach `list` to annotate prunable worktree
7:  35ad456fbb ! 7:  7938950d04 worktree: teach `list` verbose mode
    @@ t/t2402-worktree-list.sh: test_expect_success '"list" all worktrees with prunabl
     +	git worktree add locked1 --detach &&
     +	git worktree add locked2 --detach &&
     +	git worktree lock locked1 &&
    ++	test_when_finished "git worktree unlock locked1" &&
     +	git worktree lock locked2 --reason "with reason" &&
    -+	test_when_finished "git worktree unlock locked1 && git worktree unlock locked2" &&
    ++	test_when_finished "git worktree unlock locked2" &&
     +	echo "$(git -C locked2 rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >expect &&
     +	printf "\tlocked: with reason\n" >>expect &&
     +	git worktree list --verbose >out &&
-- 
2.30.0.373.geade8fefe8

