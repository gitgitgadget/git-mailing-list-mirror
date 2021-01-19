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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D60C433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 21:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01F3622D08
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 21:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbhASVbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 16:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbhASV2x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 16:28:53 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57238C061795
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 13:28:09 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j18so1071442wmi.3
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 13:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Zq9dLugqSLOtw2KUEbjvjrF5RBZFE8q3p9BqmNyAhA=;
        b=BKHNbDvfFivRYHY9N322LOC7f1kL/qOROMW25Cq3cYZksngMpWCSqlBT51pj9ETca8
         Ke/VSQdIwvxUcxi93L/iiAHSfu31qAJ0GdNfUzxbJnPzT3o26rRBclQDOR2eSUs+aehN
         3QJa+ZoWMqqwN12vt6Jdd238KqERKmNM4xF0JBRodJMQxS8rVX7K1QHVlDiWpXJE9xA7
         RdbXataXjo8IyoaNEs28XfClR6MjqpDUw1J9M5m5Z3rxHOvIOOAXBAMB6vCTlBJdqtr9
         0ZN2ouiFRZ89Fqlv9vzpMMO/n8tJZgBwXJ3cEiqcZi2dYfQLOa5o6mPxudmVpDSethe/
         7/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Zq9dLugqSLOtw2KUEbjvjrF5RBZFE8q3p9BqmNyAhA=;
        b=ZsDhyhQVIbEESjWJHnHPAt8fZtGlTJ8/5VomuGzBqXgyZEdYmtWYKB/yjEWF3e5OhG
         lBLIRRLskH2+oUTo0QnXK3YhQHDOFy7GkvC1XhSGB4dZKkvAK6X8ibSmEAu0lyPQIjmF
         kFqE/K6HP5GwkczWhHG556YPigEatGMbUCw0yeAm0jZ8FXvCLz6G3Z1DSlHFfwka/E8k
         dq0Jvc6IfQOzZDmB57bvF5KLM/o1QW/mQvSsyuQAjlS9qlmlx8bLlBgbyKfQxdjbUzy0
         W6PhRmT3/+T1zcrwwmbBj43aOy/BcWsbMBv2p9+4t86ILje+JnfoRU6cXtFRB0U3NOeN
         ikZQ==
X-Gm-Message-State: AOAM533P7+c+coCMPVBkLYZ4axbZcfE9E9R4ux7lJyZTracQyhZhfZVe
        kVChXho5GSPF5Qe7WBMnKR1gEWCosek=
X-Google-Smtp-Source: ABdhPJzB7jf0mGRIiYmMqJnCk2sb4467imhPrLBn2cq6fxcrTWxmfR1uChHodd/l76WQ41UMEEBRSA==
X-Received: by 2002:a1c:dc41:: with SMTP id t62mr1370925wmg.106.1611091687426;
        Tue, 19 Jan 2021 13:28:07 -0800 (PST)
Received: from localhost.localdomain ([212.86.35.161])
        by smtp.gmail.com with ESMTPSA id r2sm39448819wrn.83.2021.01.19.13.28.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 13:28:06 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v3 0/7] teach `worktree list` verbose mode and prunable annotations
Date:   Tue, 19 Jan 2021 22:27:32 +0100
Message-Id: <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.421.g32f838e276
In-Reply-To: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
References: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In c57b3367be (worktree: teach `list` to annotate locked worktree,
2020-10-11) we taught `git worktree list` to annotate working tree that
is locked by appending "locked" text in order to signalize to the user
that a working tree is locked.  During the review, there was some
discussion about additional annotations and information that `list`
command could provide to the user that has long been envisioned and
mentioned in [2], [3] and [4].

This patch series addresses some of these changes by teaching
`worktree list` to show "prunable" annotation, adding verbose mode and
extending the --porcelain format with prunable and locked annotation as
follow up from [1]. Additionally, it addresses one shortcoming for porcelain
format to escape any newline characters (LF or CRLF) for the lock reason
to prevent breaking the format that is mentioned in [4] and [1] during the
review cycle.

The patch series is organizes as:

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

Changes in v3
=============

v3 is 1-patch bigger than v2 and it includes the following changes:

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

 Documentation/git-worktree.txt |  62 +++++++++++++++++--
 builtin/worktree.c             | 110 +++++++++++----------------------
 builtin/worktree.cc            |   0
 t/t2402-worktree-list.sh       |  93 ++++++++++++++++++++++++++++
 worktree.c                     |  91 ++++++++++++++++++++++++++-
 worktree.h                     |  23 +++++++
 6 files changed, 299 insertions(+), 80 deletions(-)
 create mode 100644 builtin/worktree.cc

Range-diff against v2:
-:  ---------- > 1:  66cd83ba42 worktree: libify should_prune_worktree()
1:  9d47fcb4a4 ! 2:  81f4824028 worktree: teach worktree to lazy-load "prunable" reason
    @@ worktree.c: const char *worktree_lock_reason(struct worktree *wt)
     +const char *worktree_prune_reason(struct worktree *wt, timestamp_t expire)
     +{
     +	struct strbuf reason = STRBUF_INIT;
    -+	char *path;
    ++	char *path = NULL;
     +
     +	if (is_main_worktree(wt))
     +		return NULL;
2:  ac7c375bac ! 3:  d0dbf0b709 worktree: teach worktree_lock_reason() to gently handle main worktree
    @@ Commit message
     
         worktree_lock_reason() aborts with an assertion failure when called on
         the main worktree since locking the main worktree is nonsensical. Not
    -    only is this behaviour undocumented, thus callers might not even be aware
    +    only is this behavior undocumented, thus callers might not even be aware
         that the call could potentially crash the program, but it also forces
         clients to be extra careful:
     
    @@ Commit message
                 ...
     
         Since we know that locking makes no sense in the context of the main
    -    worktree, we can simpliy return false for the main worktree, thus making
    +    worktree, we can simply return false for the main worktree, thus making
         client code less complex by eliminating the need for the callers to have
         inside knowledge about the implementation:
     
    @@ Commit message
         Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
     
    + ## builtin/worktree.c ##
    +@@ builtin/worktree.c: static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
    + 			strbuf_addstr(&sb, "(error)");
    + 	}
    + 
    +-	if (!is_main_worktree(wt) && worktree_lock_reason(wt))
    ++	if (worktree_lock_reason(wt))
    + 		strbuf_addstr(&sb, " locked");
    + 
    + 	printf("%s\n", sb.buf);
    +
      ## worktree.c ##
     @@ worktree.c: int is_main_worktree(const struct worktree *wt)
      
-:  ---------- > 4:  c6f8a3e9cd t2402: ensure locked worktree is properly cleaned up
3:  ec1eb5a9f8 ! 5:  86c5253288 worktree: teach `list --porcelain` to annotate locked worktree
    @@ Commit message
             locked reason why it is locked
             ...
     
    -    The locked reason is quoted to prevent newline characters (i.e: LF or
    -    CRLF) breaking the --porcelain format as each attribute is shown per
    -    line. For example:
    +    In porcelain mode, if the lock reason contains special characters
    +    such as newlines, they are escaped with backslashes and the entire
    +    reason is enclosed in double quotes. For example:
     
            $ git worktree list --porcelain
            ...
    -       locked worktree's path mounted in\nremovable device
    +       locked "worktree's path mounted in\nremovable device"
            ...
     
         Furthermore, let's update the documentation to state that some
    @@ Commit message
         with its value depending whether the value is available or not. Thus
         documenting the case of the new "locked" attribute.
     
    -    Additionally, c57b3367be (worktree: teach `list` to annotate locked
    -    worktree, 2020-10-11) introduced a new test to ensure locked worktrees
    -    are listed with "locked" annotation. However, the test does not clean up
    -    after itself as "git worktree prune" is not going to remove the locked
    -    worktree in the first place. This not only leaves the test in an unclean
    -    state it also potentially breaks following tests that relies on the
    -    "git worktree list" output. Let's fix that by unlocking the worktree
    -    before the "prune" command.
    -
         Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
     
    @@ Documentation/git-worktree.txt: Porcelain Format
     -if the value is true.  The first attribute of a working tree is always
     -`worktree`, an empty line indicates the end of the record.  For example:
     +if the value is true.  Some attributes (like `locked`) can be listed as a label
    -+only or with a value depending whether a reason is available.  The first
    ++only or with a value depending upon whether a reason is available.  The first
     +attribute of a working tree is always `worktree`, an empty line indicates the
     +end of the record.  For example:
      
    @@ Documentation/git-worktree.txt: worktree /path/to/other-linked-worktree
      HEAD 1234abc1234abc1234abc1234abc1234abc1234a
      detached
      
    -+worktree /path/to/linked-worktree-locked
    ++worktree /path/to/linked-worktree-locked-no-reason
     +HEAD 5678abc5678abc5678abc5678abc5678abc5678c
    -+branch refs/heads/locked
    ++branch refs/heads/locked-no-reason
     +locked
     +
     +worktree /path/to/linked-worktree-locked-with-reason
    @@ builtin/worktree.c: static void show_worktree_porcelain(struct worktree *wt)
     +	reason = worktree_lock_reason(wt);
     +	if (reason && *reason) {
     +		struct strbuf sb = STRBUF_INIT;
    -+		quote_c_style(reason, &sb, NULL, CQUOTE_NODQ);
    ++		quote_c_style(reason, &sb, NULL, 0);
     +		printf("locked %s\n", sb.buf);
     +		strbuf_release(&sb);
     +	} else if (reason)
    @@ builtin/worktree.c: static void show_worktree_porcelain(struct worktree *wt)
     
      ## t/t2402-worktree-list.sh ##
     @@ t/t2402-worktree-list.sh: test_expect_success '"list" all worktrees with locked annotation' '
    - 	git worktree add --detach locked master &&
    - 	git worktree add --detach unlocked master &&
    - 	git worktree lock locked &&
    -+	test_when_finished "git worktree unlock locked" &&
    - 	git worktree list >out &&
    - 	grep "/locked  *[0-9a-f].* locked$" out &&
      	! grep "/unlocked  *[0-9a-f].* locked$" out
      '
      
    @@ t/t2402-worktree-list.sh: test_expect_success '"list" all worktrees with locked
     +	echo "locked with reason" >>expect &&
     +	git worktree add --detach locked1 &&
     +	git worktree add --detach locked2 &&
    ++	# unlocked worktree should not be annotated with "locked"
     +	git worktree add --detach unlocked &&
     +	git worktree lock locked1 &&
     +	git worktree lock locked2 --reason "with reason" &&
    @@ t/t2402-worktree-list.sh: test_expect_success '"list" all worktrees with locked
     +
     +test_expect_success '"list" all worktrees --porcelain with locked reason newline escaped' '
     +	test_when_finished "rm -rf locked_lf locked_crlf out actual expect && git worktree prune" &&
    -+	printf "locked locked\\\\r\\\\nreason\n" >expect &&
    -+	printf "locked locked\\\\nreason\n" >>expect &&
    ++	printf "locked \"locked\\\\r\\\\nreason\"\n" >expect &&
    ++	printf "locked \"locked\\\\nreason\"\n" >>expect &&
     +	git worktree add --detach locked_lf &&
     +	git worktree add --detach locked_crlf &&
    -+	printf "locked\nreason\n\n" >reason_lf &&
    -+	printf "locked\r\nreason\n\n" >reason_crlf &&
    -+	git worktree lock locked_lf --reason "$(cat reason_lf)" &&
    -+	git worktree lock locked_crlf --reason "$(cat reason_crlf)" &&
    ++	git worktree lock locked_lf --reason "$(printf "locked\nreason")" &&
    ++	git worktree lock locked_crlf --reason "$(printf "locked\r\nreason")" &&
     +	test_when_finished "git worktree unlock locked_lf && git worktree unlock locked_crlf" &&
     +	git worktree list --porcelain >out &&
     +	grep "^locked" out >actual &&
4:  f937df6460 ! 6:  be814326ee worktree: teach `list` to annotate prunable worktree
    @@ Documentation/git-worktree.txt: This can also be set up as the default behaviour
      	With `prune`, only expire unused working trees older than `<time>`.
     ++
     +With `list`, annotate missing working trees as prunable if they are
    -+older than `<mtime>`.
    ++older than `<time>`.
      
      --reason <string>::
      	With `lock`, an explanation why the working tree is locked.
    @@ Documentation/git-worktree.txt: $ git worktree list
     +
     +------------
     +$ git worktree list
    -+/path/to/linked-worktree        abcd1234 [master]
    -+/path/to/locked-worktreee       acbd5678 (brancha) locked
    -+/path/to/prunable-worktree      5678abc  (detached HEAD) prunable
    ++/path/to/linked-worktree    abcd1234 [master]
    ++/path/to/locked-worktreee   acbd5678 (brancha) locked
    ++/path/to/prunable-worktree  5678abc  (detached HEAD) prunable
     +------------
     +
      Porcelain Format
    @@ builtin/worktree.c: static void show_worktree_porcelain(struct worktree *wt)
      		printf("locked\n");
      
     +	reason = worktree_prune_reason(wt, expire);
    -+	if (reason && *reason)
    ++	if (reason)
     +		printf("prunable %s\n", reason);
     +
      	printf("\n");
      }
      
     @@ builtin/worktree.c: static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
    - 	struct strbuf sb = STRBUF_INIT;
    - 	int cur_path_len = strlen(wt->path);
    - 	int path_adj = cur_path_len - utf8_strwidth(wt->path);
    -+	const char *reason;
    - 
    - 	strbuf_addf(&sb, "%-*s ", 1 + path_maxlen + path_adj, wt->path);
    - 	if (wt->is_bare)
    -@@ builtin/worktree.c: static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
    - 			strbuf_addstr(&sb, "(error)");
    - 	}
    - 
    --	if (!is_main_worktree(wt) && worktree_lock_reason(wt))
    -+	reason = worktree_lock_reason(wt);
    -+	if (reason)
    + 	if (worktree_lock_reason(wt))
      		strbuf_addstr(&sb, " locked");
      
    -+	reason = worktree_prune_reason(wt, expire);
    -+	if (reason)
    ++	if (worktree_prune_reason(wt, expire))
     +		strbuf_addstr(&sb, " prunable");
     +
      	printf("%s\n", sb.buf);
    @@ builtin/worktree.c: static int list(int ac, const char **av, const char *prefix)
      	if (ac)
      		usage_with_options(worktree_usage, options);
     
    + ## builtin/worktree.cc (new) ##
    +
      ## t/t2402-worktree-list.sh ##
     @@ t/t2402-worktree-list.sh: test_expect_success '"list" all worktrees --porcelain with locked reason newline
      	test_cmp expect actual
5:  0b6ab6dddb ! 7:  b0688f142d worktree: teach `list` verbose mode
    @@ Commit message
         worktrees a reason might be available provided by the user via `lock`
         command.
     
    -    Let's teach "git worktree list" to output the reason why the worktrees
    -    are being annotated. The reason is a text that can take virtually any
    -    size and appending the text on the default columned format will make it
    -    difficult to extend the command with other annotations and not fit nicely
    -    on the screen. In order to address this shortcoming the annotation is
    -    then moved to the next line indented followed by the reason, if the
    -    reason is not available the annotation stays on the same line as the
    -    worktree itself.
    +    Let's teach "git worktree list" a --verbose mode that outputs the reason
    +    why the worktrees are being annotated. The reason is a text that can take
    +    virtually any size and appending the text on the default columned format
    +    will make it difficult to extend the command with other annotations and
    +    not fit nicely on the screen. In order to address this shortcoming the
    +    annotation is then moved to the next line indented followed by the reason
    +    If the reason is not available the annotation stays on the same line as
    +    the worktree itself.
     
         The output of "git worktree list" with verbose becomes like so:
     
             $ git worktree list --verbose
             ...
    -        /path/to/locked                acb124 [branch-a] locked
    -        /path/to/locked-with-reason    acc125 [branch-b]
    +        /path/to/locked-no-reason    acb124 [branch-a] locked
    +        /path/to/locked-with-reason  acc125 [branch-b]
                 locked: worktree with a locked reason
    -        /path/to/prunable-reason       ace127 [branch-d]
    +        /path/to/prunable-reason     ace127 [branch-d]
                 prunable: gitdir file points to non-existent location
             ...
     
    @@ Documentation/git-worktree.txt: This can also be set up as the default behaviour
      --expire <time>::
      	With `prune`, only expire unused working trees older than `<time>`.
     @@ Documentation/git-worktree.txt: $ git worktree list
    - /path/to/prunable-worktree      5678abc  (detached HEAD) prunable
    + /path/to/prunable-worktree  5678abc  (detached HEAD) prunable
      ------------
      
     +For these annotations, a reason might also be available and this can be
    @@ Documentation/git-worktree.txt: $ git worktree list
     +
     +------------
     +$ git worktree list --verbose
    -+/path/to/linked-worktree        abcd1234 [master]
    -+/path/to/locked-worktreee       acbd5678 (brancha)
    -+	locked: working tree path is mounted on a removable device
    -+/path/to/locked-no-reason       abcd578  (detached HEAD) locked
    -+/path/to/prunable-worktree      5678abc  (detached HEAD)
    ++/path/to/linked-worktree              abcd1234 [master]
    ++/path/to/locked-worktree-no-reason    abcd5678 (detached HEAD) locked
    ++/path/to/locked-worktree-with-reason  1234abcd (brancha)
    ++	locked: working tree path is mounted on a portable device
    ++/path/to/prunable-worktree            5678abc1 (detached HEAD)
     +	prunable: gitdir file points to non-existent location
     +------------
     +
    @@ Documentation/git-worktree.txt: $ git worktree list
     
      ## builtin/worktree.c ##
     @@ builtin/worktree.c: static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
    + 	struct strbuf sb = STRBUF_INIT;
    + 	int cur_path_len = strlen(wt->path);
    + 	int path_adj = cur_path_len - utf8_strwidth(wt->path);
    ++	const char *reason;
    + 
    + 	strbuf_addf(&sb, "%-*s ", 1 + path_maxlen + path_adj, wt->path);
    + 	if (wt->is_bare)
    +@@ builtin/worktree.c: static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
    + 			strbuf_addstr(&sb, "(error)");
      	}
      
    - 	reason = worktree_lock_reason(wt);
    --	if (reason)
    +-	if (worktree_lock_reason(wt))
    ++	reason = worktree_lock_reason(wt);
     +	if (verbose && reason && *reason)
     +		strbuf_addf(&sb, "\n\tlocked: %s", reason);
     +	else if (reason)
      		strbuf_addstr(&sb, " locked");
      
    - 	reason = worktree_prune_reason(wt, expire);
    --	if (reason)
    -+	if (verbose && reason && *reason)
    +-	if (worktree_prune_reason(wt, expire))
    ++	reason = worktree_prune_reason(wt, expire);
    ++	if (verbose && reason)
     +		strbuf_addf(&sb, "\n\tprunable: %s", reason);
     +	else if (reason)
      		strbuf_addstr(&sb, " prunable");
    @@ t/t2402-worktree-list.sh: test_expect_success '"list" all worktrees with prunabl
     +'
     +
     +test_expect_success '"list" all worktrees --verbose with locked' '
    -+	test_when_finished "rm -rf locked out actual expect && git worktree prune" &&
    -+	git worktree add locked --detach &&
    -+	git worktree lock locked --reason "with reason" &&
    -+	test_when_finished "git worktree unlock locked" &&
    -+	echo "$(git -C locked rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >expect &&
    ++	test_when_finished "rm -rf locked1 locked2 out actual expect && git worktree prune" &&
    ++	git worktree add locked1 --detach &&
    ++	git worktree add locked2 --detach &&
    ++	git worktree lock locked1 &&
    ++	git worktree lock locked2 --reason "with reason" &&
    ++	test_when_finished "git worktree unlock locked1 && git worktree unlock locked2" &&
    ++	echo "$(git -C locked2 rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >expect &&
     +	printf "\tlocked: with reason\n" >>expect &&
     +	git worktree list --verbose >out &&
    -+	sed -n "s/  */ /g;/\/locked  *[0-9a-f].*$/,/locked: .*$/p" <out >actual &&
    ++	grep "/locked1  *[0-9a-f].* locked$" out &&
    ++	sed -n "s/  */ /g;/\/locked2  *[0-9a-f].*$/,/locked: .*$/p" <out >actual &&
     +	test_cmp actual expect
     +'
     +
-- 
2.30.0.421.g32f838e276

