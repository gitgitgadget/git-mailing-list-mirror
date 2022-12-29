Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B352EC4332F
	for <git@archiver.kernel.org>; Thu, 29 Dec 2022 10:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiL2Kzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 05:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiL2Kzm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 05:55:42 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F95F011
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 02:55:38 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id c17so26186373edj.13
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 02:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QfX3Vo1hOffceIXRBBhwCf9Xjy8l7wgQ4EXuADzNGvI=;
        b=U0GOVF4z80PoKyBvTRTBRpxZihTQ5aot+B7YDaqeUys524ctN6BbZLLSf7QYwzDLiO
         T91xIFvYGTUGPhsOvx853yo4zf4XSRUSkPX+ddCIkElW6uAsYkvXL9v+BGjxac9dRYj+
         LqgLz5Ruc93Ky0tS1C7IHjYr/PTTq9ewmLFS0mbOOeuHh72sdXNt9AJPY8F6xE4bkHsF
         hneh8eodwiq5AKRAcwXj+3dCaaWWcEESP4CjSvrq1DgIZ1kaHw9oduQvvMh8lRvwv6ze
         JgsiN2qV0B6THM1+fqU2cOcELdFYW78SMB+uuu0GDxzJE/Oj+tRcsxpTyD2Vx7j2WLql
         EWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QfX3Vo1hOffceIXRBBhwCf9Xjy8l7wgQ4EXuADzNGvI=;
        b=cP2v161f7fR6ET05ZIGjMCBSxSTUnaBu4nLB/Vxf9ZIquUXywoGJDlQOvnG0C5wg4t
         s4N06mGOXVj+unpE1ILiojaxYAw1fFNB1DjWm0I7LjrnzVbfTDW5avFUf7svXiiVN1ww
         iewhcSP9e2ROmgyuXgZQRsXTmQQFh9VkZElcvUoFCBK+YenhR2Vadz4/GyYpuSj+wCBF
         9756DdFrGfUvVk4JmKip0Jjag7u9yMW3G/9P7cLwXTNuTmPUEmd9Nq1ueW53coupwIeh
         pF/agbGCk18xF+7QRPTOORdjfLoSohuLXZJsBYZJoP8jKfrL1RVCObQlI1jt6tVWDjfU
         Rxxg==
X-Gm-Message-State: AFqh2kqA5HRZAeJq0I0qEefV4mpREJ5GSVEwCBWHt4bdqb8xFagKsLRM
        d6wSiOMSy/jBKSnNQ8RXD5E=
X-Google-Smtp-Source: AMrXdXtca/DA8ArJ5TKGdyIDexSyBWqPFex//iUaGqVXdqSkLGH+rv1Ym/+buy3xM1xltrR0zilxqw==
X-Received: by 2002:a05:6402:2b89:b0:46d:c288:e798 with SMTP id fj9-20020a0564022b8900b0046dc288e798mr23309893edb.21.1672311336674;
        Thu, 29 Dec 2022 02:55:36 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id t18-20020a056402021200b0048447efe3fcsm5456084edv.84.2022.12.29.02.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 02:55:36 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pAqZT-00AJdl-1Z;
        Thu, 29 Dec 2022 11:55:35 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v6 0/4] worktree: Support `--orphan` when creating new
 worktrees
Date:   Thu, 29 Dec 2022 11:42:49 +0100
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev>
 <20221212014003.20290-1-jacobabel@nullpo.dev>
 <20221220023637.29042-1-jacobabel@nullpo.dev>
 <20221228061539.13740-1-jacobabel@nullpo.dev>
 <221228.868risuf5x.gmgdl@evledraar.gmail.com>
 <20221229063823.ij3jjuaar2fsayju@phi>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221229063823.ij3jjuaar2fsayju@phi>
Message-ID: <221229.86v8lutr6g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 29 2022, Jacob Abel wrote:

> On 22/12/28 09:01AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> On Wed, Dec 28 2022, Jacob Abel wrote:
>> [...]
>> The rest of this looks good to me, but this bit looks like you went down
>> the rabbit hole of responding to Junio's feedback in
>> https://lore.kernel.org/git/xmqqsfhawwqf.fsf@gitster.g/
>>
>> I think as we're not dealing with any quoted arguments here it's not
>> worth copy/pasting some code to do shell quoting from StackOverflow,
>> i.e. for this series this squashed at the tip passes all the tests:
>
> Understood.
> [...]
>>
>> If we do want to be slightly paranoid about it, doesn't just creating a:
>>
>> 	local args_str=3D"$*" &&
>>
>> And then using that in the description argument to test_expect_success()
>> also address Junio's feedback, without the need for this quoting helper?
>
> Below is what I have come up with while still not needing the
> quoting helper. Could this work as an alternative?
>
> It doesn't handle quotes properly without a bit of help from the
> test author but it can handle them as long as you double escape the strin=
g.
>
> The diff also includes slight tweaks to the tests themselves to better ve=
rify
> the behavior.
>
> Note: The two extra tests added in the diff wouldn't be in the next revis=
ion but they
> are there to demonstrate that things work as expected with this change.
>
> [...]
>  # Helper function to test mutually exclusive options.
> +#
> +# Note: Any arguments that contain spaces must be double and single quot=
ed, ex:
> +# test_wt_add_excl -b poodle --detach bamboo --lock --reason "'the reaso=
n'" main
>  test_wt_add_excl () {
> -	local arr=3D$(save_param_arr "$@")
> -	test_expect_success "'worktree add' with $* has mutually exclusive opti=
ons" '
> -		eval "set -- $arr" &&
> -		test_must_fail git worktree add "$@"
> -	'
> +	test_expect_success "'worktree add' with $* has mutually exclusive opti=
ons" "
> +		test_must_fail git worktree add $* 2>actual &&
> +		grep -P 'fatal:( options)? .* cannot be used together' actual
> +	"
>  }
>
> +test_wt_add_excl -b poodle --detach bamboo --lock --reason "'the reason'=
" main
>  test_wt_add_excl -b poodle -B poodle bamboo main
>  test_wt_add_excl -b poodle --detach bamboo main
>  test_wt_add_excl -B poodle --detach bamboo main
> @@ -397,19 +379,22 @@ test_expect_success '"add" worktree with orphan bra=
nch, lock, and reason' '
>  	test_cmp expect .git/worktrees/orphan-with-lock-reason/locked
>  '
>
> +# Note: Any arguments (except the first argument) that contain spaces mu=
st be
> +# double and single quoted, ex:
> +# test_wt_add_empty_repo_orphan_hint 'the context' --lock --reason "'the=
 reason'"
> [...]
> +test_wt_add_empty_repo_orphan_hint 'the context' --lock --reason "'the r=
eason'"
>  test_wt_add_empty_repo_orphan_hint 'DWIM'
>  test_wt_add_empty_repo_orphan_hint '-b' -b foobar_branch
>  test_wt_add_empty_repo_orphan_hint '-B' -B foobar_branch

I haven't even tested this, but I'm still confused here, isn't this just
a solution in seach of a problem?

To answer your question above: Yes, you can come up with shellscript
code that handles this sort of quoting problem, but it's generally a Bad
Idea and should be avoided.

*If* a function needs to take arguments that are quoted it's much better
to "unpack" those arguments in full, and then pass them on, see e.g. how
the "test_commit" helper in test-lib-functions.sh does it.

But in this case there was no need whatsoever for doing any of this, as
none of the tests wanted to pass such arguments, they didn't need to be
quoted at all.

But now for this reply you've come up with one such test, hence the
"solution in search of a problem?" above.

I.e. is this a useful test, or just an excercise to stress generic quote
handling we don't really need?

I originally suggested creating these trivial helpers in an earlier
round because it avoided the copy/pasting of a series of tests, I think
the v5 you had
(https://lore.kernel.org/git/20221212014003.20290-3-jacobabel@nullpo.dev/)
struck the right balance there, although as Junio noted it might need
the tweaking for $@ v.s. $*.

But once we have to handle quoted arguments the better solution is to
just ... not use that helper. I.e. there's no reason you can't just do:

	test_wt_add_excl -b poodle -B poodle bamboo main
	test_wt_add_excl -b poodle --orphan poodle bamboo
	[...]

Then:

	test_expect_success 'worktree add with quoted --reason arguments and --orp=
han' '
		test_must_fail git worktree add  --orphan poodle --detach bamboo --reason=
 "'\''blah blah'\''"
	'

You don't need to make test_wt_add_excl() handle that case.
