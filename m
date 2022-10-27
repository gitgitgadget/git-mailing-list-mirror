Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599D3FA3740
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 22:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiJ0W34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 18:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiJ0W3y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 18:29:54 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38806C75B
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 15:29:52 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b12so5298457edd.6
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 15:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2J3ew2stIr8aH12eaiq4qYa6susN2FqV2pdGxsfo82Y=;
        b=LGeuFXOheMnrHgwJopg2APiicbbyQdEMzxwVbVXzn2SEoCtz/BBwB3HQ/HrF8DIm0Z
         JvYgr2gPkdJoZq8pw4DYhAUJNlQkSBjKm7DAGkvFbUzIJnuDym/Nyric4DHClnxleIKS
         d/yDAPdGad76zF+3ct6dZY5dQzmgshq8mCE2e3Y7M6QoIx4JNmsdVT2tvPR/yoj20seD
         bJpTnXz2pgpjWzwhbFKsnfwl6DmFrO2IFV9BMMEXD9NMavo0armdBxmnKbmBMgV/grbJ
         421f6gxKMvsFv6/UvSfxGrw5QRvrm0aqBmT32PdHfQ+Zq+NDmFfBuf7NXSTonGCrQAyk
         Miig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2J3ew2stIr8aH12eaiq4qYa6susN2FqV2pdGxsfo82Y=;
        b=Rc87b1cz+1C1GaBFBuLSuYimFJ8xriHxAysLgMSbHItn1B06ZjtgVjGKBJAhtKktX+
         MXYpzrtN7Y1Ai+uIKNI4z2xcmSL7uy8EOGod63LNkTM1w6akP/oL75yT68xVdPDumQkZ
         uc4Hg7Me4VYAb8d+jk9Uw9ZgYWoCry37b6tOanhfNqkLmXsxpqB9vs5xx5AIKTSmcFsC
         eNS6peS7pmZMTgl3t1OXYzOfnbwQmq+SKUp3oPH4n3moRbMcxu56ByHJbSO9wg9OLfMO
         6Dxh6weR664xUCvWxROXRJbBSDnu3nzce2pYosKN2hNeukaUHN+QPCZ3ZRc7+VXAKc62
         6K/g==
X-Gm-Message-State: ACrzQf0PFE24fLB4Sofv+PZZgAbeZ8JfeLFq2GShTgheTmB5+q/LK6Uz
        j2ezjJ9aGbCeREn/yD1kf4E=
X-Google-Smtp-Source: AMsMyM5b+HmeL8gLRzMtJjB00DCcGR1Fk3aFX+ywlaYec71UIw2ltyoj4S+qZFaE5fF83cidZuIwLg==
X-Received: by 2002:a05:6402:440c:b0:43a:1124:e56a with SMTP id y12-20020a056402440c00b0043a1124e56amr48794198eda.134.1666909791203;
        Thu, 27 Oct 2022 15:29:51 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id vs18-20020a170907139200b0078ddb518a90sm1288000ejb.223.2022.10.27.15.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 15:29:50 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ooBNl-009dK8-1e;
        Fri, 28 Oct 2022 00:29:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/8] bisect--helper: factor out do_bisect_run()
Date:   Fri, 28 Oct 2022 00:26:51 +0200
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <033ebd37-40c7-01bc-e9bb-29d738532125@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <033ebd37-40c7-01bc-e9bb-29d738532125@web.de>
Message-ID: <221028.86v8o4aoiq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 27 2022, Ren=C3=A9 Scharfe wrote:

> Deduplicate the code for reporting and starting the bisect run command
> by moving it to a short helper function.  Use a string array instead of
> a strvec to prepare the arguments, for simplicity.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  builtin/bisect--helper.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 28ef7ec2a4..70d1e9d1ad 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -1142,8 +1142,14 @@ static int get_first_good(const char *refname UNUS=
ED,
>  	return 1;
>  }
>
> -static int verify_good(const struct bisect_terms *terms,
> -		       const char **quoted_argv)
> +static int do_bisect_run(const char *command)
> +{
> +	const char *argv[] =3D { command, NULL };
> +	printf(_("running %s\n"), command);
> +	return run_command_v_opt(argv, RUN_USING_SHELL);
> +}
> +
> +static int verify_good(const struct bisect_terms *terms, const char *com=
mand)
>  {
>  	int rc;
>  	enum bisect_error res;
> @@ -1163,8 +1169,7 @@ static int verify_good(const struct bisect_terms *t=
erms,
>  	if (res !=3D BISECT_OK)
>  		return -1;
>
> -	printf(_("running %s\n"), quoted_argv[0]);
> -	rc =3D run_command_v_opt(quoted_argv, RUN_USING_SHELL);
> +	rc =3D do_bisect_run(command);
>
>  	res =3D bisect_checkout(&current_rev, no_checkout);
>  	if (res !=3D BISECT_OK)
> [...]

Okey, so we end up with a helper just for the convenience of doing that
printf at the start, that's fine.

But given the line count of some of the other changes, and
e.g. including the free(), oid_to_hex_r() to oid_to_hex() etc. in later
commits I don't see why we can't just make it use run_command()
directly.

I.e. I think it makes sense as one commit, but the conversion is easy
enough, easier than looking at the same code again later in the
series...
