Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5F5C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 12:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbiKKM6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 07:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbiKKM6K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 07:58:10 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085627E9B7
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 04:58:06 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id bj12so12303742ejb.13
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 04:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/fSAPySOPwnzx2dTwz7vaqgIv5j+EAHFXnlDzNIGC7c=;
        b=PtA5wh8aTtRPqrvMo8cRqPaFU5eWVsMDoeV4RPSRWR3n4yUY5osPgDiCV4/LoIkciH
         qkxwMKKMIsin5GOxjePrqLoR5ftUuZX5hwf3NrXPVtcoHb3kbes4D733FRRzvzCURAJF
         cOFFm5erZsoL9Gk81YGqQdMb0KTAqVQpGk/sVD2C0bw80AlPNn9ef+Xh2Re7gL+NHXk1
         EDKySz0FPGnklqMa71Qj+QIIgjgq0mECl0pLmaZToIeJc/Po0LI4ByQd7axZHpGczTo3
         SlW+KXLXy8d6i27xk8ps7/KSo2xNXSjfbzBMd3eg1osIdOMHcvJf6/ZRlnWbhmsLhB8U
         /tPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/fSAPySOPwnzx2dTwz7vaqgIv5j+EAHFXnlDzNIGC7c=;
        b=XhaLqw7taAZxIf86trJIC3d8NaZxoueUCoRZZf6y62azb4Yo+wAX93B21V2mmTAM3F
         y1DZXIhzcC6URk/av126KMfiXZXtORXK5Zya59aQNAlyxuZ3zYmbQjjMS6cVmjnuq5Qm
         0QfKOU+rpJ2FZYiIHzR9aNG13AJRvTVcBKZI2Va+LGkWetkAoNNWNIlpPO7AelolrGBP
         aXAtyA+bek1N+fs7YUkfDd+nrLWRV0sWwg3E7xoqSJ2+oMA2lCuZq/tGe1OVPzUSt8LP
         cgms/3RkrnZO/Xw/tSpxvOzx+zPPql8EpPosjubeXWxFk+HDitzOA7Jk6JCQtbFKotHW
         XQyw==
X-Gm-Message-State: ANoB5pl4JaFqb69Mt7oZVEnMP/dk7jzqQd9JybL46mRD1pR4Y0TTN2o/
        YJVSSOFXmdJk1CWSZYAyxic=
X-Google-Smtp-Source: AA0mqf6tlU2j0lER129yVgqhktAFanxKeMSSq9iuXrbxItDFJgBBkZ7Qk6YRlIUEhYAll8+GAT8ziA==
X-Received: by 2002:a17:907:8b8d:b0:7ae:937f:2c38 with SMTP id tb13-20020a1709078b8d00b007ae937f2c38mr1776841ejc.201.1668171484614;
        Fri, 11 Nov 2022 04:58:04 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id c8-20020a056402120800b0045726e8a22bsm1063464edw.46.2022.11.11.04.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 04:58:04 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1otTbf-001sMz-1w;
        Fri, 11 Nov 2022 13:58:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 1/3] bisect--helper: remove unused options
Date:   Fri, 11 Nov 2022 13:42:44 +0100
References: <cover.1667561761.git.congdanhqx@gmail.com>
 <cover.1668097286.git.congdanhqx@gmail.com>
 <6b80fd93980ec5171fe0637cbd1a8173a5337da4.1668097286.git.congdanhqx@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <6b80fd93980ec5171fe0637cbd1a8173a5337da4.1668097286.git.congdanhqx@gmail.com>
Message-ID: <221111.86r0y9odgk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 10 2022, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> 'git-bisect.sh' used to have a 'bisect_next_check' to check if we have
> both good/bad, old/new terms set or not.  In commit 129a6cf344
> (bisect--helper: `bisect_next_check` shell function in C, 2019-01-02),
> a subcommand for bisect--helper was introduced to port the check to C.
> Since d1bbbe45df (bisect--helper: reimplement `bisect_run` shell
> function in C, 2021-09-13), all users of 'bisect_next_check' was
> re-implemented in C, this subcommand was no longer used but we forgot
> to remove '--bisect-next-check'.



> 'git-bisect.sh' also used to have a 'bisect_write' function, whose
> third positional parameter was a "nolog" flag.  This flag was only used
> when 'bisect_start' invoked 'bisect_write' to write the starting good
> and bad revisions.  Then 0f30233a11 (bisect--helper: `bisect_write`
> shell function in C, 2019-01-02) ported it to C as a command mode of
> 'bisect--helper', which (incorrectly) added the '--no-log' option,
> and convert the only place ('bisect_start') that call 'bisect_write'
> with 'nolog' to 'git bisect--helper --bisect-write' with 'nolog'
> instead of '--no-log', since 'bisect--helper' has command modes not
> subcommands, all other command modes see and handle that option as well.
> This bogus state didn't last long, however, because in the same patch
> series 06f5608c14 (bisect--helper: `bisect_start` shell function
> partially in C, 2019-01-02) the C reimplementation of bisect_start()
> started calling the bisect_write() C function, this time with the
> right 'nolog' function parameter. From then on there was no need for
> the '--no-log' option in 'bisect--helper'. Eventually all bisect
> subcommands were ported to C as 'bisect--helper' command modes, each
> calling the bisect_write() C function instead, but when the
> '--bisect-write' command mode was removed in 68efed8c8a
> (bisect--helper: retire `--bisect-write` subcommand, 2021-02-03) it
> forgot to remove that '--no-log' option.
> '--no-log' option had never been used and it's unused now.

FWIW I think this very long backstory can be condensed to just (mainly
trying to get some paragraph breaks in there):

	The "--no-log" option has never been used. It was added in
	0f30233a11f (bisect--helper: `bisect_write` shell function in C,
	2019-01-02).

        In that commit bisect_write() was also changed to take a
	"no_log" function parameter, with nothing providing the
	"--no-log" option, and "bisect--helper --bisect-write" being
	given an unused "nolog" parameter.

        Then, later in the same series 06f5608c14e (bisect--helper:
        `bisect_start` shell function partially in C, 2019-01-02) the
        code passing the unused "nolog" parameter went away, while
        leaving us with this unused "--no-log" code.

> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gma=
il.com>
> ---
>  builtin/bisect--helper.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 1d2ce8a0e1..5ec2e67f59 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -1283,7 +1283,6 @@ int cmd_bisect__helper(int argc, const char **argv,=
 const char *prefix)
>  {
>  	enum {
>  		BISECT_RESET =3D 1,
> -		BISECT_NEXT_CHECK,
>  		BISECT_TERMS,
>  		BISECT_START,
>  		BISECT_AUTOSTART,
> @@ -1295,12 +1294,10 @@ int cmd_bisect__helper(int argc, const char **arg=
v, const char *prefix)
>  		BISECT_VISUALIZE,
>  		BISECT_RUN,
>  	} cmdmode =3D 0;
> -	int res =3D 0, nolog =3D 0;
> +	int res =3D 0;
>  	struct option options[] =3D {
>  		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
>  			 N_("reset the bisection state"), BISECT_RESET),
> -		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
> -			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
>  		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
>  			 N_("print out the bisect terms"), BISECT_TERMS),
>  		OPT_CMDMODE(0, "bisect-start", &cmdmode,
> @@ -1319,8 +1316,6 @@ int cmd_bisect__helper(int argc, const char **argv,=
 const char *prefix)
>  			 N_("visualize the bisection"), BISECT_VISUALIZE),
>  		OPT_CMDMODE(0, "bisect-run", &cmdmode,
>  			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
> -		OPT_BOOL(0, "no-log", &nolog,
> -			 N_("no log for BISECT_WRITE")),
>  		OPT_END()
>  	};
>  	struct bisect_terms terms =3D { .term_good =3D NULL, .term_bad =3D NULL=
 };

This looks good. Is it your original work, or did the signed-off-by's go
missing along the way? I.e. in the greater history of this topic this
comes from Johannes's:

	https://lore.kernel.org/git/1e43148864a52ffe05b5075bd0e449c0e056f078.16618=
85419.git.gitgitgadget@gmail.com/
	https://lore.kernel.org/git/05262b6a7d1b20a0d2f2ca2090be284ffb8c679c.16618=
85419.git.gitgitgadget@gmail.com/

Which, when I re-rolled it I carried forward as:

	https://lore.kernel.org/git/patch-04.13-b10deee4827-20221104T132117Z-avara=
b@gmail.com/

So I assumed you went back and looked at the original topic...

In any case, if you are doing a "misc little cleanups" series, I think
lifting some more from Johannes's original topic might be useful> I
dropped some in my 13 patch re-roll to keep it more focused on just the
"bisect built-in" goal, e.g. there's:

	https://lore.kernel.org/git/f2132b61ff7d7959fd8efcd9d416736b154718f0.16618=
85419.git.gitgitgadget@gmail.com/
	https://lore.kernel.org/git/4f93692e071cf316fd391344b5dbbc995c162232.16618=
85419.git.gitgitgadget@gmail.com/

But maybe those are better left out/or submitted as *another* topic,
just pointing them out in case you missed them...
