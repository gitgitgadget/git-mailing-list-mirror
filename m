Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF888C3F2C6
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 04:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0D020728
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 04:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og+NAcKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCFER5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Mar 2020 23:17:57 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39238 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgCFER5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Mar 2020 23:17:57 -0500
Received: by mail-qk1-f193.google.com with SMTP id e16so1131153qkl.6
        for <git@vger.kernel.org>; Thu, 05 Mar 2020 20:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RniqqW4ryRZJ9GSzv9iXAR75FCg7kBWRl4UxN4DnYNY=;
        b=Og+NAcKwwqdD+TmzqUwDvRnty96c6f47xR8dWtUFrubZWhPCmbu57UGeXQNZ0M1LDG
         UIXLFM9BwdymTchlLmOoQUySfDutGZS1irVCy0ZxcWaRxMSCa2zecIXdKHNS1uPD3qqj
         qFsmlx2qu2RDxEenXQo+E/z+6gAa8xSRiGfJ6QhWQni/Tma6GMp0kX5R+86g15Nr/RJK
         Xs2Nws6/ZyVy/PHxVekw2XhZWGnUtTclyjVb/zzRBhrBXGKB02YoSUwpqM5lDortXVbO
         XQugqOcRsiebKNiloKQq2lQuVvO+btAkR70dUtMp78Ab0O/gRkdsg6yEqIHreI2ev93Q
         NADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RniqqW4ryRZJ9GSzv9iXAR75FCg7kBWRl4UxN4DnYNY=;
        b=J7Cm2XvwEWswSinOR2jt/xWD1SEJMiS7GvUG3I2pIvPhcyRH7VrsuI27iTMwU9BzBq
         k+S9tj/00UpgmdgsUpHEFxiINwYlGZHS9x6hHPuz5AMpiP7rAC/D2ly4fZUjaslOk5bp
         B9PDS+WiC4ivv/n7by+djd+VMzH/sFnOxa6F30O0/ps6t3o7GZ0z+xyOO9cg5wlzOWd/
         8wBEzHkhv8bf9vmpXjdPMrvULsmRVviXdqd1Pv7p6FwN7rN7KdlhnB3f2TovKhq6Dr8s
         M4wEQcmo1902mfixI7n/6NW3F/40mRTheo5nv/j8Z5YCJD0k/OXn5Q3F9JV5LtQpggai
         zzBQ==
X-Gm-Message-State: ANhLgQ1CkkhPnEIs0XO3y1uIxN2cHuuX+GfOgaIgQya45cYUnzKsv2jk
        Uh6UvukxWgMUPn2wFj2+FKlzR94k
X-Google-Smtp-Source: ADFU+vvZeYYV/hFMYIf6jiUchHEiI4h6YFH4fwp0L485gBHyvswpuD4J/4OlN9RR6AJabukxfG5lhw==
X-Received: by 2002:a05:620a:527:: with SMTP id h7mr1170197qkh.316.1583468275948;
        Thu, 05 Mar 2020 20:17:55 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id m26sm4821787qtf.63.2020.03.05.20.17.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Mar 2020 20:17:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 5/5] doc: --recurse-submodules only apply to active submodules
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200303170740.1879432-6-damien.olivier.robert+git@gmail.com>
Date:   Thu, 5 Mar 2020 23:17:54 -0500
Cc:     git <git@vger.kernel.org>,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EA460350-CF54-4B91-B1F0-6C4692A14B88@gmail.com>
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com> <20200303170740.1879432-1-damien.olivier.robert+git@gmail.com> <20200303170740.1879432-6-damien.olivier.robert+git@gmail.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the commit title: s/apply/applies

> Le 3 mars 2020 =C3=A0 12:07, Damien Robert =
<damien.olivier.robert@gmail.com> a =C3=A9crit :
>=20
> The documentation refers to "initialized" or "populated" submodules,
> to explain which submodules are affected by '--recurse-submodules', =
but
> the real terminology here is 'active' submodules. Update the
> documentation accordingly.

Initialized, active and populated, as far as I understand, are three =
different concepts.
- Active is defined in gitsubmodules(7), it only involves the =
configuration variables 'submodule.active',=20
'submodule.<name>.active' and 'submodule.<name>.url'. The function=20
submodule.c::is_submodule_active checks that a submodule is active.
- My understanding is that "populated" means that the submodule's =
working tree is=20
present (and the gitfile correctly points to the submodule repository),=20=

i.e. either the superproject was cloned with ` --recurse-submodules`, or
the user ran `git submodule update --init`, or `git submodule init =
[<path>]` and `git submodule update [<path]`
separately which populated the submodule working tree.=20
This does not involve the 3 configuration variables above.
- My understanding is that "initialized" (at least in the context of the =
man pages involved in this patch) means=20
both "populated" and "active" as defined above, i.e. what `git submodule =
update --init` does.

>=20
> Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
> ---
> Documentation/fetch-options.txt | 6 +++---
> Documentation/git-checkout.txt  | 2 +-
> Documentation/git-grep.txt      | 2 +-
> Documentation/git-pull.txt      | 2 +-
> Documentation/git-read-tree.txt | 2 +-
> Documentation/git-switch.txt    | 2 +-
> 6 files changed, 8 insertions(+), 8 deletions(-)

What about ls-files ? builtin/ls-files.c:231 indicates that it does call
submodule.c::is_submodule_active, so its doc should also be updated.

>=20
> diff --git a/Documentation/fetch-options.txt =
b/Documentation/fetch-options.txt
> index 58972b1a05..ba33009253 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -156,11 +156,11 @@ ifndef::git-pull[]

=46rom what I understand of the code, git-fetch really recurses into =
*populated* submodules,
and does not consult the submodule.active or submodule.<name>.active =
config settings.
If you look at builtin/fetch.c::cmd_fetch, and the functions it calls, =
but is_submodule_active is not in the call chain.
I tested that setting submodule.<name>.active to false and calling=20

    git fetch --recurse-submodules=3Dyes

still fetches in the submodule(s). So this should stay as "populated".

> diff --git a/Documentation/git-checkout.txt =
b/Documentation/git-checkout.txt
> index c8fb995fa7..3be0a28284 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -292,7 +292,7 @@ Note that this option uses the no overlay mode by =
default (see also
>=20
> --recurse-submodules::
> --no-recurse-submodules::
> -	Using `--recurse-submodules` will update the content of all =
initialized
> +	Using `--recurse-submodules` will update the content of all =
active
> 	submodules according to the commit recorded in the superproject. =
If
> 	local modifications in a submodule would be overwritten the =
checkout
> 	will fail unless `-f` is used. If nothing (or =
`--no-recurse-submodules`)

That's correct as checkout uses the unpack-trees machinery,
which calls submodule_move_head, and submodule_move_head calls=20
is_submodule_active (submodule.c:1894).

> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index ddb6acc025..cdf8e26b47 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -93,7 +93,7 @@ OPTIONS
> 	with `--no-index`.
>=20
> --recurse-submodules::
> -	Recursively search in each submodule that has been initialized =
and
> +	Recursively search in each submodule that is active and
> 	checked out in the repository.  When used in combination with =
the
> 	<tree> option the prefix of all submodule output will be the =
name of
> 	the parent project's <tree> object. This option has no effect

That's correct (builtin/grep.c:423).

> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index 47bc4a7061..2285f3729d 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -85,7 +85,7 @@ OPTIONS
> 	Pass --verbose to git-fetch and git-merge.
>=20
> --[no-]recurse-submodules[=3Dyes|on-demand|no]::
> -	This option controls if new commits of all populated submodules =
should
> +	This option controls if new commits of all active submodules =
should
> 	be fetched and updated, too (see linkgit:git-fetch[1], =
linkgit:git-config[1] and linkgit:gitmodules[5]).
> +
> If the checkout is done via rebase, local submodule commits are =
rebased as well.

That's only partly correct: I tested setting submodule.<name>.active to =
false and doing

    git pull --recurse-submodules

This does fetches the submodule but does not update its working tree, =
due to the call to=20
is_submodule_active in prepare_to_clone_next_submodule in =
builtin/submodule--helper.c

> diff --git a/Documentation/git-read-tree.txt =
b/Documentation/git-read-tree.txt
> index da33f84f33..aab6856341 100644
> --- a/Documentation/git-read-tree.txt
> +++ b/Documentation/git-read-tree.txt
> @@ -116,7 +116,7 @@ OPTIONS
> 	located in.
>=20
> --[no-]recurse-submodules::
> -	Using --recurse-submodules will update the content of all =
initialized
> +	Using --recurse-submodules will update the content of all active
> 	submodules according to the commit recorded in the superproject =
by
> 	calling read-tree recursively, also setting the submodules HEAD =
to be
> 	detached at that commit.

`read-tree` is also in the unpack-trees machinery, so that's correct.

> diff --git a/Documentation/git-switch.txt =
b/Documentation/git-switch.txt
> index 197900363b..337852d86b 100644
> --- a/Documentation/git-switch.txt
> +++ b/Documentation/git-switch.txt
> @@ -181,7 +181,7 @@ name, the guessing is aborted.  You can explicitly =
give a name with
> --recurse-submodules::
> --no-recurse-submodules::
> 	Using `--recurse-submodules` will update the content of all
> -	initialized submodules according to the commit recorded in the
> +	active submodules according to the commit recorded in the
> 	superproject. If nothing (or `--no-recurse-submodules`) is
> 	used, the work trees of submodules will not be updated. Just
> 	like linkgit:git-submodule[1], this will detach `HEAD` of the

`switch` is `checkout <branch>` under the hood, so that's also correct.

In light of these facts, I think the commit title should be :
doc: --recurse-submodules mostly applies to active submodules=
