Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06218C433FE
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 04:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345719AbiBIEHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 23:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346229AbiBIDXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 22:23:09 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3095C061576
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 19:23:08 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so1022933ooi.7
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 19:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CSbokhFN9Xh4oAKnXJv5pnd7Xqhkh7GmltkXSBhyKio=;
        b=BOt/Af2dm4ovVsaShCLsWIKWS3eyojw7uk06Po4Jl/qX06bKVkbolPfOr8XlG0GK1A
         vY20qc92YvYcWtKq4Ga6hhXqq15lLYl7fv0art8vuNcTmDCUve/bzarrJZrQUpwSXCeJ
         PvqK0wca8jV6ZRgFR8FNrM5YBdkdHraIgHV05MCfbavVUGJTRrO289br2ubRBfUkwcrS
         ZsRxYdPZuDfuQDkzu74eXcUB7nJsLIfshGt7DdQFcMtxL5UI5MGotGqMN0Uiz0EjCYi3
         ep1yKo5x7dtiiP/wCQbmjg6cZMrXXR68bt1xKG3mNITHguDoi1GnN07tAwknjkitvEDi
         O5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CSbokhFN9Xh4oAKnXJv5pnd7Xqhkh7GmltkXSBhyKio=;
        b=XakujMImOD4kNrSU2pYamXUqOL8iVxP0rU85kMgB81NYQDvJBpcLFsighlkqU+8R6w
         vRzEyFe4J1w1t5gcu0Mu+EiA9RYdddmkNNfoE0GPWoApbDcKJZPamm27YTINy8EumIzX
         +d/WL/QzxgKagqUHKazdFIxesbQVVQNtomOvqHnu+MQlxSctTfakciYKpuYFBA6mFPjL
         XYajS7LlG+O4vGjEyM/VP8kv+R0kEbgeTQBL6iw8jzQ/CZ/OvquFxdUVXiX55b/FNAkf
         WWZUDBf5hi/92rFthM/N9mS5lKYKXTlEaz8T+LKk+xbmUL9lp4GEFg87vlQTK9576Cam
         EEmg==
X-Gm-Message-State: AOAM5317hZDIHbyC58k+urOFWBSK/n9LqlZMEtbX28P7XcCaj5k8CD4l
        BNIfG+3RzKpcdIx66MdYcx96YBwyc7n/Tg==
X-Google-Smtp-Source: ABdhPJxaWEYj6fyZyi0N5Bi6G+nmz0BH6cLKSlSau4FNsUrGys240Lo2w0KkhJYTL/TWNtxToKlM5w==
X-Received: by 2002:a05:6870:e6d2:: with SMTP id s18mr317566oak.188.1644376988096;
        Tue, 08 Feb 2022 19:23:08 -0800 (PST)
Received: from iron-rod.attlocal.net (99-162-144-169.lightspeed.sntcca.sbcglobal.net. [99.162.144.169])
        by smtp.gmail.com with ESMTPSA id 100sm6092824oth.75.2022.02.08.19.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:23:07 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     Randall Becker <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Subject: Re: [Possible Bug] sparse-checkout disable followed by re-init
Date:   Tue,  8 Feb 2022 19:22:51 -0800
Message-Id: <20220209032251.4060572-1-newren@gmail.com>
X-Mailer: git-send-email 2.34.0.56.g7b2094130e
In-Reply-To: <047901d81c09$1fc30eb0$5f492c10$@nexbridge.com>
References: <047901d81c09$1fc30eb0$5f492c10$@nexbridge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Randall,

On Tue, 7 Feb 2022 04:57:26 -0500, Randall Becker wrote:

> Hi All,
> 
> I noticed a change at 2.35.1 regarding sparse-checkout and am wondering
> whether I am just missing something:
> 
> 1. Create upstream.
> 2. Clone with --no-checkout --depth=1 --filter=blob:none

A quick aside:

You may want to use --sparse instead of --no-checkout.  The fact that
there is no checkout and no index, has caused problems in combination
with sparse checkouts before.  In particular, a --no-checkout state is
hard to distinguish from the user intentionally deleted all files and
staging that deletion (i.e. a `git rm -rf .`).  Obviously,
sparse-checkout shouldn't be undeleting files when the user has staged
those deletions, so this is just a confusing state.

The --sparse flag exists for jumping straight into a sparse-checkout after
the clone.

That said, you suggested that things were fine before your first
disable, and my testing of your description seemed to suggest that
there wasn't a problem here.  I'd still recommend using --sparse over
--no-checkout when you want sparse checkouts, though.

> 3. sparse-checkout init
> 4. sparse-checkout set, with a pattern
> 5. sparse-checkout list
> 6. checkout master
> 7. sparse-checkout reapply
> 8. sparse-checkout add (up to here, everything is fine, the working area is
> consistent with the sparsity patterns)
> 9. sparse-checkout disable (the disable works - I think)

You can verify with `git ls-files -t`, and looking in the working directory.
Both to make sure that the appropriate files are marked with `H` or `S`, and
that the working directory matches that specification.

> 10. sparse-checkout list reports fatal: this worktree is not sparse, which
> is new in 2.35.1. In 2.34.1, the sparse patterns are reported without error.
> I think this is incorrect behaviour because the sparse patterns are still
> configured.
> Then I try to recover

Yeah, I'd agree that's incorrect behavior from 2.34.1; there are no
active sparsity patterns and we shouldn't mislead by listing them.
See 45c5e47048 ("sparse-checkout: add sanity-checks on initial
sparsity state", 2021-12-14) for where the fix was made.

> 11. sparse-checkout init (seems to work - no errors)
> 12. sparse-checkout list (correctly reports what was previously set/add)
> 13. sparse-checkout reapply (does nothing apparent - the objects that added
> to the working area during the disable are still there. My assumption was
> that the files not matching the sparsity patterns would be pruned).

I would presume that'd be done at the `init` step.  Indeed that's what I
observed creating a script that did:

    mkdir testing
    cd testing
    $GIT clone --no-checkout --depth=1 --filter=blob:none file:///home/newren/floss/git
    cd git
    $GIT sparse-checkout init
    $GIT sparse-checkout set Documentation
    $GIT sparse-checkout list
    $GIT checkout replay
    $GIT sparse-checkout reapply
    $GIT sparse-checkout add ci
    $GIT status
    $GIT sparse-checkout disable
    $GIT sparse-checkout list
    $GIT sparse-checkout init
    $GIT status
    $GIT sparse-checkout reapply
    $GIT status
    $GIT --version

And, in fact the `$GIT status` line at the end reported for me (with
either git version)

   You are in a sparse checkout with 21% of tracked files present.

And a `ls` showed only `Documentation` and `ci` directories.

The only differences in output for that script for me with git-2.34.1
and git-2.35.1 was the error message when calling `$GIT
sparse-checkout list` after the disable step, and the version number
printed at the end.

> The .git/config is:
> [core]
>         repositoryformatversion = 1
>         filemode = true
>         bare = false
>         logallrefupdates = true
> [remote "origin"]
>         url = file:///home/randall/stuff/src.git
>         fetch = +refs/heads/master:refs/remotes/origin/master
>         promisor = true
>         partialclonefilter = blob:none
> [branch "master"]
>         remote = origin
>         merge = refs/heads/master
> [extensions]
>         worktreeConfig = true
> 
> My question is, from this point, is there a way to recover the sparsity of
> the working index (which I expect), or do I have to clone again (not
> desirable).

I'm guessing from your wording that `git ls-files -t` will show a 'S' status
for the files you don't want to be present in the working tree, but they are
present in the working tree anyway?  I can't duplicate with your instructions
here; it seems like there's some other step involved.  However, there are
certainly a variety of ways to get into this problematic state.  And, sadly,
not a lot of good ways to discover that you have gotten into this state or
tools for getting out of it.

Fixing this class of problems was the purpose of:
  https://lore.kernel.org/git/pull.1114.v2.git.1642175983.gitgitgadget@gmail.com/
which is still waiting to merge down.

> This seems like a functional change.

The only functional change I could duplicate from your description was
the `git sparse-checkout list` behavior, which was an intentional
change.  I suspect there's some other command you ran or maybe an
ill-timed Ctrl-C that got you into the weird state; can you find a
consistent way to reproduce?

> What is weird to me is that
> I did not expect a worktreeConfig=true in this situation.

We've been setting that with sparse-checkout since the command was
introduced (see commit bab3c35908 ("sparse-checkout: create 'init'
subcommand", 2019-11-21)); and is documented in the sparse-checkout
manual.  That's not new at all.


Hope that helps,
Elijah
