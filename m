Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAE5C55179
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 13:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9ECD20709
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 13:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sju/szcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900512AbgJ0NNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 09:13:45 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36306 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900509AbgJ0NNp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 09:13:45 -0400
Received: by mail-qk1-f194.google.com with SMTP id r7so1042694qkf.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2+9O9rWbY7LJTY6VOUeKydMP5nNh9OSbApbFUQQHh7I=;
        b=Sju/szcmCGPipfUgQ1EbBIBYknr0m8RZ7pXt0TGsZ8ykxBgXD3QKT3LfaW8OxBctmu
         R8MSAQB2alo/iGWl22tbDIf8Od7DOTm7Rf2cO41ReEYASrpxEZXvNhRTpqF9vqJaCv8L
         6pDdGhkIXuG31zU4BCLwW9LD5oNFPKxo6pqntxRWHcSrVBNyqtrDE/9bU4Ya5XD34g6W
         kxInu0LIL7XcoskoYsWF987be1SxjJKDTF5XcWyaq+3xzOpm4VoW86UM+locKfa/OjWd
         qvl12DWg2PyRt/oYPHgS9vgOSWMfr6Kcxx2jegQrQvwurRIMWKPN59ehUL+Tk8LYWCo7
         zQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2+9O9rWbY7LJTY6VOUeKydMP5nNh9OSbApbFUQQHh7I=;
        b=PwXtjWHnnXa/xPAY2aN0LMtA7/kL2vflfnGOnYJ1eW+XqxLlPKmSgVefBSeUut0Hrv
         qf3pXo95Lg/zqDOV8E+rAJdeQBo7rlEuV6lthkNPQwmbKL9JSdG7m1ae/j76OdVDk1j7
         Y5dU73bxwB2AYpde3QHP2GvyPi6dM0xS0xAb9jja/VAQA/XCYuGpmsByp0JEzVaZgG5r
         yrpchcVhgU3bQ5clhs9LTn8N1ttefO+xXL6ICfUDI2L17LBM1VX/tcyFYCA/whC5KdSU
         jy+tbHXyl7dMHp4y/QrO1DwaUg29Z9L/NWuzRp7yxYe0vHBOuQry1s0Xqb65DtLF3mL6
         gsZw==
X-Gm-Message-State: AOAM5335GyA1MP/sVVIQBR8eVSsAGuexxXKEC/aBj52FdpBy5umqVrF5
        urKTvEeM4jmYldi7hgzJutw=
X-Google-Smtp-Source: ABdhPJy4v3BVijzCJBiXarL0dnmWyJ9bZvfoHL9P+yW8NavGONcYimCrUIYZ9+lakL+dj20yLfyDEw==
X-Received: by 2002:a05:620a:986:: with SMTP id x6mr2008398qkx.434.1603804423012;
        Tue, 27 Oct 2020 06:13:43 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id a200sm622311qkb.66.2020.10.27.06.13.41
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2020 06:13:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3] clone: document partial clone section
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <pull.745.v3.git.git.1603768321361.gitgitgadget@gmail.com>
Date:   Tue, 27 Oct 2020 09:13:40 -0400
Cc:     Git mailing list <git@vger.kernel.org>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C9D6F2D9-7BA3-469D-B903-DB0B389C9166@gmail.com>
References: <pull.745.v2.git.git.1586791560.gitgitgadget@gmail.com> <pull.745.v3.git.git.1603768321361.gitgitgadget@gmail.com>
To:     Teng Long via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dyrone,

> Le 26 oct. 2020 =C3=A0 23:12, Teng Long via GitGitGadget =
<gitgitgadget@gmail.com> a =C3=A9crit :
>=20
> From: Dyrone Teng <dyroneteng@gmail.com>
>=20
> Partial clones are created using 'git clone', but there is no related
> help information in the git-clone documentation during a period. Add
> a relevant section to help users understand what partial clones are
> and how they differ from normal clones.
>=20
> The section briefly introduces the applicable scenarios and some
> precautions of partial clone. If users want to know more about its
> technical design and other details, users can view the link of
> git-partial-clone(7) according to the guidelines in the section.
>=20
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>    clone: document partial clone section
>=20
>    Partial clones are created using 'git clone', but there is no =
related
>    help information in the git-clone documentation during a period. =
Add a
>    relevant section to help users understand what partial clones are =
and
>    how they differ from normal clones.
>=20
>    The section briefly introduces the applicable scenarios and some
>    precautions of partial clone. If users want to know more about its
>    technical design and other details, users can view the link of
>    git-partial-clone(7) according to the guidelines in the section.

Since your series has just the one patch now, you don't need to add a =
description
in your GitGitGadget (GGG) PR. That's why it appears two times here:
the text above the '---' is the commit message, and the text below is =
the PR description.
In the context of a one-patch series, you can use this space to add =
additional info that=20
do not fit into the commit message, for example questions about your =
patch, etc.
It is also a good idea (and viewed positively by reviewers) to use it to =
add a summary of what changed
in your series since the last version you sent. I encourage you to read =
MyFirstContribution [1]
for a good tutorial on the contribution process. Also, GGG understands =
that if you end your
PR description with a line starting with "CC:" and an email address, =
further iterations of your=20
series will be sent to those email addresses. So it would have been good =
to add Stolee in there, like this:

CC: Derrick Stolee <stolee@gmail.com>

(Junio prefers not to be directly CC'ed).

> Published-As: =
https://github.com/gitgitgadget/git/releases/tag/pr-git-745%2Fdyrone%2Fmas=
ter-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git =
pr-git-745/dyrone/master-v3
> Pull-Request: https://github.com/git/git/pull/745
>=20
> Range-diff vs v2:
>=20
> 1:  6f340d9aad < -:  ---------- partial-clone: set default filter with =
--partial
> 2:  9baf4c8ba3 < -:  ---------- clone: document --partial and --filter =
options
> 3:  c1a44a3509 ! 1:  681c5dcb79 clone: document partial clone section
>     @@ Commit message
>          clone: document partial clone section
>=20
>          Partial clones are created using 'git clone', but there is no =
related
>     -    help information in the git-clone documentation. Add a =
relevant section
>     -    to help users understand what partial clones are and how they =
differ
>     -    from normal clones.
>     +    help information in the git-clone documentation during a =
period. Add
>     +    a relevant section to help users understand what partial =
clones are
>     +    and how they differ from normal clones.

It appears that you sent the same version of the patch as in v1, instead
of the one you sent in v2 ? You had removed "during a period"  for v2,=20=

but here it pops up again. You should check that you've sent the more=20
up to date version of your patch, before sending v4.

I will not comment on the patch below, since it's not the more =
up-to-date.
I will send comments shortly on the v2 version by replying to [2] (the =
v2 version=20
of your patch).

Cheers,

Philippe.

[1] https://git-scm.com/docs/MyFirstContribution
[2] =
https://lore.kernel.org/git/c1a44a35095e7d681c312ecaa07c46e49f2fae67.15867=
91560.git.gitgitgadget@gmail.com/=
