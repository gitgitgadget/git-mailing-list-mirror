Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB26EC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 23:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC26B206F4
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 23:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmPqWXIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgFJXQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgFJXQw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 19:16:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CA9C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 16:16:52 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so4187316wrp.2
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 16:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=tKGsF7NMaPpXdwQmuYB78Nt0rv5SC/goUxEuh/mjTzo=;
        b=dmPqWXIxf5FvRgAhEta7tStpIp+PKjz/53oYLWfVXKUHPY5j4FVx+d60lg83JqMRY4
         NREierEotFUYu0OEFhFv5QGNEC622PgMEiE8q3l0Otn1fX3uo3oyhD54ta2ev7gEI8rv
         2R/7KVfK7EADF8jeQIdpFT/xUm1hUyO0wN3Mqy0x2MkYHweuCWmSu/tlKuPsSmaW0pkT
         jX+aA95A9oGvOpThmdki8YpkXfSUcEpczGlS43nBpmYCvWDNIHrZ0K7njSU/8V0KaYVh
         ZD+wlMsuIYcWKTRaloZ0IPrXyNEr5jxLPH4GDrf/R9Odbf4TquSzWJ/qYOJzWpM2leTa
         KFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tKGsF7NMaPpXdwQmuYB78Nt0rv5SC/goUxEuh/mjTzo=;
        b=VOVW2VhsHMC195KW3rcQc3PS+io51NFt1kXt2dCG9IasHkDAgD1EQQxt9hwvm3vnNl
         uBPmOy4XZZv6lb+nyNj9TnPRzY/iT3uDQUWNzyBdwCQuxqS5aO6AJFooGdc5ygjRk1Xi
         nUNSS9oPNy5CYFKiCe2XTsYiVMTYMNpoGwhvy5hAnxoJoJiiqU/7l18pPcrZpBvPt1v7
         FMCxjq2nppUsko3ZFIz9Z6eVbmJzw1NxDPVCMY7EIeEiLIVfMbLO5ihgRgGCS8JlS3n7
         K0Qyk8JK15mzJpIvVN75TADgGCC0BLqQgNSOrLaRorzY5yeEOZj1qtWg0FenfJrycUX+
         wvAQ==
X-Gm-Message-State: AOAM531v+GjvlD/kaVge8DPfhZ5aEXm28jWsz5JK/qHW7KPd/lJwueDW
        M/v8jH3FQCbSlaqmCYjYtci9GPQS
X-Google-Smtp-Source: ABdhPJzx8kmKXHj4qfk7pJIRvqnNDZMRjt6x/zwVlXjVMRMWQ+qMbhuZ3WwiOsGJHlKSsI6438XZZw==
X-Received: by 2002:a5d:4e03:: with SMTP id p3mr6301547wrt.350.1591831011034;
        Wed, 10 Jun 2020 16:16:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w10sm1920559wrp.16.2020.06.10.16.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 16:16:50 -0700 (PDT)
Message-Id: <pull.805.git.git.1591831009762.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Jun 2020 23:16:49 +0000
Subject: [PATCH] git-sparse-checkout: clarify interactions with submodules
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     matheus.bernardino@usp.br, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Ignoring the sparse-checkout feature momentarily, if one has a submodule and
creates local branches within it with unpushed changes and maybe adds some
untracked files to it, then we would want to avoid accidentally removing such
a submodule.  So, for example with git.git, if you run
   git checkout v2.13.0
then the sha1collisiondetection/ submodule is NOT removed even though it
did not exist as a submodule until v2.14.0.  Similarly, if you only had
v2.13.0 checked out previously and ran
   git checkout v2.14.0
the sha1collisiondetection/ submodule would NOT be automatically
initialized despite being part of v2.14.0.  In both cases, git requires
submodules to be initialized or deinitialized separately.  Further, we
also have special handling for submodules in other commands such as
clean, which requires two --force flags to delete untracked submodules,
and some commands have a --recurse-submodules flag.

sparse-checkout is very similar to checkout, as evidenced by the similar
name -- it adds and removes files from the working copy.  However, for
the same avoid-data-loss reasons we do not want to remove a submodule
from the working copy with checkout, we do not want to do it with
sparse-checkout either.  So submodules need to be separately initialized
or deinitialized; changing sparse-checkout rules should not
automatically trigger the removal or vivification of submodules.

I believe the previous wording in git-sparse-checkout.txt about
submodules was only about this particular issue.  Unfortunately, the
previous wording could be interpreted to imply that submodules should be
considered active regardless of sparsity patterns.  Update the wording
to avoid making such an implication.  It may be helpful to consider two
example situations where the differences in wording become important:

In the future, we want users to be able to run commands like
   git clone --sparse=moduleA --recurse-submodules $REPO_URL
and have sparsity paths automatically set up and have submodules *within
the sparsity paths* be automatically initialized.  We do not want all
submodules in any path to be automatically initialized with that
command.

Similarly, we want to be able to do things like
   git -c sparse.restrictCmds grep --recurse-submodules $REV $PATTERN
and search through $REV for $PATTERN within the recorded sparsity
patterns.  We want it to recurse into submodules within those sparsity
patterns, but do not want to recurse into directories that do not match
the sparsity patterns in search of a possible submodule.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    git-sparse-checkout: clarify interactions with submodules
    
    gitgitgadget is going to treat this like V1, but it's really V2. V1 was
    an inline scissors patch.
    
    Changes since V1:
    
     * More wording clarifications in areas pointed out by Stolee, and using
       some of his suggested wording.
     * In particular, given that the final sentence from V1 was causing lots
       of problems, I just stepped back and painted a very broad stroke for
       end users that I think will make sense to them: we have two reasons
       tracked files might be missing from the working copy, so there are
       two things that might limit commands that search through tracked
       files in the working copy. Greater detail about if or how they are
       limited can be left to the manpages of individual subcommands.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-805%2Fnewren%2Fsparse-submodule-interactions-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-805/newren/sparse-submodule-interactions-v1
Pull-Request: https://github.com/git/git/pull/805

 Documentation/git-sparse-checkout.txt | 30 +++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 1a3ace60820..c7feaeca110 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -200,10 +200,32 @@ directory.
 SUBMODULES
 ----------
 
-If your repository contains one or more submodules, then those submodules will
-appear based on which you initialized with the `git submodule` command. If
-your sparse-checkout patterns exclude an initialized submodule, then that
-submodule will still appear in your working directory.
+If your repository contains one or more submodules, then submodules
+are populated based on interactions with the `git submodule` command.
+Specifically, `git submodule init -- <path>` will ensure the submodule
+at `<path>` is present, while `git submodule deinit [-f] -- <path>`
+will remove the files for the submodule at `<path>` (including any
+untracked files, uncommitted changes, and unpushed history).  Similar
+to how sparse-checkout removes files from the working tree but still
+leaves entries in the index, deinitialized submodules are removed from
+the working directory but still have an entry in the index.
+
+Since submodules may have unpushed changes or untracked files,
+removing them could result in data loss.  Thus, changing sparse
+inclusion/exclusion rules will not cause an already checked out
+submodule to be removed from the working copy.  Said another way, just
+as `checkout` will not cause submodules to be automatically removed or
+initialized even when switching between branches that remove or add
+submodules, using `sparse-checkout` to reduce or expand the scope of
+"interesting" files will not cause submodules to be automatically
+deinitialized or initialized either.
+
+Further, the above facts mean that there are multiple reasons that
+"tracked" files might not be present in the working copy: sparsity
+pattern application from sparse-checkout, and submodule initialization
+state.  Thus, commands like `git grep` that work on tracked files in
+the working copy may return results that are limited by either or both
+of these restrictions.
 
 
 SEE ALSO

base-commit: 87680d32efb6d14f162e54ad3bda4e3d6c908559
-- 
gitgitgadget
