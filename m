Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E07CC2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 18:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE902082E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 18:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QuowMnaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgA3SOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:14:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58545 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbgA3SOr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 13:14:47 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D069752E9F;
        Thu, 30 Jan 2020 13:14:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zjRHSl1U3ZGstUAeHg4ehI/p3o0=; b=QuowMn
        aVrVlTzqInOHA6MRsuaKSUs0kDG21taWpaWEihKUMapzA84lyAEoYgsy6hSBFo1f
        SGaZtabMaXcduPTvkCS8qEVFWbQc57b+g++XQdlmDnO6nXfi14c3U1bWL5RqRdhS
        DWdV6ToAFnQMI/g73lmDa9EA4OkAxtffurqHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OWO8GZ1F3+HO3E2LcSk4K7DhdU7nQRiE
        Z/+Sbqs8nRTxCV+Ds8hT/4zaCqg1NMtNkPjIKrTQDCa6MLCjzXDz9+T4wptRzlBc
        EJCuHu8TRfzer0/olP9Dxrv9HkhEutEMDHiXKph6P7zWXXV9xrLVaDNJmGhrNxSu
        xnqrrFscedI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C853C52E9E;
        Thu, 30 Jan 2020 13:14:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2AFBF52E9D;
        Thu, 30 Jan 2020 13:14:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2] grep: ignore --recurse-submodules if --no-index is given
References: <pull.540.git.1580000298097.gitgitgadget@gmail.com>
        <pull.540.v2.git.1580391448318.gitgitgadget@gmail.com>
Date:   Thu, 30 Jan 2020 10:14:39 -0800
In-Reply-To: <pull.540.v2.git.1580391448318.gitgitgadget@gmail.com> (Philippe
        Blain via GitGitGadget's message of "Thu, 30 Jan 2020 13:37:28 +0000")
Message-ID: <xmqq36bwerqo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 624D4F9A-438C-11EA-98A7-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Using `--recurse-submodules` should not have any effect if `--no-index`
> is used inside a repository, as Git will recurse into the checked out
> submodule directories just like into regular directories.
> ...
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 50ce8d9461..ae2d5bbafc 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -958,6 +958,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  			/* die the same way as if we did it at the beginning */
>  			setup_git_directory();
>  	}
> +	/* Ignore --recurse-submodules if --no-index is given or implied */
> +	if (!use_index)
> +		recurse_submodules = 0;

This is done quite early in the execution flow.  That makes any and
all existing checks that says "if recurse-submodules is set and we
are in no-index mode, do this" unneeded.

>  
>  	/*
>  	 * skip a -- separator; we know it cannot be

> @@ -1115,8 +1118,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  		}
>  	}
>  
> -	if (recurse_submodules && (!use_index || untracked))
> -		die(_("option not supported with --recurse-submodules"));
> +	if (recurse_submodules && untracked)
> +		die(_("--untracked not supported with --recurse-submodules"));

And this is an example of a change to remove a check for such a
redundant condition.  If recurse_submodules is true (which is the
only time the RHS of &&- is evaluated), we know use_index cannot be
false, so the final outcome solely depends on the value of untracked.

Looks good.  And my quick reading of the current builtin/grep.c code
suggests that this is the only such combination that can be simplified.

Thanks.

>  	if (!show_in_pager && !opt.status_only)
>  		setup_pager();
> diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
> index 946f91fa57..828cb3ba58 100755
> --- a/t/t7814-grep-recurse-submodules.sh
> +++ b/t/t7814-grep-recurse-submodules.sh
> @@ -345,7 +345,16 @@ test_incompatible_with_recurse_submodules ()
>  }
>  
>  test_incompatible_with_recurse_submodules --untracked
> -test_incompatible_with_recurse_submodules --no-index
> +
> +test_expect_success 'grep --recurse-submodules --no-index ignores --recurse-submodules' '
> +	git grep --recurse-submodules --no-index -e "^(.|.)[\d]" >actual &&
> +	cat >expect <<-\EOF &&
> +	a:(1|2)d(3|4)
> +	submodule/a:(1|2)d(3|4)
> +	submodule/sub/a:(1|2)d(3|4)
> +	EOF
> +	test_cmp expect actual
> +'
>  
>  test_expect_success 'grep --recurse-submodules should pass the pattern type along' '
>  	# Fixed
>
> base-commit: bc7a3d4dc04dd719e7c8c35ebd7a6e6651c5c5b6
