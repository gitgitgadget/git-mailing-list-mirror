Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A26AC6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 01:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCWBto (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 21:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCWBtm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 21:49:42 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE2449C3
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 18:49:40 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id e11so12262299lji.8
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 18:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679536179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymvGGp45nlJQ6cYhfLOR0QLUNtxZPPAw7JJB81ESbuw=;
        b=ZYcG12GAoXE6jXGrzmrBegVLqzYCnf7vXo0/e96pCQWwfelZX4vylLOHRRnETnfdVq
         qaKhqaDYPUllrWg0D7D59ceB1SaGm06SIflsf4TXiO0KifCipkfw1xJV1pzCyAlIS5xW
         bQFfYlboU0pEygweXgY1AJ37GNsDqt0fa0AzTLFH0DRcKK1OZ1fYwC0obwzNNJVJ8fL/
         4mJ9Z0ygnmBWpHxUhx/CqTqtvITQ694x2A7ckKrdwqJ/3bd0boDP2D7XR9GHya1efamE
         T8ZHCb7PUaZl9IfzAz0Q9LsCVcWyfzyDmyQp2mjK8F56vmBOE+dFeH6InNBeTr3deuea
         /myA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679536179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymvGGp45nlJQ6cYhfLOR0QLUNtxZPPAw7JJB81ESbuw=;
        b=2cztmwgvdc1pAhu83dYkVpMTmDh+7OkdmiM7XqgCF2CEIKiLfm0I/LD/mwl6OsX9k3
         jXahJg2MSH0a9kWk1jAz8qidrn1+P6U1S6xnbJ7nNpGkISSf6tRkLB1yenfFlkbacazQ
         LJfcN/71QRD5spUcYrD2J1XZsZUa2CmUez4kQ7Brjf629Wnu8JEItuK2wt9s1yZFeO+V
         dLfd9R2SNWgoTYMBDToxK2InigNzKInuLZuh9EL4dJhfyErFQkTogWA5+AhepX4wb6V9
         pbzDSt199BekGGPGnIGnWhnmLZhpo757RgBBXN+3DF485ksMIim0ma0mtrlOSO5RWhce
         ApvQ==
X-Gm-Message-State: AO0yUKUsdRKAbJ1ovShZWi7vqSdYvnBTZmvLF06j2Tz9huCkLRVSsCZn
        rl7q+wR1YzETDqUuZZn14/NJk4na7p2hNnRWojw=
X-Google-Smtp-Source: AK7set/kfZVO9LUo5PosyDtxGzakPStaa6Q9a0CgBGm9BERkj1qgkw884XPFddMgu9KrWW4QCkuDqrZCewsMz5weUfI=
X-Received: by 2002:a2e:9d50:0:b0:29b:ebfa:765d with SMTP id
 y16-20020a2e9d50000000b0029bebfa765dmr2661970ljj.1.1679536178656; Wed, 22 Mar
 2023 18:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <27a7d2956ed94d7ea8eb6d17f1414525@saabgroup.com>
 <CABPp-BGnYWHtrM8fJN+79QLvm-GeXgJpxH4u=zvjJ0j9bUaE3A@mail.gmail.com> <573a64fb04584a4aa2329c471037d717@saabgroup.com>
In-Reply-To: <573a64fb04584a4aa2329c471037d717@saabgroup.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 22 Mar 2023 18:49:00 -0700
Message-ID: <CABPp-BFeB9av00=HUt3-Q=e_croHHOKfFu0Oc=axkTQEddG9nQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Soundness of signature verification excluding
 unsigned empty merges
To:     Lundkvist Per <per.lundkvist@saabgroup.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2023 at 5:14=E2=80=AFAM Lundkvist Per
<per.lundkvist@saabgroup.com> wrote:
>
> Elijah Newren <newren@gmail.com> wrote:
>
> ...
> > What does "validate" mean in this context?  Junio asked a bit about thi=
s.
> >
> > An alternative he didn't bring up is perhaps you are trying to protect
> > against supply chain attacks, with a scenario such as someone gains
> > remote access to some computers on your system, but not to any gpg
> > keys (because developers are using gpgs on yubikey or something like
> > that).  In such a case, you might ask the question of whether you can
> > determine if such an attacker has inserted additional commits to your
> > history.  You can use gpg-signed commits by known gpg-keys to rule out
> > most commits as being from a potential attacker, but odds are your git
> > hosting service does merges but doesn't sign them.  You want a way to
> > differentiate between merges it makes and ones an attacker might sneak
> > in.  And you are trying to equate "unsigned empty merge commit" with
> > "was a clean merge anyway, and we're not worried about any permutation
> > of clean merges of signed code".
> >
> > Or maybe you mean something completely different by "validate".
>
> No, you describe it perfectly :)

:-)

> > Junio brushed over whether you could assume "unsigned empty merge
> > commit" is equivalent to "was a clean merge", so I'll focus on that.
> > You often can make such an assumption, but it's not valid in general.
> >
[...]
> >
> > First off, I would use --remerge-diff over --cc.  --remerge-diff was
> > designed to show whether the user made changes relative to what a
> > current automatic remerge of the parents would give (so it shows
> > whether and how they resolved conflicts and if and what other changes
> > they added in).  --cc comes close when you only want to know if the
> > merge was clean, but still isn't quite the same.  One example I can
> > think of is that if there is a modify/delete conflict that the user
> > resolves in favor of keeping the file, then the merge obviously wasn't
> > clean.  But $(git show --pretty=3Dformat: --cc $i) will come back empty
> > (leading you to think the merge was clean) while $(git show
> > --pretty=3Dformat: --remerge-diff $i) will show there was a
> > modify/delete conflict.
>
> OK, I was not aware of --remerge-diff (we're currently on git 2.35), but =
from
> your description it seems to be much preferable. --cc makes it even easie=
r to
> sneak in old commits cleanly than expected.
>
> > Second, even with remerge-diff, it is only checking whether a merge wit=
h
> > today's merge algorithm and config settings would be clean.  Changing
> > diff.algorithm could in rare cases affect whether commits can be merged
> > cleanly -- and the default in the past was "myers" whereas nowadays for=
 merge
> > specifically it is "histogram".  Also, there have been changes to both =
of
> > these algorithms in the past (one notable example being the introductio=
n of
> > diff.indentHeuristic and later turning it on by default), and there may=
 be
> > more such changes in the future.  Similarly, merge.directoryRenames was
> > essentially "false" before it was introduced, then was "true" for a whi=
le,
> > then defaulted to "conflict".  Someone could have made a merge with an =
old
> > version of git that used either "false" or "true" for merge.directoryRe=
names
> > and have it be clean, but when you go to remerge the same commits today=
 you
> > get a conflict due to that variable defaulting to "conflict".  Further,=
 the
> > person running this script may have various `diff` or `merge` config se=
ttings
> > globally that differ from those used by whoever or whatever did the pas=
t
> > merges.  And, you have to account for the fact that the merge might hav=
e been
> > made with something other than git.  GitHub and GitLab used to use libg=
it2,
> > which had an entirely different merge algorithm.  Gerrit uses jgit, whi=
ch has
> > its own merge algorithm.  Realistically, there isn't that much differen=
ce
> > between all these algorithms.  For nearly all merges, any of these merg=
e
> > algorithms with any of these options will give the exact same answer...=
but
> > "nearly all" !=3D "all".  So, there is no guarantee.  And we can't and =
won't
> > even guarantee it going forward even if you stick with Git and somehow =
ensure
> > using the same config settings either, because we may make further chan=
ges to
> > diff and merge algorithms in the future, which may affect the "clean
> > remergeability" (or whatever you call it) of merges you make today.
>
> Good points.
>
> I think we could live with false conflicts. We can acknowledge false nega=
tives
> with a signed tag for only this purpose, right when they occur. We could =
also
> try to control the local git version and its settings. False positives ho=
wever
> are worse of course.

So long as you use --remerge-diff rather than --cc, you should be able
to rely on "empty output means the merge would be clean -- with the
current merge algorithm and config options -- and match the results
recorded in the merge commit".  I designed it to behave exactly that
way, so if anyone ever discovers a case where --remerge-diff gives
empty output despite that not being true, then that would be a bug we
would need to investigate and fix.  And even if someone did make a
merge commit using some other algorithm where it conflicted, and they
tweaked it to fix the conflicts, show --remerge-diff would only come
back empty if the tweaks made by that individual with the other merge
algorithm happen to match what you'd get with a clean merge with Git's
current merge algorithm and config options.  So, you'd be pretty safe
from false positives.  You might have to wade through a some false
negatives when merge algorithms or config options change, but as long
as you're prepared for that, it shouldn't be a big deal.

So, if you did that, the major vectors left for an attacker to fool
the "was this code from one of our employees, or from a merge from our
CI system" that I can think of would be:
  * trawl through your code review system to look for historical
signed commits that passed CI with review comments like "We shouldn't
do this; it'd open a security hole.", because they could then merge
those bad changes.
  * find systems that sign commits automatically (in a big enough
organization there always seem to be exceptions to human-signed stuff.
Maybe a system that autofixes obvious code issues and pushes up an
amended-and-signed commit, or something similar, and perhaps the
autofixing doesn't check the input was signed, or the nature of the
autofixing can be controlled somehow.)
  * figure out how to access the system that records which gpg keys
are associated with employees, and add extra attacker-controlled
gpg-keys to existing employees.

> > All that said, the odds that
> > you discover a particular merge in the wild where any of this matters
> > to your usecase is probably small.  So you might get away with
> > it...but if you try it, you should probably add some good comments to
> > the code for whoever comes along and investigates a "bug" in the
> > future, to let them know that false negatives and false positives are
> > possible with your checks, but that you just assumed they would be
> > rare enough that you decided to ignore them.
> >
> > Finally, just a couple preference questions: I'd have used [ -z
> > "$diff" ] rather than [ ! "$diff" ], and a simple "exit 1" rather than
> > "rc=3D1" to exit early, but maybe you really want all the output.  But
> > if you do want the output, would it make more sense to have the  -z
> > "$diff" before the git verify-commit "$i"?  Also, I'd be tempted to
> > use "git log --format=3D'%h %G? %s' $RANGE" rather than call git
> > verify-commit N times, and then post-process all the "N" cases, but
> > what you have works too.
>
> Yeah I wanted to show an as simple example as possible. The real version =
use
> explicit fifos, parallel xargs and shows an error for unsigned commits wh=
ile
> minimising the amount of calls to git verify commit, for performance reas=
ons. It
> just wouldn't have been a suitable example ;) I appreciate the feedback t=
hough,
> thank you!
>
> So for a smart enough attacker and a large enough commit history, dependi=
ng on
> the nature of commits and certain time windows, they may be able to intro=
duce
> previously signed commits that both go undetected and cause damage. This
> validation strategy is also brittle, since it depends on the internals of=
 the
> git implementation and the chosen diff algorithm.
>
> The proper way, and the only way to fully validate the repository would s=
till be
> to require all merge requests to be signed.
>
> We'll see, maybe this can serve as an interim, imperfect solution until w=
e have
> changed our developer workflow. It looks like introducing signed commits =
and a
> validation strategy (although somewhat brittle) to our current developer
> workflow, would still be an improvement since it is both hopefully a bit =
tricky
> to reintroduce old signed commits and we currently have no way at all to =
really
> authenticate the commits.
>
> Thank you (and Junio) very much for the thorough responses, highly apprec=
iated.

Glad it helped.
