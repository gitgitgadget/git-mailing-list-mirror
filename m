Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76F2C636CA
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 03:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98592610D1
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 03:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhGRDIZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 23:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhGRDIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 23:08:25 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01223C061762
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 20:05:26 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso14270014otu.10
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 20:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=9Q/5aSlhirMXYwbPbbSZWaziUbxcW3HT57oOJ3wgBcc=;
        b=rE53rdyNEKDwhCS4588pSqgY1HMTL8RwcdQuNDTnAopIEziJIFruAW9DwYpVNlLwUB
         iwvReESEtq/bX3s/qzOj8i3eqLscTwozNTQu6mpwu+NUUvHCFPbXIyY0cHB2kH9CvJP8
         4VXEyEd0RR39Ze6FYp/AGcm+r/jjJRaw3+CIXkhhc9EF4/KKZHFSJ7eWbZv0DKB/iP7t
         g8tQOnIfYb78rbofja8999DGZKb0wo9E6eUcAYkyGxSu9+2Nui3ypuQ+SmajH9fJ+1TG
         UGe3tDQt1fMbRhiiJH6QGzKtRRNiIpS8HmCU2kOqWqs5HoTP8y2iq9A2RpzYuS7Zx2GQ
         OEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=9Q/5aSlhirMXYwbPbbSZWaziUbxcW3HT57oOJ3wgBcc=;
        b=tZk0d429BRbQJamxTr1CgoTMMDVZKprqbAjiP/kSzk17tSmjOeqy27ePt4/86rdSyq
         Dh7c8TNvH5KBi0DSfaf/UYU15FuN+V9HeRjKN3NYlAl5yvR8k3NzXW1sWBadi7cSYqHq
         qrmqVo1YE1JGCT6ni5Yga4IjclBXLZlAegx5Vg+il25VqddJEqFSRyeYd+hTM2LD7gTc
         7XXcn89AtS75C337/aaVmG1+jEmEPG7pZ3LAZQwwLk5+IgdzE6SRXaYHCf85PlZSwu9A
         WbeGotmhwkFVCRVtcBQAgDAeDbWcjErqHSohjJrpgsVN44DIyCxnpPqje8VY9Do8y403
         mJDg==
X-Gm-Message-State: AOAM532bF/nnaFgFS/H6kscvt8e1WpRB8ryHGwboN/jwQkXFC7OXI/98
        16QrdJVsqA7eW+QA7DuUZRc=
X-Google-Smtp-Source: ABdhPJxQ1utwELMEKXN9XfIHV+tjUlPHO04HNcvp1NG5IFKR0144ysBUlD/LfYohC9qVY3Pnvy7Fzg==
X-Received: by 2002:a05:6830:545:: with SMTP id l5mr13643350otb.270.1626577524815;
        Sat, 17 Jul 2021 20:05:24 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id g66sm2901335oob.27.2021.07.17.20.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 20:05:24 -0700 (PDT)
Date:   Sat, 17 Jul 2021 22:05:22 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Message-ID: <60f39a72c9c8e_2fb208b3@natae.notmuch>
In-Reply-To: <1329d238-e38a-7c8b-d468-500a0ae38bbb@gmail.com>
References: <a0071549-73f6-9636-9279-3f01143a05de@gmail.com>
 <60f330c09ee05_25f220867@natae.notmuch>
 <1329d238-e38a-7c8b-d468-500a0ae38bbb@gmail.com>
Subject: Re: Regression in 'git pull --rebase --autostash' since v2.32.0
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain wrote:
> Le 2021-07-17 =C3=A0 15:34, Felipe Contreras a =C3=A9crit=C2=A0:
> > Hello,
> > =

> > Philippe Blain wrote:
> >> Your recent clean-up of 'git pull --autostash' seems to unfortunatel=
y have made things
> >> worse if the pull brings new files that conflict with existing untra=
cked files,
> >> which makes the pull abort,
> >> and there are tracked files with modifications (so --autostash comes=
 into play).
> >>
> >> Before your change, 'git pull --no-rebase --autostash' did *not* app=
ly the autostash
> >> after the pull failed, thus loosing modifications to tracked files (=
and it did not save the
> >> stash entry !). 'git pull --rebase --autostash' correctly applied th=
e autostash, but ended with
> >> a strange "error: could not detach HEAD".
> >>
> >> After your change, both 'git pull --no-rebase --autostash' and 'git =
pull --rebase --autostash'
> >> have the same buggy behaviour: they do not apply the autostash and d=
o not save it in the stash list.
> >>
> >> I had already documented the old behaviour at [1]. Here, I copy my r=
eproducer script
> >> (save it as "script"):
> > =

> > I cannot reproduce this. In my case the reproducer script never puts
> > anything in the stash list.
> =

> I tried again with GIT_CONFIG_GLOBAL=3D/dev/null on my end (and manuall=
y
> setting GIT_AUTHOR_{NAME,EMAIL}) to be sure that my config was not play=
ing
> a role, and I still reproduce. Copying the output from my 1st email
> (for --rebase, but it's the same thing for --no-rebase):
> =

> =

> > ** ./script --rebase --autostash **
> > =

> > ~~~
> > + git status
> > On branch master
> > Your branch is up to date with 'origin/master'.
> > =

> > Changes not staged for commit:
> >   (use "git add <file>..." to update what will be committed)
> >   (use "git restore <file>..." to discard changes in working director=
y)
> >     modified:   file
> > =

> > Untracked files:
> >   (use "git add <file>..." to include in what will be committed)
> >     other
> > =

> > no changes added to commit (use "git add" and/or "git commit -a")
> > + git pull --rebase --autostash
> > remote: Enumerating objects: 4, done.
> > remote: Counting objects: 100% (4/4), done.
> > remote: Compressing objects: 100% (2/2), done.
> > remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
> > Unpacking objects: 100% (3/3), 283 bytes | 94.00 KiB/s, done.
> > From /Users/Philippe/Code/GIT-devel/BUGS/ggg-759-pull-autotash-untrac=
ked/test
> >    4ebab2f..fc7a169  master     -> origin/master
> > Updating 4ebab2f..fc7a169
> > Created autostash: cfd51b5
> > error: The following untracked working tree files would be overwritte=
n by merge:
> >     other
> > Please move or remove them before you merge.
> > Aborting
> =

> Here is the bug: we should see "Applied autostash" after "Aborting". Th=
e 'git status'
> below is to verify that the autostash was indeed not applied, and the
> 'git stash list' was to check if the autostash was at least available
> in the stash list (it's not).

Ahh, I thought you expected `git stash list` to show something. If this
is the bug then yeah, I can reproduce.

> > + git status
> > On branch master
> > Your branch is behind 'origin/master' by 1 commit, and can be fast-fo=
rwarded.
> >   (use "git pull" to update your local branch)
> > =

> > Untracked files:
> >   (use "git add <file>..." to include in what will be committed)
> >     other
> > =

> > nothing added to commit but untracked files present (use "git add" to=
 track)
> > + git stash list
> > # empty!
> > ~~~ =

> =

> Back to your reply:
> =

> > =

> > Moreover, this is not an issue of `git pull`, but `git merge`.
> > =

> > I can reproduce the problem that the modifications are lost like this=
:
> > =

> >    git init test
> >    (
> >      cd test
> >      date >> file
> >      git add file
> >      git commit -m 'add file'
> >      date >> other
> >      git add other
> >      git commit -m 'add other'
> >      git checkout -b topic @~
> >      date >> other
> >      date >> file
> >      git status
> >      git "$@" master
> >      git status
> >      git stash list
> >    )
> > =

> > Running this with 'rebase --autostash' fails and nothing is put in th=
e
> > stash list, but the modifications to 'file' remain. I think this is t=
he
> > correct behavior.
> =

> Yes. We see the following output:
> =

>      Created autostash: 69775ee
>      Applied autostash.
>      Successfully rebased and updated refs/heads/topic.
> =

> The code correctly applied the autostash after the rebase, so it's
> normal it's not kept in the stash list. I agree it's the correct behavi=
our.

Good.

> > But with 'merge --autostash' the modifications to 'file' are lost. Th=
at
> > is a bug, and it's already present in v2.32.
> =

> That's also true. From what I understand it dates back to the introduct=
ion
> of 'git merge --autostash'.

Yes, that's probably true.

> > Do you agree?
> =

> I agree that the bug with 'merge --autostash' was already present in v2=
.32.0.
> But since your 340062243a (pull: cleanup autostash check, 2021-06-17),
> 'git pull --rebase --autostash' calls 'git merge --autostash' in the fa=
st-forward
> case, and so we hit the bug, which was not the case before since the fa=
st-forward
> merge shortcut was skipped if '--autostash' was given for 'git pull --r=
ebase'.

Yes we hit the bug with `git pull`, but the bug was there already when
people did `git merge`.

> The fix I suggested in [1] seems to fix both cases, but as I wrote ther=
e
> it still leaves two code paths that might trigger the bug. I'm not fami=
liar
> at all with the code for these two code paths, so I'm not ready to send=

> a formal patch; I thought I'd send the diff anyway if you or Denton (or=
 anyone
> else) wants to start from there.

Unfortunately I'm not familiar with the `git merge` code either, I've
only been modifying the `git pull` code, so I would also be starting
from scratch if I tried to fix that myself.

But I think that's where it should be fixed.

Cheers.

-- =

Felipe Contreras=
