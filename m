Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D7EC433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 17:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2118D608FB
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 17:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbhKBRJv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 13:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbhKBRJu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 13:09:50 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9EEC061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 10:07:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id f4so20250529edx.12
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 10:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=r9+zFS0l1zDpF4/Pu44l6TkdpHljELVZtgF4e6KVDvI=;
        b=ErCXoOJbE9V+G/lkCTpJmyBPR6602QecUiatlxWW/o/dDAzZctFDsaLDWZIlUei7RC
         CliirWwyt3y3ue+v254p2JNp0kWD4u00CGS6Rc6WqEQfzM4ZeNX2q2TKhusr5eZyXONj
         fyqXVQhFaVZkyLqXS7768WjWe5UghlidQfujZSigUYB8I4TIQYOjultIQXaXL05ZQcFN
         JQCloYktij/f9oY53vu8QhJQZH7NSoBn2SCnZbFUnqKPloZFsguzw8tOlX9zbL4qfv+L
         ydaf8jRvMa3+VGL7UkDi81CoP/gW+Vub/WfhQ4EmfzPNdeAWDYfXeZVL5vaO2yEP3rjZ
         8wzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=r9+zFS0l1zDpF4/Pu44l6TkdpHljELVZtgF4e6KVDvI=;
        b=YzFOXv9EsTUhvI6R1chp7/e+uavWPV20hVSFsNRiVkQtjuYGaOPgx8rbmUWgfN7x5Q
         xd2cJlbsmbVys9v+4bhj2eFrdjvvDUD2V8/BvFvf6Je/UCMIZp+RhahLHRQpu0qQtALm
         9oYn7f9tEQOlySDWzGgB1i1HxCQlzxsspCaYWvXTtr/sarcjPnew2qGKbXH1xlaqr1kq
         kFaF7ffIaxcFQd0aukgJSwVMKLZihB5KSR54WkDyM2GsDniQM8PuGYSmHxFx//6thTrZ
         WIUtsjJhmQ+MudoGonBnVOGJdjujNNn9dnAcqSH2qrWj5sfwzWMWVIK3YD+mT2IAk+jk
         8+WQ==
X-Gm-Message-State: AOAM531RanJ+8/FLoPWDCIJBwcpOBmGrtU+wzByzjZkJghL6nqhlceog
        x47gr25Vn6qMXK0Bhoz6DXU+6QIf880IVw==
X-Google-Smtp-Source: ABdhPJwFnNvcjMQq+73b9oNKlytiEfm61VKz5Wdrs4XxPnE91w2JAaOBJdxxas1gXC7VkOuzPJ1dkA==
X-Received: by 2002:a17:906:26da:: with SMTP id u26mr47000407ejc.315.1635872833910;
        Tue, 02 Nov 2021 10:07:13 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s28sm4100013edw.81.2021.11.02.10.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 10:07:13 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mhxFh-002ElO-39;
        Tue, 02 Nov 2021 18:07:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] var: add GIT_DEFAULT_BRANCH variable
Date:   Tue, 02 Nov 2021 17:53:46 +0100
References: <nycvar.QRO.7.76.6.2111021433010.56@tvgsbejvaqbjf.bet>
 <20211102164434.1005707-1-thomas@t-8ch.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <20211102164434.1005707-1-thomas@t-8ch.de>
Message-ID: <211102.86czni1o72.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 02 2021, Thomas Wei=C3=9Fschuh wrote:

> Introduce the builtin variable GIT_DEFAULT_BRANCH which represents the
> the default branch name that will be used by git-init.
>
> Currently this variable is equivalent to
>     git config init.defaultbranch || 'master'
>
> This however will break if at one point the default branch is changed as
> indicated by `default_branch_name_advice` in `refs.c`.
>
> By providing this command ahead of time users of git can make their
> code forward-compatible.
>
> Co-developed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas@t-8ch.de>
> ---
>
> Changes from v1 ( https://lore.kernel.org/git/20211030140112.834650-1-tho=
mas@t-8ch.de/ ):
> * Replaced the custom subcommand with an internal variable
> * Cleaned up the tests
>
> @Johannes: I replaced BUG() with die() from your example because that see=
ms to be
> nicer for user facing messages.
>
>  Documentation/git-var.txt |  3 +++
>  builtin/var.c             | 13 +++++++++++++
>  t/t0007-git-var.sh        | 19 +++++++++++++++++++
>  3 files changed, 35 insertions(+)
>
> diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
> index 6072f936ab..387cc1b914 100644
> --- a/Documentation/git-var.txt
> +++ b/Documentation/git-var.txt
> @@ -59,6 +59,9 @@ ifdef::git-default-pager[]
>      The build you are using chose '{git-default-pager}' as the default.
>  endif::git-default-pager[]
>=20=20
> +GIT_DEFAULT_BRANCH::
> +    The name of the first branch created in newly initialized repositori=
es.
> +
>  SEE ALSO
>  --------
>  linkgit:git-commit-tree[1]
> diff --git a/builtin/var.c b/builtin/var.c
> index 6c6f46b4ae..d1d82b6c93 100644
> --- a/builtin/var.c
> +++ b/builtin/var.c
> @@ -5,6 +5,7 @@
>   */
>  #include "builtin.h"
>  #include "config.h"
> +#include "refs.h"
>=20=20
>  static const char var_usage[] =3D "git var (-l | <variable>)";
>=20=20
> @@ -27,6 +28,17 @@ static const char *pager(int flag)
>  	return pgm;
>  }
>=20=20
> +static const char *default_branch(int flag)
> +{
> +	const char *name =3D repo_default_branch_name(the_repository, 1);
> +
> +	if (!name)
> +		die("could not determine the default branch name");

Isn't this die() unrechable given the similar logic in
repo_default_branch_name()? Hence the previous BUG(...)?

I really don't see how it makes sense to add this to "git var", we have
that to correspond to environment variables we use.

*Maybe* if we renamed GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME to
GIT_INITIAL_BRANCH_NAME and made it a non-test thing like
GIT_TEMPLATE_DIR, but even then shouldn't we be adding
"GIT_TEMPLATE_DIR" and any number of other things to this as well?

I'm not saying that your patch needs to do that, but we really should
think about the interface & future implications if we're going in this
direction.

The reason I suggested extending "git config" in [1] is because it seems
like a natural thing for "git config" to learn to spew out our idea of
default hardcoded config values to the user.

But creating a variable form of that existing config just so we can have
"git var" spew it out just seems weird.

We don't have or need such a variable now for anything else, so why go
through that indirection, instead of something that closes the feature
gap of asking what a config variable default is?

In any case whatever we do here this really should be updating the
documentation of init.defaultbranch & the relevant bits in the "git
init" manpage to add cross-references, similar to how we discuss
GIT_TEMPLATE_DIR now.

1. https://lore.kernel.org/git/211030.86ilxe4edm.gmgdl@evledraar.gmail.com/
