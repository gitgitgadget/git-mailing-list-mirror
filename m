Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC129C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8832060F25
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbhHDF3N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 01:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbhHDF3M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 01:29:12 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50212C0613D5
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 22:28:59 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l18so800939wrv.5
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 22:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Eb2gIqsa0TkJ0CgjVzskyEOa6lf07aIoJQuYXmFnsEQ=;
        b=YSWSVBeq04f3YXxBKC6A7nyZma7hQw805vAHpOpuoi7XkVuTGkFVCpfo9bP4MXoGtr
         5uRps+4S9UJMd7m8wN3Npg8lceFuajBE1zFXYGZ1gXdlhvNJJb1Q4Z2PAX2D8jVcp9GL
         l3Oszz9lKMR+8iYVL5A+apjvOmFVYRMWQFilvjhP8gI9fEKw7Y4e2/BFgN35Z9aN7N9x
         eAsaYRdTjov51y2Stpgk6imFZ5aX97QJ+Negs3akfmGkklWPwfQDPzNp7DpclgCGHHC7
         6KUdgaMEajNhdIA2J4sPTp4FleHa3huuV2qZeqoW+7FtNWt6V/7+X/yMODGv0hKA+lm1
         S1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Eb2gIqsa0TkJ0CgjVzskyEOa6lf07aIoJQuYXmFnsEQ=;
        b=IJ5M7RSwIKiTwXfmYQ9RK24bBzXlXfmEdIZ+wN8WhpMe5ySlZj2+gpY9IoZfftq4co
         X+Qrbh5gmFOyeTRfrl37eu8Q6l2NjHOpv1y53hAg3J7RH0zJrl8vdslpDuHXPIkqW1s0
         ATIOGtH7VTUgeV3awKijlfSvVQSmTgAMxcR4vAnDuaKwa0i39hqBjB8+jqPGxtcPyGJY
         gXXt1z1ze0Nz1LJPZRX7o1N5dDhC1acFCcOwa5/uUozVz8d+IyOUw2rh3VryV8B1vK60
         WjTyqkiGz2My393MiClzGJcwELJkkwh4LfhQ/KMhu/39ENzT0ZQQIOVngsh/c51cRBfB
         XNMg==
X-Gm-Message-State: AOAM532P9odS6aLIYWUuWnj1MWTZN1Ej46JxZ+h0Zl4pGfbpwe8Jrqie
        FrfftgvP7SzQXPzD0M8EymqDcWC6hko=
X-Google-Smtp-Source: ABdhPJxWIwgn01dQLpyYEGIuBQFbczyey+oYCgYbSDSELxiMjRZa/EUPYYh7RW3s1Qh3HKBdqFYZbg==
X-Received: by 2002:adf:ed82:: with SMTP id c2mr27161354wro.19.1628054937654;
        Tue, 03 Aug 2021 22:28:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7sm1010595wmd.3.2021.08.03.22.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 22:28:57 -0700 (PDT)
Message-Id: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 05:28:45 +0000
Subject: [PATCH v2 00/10] Documentation updates: merge-strategies
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed while updating my switch-default-merge-strategy-to-ort submission,
that many of the changes were good documentation updates that we might want
for Git v2.33.0. So I pulled those changes out and split them into lots of
little commits so that if any parts need discussion or are objectionable, we
can just drop those from this series and apply the rest for v2.33.0.

The first 9 commits are just small documentation updates, but there is one
commit at the end that updates an error message and a code comment.

Changes since v1:

 * Multiple tweaks suggested by Eric, Dscho, and Junio
 * Removed patch 7 explaining no-renames since that probably belongs in git
   diff --no-renames instead, and this series is about merge-strategies.
 * Inserted a new patch 8 that strikes some misleading or at least
   no-longer-important text from git-rebase.txt (due changes back in late
   2006).

Elijah Newren (10):
  git-rebase.txt: correct antiquated claims about --rebase-merges
  directory-rename-detection.txt: small updates due to merge-ort
    optimizations
  Documentation: edit awkward references to `git merge-recursive`
  merge-strategies.txt: update wording for the resolve strategy
  merge-strategies.txt: do not imply using copy detection is desired
  merge-strategies.txt: avoid giving special preference to patience
    algorithm
  merge-strategies.txt: fix simple capitalization error
  git-rebase.txt: correct out-of-date and misleading text about renames
  merge-strategies.txt: add coverage of the `ort` merge strategy
  Update error message and code comment

 Documentation/git-rebase.txt                  | 27 ++++++-----
 Documentation/merge-options.txt               |  4 +-
 Documentation/merge-strategies.txt            | 48 +++++++++++--------
 .../technical/directory-rename-detection.txt  | 14 +++---
 builtin/merge.c                               |  2 +-
 sequencer.c                                   |  2 +-
 6 files changed, 55 insertions(+), 42 deletions(-)


base-commit: 66262451ec94d30ac4b80eb3123549cf7a788afd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1059%2Fnewren%2Fort-doc-updates-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1059/newren/ort-doc-updates-v2
Pull-Request: https://github.com/git/git/pull/1059

Range-diff vs v1:

  1:  ab2367594a3 !  1:  34352397168 git-rebase.txt: correct antiquated claims about --rebase-merges
     @@ Commit message
          2019-07-31).  However, when the limitation was lifted, the documentation
          was not updated.  Update it now.
      
     +    Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Documentation/git-rebase.txt ##
  2:  6b89ab8d9b1 =  2:  3fdd068231a directory-rename-detection.txt: small updates due to merge-ort optimizations
  3:  c1d056f0794 !  3:  2a38320c2be Documentation: edit awkward references to `git merge-recursive`
     @@ Commit message
      
       ## Documentation/git-rebase.txt ##
      @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
     + 
       -s <strategy>::
       --strategy=<strategy>::
     - 	Use the given merge strategy.
     +-	Use the given merge strategy.
      -	If there is no `-s` option 'git merge-recursive' is used
      -	instead.  This implies --merge.
     -+	If there is no `-s` option the `recursive` strategy is the
     -+	default. This implies --merge.
     ++	Use the given merge strategy, instead of the default
     ++	`recursive`.  This implies `--merge`.
       +
       Because 'git rebase' replays each commit from the working branch
       on top of the <upstream> branch using the given strategy, using
  4:  3989f194ba9 !  4:  e422a1bc7d4 merge-strategies.txt: update wording for the resolve strategy
     @@ Metadata
       ## Commit message ##
          merge-strategies.txt: update wording for the resolve strategy
      
     -    The resolve merge strategy was given prominent positioning in this
     -    document, being listed first since it was the default at the time the
     -    document was written.  It hasn't been the default since before Git v1.0
     -    was released, though.  Move it later in the document, near `octopus` and
     -    `ours`.
     +    It is probably helpful to cover the default merge strategy first, so
     +    move the text for the resolve strategy to later in the document.
      
          Further, the wording for "resolve" claimed that it was "considered
     -    generally safe and fast", which implies that the other strategies are
     -    not.  While such an implication may have been true in 2005 when written,
     -    it may well be that `ort` is faster today (since it does not need to
     -    recurse into all directories).  Also, since `resolve` was the default
     -    for less than a year while `recursive` has been the default for a decade
     -    and a half, I think `recursive` is more battle-tested than `resolve` is.
     -    Just strike this extraneous phrase.
     -
     -    Also, provide some quick historical context that may help users
     -    understand its purpose and place in the list of merge strategies.
     +    generally safe and fast", which might imply in some readers minds that
     +    the same is not true of other strategies.  Rather than adding this text
     +    to all the strategies, just remove it from this one.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ Documentation/merge-strategies.txt: subtree[=<path>];;
      +	This can only resolve two heads (i.e. the current branch
      +	and another branch you pulled from) using a 3-way merge
      +	algorithm.  It tries to carefully detect criss-cross
     -+	merge ambiguities.  It cannot handle renames.  This was
     -+	the default merge algorithm prior to November 2005.
     ++	merge ambiguities.  It does not handle renames.
      +
       octopus::
       	This resolves cases with more than two heads, but refuses to do
  5:  5f974afe47c =  5:  b1db5fdebe5 merge-strategies.txt: do not imply using copy detection is desired
  6:  6116f4750fd !  6:  44101062e0e merge-strategies.txt: avoid giving special preference to patience algorithm
     @@ Documentation/merge-strategies.txt: theirs;;
      -	matching lines (e.g., braces from distinct functions).  Use
      -	this when the branches to be merged have diverged wildly.
      -	See also linkgit:git-diff[1] `--patience`.
     -+	Deprecated shorthand for diff-algorithm=patience.
     ++	Deprecated synonym for `diff-algorithm=patience`.
       
       diff-algorithm=[patience|minimal|histogram|myers];;
       	Use a different diff algorithm while merging, which can help
  7:  7eecf879d60 <  -:  ----------- merge-strategies.txt: explain why no-renames might be useful
  8:  010702d0841 =  7:  d1521f98dee merge-strategies.txt: fix simple capitalization error
  -:  ----------- >  8:  8978132397e git-rebase.txt: correct out-of-date and misleading text about renames
  9:  37a69fd2e0b !  9:  bc92826f7e5 Documentation: add coverage of the `ort` merge strategy
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    Documentation: add coverage of the `ort` merge strategy
     +    merge-strategies.txt: add coverage of the `ort` merge strategy
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     - ## Documentation/git-rebase.txt ##
     -@@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
     - 
     - -m::
     - --merge::
     --	Use merging strategies to rebase.  When the recursive (default) merge
     --	strategy is used, this allows rebase to be aware of renames on the
     --	upstream side.  This is the default.
     -+	Use merging strategies to rebase.  When either the `recursive`
     -+	(default) or `ort` merge strategy is used, this allows rebase
     -+	to be aware of renames on the upstream side.  This is the
     -+	default.
     - +
     - Note that a rebase merge works by replaying each commit from the working
     - branch on top of the <upstream> branch.  Because of this, when a merge
     -
       ## Documentation/merge-strategies.txt ##
      @@ Documentation/merge-strategies.txt: subtree[=<path>];;
       	is prefixed (or stripped from the beginning) to make the shape of
     @@ Documentation/merge-strategies.txt: subtree[=<path>];;
      +However, it ignores three of those options: `no-renames`,
      +`patience` and `diff-algorithm`.  It always runs with rename
      +detection (it handles it much faster than `recursive` does), and
     -+it specifically uses diff-algorithm=histogram.
     ++it specifically uses `diff-algorithm=histogram`.
      +
       resolve::
       	This can only resolve two heads (i.e. the current branch
 10:  2a7169c8c1b ! 10:  4a78ac53424 Update error message and code comment
     @@ builtin/merge.c: static int try_merge_strategy(const char *strategy, struct comm
       		for (x = 0; x < xopts_nr; x++)
       			if (parse_merge_opt(&o, xopts[x]))
      -				die(_("Unknown option for merge-recursive: -X%s"), xopts[x]);
     -+				die(_("Unknown strategy option: -X%s"), xopts[x]);
     ++				die(_("unknown strategy option: -X%s"), xopts[x]);
       
       		o.branch1 = head_arg;
       		o.branch2 = merge_remote_util(remoteheads->item)->name;

-- 
gitgitgadget
