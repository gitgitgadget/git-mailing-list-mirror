Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93482C433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 15:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355316AbiELPE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 11:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243950AbiELPE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 11:04:56 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5850F254730
        for <git@vger.kernel.org>; Thu, 12 May 2022 08:04:54 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id k27so6614485edk.4
        for <git@vger.kernel.org>; Thu, 12 May 2022 08:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Znv/orG1fvPYE2EnGKL8COMgcv+K6lv0vrtMDA1/bcw=;
        b=B9RGNDGdgkt554eLi+JJGe7qd6StadAT4c9KPOIwKakmxUpGRoLd/j7NfGR0mupsk5
         omje/9oNQCeHsMfiCcoOXLymHVqQMlbP7rNZiSJGD+jhJIo+rXWHWfA9kPeZZ4vBEIaP
         JUImZSrAD/vZOk+6w63fxkc4+Iz1uWm2J6zsc5BKI2qv2Kb/xct1/GseiN9CFOqc+I2L
         jnK3Q7xgOR5Fm/fA7+eBLTzFc+ORzfSWBuq+98v2TCIqUJ78H3tS+z+2MWViV63XJiHn
         qRvWmfu0l2ES2XSRM/JtuzFcIW2F/h7M2VttPOKTl0jPi80YkIqc1q1e9rncsoi2w7gZ
         Bcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Znv/orG1fvPYE2EnGKL8COMgcv+K6lv0vrtMDA1/bcw=;
        b=CCVX0+5dM+ga0DCNkcfdsbhWLPoVOpvwsWMwoslmjMYeI1EVPPpvnSAdut+RHQuo+m
         j6XfU+//7fUwQ22QkKGMoVTYX9XlNvqyMmsaWpDexIYtZqN0Nl458AtudwWoLYoQrV5Z
         NNI8ECwXWDOnu4Ruu7okO8bLqUoJscZUkRAC+n99WVUEpEXad16rq/Njk0RXkxhO+41Z
         njjufSdiooHz/L+ix51GOfyhW6B77nmpitHyw9JKzCoUIbkxT5GuzXZAWXggwm+LkP93
         tCguiGq7rTVYEpIxtLy5kAr12SZm6ymagdHde7kKfWj+J1LWy+X2HH9279WhJA57qkeY
         ngEQ==
X-Gm-Message-State: AOAM531CcA+fcRRre/r+n2Q4cSNVSuSDaTd+dXn8uCjrpMD3S45ZG0VE
        B+4RtMIT5OMmN+pHUjyMp9eShUMXC3xz2cqPqW0=
X-Google-Smtp-Source: ABdhPJzWlD9djyESDqqNxijgfpEwOqwP4OD6Bruf8FwxnxLJibeQYc61vWKHUkhqxbhM8duXP3zsQnMlwmjWv9xWtQM=
X-Received: by 2002:a05:6402:50d2:b0:428:b39:5c08 with SMTP id
 h18-20020a05640250d200b004280b395c08mr35773856edb.146.1652367892832; Thu, 12
 May 2022 08:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8S8rh+VYcuaqBeNtmphiRqw7HropLFpkxfnTJq6BngGXw@mail.gmail.com>
 <CAP8UFD2p+Evqv_MBAgv23zooppsNWjOw6ZU2GLqAq_skZoJPOw@mail.gmail.com>
 <CABPp-BGD3AZvXwmSHfQQ_xh_UqevH23kdBYijAWUk8GHu1q0Qw@mail.gmail.com>
 <CAOLTT8STRfqq4bfobCK8Q5uvtXzgNYY0x0wNh4HNyAhv0Mc07A@mail.gmail.com>
 <CABPp-BEFYjTvK4ZNSg+yiahRAzXW=KU11a-b+QRdcBDGb-movQ@mail.gmail.com> <CAOLTT8R7QmpvaFPTRs3xTpxr7eiuxF-ZWtvUUSC0-JOo9Y+SqA@mail.gmail.com>
In-Reply-To: <CAOLTT8R7QmpvaFPTRs3xTpxr7eiuxF-ZWtvUUSC0-JOo9Y+SqA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 12 May 2022 08:04:41 -0700
Message-ID: <CABPp-BHmNBMypVDrE=gPMXoHT9uH-u4HJG1dAuY0tjSGrK0yPg@mail.gmail.com>
Subject: Re: Question about pre-merge and git merge octopus strategy
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, vascomalmeida@sapo.pt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 11, 2022 at 4:21 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=8810=E6=97=
=A5=E5=91=A8=E4=BA=8C 15:07=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Sun, May 8, 2022 at 7:44 AM ZheNing Hu <adlternative@gmail.com> wrot=
e:
[...]
> > > Thanks for clarifying. As I reply to Christian, when I just use "git
> > > merge A B C" happily,
> > > and there is a conflict, so I try "git merge --abort" as usual, but i=
t
> > > can not work... git tell me:
> > >
> > > fatal: There is no merge to abort (MERGE_HEAD missing).
> >
> > Sounds like a bug to me; .git/MERGE_HEAD should be written.  That file
> > is created for me when I set up a simple octopus merge that has
> > conflicts.  Do you have a set of steps others can use to reproduce the
> > problem you are seeing?
>
> Let me minimally reproduce this question (with git 2.33.0):
>
> #!/bin/bash
>
> rm -rf test-repo
> git init test-repo
> cd test-repo
> git branch -m main
> echo base > base
> git add .
> git commit -m "base"
> git branch -c dev-1
> git branch -c dev-2
> echo main > main
> git add .
> git commit -m "main change"
> git checkout dev-1
> echo dev-1 >> base
> git add .
> git commit -m "dev-1 change"
> git checkout dev-2
> echo dev-2 >> base
> git add .
> git commit -m "dev-2 change"
> git checkout main
> echo main >> base
> git add .
> git commit -m "main change"
> git merge dev-1 dev-2
> file .git/MERGE_HEAD
>
> which output:
>
> .git/MERGE_HEAD: cannot open `.git/MERGE_HEAD' (No such file or directory=
)

Ah, thanks.  With this testcase, the output is:

    $ git merge dev-1 dev-2
    Trying simple merge with dev-1
    Simple merge did not work, trying automatic merge.
    Auto-merging base
    ERROR: content conflict in base
    fatal: merge program failed
    Automated merge did not work.
    Should not be doing an octopus.
    Merge with strategy octopus failed.

Also, if we check `git status`:

    $ git status
    On branch main
    Unmerged paths:
      (use "git restore --staged <file>..." to unstage)
      (use "git add <file>..." to mark resolution)
    both modified:   base

    no changes added to commit (use "git add" and/or "git commit -a")

And in git-merge-octopus.sh we see:

    case "$OCTOPUS_FAILURE" in
    1)
    # We allow only last one to have a hand-resolvable
    # conflicts.  Last round failed and we still had
    # a head to merge.
    gettextln "Automated merge did not work."
    gettextln "Should not be doing an octopus."
    exit 2
    esac

and in builtin/merge.c, we see:

    /*
     * The backend exits with 1 when conflicts are
     * left to be resolved, with 2 when it does not
     * handle the given merge at all.
     */

Which means git-merge-octopus.sh is claiming it can't handle this type
of merge, and some other merge strategy should be tried, and
implicitly that it didn't leave any conflicts to be resolved because
it can't handle this merge.  But it clearly decides to leave the
modifications it made to the index and working tree around, which just
seems wrong to me.  If it doesn't handle the merge and other merge
strategies (if available) should be tried, it should leave things the
way it found them.  So, perhaps a patch like the below would do that;
can you give it a try to see if it solves your cases (it works for
your simplified testcase, but I'm curious about your more involved
cases and if it works for them too)?


----- >8 -----

diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
index 7d19d37951..6ddbdc8f56 100755
--- a/git-merge-octopus.sh
+++ b/git-merge-octopus.sh
@@ -47,6 +47,13 @@ then
     git diff-index --cached --name-only HEAD -- | sed -e 's/^/    /'
     exit 2
 fi
+
+# If octopus is inapplicable, make sure we undo any changes we made first
+cannot_octopus() {
+       git reset --merge
+       exit 2
+}
+
 MRC=3D$(git rev-parse --verify -q $head)
 MRT=3D$(git write-tree)
 NON_FF_MERGE=3D0
@@ -60,7 +67,7 @@ do
                # a head to merge.
                gettextln "Automated merge did not work."
                gettextln "Should not be doing an octopus."
-               exit 2
+               cannot_octopus
        esac

        eval pretty_name=3D\${GITHEAD_$SHA1:-$SHA1}
@@ -95,7 +102,8 @@ do
        NON_FF_MERGE=3D1

        eval_gettextln "Trying simple merge with \$pretty_name"
-       git read-tree -u -m --aggressive  $common $MRT $SHA1 || exit 2
+       git read-tree -u -m --aggressive  $common $MRT $SHA1 || cannot_octo=
pus
+
        next=3D$(git write-tree 2>/dev/null)
        if test $? -ne 0
        then
