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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56935C433E9
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 23:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27106206ED
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 23:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbhAQXor (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 18:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730770AbhAQXo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 18:44:28 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5327C061573
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 15:43:47 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id hs11so18896200ejc.1
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 15:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+unObqonI1Jv+nbygVkLi56UCAfZer/xvsLcPbyfgbs=;
        b=mTFziHtRa1iLc9cteX1tL93NclGGlzIzPbTT/JMkDnJDfeuSuioFOiQGI1z7BDu0ow
         Vi+hKN+0HCPEhVm9zDhw5lW4Sfz6/MlfLwULcPJy6Zw7biPcLhPD6SoNL7AIMklaVCCs
         hXNxzjdxo6zMPgl+iytmUXmB/XXXIJQA4creIaUKPbwu+XQ4iY070P8X7hFR7wPhUxyE
         dZLEydVieoUax+hTTN6r0pd5Zp4RqFDFvRQ1IF7j+8uoIhl93YAIK/cw5Bwbk/J1t2PG
         n5o6EVHHt6WMSTpt8/1p3gmCT+y1x3QOomd0m9zxrP7TENRm9spHyBlbq1e78ivUMhQb
         qrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+unObqonI1Jv+nbygVkLi56UCAfZer/xvsLcPbyfgbs=;
        b=W+T82C9jCCnKClhtUuaahB7PUYQ+kg0FVGTpwdxoWdgZ73Tfp2b1ii3rDVGkc3tw3h
         0lDI9+4ar2C60MZGZDQP3CbFj/19Zm28HRKeqrDF9hv/UZSMKDXZq8vq4hvu1TRKFau+
         lEOAwHsiSLwarM9JknW+NOdJlwK4bHXSkim+T0CcZxeXIq62LCZSOEWybtnoeE2clcMO
         F9uz2Cz7NU+YscIuBHKcfO42VrTgk06m5jgEvS2BLv1A5YBOuJ+w9qwkieJUQy3tObGa
         fnG2+LXmMRKes9xbD/3Fks2QX88grOJyH8VHXmtq1WQMloPoa8vV6WR0DF6DEunnknWL
         ayMg==
X-Gm-Message-State: AOAM5333ooueUPN92eVlP+HmHjdfIyyTzIeP2FacQXgeLvAPk9wk/O92
        yeKj8JuVxWJmzJji1+tiWjJ7OKZ9IeE=
X-Google-Smtp-Source: ABdhPJxwl8DFCHRYWJJM8Rj6NPu6tJ48XoMb2v9WiPT03cl0cn0wOzzVkNQ76gCHeM1/7jK09bAmtw==
X-Received: by 2002:a17:907:2458:: with SMTP id yw24mr1778046ejb.333.1610927025844;
        Sun, 17 Jan 2021 15:43:45 -0800 (PST)
Received: from localhost.localdomain ([79.140.114.246])
        by smtp.gmail.com with ESMTPSA id f13sm8639932ejf.42.2021.01.17.15.43.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 15:43:45 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v2 0/6] teach `worktree list` verbose mode and prunable annotations
Date:   Mon, 18 Jan 2021 00:42:38 +0100
Message-Id: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.372.gbc7e965391
In-Reply-To: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
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

4. The fourth patch adds the "locked" attribute for the porcelain format
   in order to make both default and --porcelain format consistent.

5. The fifth patch introduces "prunable" annotation for both default
   and --porcelain format.

6. The sixth patch introduces verbose mode to expand the `list` default
   format and show each annotation reason when its available.

Series is built on top of 66e871b664 (The third batch, 2021-01-15).

[1] https://lore.kernel.org/git/20200928154953.30396-1-rafaeloliveira.cs@gmail.com/
[2] https://lore.kernel.org/git/CAPig+cQF6V8HNdMX5AZbmz3_w2WhSfA4SFfNhQqxXBqPXTZL+w@mail.gmail.com/
[3] https://lore.kernel.org/git/CAPig+cSGXqJuaZPhUhOVX5X=LMrjVfv8ye_6ncMUbyKox1i7QA@mail.gmail.com/
[4] https://lore.kernel.org/git/CAPig+cTitWCs5vB=0iXuUyEY22c0gvjXvY1ZtTT90s74ydhE=A@mail.gmail.com/
[5] https://lore.kernel.org/git/CACsJy8ChM99n6skQCv-GmFiod19mnwwH4j-6R+cfZSiVFAxjgA@mail.gmail.com/
[6] https://lore.kernel.org/git/xmqq8sctlgzx.fsf@gitster.c.googlers.com/

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

Rafael Silva (6):
  worktree: libify should_prune_worktree()
  worktree: teach worktree to lazy-load "prunable" reason
  worktree: teach worktree_lock_reason() to gently handle main worktree
  worktree: teach `list --porcelain` to annotate locked worktree
  worktree: teach `list` to annotate prunable worktree
  worktree: teach `list` verbose mode

 Documentation/git-worktree.txt |  62 +++++++++++++++++--
 builtin/worktree.c             | 110 +++++++++++----------------------
 t/t2402-worktree-list.sh       |  91 +++++++++++++++++++++++++++
 worktree.c                     |  91 ++++++++++++++++++++++++++-
 worktree.h                     |  23 +++++++
 5 files changed, 297 insertions(+), 80 deletions(-)

Range-diff against v1:
1:  9d3fff52b4 ! 1:  e4df49d882 worktree: move should_prune_worktree() to worktree.c
    @@ Metadata
     Author: Rafael Silva <rafaeloliveira.cs@gmail.com>
     
      ## Commit message ##
    -    worktree: move should_prune_worktree() to worktree.c
    +    worktree: libify should_prune_worktree()
     
         As part of teaching "git worktree list" to annotate worktree that is a
         candidate for pruning, let's move should_prune_worktree() from
         builtin/worktree.c to worktree.c in order to make part of the worktree
         public API.
     
    -    This function will be used by another API function, implemented in the
    -    next patch that will accept a pointer to "worktree" structure directly
    -    making it easier to implement the "prunable" annotations.
    +    should_prune_worktree() knows how to select the given worktree for
    +    pruning based on an expiration date, however the expiration value is
    +    stored in a static file-scope variable and it is not local to the
    +    function. In order to move the function, teach should_prune_worktree()
    +    to take the expiration date as an argument and document the new
    +    parameter that is not immediately obvious.
     
    -    should_prune_worktree() knows how to select the given worktree for pruning
    -    based on an expiration date, however the expiration value is stored on a
    -    global variable and it is not local to the function. In order to move the
    -    function, teach should_prune_worktree() to take the expiration date as an
    -    argument.
    +    Also, change the function comment to clearly state that the worktree's
    +    path is returned in `wtpath` argument.
     
    +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
     
      ## builtin/worktree.c ##
    @@ worktree.c: void repair_worktree_at_path(const char *path,
      	strbuf_release(&dotgit);
      }
     +
    -+/*
    -+ * Return true if worktree entry should be pruned, along with the reason for
    -+ * pruning. Otherwise, return false and the worktree's path, or NULL if it
    -+ * cannot be determined. Caller is responsible for freeing returned path.
    -+ */
     +int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath, timestamp_t expire)
     +{
     +	struct stat st;
    @@ worktree.h: int is_main_worktree(const struct worktree *wt);
      
     +/*
     + * Return true if worktree entry should be pruned, along with the reason for
    -+ * pruning. Otherwise, return false and the worktree's path, or NULL if it
    -+ * cannot be determined. Caller is responsible for freeing returned path.
    ++ * pruning. Otherwise, return false and the worktree's path in `wtpath`, or
    ++ * NULL if it cannot be determined. Caller is responsible for freeing
    ++ * returned path.
    ++ *
    ++ * `expire` defines a grace period to prune the worktree when its path
    ++ * does not exist.
     + */
     +int should_prune_worktree(const char *id,
     +			  struct strbuf *reason,
2:  80044e0ba9 ! 2:  d8db43fec8 worktree: implement worktree_prune_reason() wrapper
    @@ Metadata
     Author: Rafael Silva <rafaeloliveira.cs@gmail.com>
     
      ## Commit message ##
    -    worktree: implement worktree_prune_reason() wrapper
    +    worktree: teach worktree to lazy-load "prunable" reason
     
    -    The should_prune_worktree() machinery is used by the "prune" command to
    -    identify whether a worktree is a candidate for pruning. This function
    -    however, is not prepared to work directly with "struct worktree" and
    -    refactoring is required not only on the function itself, but also also
    -    changing get_worktrees() to return non-valid worktrees and address the
    -    changes in all "worktree" sub commands.
    -
    -    Instead let's implement worktree_prune_reason() that accepts
    -    "struct worktree" and uses should_prune_worktree() and returns whether
    -    the given worktree is a candidate for pruning. As the "list" sub command
    -    already uses a list of "struct worktree", this allow to simply check if
    -    the working tree prunable by passing the structure directly without the
    -    others parameters.
    -
    -    Also, let's add prune_reason field to the worktree structure that will
    -    store the reason why the worktree can be pruned that is returned by
    -    should_prune_worktree() when such reason is available.
    +    Add worktree_prune_reason() to allow a caller to discover whether a
    +    worktree is prunable and the reason that it is, much like
    +    worktree_lock_reason() indicates whether a worktree is locked and the
    +    reason for the lock. As with worktree_lock_reason(), retrieve the
    +    prunable reason lazily and cache it in the `worktree` structure.
     
    +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
     
      ## worktree.c ##
    @@ worktree.c: const char *worktree_lock_reason(struct worktree *wt)
      
     +const char *worktree_prune_reason(struct worktree *wt, timestamp_t expire)
     +{
    -+	if (!is_main_worktree(wt)) {
    -+		char *path;
    -+		struct strbuf reason = STRBUF_INIT;
    ++	struct strbuf reason = STRBUF_INIT;
    ++	char *path;
     +
    -+		if (should_prune_worktree(wt->id, &reason, &path, expire))
    -+			wt->prune_reason = strbuf_detach(&reason, NULL);
    -+		else
    -+			wt->prune_reason = NULL;
    ++	if (is_main_worktree(wt))
    ++		return NULL;
    ++	if (wt->prune_reason_valid)
    ++		return wt->prune_reason;
     +
    -+		free(path);
    -+		strbuf_release(&reason);
    -+	}
    ++	if (should_prune_worktree(wt->id, &reason, &path, expire))
    ++		wt->prune_reason = strbuf_detach(&reason, NULL);
    ++	wt->prune_reason_valid = 1;
     +
    ++	strbuf_release(&reason);
    ++	free(path);
     +	return wt->prune_reason;
     +}
     +
    @@ worktree.h: struct worktree {
      	struct object_id head_oid;
      	int is_detached;
      	int is_bare;
    + 	int is_current;
    + 	int lock_reason_valid; /* private */
    ++	int prune_reason_valid; /* private */
    + };
    + 
    + /*
     @@ worktree.h: int is_main_worktree(const struct worktree *wt);
       */
      const char *worktree_lock_reason(struct worktree *wt);
      
     +/*
    -+ * Return the reason string if the given worktree should be pruned
    -+ * or NULL otherwise.
    ++ * Return the reason string if the given worktree should be pruned, otherwise
    ++ * NULL if it should not be pruned. `expire` defines a grace period to prune
    ++ * the worktree when its path does not exist.
     + */
     +const char *worktree_prune_reason(struct worktree *wt, timestamp_t expire);
     +
      /*
       * Return true if worktree entry should be pruned, along with the reason for
    -  * pruning. Otherwise, return false and the worktree's path, or NULL if it
    +  * pruning. Otherwise, return false and the worktree's path in `wtpath`, or
3:  fa2297714b < -:  ---------- worktree: teach worktree_lock_reason() to gently handle main worktree
4:  bcc2e5d745 < -:  ---------- worktree: teach `list` prunable annotation and verbose
5:  588051ed5f < -:  ---------- worktree: `list` escape lock reason in --porcelain
6:  cbff8c993a < -:  ---------- worktree: add tests for `list` verbose and annotations
7:  9c5893d2b9 < -:  ---------- worktree: document `list` verbose and prunable annotations
-:  ---------- > 3:  5b8963292f worktree: teach worktree_lock_reason() to gently handle main worktree
-:  ---------- > 4:  6bdd46b9bc worktree: teach `list --porcelain` to annotate locked worktree
-:  ---------- > 5:  bbf6c53ecc worktree: teach `list` to annotate prunable worktree
-:  ---------- > 6:  acc0bf22cd worktree: teach `list` verbose mode
-- 
2.30.0.356.gd4bb5ad4ba

