Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E8FC433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 19:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244157AbiANTqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 14:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbiANTqn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 14:46:43 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596B9C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 11:46:43 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id z17so7220358ilm.3
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 11:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=byEBWRAyXMoPlHr5KbdISWviSqq+qwiZQh55kLC0fDY=;
        b=NWyiWnSzLqA0hAw0ar3B9gFFEOrA/rXrYcXwmhRRCv8PIYS1VfmwrlXf9kLJ3tguwP
         pWFIAGjrD64JB607ZhJi/h1XLMFWWt7sy7fYYPKkfsfs2hdxKulVjuWLOsLWquFbQWLp
         NkOK50V5XDm89exoGcThBd9P2oMVq9J4e2turs+yS2/e1FvwtGlxqfHO7EvNlWT1vyWl
         mxwqPTnlXqahbzojVOUZQjHbGclK/HUFx10uYA+ucEaHvz4+VLPvFlls0sBthRKgy7fr
         aKxvgvzYOR/CrxKJsOV79rvfshaxeQE2nqS7UbY7BfNBZTlfD2mKlkH9amHJfzr7EQJt
         W+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=byEBWRAyXMoPlHr5KbdISWviSqq+qwiZQh55kLC0fDY=;
        b=XW/3mEZ3dvy/JlPZnIv559zpHJWeDs8B0NZZSCO4TF5LZgH9zewNJkNSei+nhCYp06
         C+uLcgqR4wKge6YKFTx53iYhdaHll3cNk2Q5riDwIQeoQz/GLMHuWqGHWR3MOvNFtx+s
         ur0F7+2kiFP/PvTqP53hr6XWlz4TLTR6smugGgMOlXhJi2+G9Wm9YKcxCOzT+FlJyHu0
         6ipYFlH30o0okTDwNU3lW9o5Pw2WKT9WD4IYlMd8Rmn/hwFSdEXCbVorBMO5NMCbcQAJ
         /G4eUWX+s0t1QcipEkY8q+fDxWyn4iZNjih1gANYBDqhfQFHrJJpaCbVTulTttjsSwiL
         CnNg==
X-Gm-Message-State: AOAM530L98oySrkfWspicaXTILFnX0bJBkbplEeJy4D7JAV5kAQmlxCv
        nX+gVLEAq8tTmRJ2VNta7qtw4V+hcvVjUQ==
X-Google-Smtp-Source: ABdhPJwj8NdzvpZr4mp9smFP3x6vu1g12MJUzDcfM+H4AbRPbhGSC7Fsw/fxz52XebFlzrQ98KOfMg==
X-Received: by 2002:a92:c681:: with SMTP id o1mr5538934ilg.23.1642189602709;
        Fri, 14 Jan 2022 11:46:42 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8sm1613031ily.67.2022.01.14.11.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 11:46:42 -0800 (PST)
Date:   Fri, 14 Jan 2022 14:46:41 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: merge-ort assertion failure
Message-ID: <YeHTIfEutLYM4TIU@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah,

A colleague reported that they were able to hit an assertion failure in
merge-ort when rebasing a topic of their back onto upstream.

The scenario (which I have been able to reproduce on a private
repository, but haven't had time to reduce further) is:

    $ git --version
    git version 2.34.1

    $ git rebase origin/master
    warning: skipped previously applied commit 9cda243afc2a
    warning: skipped previously applied commit 882bb87a3a7c
    hint: use --reapply-cherry-picks to include skipped commits
    hint: Disable this message with "git config advice.skippedCherryPicks false"
    [some "Auto-merging" messages ...]
    CONFLICT (content): Merge conflict in
    [some file]
    warning: exhaustive rename detection was skipped due to too many files.
    warning: you may want to set your merge.renamelimit variable to at least 165 and retry the command.
    Assertion failed: (renames->cached_pairs_valid_side == 0), function
    clear_or_reinit_internal_opts, file merge-ort.c, line 546.
    Abort trap: 6

Their merge.renameLimit is set pretty low at just "1", and this
assertion goes away so long as `merge.renameLimit` is set sufficiently
high.

I haven't had a chance to look into it very deeply yet. Elijah: I figure
that this is the sort of thing that may be totally obvious to you, so
I'm sharing it here in case it is.

Otherwise, I'll continue to poke at it locally and see if I can learn
anything else.

Thanks,
Taylor
