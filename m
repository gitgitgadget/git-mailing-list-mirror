Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF73C433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 14:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243586AbiATOAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 09:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242624AbiATOAP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 09:00:15 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72351C061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 06:00:15 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id u18so14909171edt.6
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 06:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=wtk2BH2FSTXRLtbUhuw7AEeq43oP+asFkyA6aM6yQ3w=;
        b=gyfIabTB7ure83VAqhcHDnioFAc18Cpgw6rECOsOD2c7DSObl4PaCojKWsRxzDP5G3
         FyfZ8KkgeLdPE/FkG6ucRuunsD81107PS6oaJiTRZd3NrDt3aLvqHE4qBUFnVMKWfSMr
         ccKdKh/dtjGXFe4R68pdgCP1GLqLLwY2xT2VgJPhQaEzFLT6cL/phTK4nxPD0j5r5MVt
         U1KlMEy2roScsuEUEZK3KC5IND1maDYPWzb9hKpeZ/us0partUuZ6jA8HE6akleWfc4N
         eO8bqUslQniqY1FxQXPYO0whyaS2kwbP5RJFPfp44VzIIxc+SCAdDvNCutVgAOQIUwRN
         4TPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=wtk2BH2FSTXRLtbUhuw7AEeq43oP+asFkyA6aM6yQ3w=;
        b=E4mbVkDLArk4/32v345nvihDtmbVmfUNBc3FNhBed/bIkU11kI3nohjxTJEbq3cLTY
         1yRFOFn0orUOj1V1/xwQ6kRti/XfYy6XHTUvVst+hASvua2goww/SmFvyPS0WZsQ0Tdy
         10/UBFHe6jv3IVbFK5j36wkn9LaGwMDr6EaeJQUUic1hqN5qsJ/eTaGRRM5GmgKsSP64
         9auYXnbkKKqGezZ074V8/PMpf6hM9yUzMZ16hLtZ0Jkirkx2wQXKBcyEt5mMP/U0xVJY
         fNngwsgauEu+IB57SLjPwrbWOAAQNNfsYrsW8NbWLbyV0ERtQfbq2ZsOVurKMUTc0tZP
         h2Ig==
X-Gm-Message-State: AOAM53311Xnd9GvBQD+F6Bt+J26Dy0v+E9+xrjb/pSdGBSQ3nSumU8wO
        HtUFCwf+NN4cJkX6ElXH5hk=
X-Google-Smtp-Source: ABdhPJzJpvtQy/Fp0SGuMR0IWtrrxXLENGGVBJdgvHjp3e1Gqxay+3AR7MjAV3Y7FRWh90xP+46ahA==
X-Received: by 2002:a05:6402:1bcc:: with SMTP id ch12mr7573297edb.227.1642687213761;
        Thu, 20 Jan 2022 06:00:13 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o13sm1386255edj.58.2022.01.20.06.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 06:00:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nAXz2-0021Ub-Mt;
        Thu, 20 Jan 2022 15:00:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        chooglen@google.com, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch,checkout: fix --track documentation
Date:   Thu, 20 Jan 2022 14:57:49 +0100
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1640039978.git.steadmon@google.com>
 <dcba40e2c4001611f837f612cc5ee7890c653aff.1640039978.git.steadmon@google.com>
 <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
 <55d5327a-9c6c-7fd8-b540-e710259c0694@web.de>
 <220120.864k5ymx55.gmgdl@evledraar.gmail.com>
 <c3c26192-aee9-185a-e559-b8735139e49c@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <c3c26192-aee9-185a-e559-b8735139e49c@web.de>
Message-ID: <220120.86v8yeld77.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 20 2022, Ren=C3=A9 Scharfe wrote:

> Document that the accepted variants of the --track option are --track,
> --track=3Ddirect, and --track=3Dinherit.  The equal sign in the latter two
> cannot be replaced with whitespace; in general optional arguments need
> to be attached firmly to their option.
>
> Put "direct" consistently before "inherit", if only for the reasons
> that the former is the default, explained first in the documentation,
> and comes before the latter alphabetically.
>
> Mention both modes in the short help so that readers don't have to look
> them up in the full documentation.  They are literal strings and thus
> untranslatable.  PARSE_OPT_LITERAL_ARGHELP is inferred due to the pipe
> and parenthesis characters, so we don't have to provide that flag
> explicitly.
>
> Mention that -t has the same effect as --track and --track=3Ddirect.
> There is no way to specify inherit mode using the short option, because
> short options generally don't accept optional arguments.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  Documentation/git-branch.txt   | 12 ++++++------
>  Documentation/git-checkout.txt |  2 +-
>  builtin/branch.c               |  2 +-
>  builtin/checkout.c             |  2 +-
>  4 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 2d52ae396b..731e340cbc 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -16,7 +16,7 @@ SYNOPSIS
>  	[--points-at <object>] [--format=3D<format>]
>  	[(-r | --remotes) | (-a | --all)]
>  	[--list] [<pattern>...]
> -'git branch' [--track [direct|inherit] | --no-track] [-f] <branchname> [=
<start-point>]
> +'git branch' [--track[=3D(direct|inherit)] | --no-track] [-f] <branchnam=
e> [<start-point>]
>  'git branch' (--set-upstream-to=3D<upstream> | -u <upstream>) [<branchna=
me>]
>  'git branch' --unset-upstream [<branchname>]
>  'git branch' (-m | -M) [<oldbranch>] <newbranch>
> @@ -206,7 +206,7 @@ This option is only applicable in non-verbose mode.
>  	Display the full sha1s in the output listing rather than abbreviating t=
hem.
>
>  -t::
> ---track [inherit|direct]::
> +--track[=3D(direct|inherit)]::
>  	When creating a new branch, set up `branch.<name>.remote` and
>  	`branch.<name>.merge` configuration entries to set "upstream" tracking
>  	configuration for the new branch. This
> @@ -216,11 +216,11 @@ This option is only applicable in non-verbose mode.
>  	upstream when the new branch is checked out.
>  +
>  The exact upstream branch is chosen depending on the optional argument:
> -`--track` or `--track direct` means to use the start-point branch itself=
 as the
> -upstream; `--track inherit` means to copy the upstream configuration of =
the
> -start-point branch.
> +`-t`, `--track`, or `--track=3Ddirect` means to use the start-point bran=
ch
> +itself as the upstream; `--track=3Dinherit` means to copy the upstream
> +configuration of the start-point branch.
>  +
> -`--track direct` is the default when the start point is a remote-trackin=
g branch.
> +`--track=3Ddirect` is the default when the start point is a remote-track=
ing branch.
>  Set the branch.autoSetupMerge configuration variable to `false` if you
>  want `git switch`, `git checkout` and `git branch` to always behave as i=
f `--no-track`
>  were given. Set it to `always` if you want this behavior when the
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.=
txt
> index 2a90ea6cd0..9f37e22e13 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -156,7 +156,7 @@ of it").
>  	linkgit:git-branch[1] for details.
>
>  -t::
> ---track [direct|inherit]::
> +--track[=3D(direct|inherit)]::

These changes (and the below) all look good to me. Thanks for fixing
this.

>  	When creating a new branch, set up "upstream" configuration. See
>  	"--track" in linkgit:git-branch[1] for details.

As a side-note this "--track" reference is incorrect, and has been since
d3115660b4c (branch: add flags and config to inherit tracking,
2021-12-20), i.e. it should now mention "--track[=3D(direct|inherit)]".

But as we're not explicitly cross-linking anything here with the
relevant syntax I think leaving it as-is is fine, the user would also
find it with a substring search.
