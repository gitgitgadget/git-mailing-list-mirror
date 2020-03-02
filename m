Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275F8C3F2D2
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 04:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED641246BB
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 04:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSIx+jnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgCBEpG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Mar 2020 23:45:06 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43074 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgCBEpF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Mar 2020 23:45:05 -0500
Received: by mail-qt1-f196.google.com with SMTP id v22so3059802qtp.10
        for <git@vger.kernel.org>; Sun, 01 Mar 2020 20:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4B04tiMspiNrL4TlBHv60UgHZsaPEagNVvzUCDdthnY=;
        b=nSIx+jnPuYQvdqf0b2tiOSU61zmKEDL+2nyNAQ3l5mNPXE9YXaULWdmsqYu9+2Eht2
         cDFBtt4kmoAQJURrFJl+I5getXcd4CZJOh4nFD12emESalN3vASmlJil1XcbchuMmeYU
         9RvkIOzrRvDUJ2QHxEMNk5JQ/kMUYc6YBHBfMhsGME4PKef/dLtLzhYtD4Wm3ffXyL4j
         +mmgQpE4tZfwEBLsuD6caPt8KnfJj/GYzUlq7Jo7Q6IihuzHuC2vGppTCHZ/mxfn7qb8
         8NevWMD6wdPi6CiOZ7fDIomHqOOItXHG6K66zKxMzjMIwtfY1Air+gg77kTdBuNhNqWb
         U8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4B04tiMspiNrL4TlBHv60UgHZsaPEagNVvzUCDdthnY=;
        b=VoR4cc+5JviJSZOvfzMkS842S7OHRT+45hacFL0bUAXUdSoCV/cgbGaV5kGHfxy5PR
         q1UseU787yC0fJOpK1fbPeqMa9q0Reh49a0OMAixp3QyqSvaVdRzlap2annp1HEJhWcI
         hK808zkoqSLRJRsQf8jet3FJu35MWaXZB2nLyaTEUHvrucxKeV6Ye8FahMAcduysZo4c
         iYnu/WYuqTYKEdYGuZPYoeNpyoSfVuklMk5LALLHfo8XkexP6zV2iqc74tjrc3gFZbdt
         GljzpDzo3AQGpmHplZ6LdJOkpSLaC2HlyC0kAeI86o4VbrHyT2UxleQwcKw9cE+Ka+dm
         aXSQ==
X-Gm-Message-State: ANhLgQ3vI2EKeXl1Vc3NcIiRiiC7POUja5nAu2N9AkjnmcxYyylPckwz
        nMp3ZiFlRaYzLhvXxqMue3M=
X-Google-Smtp-Source: ADFU+vtLmBnLIZiJA34AdneAhUehfGYuIQRC7B0Jj5ovHbfqakoQBW393w25X822jGU47d2AkWOA5w==
X-Received: by 2002:ac8:4745:: with SMTP id k5mr3657872qtp.210.1583124304827;
        Sun, 01 Mar 2020 20:45:04 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id i4sm9594602qkf.111.2020.03.01.20.45.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Mar 2020 20:45:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/4] doc: document --recurse-submodules for reset and restore
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200228103558.1684937-3-damien.olivier.robert+git@gmail.com>
Date:   Sun, 1 Mar 2020 23:45:02 -0500
Cc:     git@vger.kernel.org,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9831AAEE-8FBF-4CBD-B589-3F045720D6DC@gmail.com>
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com> <20200228103558.1684937-3-damien.olivier.robert+git@gmail.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 28 f=C3=A9vr. 2020 =C3=A0 05:35, Damien Robert =
<damien.olivier.robert@gmail.com> a =C3=A9crit :
>=20
> Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
> ---
> Documentation/git-reset.txt   | 6 ++++++
> Documentation/git-restore.txt | 9 +++++++++
> 2 files changed, 15 insertions(+)
>=20
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index 932080c55d..838c0f1101 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -87,6 +87,12 @@ but carries forward unmerged index entries.
> 	different between `<commit>` and `HEAD`.
> 	If a file that is different between `<commit>` and `HEAD` has =
local
> 	changes, reset is aborted.
> +
> +--[no-]recurse-submodules::
> +	When the working tree is updated, using --recurse-submodules =
will
> +	also recursively reset the content of all active submodules
> +	according to the commit recorded in the superproject, also =
setting
> +	the submodules HEAD to be detached at that commit.
> =E2=80=94

=46rom previous testing I had done, when the submodule is modified =
(either modified content,=20
new commits or new commits, staged)  and `git reset` is invoked (and so =
`git reset HEAD` is assumed),
the submodule is only touched if `--hard` or `--merge` is given,=20
i.e. not when `--soft`, `--mixed` (the default action) or `--keep` are =
given.
So this is in line with this option just coming into play "When the =
working tree is updated", as you wrote.
However I just noticed that according to the doc `--merge` should abort =
in that case (I think?), but it does not if=20
`--recurse-submodules` is given. I don=E2=80=99t know if it=E2=80=99s a =
doc oversight or a real bug though...

>=20
> See "Reset, restore and revert" in linkgit:git[1] for the differences
> diff --git a/Documentation/git-restore.txt =
b/Documentation/git-restore.txt
> index 5bf60d4943..b94b2559c7 100644
> --- a/Documentation/git-restore.txt
> +++ b/Documentation/git-restore.txt
> @@ -107,6 +107,15 @@ in linkgit:git-checkout[1] for details.
> 	patterns and unconditionally restores any files in
> 	`<pathspec>`.
>=20
> +--recurse-submodules::
> +--no-recurse-submodules::
> +	Using `--recurse-submodules` will update the content of all
> +	restored submodules according to the commit recorded in the
> +	superproject.

I=E2=80=99d phrase it more like so :
If `<pathspec>` names a submodule and the restore location includes the =
working tree,=20
the submodule will only be updated if this option is given,=20
in which case it=E2=80=99s working tree will be restored to the commit =
recorded in the superproject=20
at the tree-ish given as the restore source.

This makes it clearer that `git restore -- submodule` does nothing, and =
one has to say
`git restore --recurse-submodules -- submodule` for the submodule =
working tree to be updated.

> Local modifications in a restored submodule are
> +	overwritten. If nothing (or `--no-recurse-submodules`) is used, =
the
> +	work trees of submodules will not be updated. Just like
> +	linkgit:git-submodule[1], this will detach `HEAD` of the =
submodule.
> +

In fact `git submodule` does not unconditionally detach the submodules =
HEAD=20
(if `git submodule update` is invoked and a branch is checked out in the =
submodule that points
to the same commit as the one recorded in the superproject, the HEAD is =
not detached and the branch
stays checked out unless `--force` is given.) So I would instead link to =
`checkout`,=20
which does unconditionally detach the submodules HEAD.

> --overlay::
> --no-overlay::
> 	In overlay mode, the command never removes files when
> --=20
> Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)
>=20

