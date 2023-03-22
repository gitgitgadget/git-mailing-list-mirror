Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93513C7619A
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 01:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCVBmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 21:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCVBmt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 21:42:49 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3998584B3
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 18:42:46 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a11so6918939lji.6
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 18:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679449365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGL/tG9ydopP2klszfe5Zsrb3PZOAczmRM3L1wSfqss=;
        b=ctFCtXyLvx2j8EySUuspxNfmMtEfz43+Vv9zh4VXjR4yvrYPTlDdSaLWJfFs3vcuIO
         kmIRuyEaljrG9v1XgpAEdwRS6w0eo0Rw0gJ1CGP+krXluoUykrnG5R7/wXcJOBLvHwnG
         +dyKjEAs507WynbwXU7rAIFIqZunRc4rOLACCnnhj/+cHl58+lmyy39NSMK4qSzEpg/R
         +qhmfWwtpbZs0a6WeBsgrwCkpledheMCXsAHWFpbTlqg+dqU6+bAVDJfM/bTLcTvNtsw
         Rbmt5X+gYXJhjhjpZ1xQpXgc78Nu3DM8cMZMQhepRp+Po2ziu/bWu9c/aIbsluQbrpMg
         VKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679449365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGL/tG9ydopP2klszfe5Zsrb3PZOAczmRM3L1wSfqss=;
        b=ZJias1o0KWhR3jJcL5UxFkq1gxOEZcNwKrkkBYb8R8eWBXERNpcJNulMjpM6VX+xnn
         b531qMVhYiG2n4OQURN4GXlBvc1uRZiOpAa3bOv5/GmJRir6JKO8/gQMDq9X6O5BUcY0
         L2Vl6K2C4fKrFwnBvEBU+9vWSsVq43TRZKNO5iSHnZ11plSk5SewWj1RTZaf2NY/9eHm
         HsaVhhclmbfNs5CtgeJj/hAuMI63d+rBEv9E+CJrv6OwyMWs+A1KuhHrTsXMm8biWCUf
         08YKigv2g/EFfpks9wa9+VPaAEoFLFaObNhLCwR2PeaZ05JBuC5WiXNlPMbEUZSlWNkr
         iwcg==
X-Gm-Message-State: AO0yUKV7jMpGp+P0/26KhPWyMK5j1eTdx4i6WbWeGrd8fcmv41REGjNT
        qZBrvwgNCMaHWzltutNRYabsT1gt8CzDoAe9KCiIDCcarho=
X-Google-Smtp-Source: AK7set9Pq3BI68pKzpncKJ4ncD9ZZvdhujUS5qVDyKF5VHTOgipkdh/OFr6CMWsQY73xZE5UyTNxPiutkk098NWANw8=
X-Received: by 2002:a05:651c:1505:b0:295:acea:5884 with SMTP id
 e5-20020a05651c150500b00295acea5884mr229604ljf.3.1679449364718; Tue, 21 Mar
 2023 18:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <27a7d2956ed94d7ea8eb6d17f1414525@saabgroup.com>
In-Reply-To: <27a7d2956ed94d7ea8eb6d17f1414525@saabgroup.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 21 Mar 2023 18:41:00 -0700
Message-ID: <CABPp-BGnYWHtrM8fJN+79QLvm-GeXgJpxH4u=zvjJ0j9bUaE3A@mail.gmail.com>
Subject: Re: Soundness of signature verification excluding unsigned empty merges
To:     Lundkvist Per <per.lundkvist@saabgroup.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Mar 21, 2023 at 4:21=E2=80=AFAM Lundkvist Per
<per.lundkvist@saabgroup.com> wrote:
>
> Hi,
>
> We are investigating adding commit and tag signatures into our existing
> repositories. We currently use the common workflow of developers merging =
commits
> to master using an internal git hosting service after having passed code
> review. Non-local merges like this would then be unsigned.
>
> But it seems like if we allow unsigned empty merge commits, i.e. those th=
at
> themselves do not introduce any any other change than what its parents
> introduce, and require all other commits to be properly validated, then w=
e can
> safely validate the whole repository?

What does "validate" mean in this context?  Junio asked a bit about this.

An alternative he didn't bring up is perhaps you are trying to protect
against supply chain attacks, with a scenario such as someone gains
remote access to some computers on your system, but not to any gpg
keys (because developers are using gpgs on yubikey or something like
that).  In such a case, you might ask the question of whether you can
determine if such an attacker has inserted additional commits to your
history.  You can use gpg-signed commits by known gpg-keys to rule out
most commits as being from a potential attacker, but odds are your git
hosting service does merges but doesn't sign them.  You want a way to
differentiate between merges it makes and ones an attacker might sneak
in.  And you are trying to equate "unsigned empty merge commit" with
"was a clean merge anyway, and we're not worried about any permutation
of clean merges of signed code".

Or maybe you mean something completely different by "validate".

Junio brushed over whether you could assume "unsigned empty merge
commit" is equivalent to "was a clean merge", so I'll focus on that.
You often can make such an assumption, but it's not valid in general.

> A simple naive example of this would look something like this:
>
>     rc=3D0
>     tags=3D$(git for-each-ref --format '%(objectname)' refs/tags)
>     tags_verified=3D$(for i in $tags; do git verify-tag --format=3D'%(obj=
ectname)' "$i"; done)
>
>     for i in $(git rev-list HEAD --no-merges --not $tags_verified); do
>         git verify-commit "$i" || rc=3D1
>     done
>
>     for i in $(git rev-list HEAD --merges --not $tags_verified); do
>         diff=3D$(git show --text --pretty=3Dformat: --diff-merges=3Dcc "$=
i")
>         git verify-commit "$i" || [ ! "$diff" ] || rc=3D1
>     done
>
>     exit $rc
>
> Or is this a faulty strategy?

It's faulty, but it'd only rarely trip you up.

First off, I would use --remerge-diff over --cc.  --remerge-diff was
designed to show whether the user made changes relative to what a
current automatic remerge of the parents would give (so it shows
whether and how they resolved conflicts and if and what other changes
they added in).  --cc comes close when you only want to know if the
merge was clean, but still isn't quite the same.  One example I can
think of is that if there is a modify/delete conflict that the user
resolves in favor of keeping the file, then the merge obviously wasn't
clean.  But $(git show --pretty=3Dformat: --cc $i) will come back empty
(leading you to think the merge was clean) while $(git show
--pretty=3Dformat: --remerge-diff $i) will show there was a
modify/delete conflict.

Second, even with remerge-diff, it is only checking whether a merge
with today's merge algorithm and config settings would be clean.
Changing diff.algorithm could in rare cases affect whether commits can
be merged cleanly -- and the default in the past was "myers" whereas
nowadays for merge specifically it is "histogram".  Also, there have
been changes to both of these algorithms in the past (one notable
example being the introduction of diff.indentHeuristic and later
turning it on by default), and there may be more such changes in the
future.  Similarly, merge.directoryRenames was essentially "false"
before it was introduced, then was "true" for a while, then defaulted
to "conflict".  Someone could have made a merge with an old version of
git that used either "false" or "true" for merge.directoryRenames and
have it be clean, but when you go to remerge the same commits today
you get a conflict due to that variable defaulting to "conflict".
Further, the person running this script may have various `diff` or
`merge` config settings globally that differ from those used by
whoever or whatever did the past merges.  And, you have to account for
the fact that the merge might have been made with something other than
git.  GitHub and GitLab used to use libgit2, which had an entirely
different merge algorithm.  Gerrit uses jgit, which has its own merge
algorithm.  Realistically, there isn't that much difference between
all these algorithms.  For nearly all merges, any of these merge
algorithms with any of these options will give the exact same
answer...but "nearly all" !=3D "all".  So, there is no guarantee.  And
we can't and won't even guarantee it going forward even if you stick
with Git and somehow ensure using the same config settings either,
because we may make further changes to diff and merge algorithms in
the future, which may affect the "clean remergeability" (or whatever
you call it) of merges you make today.  All that said, the odds that
you discover a particular merge in the wild where any of this matters
to your usecase is probably small.  So you might get away with
it...but if you try it, you should probably add some good comments to
the code for whoever comes along and investigates a "bug" in the
future, to let them know that false negatives and false positives are
possible with your checks, but that you just assumed they would be
rare enough that you decided to ignore them.

Finally, just a couple preference questions: I'd have used [ -z
"$diff" ] rather than [ ! "$diff" ], and a simple "exit 1" rather than
"rc=3D1" to exit early, but maybe you really want all the output.  But
if you do want the output, would it make more sense to have the [[ -z
"$diff"]] before the git verify-commit "$i"?  Also, I'd be tempted to
use "git log --format=3D'%h %G? %s' $RANGE" rather than call git
verify-commit N times, and then post-process all the "N" cases, but
what you have works too.
