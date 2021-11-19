Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96268C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 01:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D75E611C7
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 01:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbhKSBQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 20:16:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52570 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhKSBQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 20:16:57 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B13AF104EC8;
        Thu, 18 Nov 2021 20:13:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qMROVw/kXWSWlHPGsyrfcezlGpWqNupQfT6pTF
        JQIGk=; b=no4CWfAlg+cLf3J8Zf1y8FDxmuZBt0j9vA3SH2NY0OJi0lQM4w+ots
        HIFErQcK/fGnUTEOKJxRUlvRiVzgXvLO1GfcWbgfXMMzuG27a6qJ2J2anoX1ymof
        V8IgASP0Y/ByJqq7EKu1k1V3F4v7DNcTBQU/Y4WCT6T+3qjKZvOrI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A74F6104EC7;
        Thu, 18 Nov 2021 20:13:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F18B104EC5;
        Thu, 18 Nov 2021 20:13:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v6 3/3] am: throw an error when passing --empty option
 without value
References: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
        <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
        <e907a2b2faa1e3c5854504c23cc6e118c2125817.1637232636.git.gitgitgadget@gmail.com>
Date:   Thu, 18 Nov 2021 17:13:53 -0800
In-Reply-To: <e907a2b2faa1e3c5854504c23cc6e118c2125817.1637232636.git.gitgitgadget@gmail.com>
        (Aleen via GitGitGadget's message of "Thu, 18 Nov 2021 10:50:36
        +0000")
Message-ID: <xmqqr1bdrlpq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6FF4E9A-48D5-11EC-86C5-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Aleen via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Aleen <aleen42@vip.qq.com>

Here is a place for you to explain why this change might be a good
idea to defend it.  If we applied 1/3 and 2/3 but not this one, what
happens?  "am --empty" (not "am --empty=<choice>") is accepted and
behaves just like "am --empty=die"?  Is that a bad thing?

If it is unconditonally a bad thing, then this patch does not stand
on its own.  It should be squashed into the previous step; otherwise
it would be "oops, we didn't think it through and failed to detect
an argument-less --error as an error in the previous step, and here
is a fix for that mistake".  We try not to deliberately commit a
mistake and then fix it to gain commit counts in this project (or
putting it differently, we try to pretend we are better than we
really are and did not make a mistake in the first place).

Or are you giving list participants and reviewers a choice between
"'--empty' is a synonym to '--empty=die'" and "'--empty' alone is an
error" because you cannot decide yourself?  If that is the case, you
really really need to make it clear in this place between "From:"
and "Signed-off-by:".  Why would we want to use this patch?  Why
would we be better without this patch?

I haven't thought things through, but my gut feeling is that the
semantics of the --empty=<choice> option is better _with_ this,
in other words, it makes more sense to forbid "--empty" alone.  So
if I were doing this series, I would probably have squashed this
into the previous one, making it a two-patch series.

Thanks.


> Signed-off-by: Aleen <aleen42@vip.qq.com>
> ---
>  builtin/am.c  | 13 +++++++------
>  t/t4150-am.sh |  8 +++++++-
>  2 files changed, 14 insertions(+), 7 deletions(-)


> diff --git a/builtin/am.c b/builtin/am.c
> index 1a3ed87b445..5d487b5256b 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -185,12 +185,14 @@ static int am_option_parse_quoted_cr(const struct option *opt,
>  	return 0;
>  }
>  
> -static int am_option_parse_empty_commit(const struct option *opt,
> +static int am_option_parse_empty(const struct option *opt,
>  				     const char *arg, int unset)
>  {
>  	int *opt_value = opt->value;
>  
> -	if (unset || !strcmp(arg, "die"))
> +	BUG_ON_OPT_NEG(unset);



> +	if (!strcmp(arg, "die"))
>  		*opt_value = DIE_EMPTY_COMMIT;
>  	else if (!strcmp(arg, "drop"))
>  		*opt_value = DROP_EMPTY_COMMIT;
> @@ -2391,10 +2393,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>  		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
>  		  N_("GPG-sign commits"),
>  		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> -		{ OPTION_CALLBACK, 0, "empty", &state.empty_type,
> -		  "(die|drop|keep)",
> -		  N_("specify how to handle empty patches"),
> -		  PARSE_OPT_OPTARG, am_option_parse_empty_commit },
> +		OPT_CALLBACK_F(0, "empty", &state.empty_type, "{drop,keep,die}",
> +		  N_("how to handle empty patches"),
> +		  PARSE_OPT_NONEG, am_option_parse_empty),
>  		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
>  			N_("(internal use for git-rebase)")),
>  		OPT_END()
> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index 3119556884d..c32d21e80da 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -1165,8 +1165,14 @@ test_expect_success 'still output error with --empty when meeting empty files' '
>  	test_cmp expected actual
>  '
>  
> -test_expect_success 'error when meeting e-mail message that lacks a patch by default' '
> +test_expect_success 'invalid when passing no value for the --empty option' '
>  	git checkout empty-commit^ &&
> +	test_must_fail git am --empty empty-commit.patch 2>err &&
> +	echo "error: Invalid value for --empty: empty-commit.patch" >expected &&
> +	test_cmp expected err
> +'
> +
> +test_expect_success 'error when meeting e-mail message that lacks a patch by default' '
>  	test_must_fail git am empty-commit.patch >err &&
>  	test_path_is_dir .git/rebase-apply &&
>  	test_i18ngrep "Patch is empty." err &&
