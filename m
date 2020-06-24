Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CD5C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 02:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360A320874
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 02:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p411z+cA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387828AbgFXCSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 22:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387694AbgFXCSV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 22:18:21 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08B5C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 19:18:20 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f18so532003qkh.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 19:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lBsgsyZRzEYYMeMyQR/NmXkHj5CWWEFq9wzkmam1EIc=;
        b=p411z+cA4Pk5OGnzMHOBwHb974W5VKNt8j446ZMJ0Czj/4oO1yOGJzH41Mkq8zWqk/
         +xV0X4cAVGGVBSA/SmVmGlENdlnk8XQbzK6x8l1lsTdBBJP1i1ZF6hICB0eVG0lxME0H
         rFBLc7EJAo8nMf/iu0ftKs01/0yzey3MYpiQypC6Zmt5kN6PQe/sZM3uzVwbnO2x7sHf
         3sCHVB1GAJvYUfhHKZTfd4TqpuLFfjZ/Kcf9fqLSCJbfJjruOj1DxQfQ33gCjheqxB1j
         NxgnYSwihIKnPzi1ei3VdIEhta9dwqZoSI8ZrwwOr0eJbYaPPx1mI5SVpSW+dK9I8mG9
         JqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lBsgsyZRzEYYMeMyQR/NmXkHj5CWWEFq9wzkmam1EIc=;
        b=JD2vjyk079ceghz2xz7LKHttpNb0GN4Jryv/P7af8jLC07QHkIoUNTx8u+gHM38Fmq
         bp6VrSvnSsVGZiXAk1Ah43eLNChAMewUob39bN60rN+RVG28LjGtgxQaXd4V/kbT0BWt
         Dq327ZVubxrb6668K0/1acQ1KwcgypjSRdioGM8jvXGiR9kiZ2BzzFGTw7RGpeDZ8e73
         yAIb24VrTbpmw9FHqDeXWQDgyGThn2+7xOu1Mjk/OmOhlwoN8uOb3nQl/SShtsK54x+f
         Oo5g+UxDiDagO7KLinreBP6u1KUhG2//eSzJoICvPIeSGs3rx3xyGR/cQ99bDeAUPGcP
         o0Cw==
X-Gm-Message-State: AOAM530qUWibsuiAJYXbcBQvIX70Zk+gACrevWPXJNnt4GUS/IJlzcBr
        X2JbEFWaxPhOwwSbViZ2lo4=
X-Google-Smtp-Source: ABdhPJwcB8JsFqGec7UHvFp9Zfmg18XZ1+t2g8/Qh7JazZYXLOH7/pzntzKekVwLA/EsgoEMbftlDA==
X-Received: by 2002:a37:796:: with SMTP id 144mr7114600qkh.84.1592965099265;
        Tue, 23 Jun 2020 19:18:19 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id e11sm2270130qtp.67.2020.06.23.19.18.17
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 23 Jun 2020 19:18:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 3/8] submodule: use a better fall-back for missing remote.<name>.branch
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <6bda69541b12e93cfcf7b841b8691296dc82eeba.1592951611.git.gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 22:18:15 -0400
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D2ED942B-9397-472A-B017-190016531547@gmail.com>
References: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com> <pull.656.v3.git.1592951611.gitgitgadget@gmail.com> <6bda69541b12e93cfcf7b841b8691296dc82eeba.1592951611.git.gitgitgadget@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

> Le 23 juin 2020 =C3=A0 18:33, Johannes Schindelin via GitGitGadget =
<gitgitgadget@gmail.com> a =C3=A9crit :
>=20
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> When `remote.<name>.branch` is not configured, `git submodule update`
> currently falls back to using the branch name `master`. A much better
> idea, however, is to use `HEAD`: on all Git servers running reasonably
> recent Git versions, the symref `HEAD` points to the main branch.

To be pedantic, it is up to the maintainer/developers to make sure that=20=

HEAD on the canonic repository indeed points to the branch that is =
considered
the 'main' branch of the project; the Git version does not really matter =
IMO...
I've seen plenty of repos at work that have HEAD pointing to `master` =
but `master`=20
is not used, or not anymore...

> Note: t7419 demonstrates that there _might_ be use cases out there =
that
> _expect_ `git submodule update --remote` to update submodules to the
> remote `master` branch even if the remote `HEAD` points to another
> branch. Arguably, this patch makes the behavior more intuitive, but
> there is a slight possibility that this might cause regressions in
> obscure setups.
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

I think that's an excellent idea. However I'd be more explicit in the =
commit message title:
submodule: fall back to remote's HEAD for missing remote.<name>.branch

meta comment: I never know where is the best place to make suggestions
about changing the commit message title, since I can't quote it in my =
replies!

> ---
> Documentation/git-submodule.txt |  4 ++--
> builtin/submodule--helper.c     |  2 +-
> t/t7406-submodule-update.sh     | 16 ++++++++++++++++
> t/t7419-submodule-set-branch.sh |  7 +++++--
> 4 files changed, 24 insertions(+), 5 deletions(-)

I think Documentation/gitmodules.txt (`submodule.<name>.branch` header)
 should also be changed to reflect the behaviour change:=20

diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 67275fd187..539b4e1997 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -49,9 +49,9 @@ submodule.<name>.update::
=20
 submodule.<name>.branch::
 	A remote branch name for tracking updates in the upstream =
submodule.
-	If the option is not specified, it defaults to 'master'.  A =
special
-	value of `.` is used to indicate that the name of the branch in =
the
-	submodule should be the same name as the current branch in the
+	If the option is not specified, it defaults to the remote =
'HEAD'.
+	A special value of `.` is used to indicate that the name of the =
branch
+	in the submodule should be the same name as the current branch =
in the
 	current repository.  See the `--remote` documentation in
 	linkgit:git-submodule[1] for details.

> diff --git a/Documentation/git-submodule.txt =
b/Documentation/git-submodule.txt
> index c9ed2bf3d5..b20f85e622 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -284,7 +284,7 @@ OPTIONS
> 	`.gitmodules` for `update --remote`.  A special value of `.` is =
used to
> 	indicate that the name of the branch in the submodule should be =
the
> 	same name as the current branch in the current repository.  If =
the
> -	option is not specified, it defaults to 'master'.
> +	option is not specified, it defaults to 'HEAD'.

Just to be extra clear (it's easy to get confused with submodules!) I'd =
say explicitly:

If the option is not specified, it defaults to the remote 'HEAD'.

>=20
> -f::
> --force::
> @@ -322,7 +322,7 @@ OPTIONS
> 	the superproject's recorded SHA-1 to update the submodule, use =
the
> 	status of the submodule's remote-tracking branch.  The remote =
used
> 	is branch's remote (`branch.<name>.remote`), defaulting to =
`origin`.
> -	The remote branch used defaults to `master`, but the branch name =
may
> +	The remote branch used defaults to `HEAD`, but the branch name =
may

Same thing here:

The remote branch used defaults to the remote `HEAD`.

> 	be overridden by setting the `submodule.<name>.branch` option in
> 	either `.gitmodules` or `.git/config` (with `.git/config` taking
> 	precedence).

Also, you seem to have missed the `master` reference in the description =
of=20
the 'set-branch' subcommand. Something like this would do, I think:

diff --git a/Documentation/git-submodule.txt =
b/Documentation/git-submodule.txt
index c9ed2bf3d5..8cf5831a72 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -183,7 +183,7 @@ set-branch (-d|--default) [--] <path>::
 	Sets the default remote tracking branch for the submodule. The
 	`--branch` option allows the remote branch to be specified. The
 	`--default` option removes the submodule.<name>.branch =
configuration
-	key, which causes the tracking branch to default to 'master'.
+	key, which causes the tracking branch to default to the remote =
'HEAD'.
=20
 set-url [--] <path> <newurl>::
 	Sets the URL of the specified submodule to <newurl>. Then, it =
will


The rest of the patch looks good.

Cheers,
Philippe.

