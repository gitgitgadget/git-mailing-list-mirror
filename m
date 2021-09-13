Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4882BC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22CC7610A5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbhIMLYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 07:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238684AbhIMLYd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 07:24:33 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4BFC061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 04:23:18 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h17so3704636edj.6
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 04:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=7ofuRMQWbFMwckENgSl3aJCdARTEOfzrBJV5qWqvxNc=;
        b=UIiJetEBe5D6cV+fj101XuxRO+VZqQNkT4ng36BsK39TI05zkx6vJJc9cahkU1Pejn
         nT51HohO9htjEPmDPl1JoWndcfJoLtnCOdyPuIW4gvubZcjg5CKJei7YLgF+7MMiIGQT
         QSi4ufleiyvyecumG2w6L3DWjTKKcy03CnxQ06D/XtEii57tb1XuVV3FhwWrV3xTg8Ac
         NmU4da0OFVKcMEKqPHrp+L5gdj3AT1UCbPB/jGF4vAV4fKhnyJpz0PmSwG1QRC/ijD42
         7Z68HTA5tcuxAlSN8rGwpQRAEepMwxdsUTL0/AUzSLwP+N8s78UrSv7ht8JjRojkH1CP
         iRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=7ofuRMQWbFMwckENgSl3aJCdARTEOfzrBJV5qWqvxNc=;
        b=rfvagvvqwFZDf6aUnxYySxHEVR26693m2XkzIme9REQcxS8XvyWcskRCyFhlzbZ7I6
         iCQpbFxNRG4yYO8v0UEGcdLL1MO7Se4qL5Bu2WDnIiXd87bkkpSy5fRvYFSRhwSvZaBC
         VfsAIbjeiwLKb0z7H14eNp+vSMU92o4cezgGzeQIltbdAHtRV/5AWo6M1NyEVUTeIiAW
         468BoUxNjh1SPpwGxmZxFEl6exKY0/e5eJff+y9nlp2Bmfnl5pvnasBG1YQkvecsEdBY
         Z1wYgU75+ycaTzevwHZM2QvmpQQM1n2dojDziQ1wHUfZP0k9qDH6mpk00ROZ2eKgqi0Q
         dRZA==
X-Gm-Message-State: AOAM53378kZvfZlRfwJLHjUsDTMNwG5OpUT4w4WI3fW4OkGkZ06SrIn5
        w/DQxlBk0QZQgUlvNB1+zdY=
X-Google-Smtp-Source: ABdhPJwoRFEViyIfu6DUTr3PtUdmbWPdGA+zosyBkJf6Ohtqnzp7+UJbG/i7KcCAm1+rMHlbGtqOAw==
X-Received: by 2002:aa7:cf93:: with SMTP id z19mr4773152edx.202.1631532196737;
        Mon, 13 Sep 2021 04:23:16 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k22sm3279063eje.89.2021.09.13.04.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 04:23:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthias =?utf-8?Q?A=C3=9Fhauer?= via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Subject: Re: [PATCH 2/2] documentation: add documentation for 'git version'
Date:   Mon, 13 Sep 2021 13:19:11 +0200
References: <pull.1038.git.1631531218.gitgitgadget@gmail.com>
 <d3635cbfd6ef0d47ebf28c516476dcd0b718afd4.1631531219.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <d3635cbfd6ef0d47ebf28c516476dcd0b718afd4.1631531219.git.gitgitgadget@gmail.com>
Message-ID: <87r1ds4t3w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 13 2021, Matthias A=C3=9Fhauer via GitGitGadget wrote:

> From: =3D?UTF-8?q?Matthias=3D20A=3DC3=3D9Fhauer?=3D <mha1993@live.de>
>
> While 'git version' is probably the least complex git command,
> it is a non-experimental user-facing builtin command. As such
> it should have a help page.

This looks good

> Signed-off-by: Matthias A=C3=9Fhauer <mha1993@live.de>
> ---
>  Documentation/git-version.txt | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/git-version.txt
>
> diff --git a/Documentation/git-version.txt b/Documentation/git-version.txt
> new file mode 100644
> index 00000000000..c7d6b496c8d
> --- /dev/null
> +++ b/Documentation/git-version.txt
> @@ -0,0 +1,35 @@
> +git-version(1)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +git-version - Display version information about Git
> +
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git version' [--build-options]
>
> +
> +DESCRIPTION
> +-----------
> +
> +With no options given, the version of 'git' is printed
> +on the standard output.

Good

> +
> +If the option `--build-options` is given, information about how git was =
built is
> +printed on the standard output in addition to the version number.

Let's just cover this in the OPTIONS section you added...

> +Note that `git --version` is identical to `git version` because the
> +former is internally converted into the latter.

Probably better to just have a new section:

SEE ALSO
--------

linkgit:git[1]'s `--version` option, which dispatches to this command.


> +OPTIONS
> +-------
> +--build-options::
> +	Prints out additional information about how git was built for diagnostic
> +	purposes.
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite


It would also be good to update git.txt, which now says:

    Prints the Git suite version that the git program came from

To say e.g. "Dispatches to linkgit:git-version[1], prints the git
program version".

Or something like that, i.e. to cross-link the two.
