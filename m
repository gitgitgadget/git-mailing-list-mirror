Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A34591F403
	for <e@80x24.org>; Thu,  7 Jun 2018 04:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751331AbeFGE6x (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 00:58:53 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34797 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbeFGE6v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 00:58:51 -0400
Received: by mail-ua0-f196.google.com with SMTP id 74-v6so5643503uav.1
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 21:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=m14IKCEL//YUNwEZgej502qVvBEwXywkpFW3sfDRO1E=;
        b=QPJvO4SG6qPj04Qw03vizOuhLROPII0O5MZ1pVGfgR7g3VxyExuASNJl9nLL/j/lOk
         Zc/HE332lCqCkeTYuXyg/a3uwNpApp5I1qHvoBZfOrAXQDt4dcw24GQf8BrJCC1f+sDa
         D/RgAJ3s/rnv2lv1nM7SAZg2GM9X24DnEA+IVdVmmgrK5qrOmaebCHzTa36lA+oP04TM
         dY9cLGhj2yvu0y2ErI9JhKu1hlDD2T/c6qHO6KROGAt/BdQUE7uz//NVgF3H5fxlhl9h
         wlRC4srR40ulIbxky+rNazOjG7ewpq9pZWJA7c1CQAdHjoTaUt7IB11hF5EcsEORJsh0
         bfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=m14IKCEL//YUNwEZgej502qVvBEwXywkpFW3sfDRO1E=;
        b=CDsyZY4fNgTjXBbAnjs+1OASL7WJfdDDaVosWWzGcchCsaAL8TaAvldpwBTrkJ67Tk
         eUjb0MdwNN/kMKYbe8GHpCvV//ZaayKJLbtHZhyyPv/2zxGgB/V8/l4qGp+BD6CfGPmu
         lLIsooOGyLt9Mb+tt0Dj/JzVoJYHl9+90tpOxtxqpmlhnMLsSsJVkimlAL2o918Pqjsy
         V/7SMBq+Bx3sayPHSUX6aHlP2l9w7VG1NFileJRtEvtbuW2E/cwFRT0Ax7ABHz9x0+m3
         dT5HAA6SEYSPEQKTaRl1SN7ZbZ24zj2HSIx7aE608sMQAtSgxBquP9WkIIIIqVcRl7TR
         m2Kg==
X-Gm-Message-State: APt69E0sxINGazud87g+DK5sxXEw/8Z/ld/bMMXQiT8dm06krxLHYgB8
        q+MKZeMHu2qBthuJ2sUU9cPDTEwoj2ytgR0aSKj61A==
X-Google-Smtp-Source: ADUXVKIkkuM/AbeF4CZYNRwMmpOJrvIZxORUewEodOVit1jQK2+TkVHC1JgSHbYwH3rqen+Mwc5N/gU4yRSqirn7n+w=
X-Received: by 2002:a9f:3091:: with SMTP id j17-v6mr203342uab.23.1528347530612;
 Wed, 06 Jun 2018 21:58:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 21:58:50 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 6 Jun 2018 21:58:50 -0700
Message-ID: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
Subject: RFC: rebase inconsistency in 2.18 -- course of action?
To:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

We've got a small rebase problem; I'm curious for thoughts about the
best course of action.  I'll provide several options below.

In short, while interactive-based and merge-based rebases handle
directory rename detection fine, am-based rebases do not.  This
inconsistency may frustrate or surprise users.

=== Demonstration Example ===

Let's say we have a repo with three commits -- an original commit
('O'), and two branches based off of it, A and B with an extra commit
each:

  O: has files l, x/a, x/b, x/c
  A: renames l -> lt, x/ -> y/
  B: modifies l, adds x/d

If I checkout B and run

  git rebase --interactive A

and don't bother editing the list of commits at all but just save,
then I end up with lt, y/{a, b, c, d} as expected.  However, if I run

  git rebase A

then I end up with lt, y/{a, b, c} and x/d; d is in the wrong place.

=== Problem explanation ===

am-based rebases suffer from a reduced ability to detect directory
renames upstream, which is fundamental to the fact that it throws away
information about the history: in particular, it dispenses with the
original commits involved by turning them into patches, and without
the knowledge of the original commits we cannot determine a proper
merge base.

The am-based rebase will proceed after generating patches by
commit-wise first trying git-apply, and if that fails it will attempt
a 3-way merge.  Since am has no knowledge of original commits, it
instead reconstructs a provisional merge base using
build_fake_ancestor() which will only contain the original versions of
the files modified in the patch.  Without the full list of files in
the real merge base, renames of any missing files cannot be detected.
Directory rename detection works by looking at individual file renames
and deducing when a full directory has been renamed.

Trying to modify build_fake_ancestor() to instead create a merge base
that includes common file information by looking for a commit that
contained all the same blobs as the pre-image of the patch would
require a very expensive search through history, and may choose a
wrong commit from among the several it finds.  (Also, regular am
outside of rebase may not find any commit that matches, forcing it to
somehow choose a near-fit).  Further, this would only work when the
fallback to a 3-way merge is triggered (i.e. when git-apply fails),
which may not happen for some patches. (For example, if the l->lt
change were not in the example, then git-apply would succeed and
incorrectly place d in x/, so we'd never even hit the 3-way fallback.)

In short, the am machinery simply doesn't have the necessary
information to properly detect directory renames, except when other
files involved in the renames upstream were also modified on the side
with the new file additions.

=== Possible solutions ===

1. Just accept it as a known shortcoming.

2. Revert directory rename detection from master...again.

   (Please, please, let's not pick this one.)

3. Claim it's not a bug at all.  In particular, the git-rebase(1) manpage
   states for the `--merge` option:

       Use merging strategies to rebase.  When the recursive (default)
       merge strategy is used, this allows rebase to be aware of
       renames on the upstream side.

   While "renames" is precisely why rebase --merge was added in commit
   58634dbff822 back on 2006-06-21, am-based rebases gained the
   ability to handle normal (non-directory) renames back in commit
   18cdf802ca6e from 2008-11-10.  So folks might be used to and expect
   their simple rebases to handle renames the same as --merge or
   --interactive rebases do.

4. Edit the 2.18 release notes.  Point out that directory renames can
   be detected by cherry-pick, merge, and rebases with either the -i
   or -m options (or any rebase option that implies either -i or -m);
   but not always by other rebases.  Folks may want to set pull.rebase
   to 'interactive' and just get used to immediately saving the
   popped-up list of commits and exiting to avoid this problem.

   Also, there's no good way to avoid this problem when using git-am
   directly.  At best, we can tell users to carefully select which
   older commit base to apply the patches on top of and then
   immediately run rebase --merge afterward.

5. Add an --am option to git-rebase, and make it not be the default
   (though make it be triggered by am-specific options like
   --whitespace or -C).  For the default, use either:

     5a. do_merge=t

     5b. interactive_rebase=implied

   As a slight aside, since there are only a few small changes
   necessary to make git-rebase--interactive handle ALL functionality
   from git-rebase--merge, we could take 5b one step further and
   delete git-rebase--merge and have one less rebase type.

   Either 5a or 5b may have a minor performance hit here, though
   personally I don't see this as a major factor.  But I'm happy to
   discuss at a high level if folks are curious (exact figures would
   depend heavily on the repo, size of commits, etc.)

6. Since there's not much time left before 2.18, do (1) and (4) for
   now, and (5) for 2.19.  Continue doing (1) or (3) for git-am itself.

7. Other solutions I haven't thought of?

=== Final Notes ===

I have patches implementing 5b, including the bonus removal of
git-rebase--merge.  However:

  * while my patches apply cleanly on master or next, there are lots
    of minor conflicts for the final two patches with ag/rebase-p in
    pu (in fact, even master conflicts with ag/rebase-p).  So I'm
    curious if I should wait off on sending these patches until that
    topic advances.

  * My first 9 patches are 7 independent fixes and cleanups, so I'll
    send those out shortly.


Thanks for reading this far,
Elijah
