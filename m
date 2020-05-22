Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E24C433E0
	for <git@archiver.kernel.org>; Fri, 22 May 2020 14:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFFC722B39
	for <git@archiver.kernel.org>; Fri, 22 May 2020 14:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSs03fgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgEVO0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 10:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbgEVO0X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 10:26:23 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEE6C061A0E
        for <git@vger.kernel.org>; Fri, 22 May 2020 07:26:23 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id i22so9422995oik.10
        for <git@vger.kernel.org>; Fri, 22 May 2020 07:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w3jGOVOlyEv2SG43sKfJvf9EIaVIzeJ9QH4h7jnW530=;
        b=YSs03fgt6GBIs4eI1IWV0IWVrE4vXnQ8UGudwt2tazmYmhgxKnVQ2Gsf7o8txkyQkz
         TqSkZh9B/Y7LtXOhFNoHO2Mm17kMHMDA832fKah+kGAnpgE8iN39wrG1goo7/gnfyPEe
         5AfqP3KR5OFRIi+c/oqfNHpqG3GnPpSYKG/GPxkgAfpiVRQ7F6wBpSxO7eJUlE6Qtxyu
         HqXYjbbSWCXernEQdtkWdkLXVypipt1rlfH5A28uZ2h3XKCA2cHqz4dmOs7T8g37rPOB
         c595yuvL9aXyFLA4XmQyeG6UwlqauG8XJaZFbMQvn2ncP6XkJQa8vj3wtNrRPKbNUL2s
         duxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w3jGOVOlyEv2SG43sKfJvf9EIaVIzeJ9QH4h7jnW530=;
        b=aqXjmOZSbMkFzIh5CwHLkTNv2LRbX7yH55MS8LYJgrqbvH1mgKz5xxa9rRzpWc2gWO
         MZpGteKM62peQBEB6+1lTppVQtAdfE+EQG9kvGdgMCjRFDZnxUC/TmK7Zi6XT73QBNst
         Qdv0KkW/a7BNcQ2+IAkbf1HSOXEq7lrJr5FJ/gXCfmdRQRV7wMDw2y/+SO6ceNdEE5fM
         fNqRCs7P694/KMkthPFZlRHnMLG5tg3R7UziZORBKlXx7AOhHgjE+PQrQdPtiWmEvknE
         W/Wd7AB/G5aKxsKnj9ACk/cEFRzsRvypLih7d0JwHqO0pVPWVsdwbBLVcDg4g8JSeWCP
         t3Yw==
X-Gm-Message-State: AOAM531311HnlJ+s+ztBx5q61lFRph75Q7VOCw0M2CgGtxPTPI/M28ZW
        UuteaalylDH4o8dn/k/d96M=
X-Google-Smtp-Source: ABdhPJz33HK+M1P8BIQO/uq/PCTUzfkx0bW5moqBQvgPOUGIFD7C2wYWhfJXMUeVP+gXiv/KxMIvUQ==
X-Received: by 2002:aca:dfc5:: with SMTP id w188mr2743818oig.7.1590157582272;
        Fri, 22 May 2020 07:26:22 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id t4sm2498684ooa.40.2020.05.22.07.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 07:26:21 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [RFC PATCH v2 3/4] grep: honor sparse checkout patterns
Date:   Fri, 22 May 2020 07:26:11 -0700
Message-Id: <20200522142611.1217757-1-newren@gmail.com>
X-Mailer: git-send-email 2.26.1.250.g8bb771e84c
In-Reply-To: <CAHd-oW7_6+Jv+SQG3qh8eRjwJmqnRJKs=_bAV3WaC4-SKkoywg@mail.gmail.com>
References: <CAHd-oW7_6+Jv+SQG3qh8eRjwJmqnRJKs=_bAV3WaC4-SKkoywg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Thu, May 21, 2020 at 10:49 PM Matheus Tavares Bernardino <matheus.bernardino@usp.br> wrote:
>
> On Thu, May 21, 2020 at 2:52 PM Elijah Newren <newren@gmail.com> wrote:
> >
<snip>
> > Good to know.  To up the ante a bit: What if another branch has
> > directory that doesn't exist in HEAD or the current checkout, and
> > within that directory is a submodule.  Would it be recursed into?
>
> In this case, `git grep --recurse-submodules <pattern> $branch` will
> recurse into the submodule, but only if it has already been
> initialized. I.e. if we have checked out to $branch, ran `git
> submodule init` and then checked out back.
>
> > What if it matched the sparsity paths?  (Is it even possible to
> > recurse into it?)
>
> That's a great question. The idea that I tried to implement is to
> always recurse into _initialized_ submodules (even the ones excluded
> by the superproject's sparsity patterns) and, then, follow their own
> sparsity patterns inside. I'm not necessarily in favor (or against)
> this behavior, but this seemed to be the most compatible way with the
> design we describe in our docs:
>
> "If your sparse-checkout patterns exclude an initialized submodule,
> then that submodule will still appear in your working directory." (in
> git-sparse-checkout.txt)
>
> So, back to the original question, if you run `git grep
> --recurse-submodules <pattern> $branch` and $branch contains a
> submodule which was previously initialized, git-grep _would_ recurse
> into it, even if it (or its parent dir) was excluded. However, your
> question helped me notice an inconsistency in my patch: the behavior I
> just described is working for the full pattern set, but not in cone
> mode. That's because, in cone mode, we can mark the whole submodule's
> parent dir as excluded. Then, path_matches_pattern_list() will return
> NOT_MATCHED for the parent dir and we won't recurse into it, so we
> won't even get to the submodule's path to discover that it refers to a
> gitlink.
>
> Therefore, if we decide to keep the behavior of always recursing into
> submodules, we will need some extra work for the cone mode. I.e.
> grep_tree() will have to check if NOT_MATCHED directories contain
> submodules before discarding them, and recurse only into the
> submodules if so. As for the implementation, the first idea that came
> to my mind was to list the submodules' pathnames and do prefix
> matching for each submodule and NOT_MATCHED dir. But the places I've
> seen such submodule listings in the code base so far [1] seem to work
> only in the current branch. My second idea was to continue the tree
> walk when we hit NOT_MATCHED dir entries, but not doing any work, just
> looking for possible gitlinks to recurse into. I'm not sure if that
> could negatively affect the execution time, though.
>
> Does this seem like a good approach? Or is there another solution that
> I have not considered? Or even further, should we choose to skip the
> submodules in excluded paths? My only concern in this case is that it
> would be contrary to the design in git-sparse-checkout.txt. And the
> working tree grep and cached grep would differ even on a clean working
> tree.

To be honest, I think it sounds insane.  What you propose does make
sense if you take what was written in git-sparse-checkout.txt very
literally and as though it was a core design principle meant to cover
all cases but I do not think it merits such a standing at all.  I
think it should be treated as a first draft attempt to explain
interactions that was written solely with the 'checkout' case in mind,
especially since it was written at the same approximate time that this
was written earlier in the same file:

    THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR, AND THE BEHAVIOR OF
    OTHER COMMANDS IN THE PRESENCE OF SPARSE-CHECKOUTS, WILL LIKELY
    CHANGE IN THE FUTURE.

Anyway, the wording in that file seems to be really important, so
let's fix it.

-- >8 --
Subject: [PATCH] git-sparse-checkout: clarify interactions with submodules

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
 Documentation/git-sparse-checkout.txt | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index c0342e5393..7dde2d330c 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -190,10 +190,23 @@ directory.
 SUBMODULES
 ----------
 
-If your repository contains one or more submodules, then those submodules will
-appear based on which you initialized with the `git submodule` command. If
-your sparse-checkout patterns exclude an initialized submodule, then that
-submodule will still appear in your working directory.
+If your repository contains one or more submodules, then those submodules
+will appear based on which you initialized with the `git submodule`
+command.  Submodules may have additional untracked files or code stored on
+other branches, so to avoid data loss, changing sparse inclusion/exclusion
+rules will not cause an already checked out submodule to be removed from
+the working copy.  Said another way, just as `checkout` will not cause
+submodules to be automatically removed or initialized even when switching
+between branches that remove or add submodules, using `sparse-checkout` to
+reduce or expand the scope of "interesting" files will not cause submodules
+to be automatically deinitialized or initialized either.  Adding or
+removing them must be done as a separate step with `git submodule init` or
+`git submodule deinit`.
+
+This may mean that even if your sparsity patterns include or exclude
+submodules, until you manually initialize or deinitialize them, commands
+like grep that work on tracked files in the working copy will ignore "not
+yet initialized" submodules and pay attention to "left behind" ones.
 
 
 SEE ALSO
-- 
2.26.1.250.g8bb771e84c

