Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6177FC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 20:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240216AbhKWUL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 15:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbhKWUL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 15:11:26 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CE8C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 12:08:18 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso287902pjb.0
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 12:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eo7fLiiHIHZ2JtCBUb3bfBPO4OkHLO5qqNsgaWolgOg=;
        b=XDAZGxN/mzL8BOZMMjJH2RqljSl7Bvfl28GHkOOddgsTADJp52+sEMhCvMuNqj3lwr
         c0lFfTwB0f5oiawmn7G+WIUjYGoyznHzK4WA27GhjHnAW5/OpnG+5IwUBtt9KHDeFOph
         1VoElJZuZkggWZGmappPZ+6mPoqDL6kkgKINuaZyNvAYGi/PozsDPmrzQtvMAFjPBint
         DpKOURIjgDrHOFI3RiUEEl3xaLj6HadDiGHl2uMhGzHqEy8uXUhtcs1no3P7F0PBpK3Y
         F3+ZZkVfFwHGmJhFk4bxa17WWg4EC11Qfwd+9yA5KbCSwID2k9j0C1OAxShrwe/IyTJJ
         jILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eo7fLiiHIHZ2JtCBUb3bfBPO4OkHLO5qqNsgaWolgOg=;
        b=f8QUjUb7aePDD6+y8ch3rDJSlHMWzwo6JYzoPoTA2ZdTILlMVobgpmLIb6WHckzi+o
         QJOUpP7nmbFC5pZehiuf+747W70ibvNM9JrxPIEDNSP5E0GoE0hlct4Ll93bgC/g3WSI
         x+HmaEkY1fF10b54sLxJQMQ7pSLANbupRxE8Gnha7OcJwGMVYW42PLyJp82aUK6ydnp5
         8Xd5la7VtVtQpVnXGywaeglIk9oS36fOXhPboqZJDv4h0bUZztczA+C4xp0W2Pq91L57
         mleGyaaZIPNX6i7chFzaQ3QewbizRNP+kDwHzSFkxaLHfxxPWIaAXTx3lpHmykd0lBLN
         6k5w==
X-Gm-Message-State: AOAM530ZYdDJLwTgLW/iCeCsXOE9EXaGGYtEnAjM4Kj937SaMb823/yt
        PCGwCEF4VyGxVC+B7ierJkSQqg==
X-Google-Smtp-Source: ABdhPJyrbivbL3CqqSSX2b7LZ4+90sJOVQhpqbDqaqw9lRzk1ikFXgyKsL/Z/ZgqK7IiqF+Kmz3WRQ==
X-Received: by 2002:a17:902:b411:b0:143:6fe8:c60e with SMTP id x17-20020a170902b41100b001436fe8c60emr10382861plr.41.1637698097263;
        Tue, 23 Nov 2021 12:08:17 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:89f5:ea70:7aea:ec19])
        by smtp.gmail.com with ESMTPSA id hk18sm2172784pjb.20.2021.11.23.12.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 12:08:16 -0800 (PST)
Date:   Tue, 23 Nov 2021 12:08:12 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [RFC PATCH 0/2] submodule: test what happens if
 submodule.superprojectGitDir isn't around
Message-ID: <YZ1KLNwsxx7IR1+5@google.com>
References: <20211117005701.371808-1-emilyshaffer@google.com>
 <RFC-cover-0.2-00000000000-20211117T113134Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <RFC-cover-0.2-00000000000-20211117T113134Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 12:43:38PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Nov 16 2021, Emily Shaffer wrote:
> 
> > [...]
> > A couple things. Firstly, a semantics change *back* to the semantics of
> > v3 - we map from gitdir to gitdir, *not* from common dir to common dir,
> > so that theoretically a submodule with multiple worktrees in multiple
> > superproject worktrees will be able to figure out which worktree of the
> > superproject it's in. (Realistically, that's not really possible right
> > now, but I'd like to change that soon.)
> >
> > Secondly, a rewording of comments and commit messages to indicate that
> > this isn't a cache of some expensive operation, but rather intended to
> > be the source of truth for all submodules. I also added a fifth commit
> > rewriting `git rev-parse --show-superproject-working-tree` to
> > demonstrate what that means in practice - but from a practical
> > standpoint, I'm a little worried about that fifth patch. More details in
> > the patch 5 description.
> >
> > I did discuss Ævar's idea of relying on in-process filesystem digging to
> > find the superproject's gitdir with the rest of the Google team, but in
> > the end decided that there are some worries about filesystem digging in
> > this way (namely, some ugly interactions with network drives that are
> > actually already an issue for Googler Linux machines). Plus, the allure
> > of being able to definitively know that we're a submodule is pretty
> > strong. ;) But overall, this is the direction I'd prefer to keep going                                                                                                                          
> > in, rather than trying to guess from the filesystem going forward.
> 
> Did you try running the ad-hoc benchmark I included in [1] on that
> Google NFS? I've dealt with some slow-ish network filesystems, but if
> it's slower than AIX's local FS (where I couldn't see a difference) I'd
> put money on it being a cross-Atlantic mount or something :)
> 
> Re your:
> 
>     "this isn't a cache of some expensive operation, but rather intended to                                                                                                                          be the source of truth for all submodules."
> 
> In your 5/5 it says, in seeming contradiction to this:
> 
>     This commit may be more of an RFC - to demonstrate what life looks like
>     if we use submodule.superprojectGitDir as the source of truth. But since
>     'git rev-parse --show-superproject-working-tree' is used in a lot of
>     scripts in the wild[1], I'm not so sure it's a great example.
> 
>     To be honest, I'd prefer to die("Try running 'git submodule update'")
>     here, but I don't think that's very script-friendly. However, falling
>     back on the old implementation kind of undermines the idea of treating
>     submodule.superprojectGitDir as the point of truth.
> 
> Most of what I've been suggesting in my [1] and related is that I'm
> confused about if & how this is a pure caching mechanism.
> 
> Removing mentions of it being a cache but it seemingly still being a
> cache at the tip of this series has just added to that confusion for
> me :)

Yeah, I think this was a bad choice for me to include that patch. I was
really hopeful that I could show off "look, we don't need to ever hunt
in the FS above us", but for established repos, that's a bad idea
(because lots of people are already using this 'git rev-parse
--show-superproject-work-tree' thing in scripts, like I mentioned). So I
think it was a mistake to include it at all. Rather, I think it's
probably a better idea to treat that particular entry point as "legacy"
and implement other things using 'submodule.superprojectGitDir'
directly.

Because the patch 5 illustrates: "I'm saying that this new config isn't
a cache, but look, here's how I can treat it like a cache that might be
invalid and here's how I can fall back on a potentially expensive
operation anyways." I think I could have illustrated it a little better
with something like "here's a brand new 'git rev-parse
--show-superproject-gitdir'" which directly calls on the new config.

So, sorry about that.

> 
> Anyway. While I do think this caching mechanism is probably
> unnecessary in the short to medium term, i.e. it seems to the extent
> that it was ever needed was due to some bridging of *.sh<->*.c that
> we're *this* close to eliminating anyway.
> 
> But maybe I'm wrong. The benchmark I suggested above on that Google
> NFS might be indicative. I don't really see how something that'll be
> doing a bunch of FS ops anyway is going to be noticeably slower with
> that approach, but maybe opening the index/tree of the superproject is
> more expensive than I'm expecting.
> 
> In any case, all of that's not the hill I'm picking to die on. If
> you'd like to go ahead with this cache-or-not-a-cache then sure, I
> won't belabor that point.

Yeah, I think I would. I've heard some serious reservations from others
on my team about trying to use filesystem traversal here at all, so I
think that would be an uphill battle.

> 
> I *do* strongly think if we're doing so though that we should have
> something like this on top. I.e. let's test wha happens if we do and
> don't have this "caching" variable, which is demonstrably easy to do.
> 
> Benchmarking the two gives me:
> 
>     $ git hyperfine -L rev HEAD~0 -L s true,false -s 'make -j8 all' '(cd t && GIT_TEST_SUBMODULE_CACHE_SUPERPROJECT_DIR={s} ./t7412-submodule-absorbgitdirs.sh)'
>     Benchmark 1: (cd t && GIT_TEST_SUBMODULE_CACHE_SUPERPROJECT_DIR=true ./t7412-submodule-absorbgitdirs.sh)' in 'HEAD~0
>       Time (mean ± σ):     545.9 ms ±   1.6 ms    [User: 490.3 ms, System: 114.0 ms]
>       Range (min … max):   543.5 ms … 548.1 ms    10 runs
>      
>     Benchmark 2: (cd t && GIT_TEST_SUBMODULE_CACHE_SUPERPROJECT_DIR=false ./t7412-submodule-absorbgitdirs.sh)' in 'HEAD~0
>       Time (mean ± σ):     537.9 ms ±  11.4 ms    [User: 476.8 ms, System: 117.6 ms]
>       Range (min … max):   532.7 ms … 570.1 ms    10 runs
>      
>     Summary
>       '(cd t && GIT_TEST_SUBMODULE_CACHE_SUPERPROJECT_DIR=false ./t7412-submodule-absorbgitdirs.sh)' in 'HEAD~0' ran
>         1.01 ± 0.02 times faster than '(cd t && GIT_TEST_SUBMODULE_CACHE_SUPERPROJECT_DIR=true ./t7412-submodule-absorbgitdirs.sh)' in 'HEAD~0'
> 
> I.e. not using the cache is either indistinguishable or a bit faster
> (the "a bit faster" is definitely due to just running less test code
> though).

Yeah, once again, I think it is better to treat "git rev-parse
--show-superproject-work-tree" as "legacy" and to rely solely on the
config for new options, meaning that "what happens without this
variable" is as simple as "we treat it like it's a standalone repository
with no superproject", rather than a performance difference at all.

 - Emily

> 
> I'm sending this before the CI run[2] finishes (which now tests both
> modes), but both of these work for me locally on a full test suite
> run.
> 
> 1. https://lore.kernel.org/git/211109.86v912dtfw.gmgdl@evledraar.gmail.com/
> 2. https://github.com/avar/git/runs/4237446991?check_suite_focus=true
> 
> Ævar Arnfjörð Bjarmason (2):
>   submodule tests: fix potentially broken "config .. --unset"
>   submodule: add test mode for checking absence of "superProjectGitDir"
> 
>  ci/run-build-and-tests.sh          |  1 +
>  git-submodule.sh                   |  2 +-
>  submodule.c                        |  7 +++++++
>  t/lib-submodule-superproject.sh    | 24 ++++++++++++++++++++++++
>  t/t7406-submodule-update.sh        | 13 ++++++-------
>  t/t7412-submodule-absorbgitdirs.sh | 19 ++++++-------------
>  6 files changed, 45 insertions(+), 21 deletions(-)
>  create mode 100644 t/lib-submodule-superproject.sh
> 
> -- 
> 2.34.0.796.g2c87ed6146a
> 
