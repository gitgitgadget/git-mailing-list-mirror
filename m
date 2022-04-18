Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E665BC433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 18:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347366AbiDRSSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 14:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiDRSSR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 14:18:17 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9554BC1
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 11:15:36 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso17540pju.1
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 11:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=sGCNw26sVjbbvJrSN8TXewjwqQWKiv3Za1iqXGjkYws=;
        b=muc4x69DD3KSyZhcO8p/PIYT+HOjWuYfb9b3AOgQpatBgQ2oXe/PAXhoIlZK5L/TBg
         qkW0icOmwdVCDyORgTEUgkBn1f1HuqlmIczejY4mDxRT00hSidUpBSKyQBMG5djp+mPd
         LDDk3QqXpEicS0KNp0dbjt0CPxN7MGJg3nMjZ46/7/+5iIV5AeIBk5g2z4cXVAzCbcmn
         77cTfYQq5YEkaNfCSZHXhtO1Xkyr8KRa/wHvL0tQaUfCu/3I/p14wG2fr8ZmZXUWJrXA
         uZ2Qasp7cYyUyPTWK77A0frDS9NYy2tdKUA5fQfyAHWXllWmX5JtWGuxbtp/r6r2oBcF
         2rUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=sGCNw26sVjbbvJrSN8TXewjwqQWKiv3Za1iqXGjkYws=;
        b=tY62MSS5YlNyqKvUXe/YJT5caVsTVcRqnNUsLXCG0QSJb6sEVoIU1oZuflUMv4/EtF
         ge4nSl2RdwilM+C4yfYBztkXJ/BOIuzCAexxnZlv2Tz2LjcN4mLv5c/w2AOqKLYu8cub
         8+2ey++6HazvcDllZQV02T9fBTD1TuinWZ9HwEiKUbogNsErwZMEF5GY4dDX8I8WIPKf
         kWJ870K5/BdkEbxH1lvqx85j3cCQIiuvAQeAkOZhLEWbTTM3FiuvXyS4H3kgwctL6fvX
         FZdvFpb1PiWPJUGycmG1vmonN7supTPv4aOOe3+Hjbs24UI6VM6n9m0EtwUyF7bM3p+6
         0/UA==
X-Gm-Message-State: AOAM531f/UkOIuGjLdLzg3iIU7twjllBADg2ANuRE0IptkQCzviiqikj
        i1fVB1bh7k3idRATkvMz0PLxByo24+BKWg==
X-Google-Smtp-Source: ABdhPJw5WU+Z+gawXHg5Yhu4T3zsuZhjxJttst8ZQfwE+LX16Cdm3rkmDvvbnwO6CzBRPDH0MgSQ+Q==
X-Received: by 2002:a17:902:f60e:b0:158:5c4d:d9b0 with SMTP id n14-20020a170902f60e00b001585c4dd9b0mr12076074plg.63.1650305736040;
        Mon, 18 Apr 2022 11:15:36 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ab4d:a27d:4699:2552])
        by smtp.gmail.com with ESMTPSA id v16-20020a62a510000000b0050759c9a891sm12995736pfm.6.2022.04.18.11.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 11:15:35 -0700 (PDT)
Date:   Mon, 18 Apr 2022 11:15:28 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] merge: new autosetupmerge option 'simple' for
 matching branches
Message-ID: <Yl2qwO0SMPOhb5h9@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Tao Klerks <tao@klerks.biz>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com>
 <pull.1161.v4.git.1647843442911.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1161.v4.git.1647843442911.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.03.21 06:17, Tao Klerks via GitGitGadget wrote:
> From: Tao Klerks <tao@klerks.biz>
> 
> With the default push.default option, "simple", beginners are
> protected from accidentally pushing to the "wrong" branch in
> centralized workflows: if the remote tracking branch they would push
> to does not have the same name as the local branch, and they try to do
> a "default push", they get an error and explanation with options.
> 
> There is a particular centralized workflow where this often happens:
> a user branches to a new local feature branch from an existing
> upstream branch, eg with "checkout -b feature1 origin/master". With
> the default branch.autosetupmerge configuration (value "true"), git
> will automatically add origin/master as the remote tracking branch.
> 
> When the user pushes with "git push", they get an error, and (amongst
> other things) a suggestion to run "git push origin HEAD". Eventually
> they figure out to add "-u" to change the tracking branch, or they set
> push.default to "current", or some tooling does one or the other of
> these things for them.
> 
> When one of their coworkers works on the same branch, they don't get
> any of that weirdness. They just "git checkout feature1" and
> everything works exactly as they expect, with the shared remote branch
> set up as remote tracking branch, and push and pull working out of the
> box.
> 
> The "stable state" for this way of working is that local branches have
> the same-name remote tracking branch (origin/feature1 in this
> example), and multiple people can work on that remote feature branch
> at the same time, trusting "git pull" to merge or rebase as required
> for them to be able to push their interim changes to that same feature
> branch on that same remote.
> 
> (merging from the upstream "master" branch, and merging back to it,
> are separate more involved processes in this flow).
> 
> There is a problem in this flow/way of working, however, which is that
> the first user, when they first branched from origin/master, ended up
> with the "wrong" remote tracking branch (different from the stable
> state). For a while, before they pushed (and maybe longer, if they
> don't use -u/--set-upstream), their "git pull" wasn't getting other
> users' changes to the feature branch - it was getting any changes from
> the remote "master" branch instead (a completely different class of
> changes!)
> 
> Any experienced git user will presumably say "well yeah, that's what
> it means to have the remote tracking branch set to origin/master!" -
> but that user didn't *ask* to have the remote master branch added as
> remote tracking branch - that just happened automatically when they
> branched their feature branch. They didn't necessarily even notice or
> understand the meaning of the "set up to track 'origin/master'"
> message when they created the branch - especially if they are using a
> GUI.
> 
> Looking at how to fix this, you might think "OK, so disable auto setup
> of remote tracking - set branch.autosetupmerge to false" - but that
> will inconvenience the *second* user in this story - the one who just
> wanted to start working on the feature branch. The first and second
> users swap roles at different points in time of course - they should
> both have a sane configuration that does the right thing in both
> situations.
> 
> Make these flows painless by introducing a new branch.autosetupmerge
> option called "simple", to match the same-name "push.default" option
> that makes similar assumptions.
> 
> This new option automatically sets up tracking in a *subset* of the
> current default situations: when the original ref is a remote tracking
> branch *and* has the same branch name on the remote (as the new local
> branch name).
> 
> With this new configuration, in the example situation above, the first
> user does *not* get origin/master set up as the tracking branch for
> the new local branch. If they "git pull" in their new local-only
> branch, they get an error explaining there is no upstream branch -
> which makes sense and is helpful. If they "git push", they get an
> error explaining how to push *and* suggesting they specify
> --set-upstream - which is exactly the right thing to do for them.
> 
> This new option is likely not appropriate for users intentionally
> implementing a "triangular workflow" with a shared upstream tracking
> branch, that they "git pull" in and a "private" feature branch that
> they push/force-push to just for remote safe-keeping until they are
> ready to push up to the shared branch explicitly/separately. Such
> users are likely to prefer keeping the current default
> merge.autosetupmerge=true behavior, and change their push.default to
> "current".

I think this is a good solution for relatively inexperienced users, and
I don't see any issues with the implementation or tests. However, I
wonder how users for whom this may be useful are going to discover this
option? I don't expect that such users are going to be watching Git's
release notes looking for new features such as this, or carefully
reading documentation changes.

In the discussion on v3 of this series, you mentioned you were thinking
about adding an advice setting to point users here; is there a reason
why that didn't make it into v4? It seems appropriate to me to add one,
perhaps at the point where a user with "autosetupmerge=true" would run
into a failure when trying to push?
