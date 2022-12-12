Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387C6C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 18:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiLLSTx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 13:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiLLSTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 13:19:25 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC376351
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 10:19:10 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id kw15so30227572ejc.10
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 10:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DdGwvmIWdpIkGM1Lej6Bn/U7TgCEK0A4KO/qycUK1rk=;
        b=ikPk1V65E21+EYTYGly5n8Pi5GsRg5IlBFuk+t/imnIYXw291hL7mzWTFWXcmX169W
         J3/3bwNyRI8HZiiyXSudPd1+9IGNnziaI9mssgStkSqUR4TgVneiZxgTOF3dJ8HvYhvy
         /r0npPDWuv/YHzgYemIixivKqQKQ6/RHWIcGm0Z+tc1OQGK2w92bBIr58HUqnr53IDFp
         B/VK4frnweK39oC5U5XY3SIrl8akMXO8thyQvvnECpC0+7QxEoX3nXVsfz/WJVTaxTq9
         XH2TUglAQy9ZNvtx9WaZ4bka+mrKpijoJ5y0+AC0IJwn3Ce7vDrkBDI1P/bcNEPavAbp
         vdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DdGwvmIWdpIkGM1Lej6Bn/U7TgCEK0A4KO/qycUK1rk=;
        b=bHycPgrVQ7FPHGl7Gl1+/tsb5aRZNG26ftdap3g9XssAfB6OG7aZphcXDwtGuUZRMS
         +JungUJcGeueath4hDjltwXWm+gcPf5wOFyzFo0OcLoO8uqVSDu6hRFFxxOB9v7MhMUm
         0Fpe40ttck4UM3vPvrjhpoghbuhFlKA2eA6JVQIRGHVs+RCwccNVxzPG5icjjoHaQ9cQ
         DcSrtO8iteMpOUYI7DINqU6oZ3IKHVeX5kbCY8ZN3+0HX12ZZBTrcRJs+iX3SpVhD8IR
         UNzYcs/geI6riCjRHFU3SzZ5vytSPKU5uvbaL1LLx6J9jnBshC0whn8L7pj5/VhAkcCR
         oDKw==
X-Gm-Message-State: ANoB5pndob7S9B3RddgnX7e+cNaai93LDgCwozOqN/FTbDA49rLIsBUK
        O4aGcWoco4ysqKZF85D2pCo=
X-Google-Smtp-Source: AA0mqf6wbfN59mB6W0WdFQLy0b1Xmf52i0EMtGes+lA/1lMAlbtFWAtX/TpENNqrF09d/fldWKplDQ==
X-Received: by 2002:a17:906:4946:b0:7ad:ca80:5669 with SMTP id f6-20020a170906494600b007adca805669mr20471645ejt.64.1670869149073;
        Mon, 12 Dec 2022 10:19:09 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id h22-20020a170906591600b007bdc2de90e6sm3552235ejq.42.2022.12.12.10.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:19:08 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p4nOO-005Rlo-0U;
        Mon, 12 Dec 2022 19:19:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v4 3/3] worktree add: Add hint to use --orphan when bad ref
Date:   Mon, 12 Dec 2022 19:16:38 +0100
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev>
 <20221212014003.20290-1-jacobabel@nullpo.dev>
 <20221212014003.20290-4-jacobabel@nullpo.dev>
 <221212.86pmcp57w4.gmgdl@evledraar.gmail.com>
 <20221212145913.aftjeq6kn55zbkai@phi>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221212145913.aftjeq6kn55zbkai@phi>
Message-ID: <221212.86zgbs4h9f.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 12 2022, Jacob Abel wrote:

> On 22/12/12 09:35AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> On Mon, Dec 12 2022, Jacob Abel wrote:
>>
>> >  int git_default_advice_config(const char *var, const char *value);
>> > diff --git a/builtin/worktree.c b/builtin/worktree.c
>> > index 51b247b2a7..ea306e18de 100644
>> > --- a/builtin/worktree.c
>> > +++ b/builtin/worktree.c
>> > @@ -744,6 +744,14 @@ static int add(int ac, const char **av, const cha=
r *prefix)
>> >  		 * If `branch` does not reference a valid commit, a new
>> >  		 * worktree (and/or branch) cannot be created based off of it.
>> >  		 */
>> > +		advise_if_enabled(ADVICE_WORKTREE_ADD_ORPHAN,
>> > +			"If you meant to create a worktree containing a new orphan branch\=
n"
>> > +			"(branch with no commits) for this repository, e.g. '%s',\n"
>>
>> I think this '%s' is just confusing, how is repeating the name of the
>> branch at the user (which we're about to mention in the example command)
>> helpful?
>>
>> Shouldn't we just omit it, or reword this to e.g.:
>>
>> 	If you'd like the '%s' branch to be a worktree containing a
>> 	new....
>>
>>
>> > +			"you can do so using the --orphan option:\n"
>> > +			"\n"
>> > +			"	git worktree add --orphan %s %s\n"
>> > +			"\n",
>
> Done.
>
>>
>> Missing the usual:
>>
>> 	"Turn this message off by running\n"
>> 	"\"git config advice.worktreeAddOrphan false\""
>>
>> blurb.
>
> That blurb is added at runtime by `advise_if_enabled()`. I originally add=
ed it
> but it was giving me the line twice so I took it out.

Ah, sorry. I just forgot it did that. Looks good then!


> The following are what I have made for this set of changes (against v4).
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 8bb1453e0f..38f7a27927 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -732,12 +732,11 @@ static int add(int ac, const char **av, const char =
*prefix)
>         } else if (!lookup_commit_reference_by_name(branch)) {
>                 advise_if_enabled(ADVICE_WORKTREE_ADD_ORPHAN,
>                         "If you meant to create a worktree containing a n=
ew orphan branch\n"
> -                       "(branch with no commits) for this repository, e.=
g. '%s',\n"
> -                       "you can do so using the --orphan option:\n"
> +                       "(branch with no commits) for this repository, yo=
u can do so\n"
> +                       "using the --orphan option:\n"
>                         "\n"
> -                       "       git worktree add --orphan %s %s\n"
> -                       "\n",
> -                        new_branch, new_branch, path);
> +                       "       git worktree add --orphan %s %s\n",
> +                        new_branch, path);

Looks good, we'd usually put the "new_branch, path" on the previous line
(to the extent that it fits within 79 chars.

Also: This string should use _() to mark this for translation.

> -# Helper function to test hints for using --orphan in an empty repo.
>  test_wt_add_empty_repo_orphan_hint() {
> -       local context=3D"$1" &&
> -       local opts=3D"${@:2}" &&
> +       local context=3D"$1"
> +       shift
> +       local opts=3D"$@"
>         test_expect_success "'worktree add' show orphan hint in empty rep=
o w/ $context" '
>                 test_when_finished "rm -rf empty_repo" &&
>                 GIT_DIR=3D"empty_repo" git init --bare &&
> -               test_must_fail git -C empty_repo worktree add $opts 2> ac=
tual &&
> +               test_must_fail git -C empty_repo worktree add $opts fooba=
r/ 2> actual &&

Looks good.

>                 grep "hint: If you meant to create a worktree containing =
a new orphan branch" actual
>         '
>  }
>
> -test_wt_add_empty_repo_orphan_hint 'DWIM' foobar/
> -test_wt_add_empty_repo_orphan_hint '-b' -b foobar_branch foobar/
> -test_wt_add_empty_repo_orphan_hint '-B' -B foobar_branch foobar/
> +test_wt_add_empty_repo_orphan_hint 'DWIM'
> +test_wt_add_empty_repo_orphan_hint '-b' -b foobar_branch
> +test_wt_add_empty_repo_orphan_hint '-B' -B foobar_branch
>
>  test_expect_success 'local clone from linked checkout' '
>         git clone --local here here-clone &&
>
>
> Also, Is there an easier way to debug the `test_expect_success` statement=
s? I
> tried enabling tracing mode but it doesn't seem to trace into those state=
ments.

Not really, other than just enabling "-x" for the test-lib.sh itself, i.e.:

	sh -x ./t0001-init.sh

I *think* that should work, but I didn't test it...
