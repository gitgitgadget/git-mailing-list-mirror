Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCAEC1975A
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 22:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0969C2070A
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 22:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkMPBVuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgCVWiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 18:38:51 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38108 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgCVWiu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 18:38:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id z12so10186117qtq.5
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 15:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SDPAgaWQk5bLyLIaw/YZq4rUJRFfXMrKHLttgihqKnU=;
        b=nkMPBVuL0fHnTpeyCMl/rC5kg0Vbydyxjk2XHlmh5xV97/9XTH9g0l/GgPwtCsJ8fU
         GQO4UuR/PwvmFI0dyJvK0aCln3ur/cyDfcQz2MVRCbqgDAIZoV8KYl5SMXWq4EdZYXPd
         L/Wngv7sZFlMLqDh4g3mhFNlAt7w00yfyLrwM+7MPIcONW0BPl2dOZqaGZHkibJq7CrJ
         G2r0BA2gFAIflTtdsQqTasS5+UuuKms7hNSTmF/Ap8WwyFfxaf1gBj17w4QzIFNsM2gH
         nz/34J9ylLisDfudMq20InpYge8cdK2+zsGfiY8xlutZVoBFq4neIXGHTNmTm5B7cQrH
         zIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SDPAgaWQk5bLyLIaw/YZq4rUJRFfXMrKHLttgihqKnU=;
        b=h4A9/dS+2EcNbFk0tu/4C39armF+7NMPRwVSmUhYCPPtLh/lTe26EIxuh2t9rdtBbE
         90Fl2evxVSTxDTkCeyVVTOFAp+Dm5X9fQg22lL/3tPe3yyKP4tlFJyqCF1PcKnhiaYb3
         pOnrzw1mltw+dsVK+wdyCjVzs4AVUkWwvfcrhUj6DLuT4omWrcvugGAiDXiokfpSsv6y
         ED6R/sib2NUhBzpk05EkxuPXdGodAC6+EYiLG1eNZzB2IS63+cXSiospE7HEuqUV4GTI
         zhReWSoD8yfL7/4h2JMjFKKVcrFR1a6svRlBgfvZ5pgMuLgdsQM1oKEJ/nepnD+stvwn
         nA5g==
X-Gm-Message-State: ANhLgQ1NiQMIQXm4+syeO52/MVgZ1ZBtA4Ow6ykx1U9kzwFmCK+2bz7F
        XqZwX24WoqdTUYPU9hK23vw=
X-Google-Smtp-Source: ADFU+vtGZQpKeYyi406kOilXwH1JBVTzArMt4ZjceQLHUaNpD60oyKOQ3T+Kxsy9IBZqgYjIjnjnLw==
X-Received: by 2002:ac8:d8e:: with SMTP id s14mr6289168qti.204.1584916729503;
        Sun, 22 Mar 2020 15:38:49 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id o67sm9353775qka.114.2020.03.22.15.38.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Mar 2020 15:38:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 5/5] doc: --recurse-submodules mostly only apply to active submodules
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200320213729.571924-6-damien.olivier.robert+git@gmail.com>
Date:   Sun, 22 Mar 2020 18:38:47 -0400
Cc:     git@vger.kernel.org,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3689E44D-AB57-448E-99AA-C5317373E825@gmail.com>
References: <20200320213729.571924-1-damien.olivier.robert+git@gmail.com> <20200320213729.571924-6-damien.olivier.robert+git@gmail.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 20 mars 2020 =C3=A0 17:37, Damien Robert =
<damien.olivier.robert@gmail.com> a =C3=A9crit

in the title, I'd drop the "only"
"mostly only apply" -> "mostly applies"

> :
>=20
> The documentation refers to "initialized" or "populated" submodules,
> to explain which submodules are affected by '--recurse-submodules', =
but
> the real terminology here is 'active' submodules. Update the
> documentation accordingly.
>=20
> Some terminology:
> - Active is defined in gitsubmodules(7), it only involves the
>  configuration variables 'submodule.active', 'submodule.<name>.active'
>  and 'submodule.<name>.url'. The function
>  submodule.c::is_submodule_active checks that a submodule is active.
> - Populated means that the submodule's working tree is present (and =
the
>  gitfile correctly points to the submodule repository), i.e. either =
the
>  superproject was cloned with ` --recurse-submodules`, or the user ran
>  `git submodule update --init`, or `git submodule init [<path>]` and
>  `git submodule update [<path]`

missing a closing '>' here (my mistake).

> separately which populated the
>  submodule working tree. This does not involve the 3 configuration
>  variables above.
> - Initialized (at least in the context of the man pages involved in =
this
>  patch) means both "populated" and "active" as defined above, i.e. =
what
>  `git submodule update --init` does.
>=20
> The --recurse-submodules option mostly affects submodules.

I think you meant  "mostly affects active submodules" here, right?

> An exception
> is `git fetch` where the option affects populated submodules.
> As a consequence, in `git pull` the fetch affects populated =
submodules,
> but the resulting working tree update only affects active submodules.
>=20
> In the documentation of `git-pull` we only refer to active submodules,
> since it is implicit that the fetching behaviour is governed by the
> fetch command.

This last paragraph is not a description of the current state of the =
code base,=20
but describes the changes introduced by this patch. As such, it's =
customary
to write it in the imperative mode. A simple suggestion to fix that:

s/we/let's/

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

I understand that the goal here is to make the formulation not too =
heavy, as you wrote in=20
https://lore.kernel.org/git/20200320222328.lynvrgqc35pvxxnl@doriath/. =
However I think the formulation=20
is awkward to begin with : commits are "fetched", but commits are not =
"updated", the submodules working tree=20
are updated. So maybe:

This option controls if new commits of populated submodules should be =
fetched,=20
and if the working trees of active submodules should be updated, too=
