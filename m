Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8EEC2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 22:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E6D20801
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 22:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X+cj4K4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgDJW13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 18:27:29 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:35752 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDJW12 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 18:27:28 -0400
Received: by mail-pj1-f74.google.com with SMTP id nk12so3283372pjb.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 15:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EfRyA+zSSF8RTyAVY/1Rc/TweLYMOG6J+SW5YGAtErg=;
        b=X+cj4K4zbidEJYtf6uN1KqYwlsmHv9OGPaxSHgay1feRBEkvlQ6YDdkIG35LSVYFgc
         ewbpodXslbA4B2h4rZBCajpi6fGO8fyi8ivmlpBLKkkK/OdpOsJSvcq6Oz6OrtSMoWMy
         p9hqSDpgg0uqlpAnUvVhBeVKLs+6blIF4wM+vLqnjxWqARW/cDPqD92F+t19Btc8by+V
         GNBffi0u2EUDDVzrvOsmlqaL2w/jyEIoTZMrIH4hAgxUIRLiGNWf3azNarNAlX2e9W/X
         9IWU/YCQQcuezJ/GHHVTWpB3riAfmvBspG3fhmrUF5jSPT6qNGH2N/v3Co95wb+ykZMp
         LiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EfRyA+zSSF8RTyAVY/1Rc/TweLYMOG6J+SW5YGAtErg=;
        b=MiwwylP4BARuVLmGdR49ALvn+cqdLkLmz989DiIAYIqBKqj1KluOJQDo+L32XdlBWl
         aB9i4ZOI4T+5eXNQDHkbA/R/aPRYqj/3dK0m86BVFW7FA6VsKeEK0Nz5LuAg1ML74drc
         BTFOotRsOicWJdJQYgi6VGpIpRd6wueUvgE1B9RYyii0s4J0h2Kqxvc153vVFBtCnoWz
         ZCtg1WQwYr1sqYOdnrgAcn2z2lHSjVLi7JTGrdOTGwH5/ngXFUQslcyhuvwdugsqrG3n
         TUDGL7Qg5zkNwJZg8oa/mUhMzTv0DOUH4ykY/+f/3qHgk2QY3u3gHeFzaOGQOzn48+TK
         6z+Q==
X-Gm-Message-State: AGi0PuYwss1c6fbaHHzYL8PwbkvulynbtiS0Uim6jG599AYYFAsdiqiU
        TlLJ/D+dOC2PMp4DXnFWVURsBjxezGSaTb+rH4tW
X-Google-Smtp-Source: APiQypLGhKaizKXomE5nkjj4YOZmPkQqqqnhbzpSwjwDhkYvm+CfVnmWKO9xQQeh5SwjMPypW4bsmebgeu7CpPZKNP8O
X-Received: by 2002:a17:90a:f407:: with SMTP id ch7mr908791pjb.72.1586557645602;
 Fri, 10 Apr 2020 15:27:25 -0700 (PDT)
Date:   Fri, 10 Apr 2020 15:27:22 -0700
In-Reply-To: <CABPp-BGew8HWChsMVH3ZNS4DuH=nE-GF5ouifP7DhLP-xQ_xbg@mail.gmail.com>
Message-Id: <20200410222722.95611-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BGew8HWChsMVH3ZNS4DuH=nE-GF5ouifP7DhLP-xQ_xbg@mail.gmail.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: Re: [PATCH v3] rebase --merge: optionally skip upstreamed commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        congdanhqx@gmail.com, gitster@pobox.com, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +If `--keep-cherry-pick is given`, all commits (including these) will be
> > +re-applied. This allows rebase to forgo reading all upstream commits,
> > +potentially improving performance.
> 
> I'm slightly worried that "keep" is setting up an incorrect
> expectation for users; in most cases, a reapplied cherry-pick will
> result in the merge machinery applying no new changes (they were
> already applied) and then rebase's default of dropping commits which
> become empty will kick in and drop the commit.
> 
> Maybe the name is fine and we just need to be more clear in the text
> on the expected behavior and advantages and disadvantages of this
> option:
> 
> If `--keep-cherry-picks` is given, all commits (including these) will be
> re-applied.  Note that cherry picks are likely to result in no changes
> when being reapplied and thus are likely to be dropped anyway (assuming
> the default --empty=drop behavior).  The advantage of this option, is it
> allows rebase to forgo reading all upstream commits, potentially
> improving performance.  The disadvantage of this option is that in some
> cases, the code has drifted such that reapplying a cherry-pick is not
> detectable as a no-op, and instead results in conflicts for the user to
> manually resolve (usually via `git rebase --skip`).
> 
> It may also be helpful to prevent users from making a false inference
> by renaming these options to --[no-]reapply-cherry-pick[s].  Sorry to
> bring this up so late after earlier saying --[no-]keep-cherry-pick[s]
> was fine; didn't occur to me then.  If you want to keep the name, the
> extended paragraph should be good enough.

Sorry for getting back to this so late. After some thought, I'm liking
--reapply-cherry-picks too. Perhaps documented like this:

  Reapply all clean cherry-picks of any upstream commit instead of
  dropping them. (If these commits then become empty after rebasing,
  because they contain a subset of already upstream changes, the
  behavior towards them is controlled by the `--empty` flag.)

  By default (or if `--noreapply-cherry-picks` is given), these commits
  will be automatically dropped. Because this necessitates reading all
  upstream commits, this can be expensive in repos with a large number
  of upstream commits that need to be read.

  `--reapply-cherry-picks` allows rebase to forgo reading all upstream
  commits, potentially improving performance.

  See also INCOMPATIBLE OPTIONS below.

This also makes me realize that we probably need to change the "--empty"
documentation too. Maybe:

   --empty={drop,keep,ask}::
  -       How to handle commits that are not empty to start and are not
  -       clean cherry-picks of any upstream commit, but which become
  +       How to handle commits that become
          empty after rebasing (because they contain a subset of already
          upstream changes).  With drop (the default), commits that
          become empty are dropped.  With keep, such commits are kept.
          With ask (implied by --interactive), the rebase will halt when
          an empty commit is applied allowing you to choose whether to
          drop it, edit files more, or just commit the empty changes.
          Other options, like --exec, will use the default of drop unless
          -i/--interactive is explicitly specified.
   +
  -Note that commits which start empty are kept, and commits which are
  -clean cherry-picks (as determined by `git log --cherry-mark ...`) are
  -always dropped.
  +Commits that start empty are always kept.
  ++
  +Commits that are clean cherry-picks of any upstream commit (as determined by
  +`git log --cherry-mark ...`) are always dropped, unless
  +`--reapply-cherry-picks`, is set, in which case they are reapplied. If they
  +become empty after rebasing, `--empty` determines what happens to them.
   +
   See also INCOMPATIBLE OPTIONS below.

If this works, I'll send out a new version containing Elijah's patches
and mine in whatever branch my patch shows up in [1].

[1] https://lore.kernel.org/git/xmqqd08fhvx5.fsf@gitster.c.googlers.com/

> > @@ -568,6 +583,9 @@ In addition, the following pairs of options are incompatible:
> >   * --keep-base and --onto
> >   * --keep-base and --root
> >
> > +Also, the --keep-cherry-pick option requires the use of the merge backend
> > +(e.g., through --merge).
> 
> Why not just list --keep-cherry-pick[s] in the list of options that
> require use of the merge backend (i.e. the list containing '--merge')
> instead of adding another sentence here?

My reading of the list containing "--merge" is that they *trigger* the
merge backend, not require the merge backend. My new option requires but
does not trigger it (unless we want to change it to do so, which I'm
fine with).
