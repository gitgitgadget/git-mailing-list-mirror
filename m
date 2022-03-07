Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45772C433FE
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242518AbiCGMfS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242515AbiCGMfL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:35:11 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CC088B03
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:33:50 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso6556551wms.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cg0Mi89t11gUJ/BzBwRtWdH6/TKUryHHUl5SmmB555k=;
        b=cac1SnhgirZuBESCa0pGAHq2mkM5WFygCOLReC+08fOvnZ3gqyCKFblwaeMbv4DCA5
         hze7J8IA0JOzakae2DubpQeRLW+QOIJBPnszQGrPGtgpuW86cOTEgZQEEWhNpm/3SeL2
         FHoBxNAqx/lNkge4MydnqESZ4xygjxjjTYJhQsyKRjToQgTI/XC+u8haQWcAiL7bKiWd
         K6j9zUX44/WcmrPjrHyyI8IDh0QyU03YSphOvHvMVeVvXjEZ9oW9mX8hwTIRFQ6EW1zB
         AnxVKPi1+KLln315ELWFIWMJgW+yUXCcYlaEvpb6hvVevBj+BmuvCfdzy18wZHIvnyaU
         cJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cg0Mi89t11gUJ/BzBwRtWdH6/TKUryHHUl5SmmB555k=;
        b=GuVAA3qzq27MsHkIqUCJ0GYgGezeqyNCZM6t3aulnOvrvVph+hZdk4077QG7WGK+E7
         FIroN4M3uceudtSZ0d7ui3bFJDyxAkdeXu4Jek83fIAcAAuWpNHSspEAYQdAsS1hO8Ab
         rJfhUoRAhLAN0KrsoF1Uzg5BsLe80ojEXnzw2YbRknuSv0BATi/kex5dhVnQq77+9VVw
         mt6CMKGjspDUgnGJEEdKI/4ceD+Ld6eG5sXyMRy1ZbBcdObG+5PRWg7zR37d8D8qSTLn
         tJwF4OrwcKc5CODU9GWsI8GysUHWnwQ0Qhz/nuVtLdMB3/1b/lbFcO84arwOGtlU0AW3
         CR4A==
X-Gm-Message-State: AOAM531zfeKE5Hc9picdvvxX1Ysrr6ETXT8Qpp2taCMnikrWS4Pf/TGw
        AwA+kUM8jtWNDFCXh0PP+3geZyX6nJSsJw==
X-Google-Smtp-Source: ABdhPJwH7tWjmZY/qlzTmdvAgJ/ipIwIEKdq1XNA9RI00LRB6ZHb/RXcDAZ1QQbh/y7n8xYzSbyJNw==
X-Received: by 2002:a1c:f718:0:b0:380:ed20:6557 with SMTP id v24-20020a1cf718000000b00380ed206557mr18456449wmh.53.1646656428678;
        Mon, 07 Mar 2022 04:33:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c4f8400b00380e45cd564sm13657012wmq.8.2022.03.07.04.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:33:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] hooks: fix a race in hook execution
Date:   Mon,  7 Mar 2022 13:33:44 +0100
Message-Id: <cover-v2-0.2-00000000000-20220307T123244Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-0.2-00000000000-20220218T203834Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220218T203834Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A documentation & commit-message only change to this v1 which fixes an
obscure race condition in hook execution. For v1 see:
https://lore.kernel.org/git/cover-0.2-00000000000-20220218T203834Z-avarab@gmail.com/

Junio: This topic wasn't picked up yet, but hopefully will be with the
below, which should address coments you & Taylor had on the v1.

Ævar Arnfjörð Bjarmason (2):
  merge: don't run post-hook logic on --no-verify
  hooks: fix an obscure TOCTOU "did we just run a hook?" race

 builtin/commit.c       | 18 +++++++++++-------
 builtin/merge.c        | 28 +++++++++++++++++-----------
 builtin/receive-pack.c |  8 +++++---
 commit.c               |  2 +-
 commit.h               |  3 ++-
 hook.c                 |  7 +++++++
 hook.h                 | 12 ++++++++++++
 sequencer.c            |  4 ++--
 8 files changed, 57 insertions(+), 25 deletions(-)

Range-diff against v1:
1:  9b5144daee6 ! 1:  8f7b01ed758 merge: don't run post-hook logic on --no-verify
    @@ Commit message
         hand. There's no point in invoking discard_cache() here if the hook
         couldn't have possibly updated the index.
     
    +    It's buggy that we use "hook_exist()" here, and as discussed in the
    +    subsequent commit it's subject to obscure race conditions that we're
    +    about to fix, but for now this change is a strict improvement that
    +    retains any caveats to do with the use of "hooks_exist()" as-is.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/merge.c ##
2:  d01d088073b ! 2:  9d16984898c hooks: fix a TOCTOU in "did we run a hook?" heuristic
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    hooks: fix a TOCTOU in "did we run a hook?" heuristic
    +    hooks: fix an obscure TOCTOU "did we just run a hook?" race
     
         Fix a Time-of-check to time-of-use (TOCTOU) race in code added in
         680ee550d72 (commit: skip discarding the index if there is no
         pre-commit hook, 2017-08-14).
     
    -    We can fix the race passing around information about whether or not we
    -    ran the hook in question, instead of running hook_exists() after the
    -    fact to check if the hook in question exists. This problem has been
    +    This obscure race condition can occur if we e.g. ran the "pre-commit"
    +    hook and it modified the index, but hook_exists() returns false later
    +    on (e.g., because the hook itself went away, the directory became
    +    unreadable, etc.). Then we won't call discard_cache() when we should
    +    have.
    +
    +    The race condition itself probably doesn't matter, and users would
    +    have been unlikely to run into it in practice. This problem has been
         noted on-list when 680ee550d72 was discussed[1], but had not been
         fixed.
     
    -    In addition to fixing this for the pre-commit hook as suggested there
    -    I'm also fixing this for the pre-merge-commit hook. See
    -    6098817fd7f (git-merge: honor pre-merge-commit hook, 2019-08-07) for
    -    the introduction of its previous behavior.
    +    This change is mainly intended to improve the readability of the code
    +    involved, and to make reasoning about it more straightforward. It
    +    wasn't as obvious what we were trying to do here, but by having an
    +    "invoked_hook" it's clearer that e.g. our discard_cache() is happening
    +    because of the earlier hook execution.
     
         Let's also change this for the push-to-checkout hook. Now instead of
         checking if the hook exists and either doing a push to checkout or a
    @@ Commit message
         This leaves uses of hook_exists() in two places that matter. The
         "reference-transaction" check in refs.c, see 67541597670 (refs:
         implement reference transaction hook, 2020-06-19), and the
    -    prepare-commit-msg hook, see 66618a50f9c (sequencer: run
    +    "prepare-commit-msg" hook, see 66618a50f9c (sequencer: run
         'prepare-commit-msg' hook, 2018-01-24).
     
         In both of those cases we're saving ourselves CPU time by not
    @@ Commit message
         don't have the hook. So using this "invoked_hook" pattern doesn't make
         sense in those cases.
     
    -    More importantly, in those cases the worst we'll do is miss that we
    -    "should" run the hook because a new hook appeared, whereas in the
    -    pre-commit and pre-merge-commit cases we'll skip an important
    -    discard_cache() on the bases of our faulty guess.
    -
    -    I do think none of these races really matter in practice. It would be
    -    some one-off issue as a hook was added or removed. I did think it was
    -    stupid that we didn't pass a "did this run?" flag instead of doing
    -    this guessing at a distance though, so now we're not guessing anymore.
    +    The "reference-transaction" and "prepare-commit-msg" hook also aren't
    +    racy. In those cases we'll skip the hook runs if we race with a new
    +    hook being added, whereas in the TOCTOU races being fixed here we were
    +    incorrectly skipping the required post-hook logic.
     
         1. https://lore.kernel.org/git/20170810191613.kpmhzg4seyxy3cpq@sigill.intra.peff.net/
     
    @@ hook.h: struct run_hooks_opt
     +
     +	/**
     +	 * A pointer which if provided will be set to 1 or 0 depending
    -+	 * on if a hook was invoked (i.e. existed), regardless of
    -+	 * whether or not that was successful. Used for avoiding
    -+	 * TOCTOU races in code that would otherwise call hook_exist()
    -+	 * after a "maybe hook run" to see if a hook was invoked.
    ++	 * on if a hook was started, regardless of whether or not that
    ++	 * was successful. I.e. if the underlying start_command() was
    ++	 * successful this will be set to 1.
    ++	 *
    ++	 * Used for avoiding TOCTOU races in code that would otherwise
    ++	 * call hook_exist() after a "maybe hook run" to see if a hook
    ++	 * was invoked.
     +	 */
     +	int *invoked_hook;
      };
-- 
2.35.1.1242.gfeba0eae32b

