Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51B6C35242
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 04:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D30420679
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 04:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqMVnwFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgBQEvw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 23:51:52 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36135 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgBQEvw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 23:51:52 -0500
Received: by mail-qk1-f196.google.com with SMTP id w25so15080162qki.3
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 20:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NcBinaebE4TiGmT4G849J7IE5+WMRVuWB/476bA9sAk=;
        b=iqMVnwFAYMCqmJ/6FHtmoOnqQykZw0CwBYU7SsJS0o+EmeYmHWE6RHoYVcays+LtjT
         kyb1wESx6i1Z2qJTiVBFQiPdfcmYb/unyZNyRkXH/LDdCHPpDxmgPeiKQWCLrnPcKmo2
         DuSUfbPSHP6PPo0EakCbg98ast+X6SX8mOKig6RCr4I2lNJgvQi0Gxx2lPF9WQJ7ezkr
         cMUP2zTdZC/fAuE0H4oNNW5K5HMyZMz6P1afgxZwGrh4MxInkL656wqZV8PpKkUHL4KQ
         hlCG+X5hFt8aCXqmELDn2ufGGcdieJwHxdEe0BKdH/hVV0m/CmKr3IX3JgCzeiid7Z1x
         EPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NcBinaebE4TiGmT4G849J7IE5+WMRVuWB/476bA9sAk=;
        b=Lz9jThQjkf/UvcYZTN+wRWZYZAnxgPb1UmhLdMhg6EDqYnYWxFaDCx1q1bhRvqbAnK
         HgbFjysHwQbeZxCc1Q2mmmPYaDz7U9pAypwXrc6XRx6eHn0KeIWiXXlAFk+epYLrEj+6
         kgLZeFhZfotu0dJj3csJd5ZGslYtNfz/AQWtO9KbfumdPz9H1vhjfc6cfOB2LM/SXJFy
         zWoVeNDE1hG3Djg7kRkaz1xyQWw1zkIBPWc2MkvoXM3hxg44RR0yFsLS+Ccg+sCFcoeE
         WckhSPKIgFok9dDj8zFS+BlA7tL1v9x3pgZPJ6KCFjh9CYFSV1BtScfR6cBly77iTIiz
         YDbQ==
X-Gm-Message-State: APjAAAUmVozDQ09Wnk2lpjD2TCvWQnVydNlNndktwbleFsva0UAAcmiJ
        1uuaTULgNkk7y2T0mTt4SiU=
X-Google-Smtp-Source: APXvYqwjqHnCym5WupOc2jDJn3O1oX0ggGRRLsv9MFY1y/Nf71Q+0DG4MBUUQiiop8RWnJ47fcqivw==
X-Received: by 2002:a05:620a:101a:: with SMTP id z26mr12559521qkj.141.1581915109106;
        Sun, 16 Feb 2020 20:51:49 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id w9sm8182767qkf.126.2020.02.16.20.51.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Feb 2020 20:51:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Nested submodule checkout
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200214224242.knmzkwx7ls4sote7@doriath>
Date:   Sun, 16 Feb 2020 23:51:43 -0500
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0123F1ED-C421-4C1F-896B-E54C9D345A34@gmail.com>
References: <20200214224242.knmzkwx7ls4sote7@doriath>
To:     Damien Robert <damien.olivier.robert@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Damien,

I reported the same bug to the list back in September [1], and I=E2=80=99m=
 glad to say I just finished (today!) a patch series [2] that fixes this =
bug.

> Le 14 f=C3=A9vr. 2020 =C3=A0 17:42, Damien Robert =
<damien.olivier.robert@gmail.com> a =C3=A9crit :
>=20
> Dear git developers,
>=20
> I stumbled into this situation from which it was a bit painful to =
recover:
>=20
> -> test script:
>=20
>    mkdir ploum
>    cd ploum
>    git init
>    echo 'foo' > foo
>    git add foo
>    git commit -m foo
>    git branch nosubmodules
>=20
>    mkdir plam
>    cd plam
>    git init
>    echo 'bar' > bar
>    git add bar
>    git commit -m bar
>=20
>    mkdir plim
>    cd plim
>    git init
>    echo 'baz' > baz
>    git add baz
>    git commit -m baz
>=20
>    cd ..
>    git submodule add ./plim
>    git commit -am 'Add submodule plim'
>=20
>    cd ..
>    git submodule add ./plam
>    git commit -am 'Add submodule plam'
>=20
>    git checkout nosubmodules
>    git checkout --recurse-submodules master
>=20
> -> The result is as follow:
>=20
> Initialized empty Git repository in /data/dams/var/tmp/ploum/.git/
> [master (root-commit) ec7c09a] foo
> 1 file changed, 1 insertion(+)
> create mode 100644 foo
> Branch 'nosubmodules' set up to track local branch 'master'.
> Initialized empty Git repository in =
/data/dams/var/tmp/ploum/plam/.git/
> [master (root-commit) 35e6696] bar
> 1 file changed, 1 insertion(+)
> create mode 100644 bar
> Initialized empty Git repository in =
/data/dams/var/tmp/ploum/plam/plim/.git/
> [master (root-commit) b4712c1] baz
> 1 file changed, 1 insertion(+)
> create mode 100644 baz
> Adding existing repo at 'plim' to the index
> [master 989c11d] Add submodule plim
> 2 files changed, 4 insertions(+)
> create mode 100644 .gitmodules
> create mode 160000 plim
> Adding existing repo at 'plam' to the index
> [master 5b34041] Add submodule plam
> 2 files changed, 4 insertions(+)
> create mode 100644 .gitmodules
> create mode 160000 plam

Here you just did ` git commit -am 'Add submodule plam=E2=80=99` so the =
next command according to your reproducer above would be `git checkout =
nosubmodules`

> Migrating git directory of 'plam' from
> '/data/dams/var/tmp/ploum/plam/.git' to
> '/data/dams/var/tmp/ploum/.git/modules/plam'
> Migrating git directory of 'plam/plim' from
> '/data/dams/var/tmp/ploum/plam/plim/.git' to
> '/data/dams/var/tmp/ploum/.git/modules/plam/modules/plim'
> Switched to branch 'nosubmodules'
> Your branch is behind 'master' by 1 commit, and can be fast-forwarded.
>  (use "git pull" to update your local branch)

Here, git is migrating the git directories of both submodules to the git =
directory of the superproject (ploum). This tells me you probably have =
the `submodule.recurse` config set somewhere, as this is the behaviour I =
get I if I do `git checkout --recurse-submodules nosubmodules`.
If I just do `git checkout nosubmodules`, I get=20
   =20
    $ git checkout nosubmodules=20
    warning: unable to rmdir 'plam': Directory not empty
    Switched to branch 'nosubmodules'
    Your branch is behind 'master' by 1 commit, and can be =
fast-forwarded.
      (use "git pull" to update your local branch)

and then doing `git checkout --recurse-submodules master` actually =
works.=20

> fatal: exec '--super-prefix=3Dplam/plim/': cd to 'plim' failed: No =
such file or directory
> error: Submodule 'plim' could not be updated.
> error: Submodule 'plam/plim' cannot checkout new HEAD.
> error: Submodule 'plam' could not be updated.
> M	plam
> Switched to branch 'master'
>=20
> As you can see, the nested plim submodules could not be recreated =
since the
> folder does not exists yet in the 'nosubmodules' branch.

That=E2=80=99s the cause of the bug: in fact git tries to change =
directory into =E2=80=98plim=E2=80=99 before the =E2=80=98plim=E2=80=99 =
directory is created in the filesystem.

> This makes the
> 'plam' submodule update fails, and in the following state
>=20
> Unstaged changes after reset:
> D	.gitmodules
> D	bar
> D	plim

At this point, if you go into =E2=80=98plam=E2=80=99 and do `git =
ls-files -s` (to list the content of the index), you will see that the =
index is empty (the checkout died before the index could be populated.)=20=


> -> To recover
>=20
> In the folder plam, do a `git reset` followed by a `git reset --hard`
> (`git reset --hard` directly does not work:
> fatal: exec '--super-prefix=3Dplim/': cd to 'plim' failed: No such =
file or directory)

That=E2=80=99s another hint that you have `submodule.recurse` set. I =
don=E2=80=99t get this error doing `git reset --hard`, but I get it =
doing `git reset --hard --recurse-submodules` (or `git reset --hard =
--r`, which works and is quicker to type!). `git reset` populates the =
index, so now `git ls-files -s` would now show the correct content of =
=E2=80=98plam=E2=80=99.

> Indeed the first reset, which puts .gitmodules back in the index, is =
what
> allows to do the `git submodule update` implied by `git reset --hard`.

In fact, `git reset --hard` does not spawn `git submodule update`, it =
calls functions in unpack-trees.c (that actually spawn `git read-tree =
=E2=80=94recurse-submodules`) to update the submodules recursively.=20

> Note that I wasn't able to reproduce in this small examples, but when
> trying to repair I also add some strange errors of the form
> '.git is not a git directory' (where .git was a pseudo symlink
> gitdir: ../.git/modules/plam).
>=20
> -> Question
>=20
> My usage is probably non standard (I have quite a lot of nested
> submodules), so I had a hard time to recover from this checkout. Is =
there a
> better way? Would it be possible to make nested submodules checkout of =
this
> form work out of the box?

It is supposed to work out of the box when using `--recurse-submodules` =
or the `submodule.recurse` config. Although, it=E2=80=99s always =
possible to run into some bugs.=20
One thing you can do to get out of tricky situations is to temporarily =
deactivate the config (`git -c submodule.recurse=3D0 <command>`). For =
example, after the failed `git checkout --recurse-submodules master` =
above, issuing

    git -c submodule.recurse=3D0 submodule update --recursive --force

would have correctly checked out the submodules. I have a git alias =
=E2=80=98no-rs=E2=80=99 (for no recurse-submodules) that I use in these =
situations:

    git config --global alias.no-rs =E2=80=98-c submodule.recurse=3D0=E2=80=
=99

Then the `submodule update` call above could be shortened to=20

    git no-rs submodule update --recursive --force

Note that using the `submodule.recurse` config also applies to internal =
calls to git commands (issued by other git commands), so using adding =
`--no-recurse-submodules` to the command line might not be enough to =
completely turn off the effect of that config, hence this handy alias.

>=20
> Thanks!
> Damien Robert
>=20

Cheers,
Philippe.

[1] =
https://lore.kernel.org/git/7437BB59-4605-48EC-B05E-E2BDB2D9DABC@gmail.com=
/
[2] https://github.com/gitgitgadget/git/pull/555=
