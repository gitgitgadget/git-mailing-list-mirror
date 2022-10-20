Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F68DC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 23:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiJTXTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJTXSz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 19:18:55 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA642303DC
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:18:55 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id u8-20020a170902e5c800b00185483ee4f5so452518plf.10
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vaStAgqt/lZLMBiHI1tim13TCzPjZzQXxkCywzj9cQ=;
        b=jEA7dqRE1VvoBAQio2kZ/M4/325nF1KfCIhHkye6Hh8Oz52jlhE7bNpu6z6XQrrq0J
         WeQ7fT1/hY5FTDa3QAtfAAtA4avJM6Ott0RB5Vtt0hsf5K2N6TGK3VWzEQHt6p8Ut47i
         DbYccvy+lF0nQevARD5Am22TZaynwokYwfqw+XpAPINGW+2MkrABhPVKaxSQ03FV70Cv
         SbKRfTHGazLq9g0JaHEoPgA0oxJvroJWXy37IZKe8iE4NFWOTLk6LChBDyZKIgviAQea
         k73uFy9wl5Adnthxpyjhj7PE/8fEUUA+VeBMM6mxHrKV5LbyCp2cB7NH0CkoqnI6TJzn
         BKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1vaStAgqt/lZLMBiHI1tim13TCzPjZzQXxkCywzj9cQ=;
        b=1yKLm+x/4eOoAOXq3Xaame4QtW2B6BjUfTbDjdkgWAUfYe8G5vTDPjhKsrID65oKJO
         k5GrP/k70IVQ7WS2KOJCOVTSCEBEwfvUEf8vdj1cIYdfe0i6akA2HGtdm9R2vliVPuoc
         JFnXnkDSN3JM7KSq7bovZxY5kC6WrC9hrgEWevouBiqazHOk3mTuJ/8cru0Mxxm4Bzx4
         HwTQ3Q/Xo4ejGnCpoM7uLpa4weggSCgbNG+GBhJmXy3Dn5EUWwJdNPVq05SpOcm/PFYt
         w9koMNvCabbSt6nwiB5DwoDdR2TTlId6FUD/Tlee380pbL6Xcw+0Vqp6PKDFaMQMum1i
         eqzQ==
X-Gm-Message-State: ACrzQf2BjIKmIeMDuKveLdM0J2EAdIDUx5OatF8vY0r9KzePzS/r96rG
        qW5VoTQQ8RtNf2iLGklM33OamMje+A1Jcw==
X-Google-Smtp-Source: AMsMyM5Tuyb+FvttHcQjoKOqWACbl9k20MERFAIBkcY6VFRekyjMWKLbrtO6buSxdGbkEubl0kC1oJ+uY7jp+g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:4ec6:b0:20a:96cd:2a46 with SMTP
 id v6-20020a17090a4ec600b0020a96cd2a46mr19040364pjl.171.1666307934559; Thu,
 20 Oct 2022 16:18:54 -0700 (PDT)
Date:   Thu, 20 Oct 2022 16:18:53 -0700
In-Reply-To: <patch-10.10-81f138e460c-20221017T115544Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com> <patch-10.10-81f138e460c-20221017T115544Z-avarab@gmail.com>
Message-ID: <kl6lk04uxew2.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 10/10] submodule: don't use a subprocess to invoke "submodule--helper"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonas Bernoulli <jonas@bernoul.li>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> In a preceding commit we created "builtin/submodule.c" and faithfully
> tried to reproduce every aspect of "git-submodule.sh", including its
> invocation of "git submodule--helper" as a sub-process.
>
> Let's do away with the sub-process and invoke
> "cmd_submodule__helper()" directly. Eventually we'll want to do away
> with "builtin/submodule--helper.c" altogether, but let's not do that
> for now to avoid conflicts with other in-flight topics. Even without
> those conflicts the resulting diff would be large. We can leave that
> for a later cleanup.

Thanks! e.g. this managed to avoid conflicts with my newly sent out
"submodule clone with branches" v2 [1]

[1] https://lore.kernel.org/git/pull.1321.v2.git.git.1666297238.gitgitgadge=
t@gmail.com

> It's also worth noting that some users were using e.g. "git
> submodule--helper list" directly for performance reasons[2]. With
> 31955475d1c (submodule--helper: remove unused "list" helper,
> 2022-09-01) released with v2.38.0 the "list" command was no longer
> provided.

[...]

> I think it would make sense to implement a "--format" option for "git
> submodule foreach" to help anyone who cares about that remaining
> performance (and to improve the API, e.g. by supporting "-z"), but as
> far as performance goes this makes the runtime acceptable again.

FWIW, I don't think that dropping "git submodule--helper list" was a
mistake, since all of "git submodule--helper" was meant to be internal
anyway. But if users find it useful, we could add actually supported
functionality like what you propose here.

> The pattern in "cmd_submodule_builtin()" of saving "struct strvec"
> arguments to a "struct string_list" and free()-ing them after the
> "argv" has been modified by "cmd_submodule__helper()" is new, without
> it we'd get various already-passing tests failing under SANITIZE=3Dleak.

[...]=20

> +static int cmd_submodule_builtin(struct strvec *args, const char *prefix=
)
> +{
> +	size_t i;
> +	struct string_list to_free =3D STRING_LIST_INIT_DUP;
> +	int ret;
> +
> +	/*
> +	 * The cmd_submodule__helper() will treat the argv as
> +	 * its own and modify it, so e.g. for "git submodule
> +	 * add" the "add" argument will be removed, and we'll
> +	 * thus leak from the strvec_push()'s in
> +	 * setup_helper_args().
> +	 *
> +	 * So in lieu of some generic "snapshot for a free"
> +	 * API for "struct strvec" squirrel away the pointers
> +	 * to free with string_list_clear() later.
> +	 */
> +	for (i =3D 0; i < args->nr; i++)
> +		string_list_append_nodup(&to_free, (char *)args->v[i]);
> +
> +	ret =3D cmd_submodule__helper(args->nr, args->v, prefix);
> +
> +	string_list_clear(&to_free, 0);

Hm, so this trick works because we init STRING_LIST_INIT_DUP to make the
string_list think that it owns its strings, but when we append, we use
string_list_append_nodup(), which doesn't dup the strings. This
'moves' the strings into the string_list and causes them to be freed
when we call string_list_clear().

Sounds reasonable enough to me, but I'm not an expert on leaks :)

> +	free(strvec_detach(args));
> +
> +	return ret;
> +}
> +
>  int cmd_submodule(int argc, const char **argv, const char *prefix)
>  {
>  	int opt_quiet =3D 0;
>  	int opt_cached =3D 0;
>  	int opt_recursive =3D 0;
> -	struct child_process cp =3D CHILD_PROCESS_INIT;
> +	struct strvec args =3D STRVEC_INIT;
>  	struct option options[] =3D {
>  		OPT__QUIET(&opt_quiet, N_("be quiet")),
>  		OPT_BOOL(0, "cached", &opt_cached,
> @@ -141,13 +169,10 @@ int cmd_submodule(int argc, const char **argv, cons=
t char *prefix)
>  	 * Tell the rest of git that any URLs we get don't come
>  	 * directly from the user, so it can apply policy as appropriate.
>  	 */
> -	strvec_push(&cp.env, "GIT_PROTOCOL_FROM_USER=3D0");
> -	setup_helper_args(argc, argv, prefix, opt_quiet, opt_cached,
> -			  opt_recursive, &cp.args, options);
> +	xsetenv("GIT_PROTOCOL_FROM_USER", "0", 1);
> =20
> -	cp.git_cmd =3D 1;
> -	cp.no_stdin =3D 0; /* for git submodule foreach */
> -	cp.dir =3D startup_info->original_cwd;
> +	setup_helper_args(argc, argv, prefix, opt_quiet, opt_cached,
> +			  opt_recursive, &args, options);
> =20
> -	return run_command(&cp);
> +	return cmd_submodule_builtin(&args, prefix);
>  }
> --=20
> 2.38.0.1091.gf9d18265e59
