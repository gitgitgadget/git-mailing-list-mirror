Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CBFC81857
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 23:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFACC206D4
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 23:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FbiXPrUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgD0XeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 19:34:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61290 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgD0XeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 19:34:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 879CE445DC;
        Mon, 27 Apr 2020 19:34:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eeQJJjsvDZ7irq0k1/mo5YooW9k=; b=FbiXPr
        UnQhxurAnwp+SVF1DsF61Y66G8kjuFLcJTdZ6mgBnoopD9ewi2kw0cVzq0NP/to4
        J/cJkiO/Fog8Ui7kD/MWx2PLuc+WXHjawfGnKXfGUKf02jFp59g0VsY52hdaFUuF
        ifTruBViT4zvck2M1Bom4pYtATeXwcnv6ZtWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K02O6D2ovXqnWNr5AdSkNi+oJfZFDdji
        HnaSbDiWSoE6y9LaSsO0KT23DHycvxmGuLilJXkdKkL8sIexFCft+Uhfvt3dKJBq
        saLewX/bd3J5CYu4AJFmgZCBZC2t0f7LTkckaNBnRT00AJYvzoh8z+EFkECengpO
        a5FD6AKGabo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E6DF445DB;
        Mon, 27 Apr 2020 19:34:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 07B10445DA;
        Mon, 27 Apr 2020 19:34:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 05/11] completion: add test showing subpar completion for git switch --orphan
References: <20200425022045.1089291-1-jacob.e.keller@intel.com>
        <20200425022045.1089291-6-jacob.e.keller@intel.com>
Date:   Mon, 27 Apr 2020 16:34:13 -0700
In-Reply-To: <20200425022045.1089291-6-jacob.e.keller@intel.com> (Jacob
        Keller's message of "Fri, 24 Apr 2020 19:20:38 -0700")
Message-ID: <xmqqv9lk5wqy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A9089CE-88DF-11EA-BC17-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> git switch with the --orphan option is used to create a new branch that
> is not connected to any history and is instead based on the empty tree.
>
> It does not make sense for completion to return anything in this case,
> because there is nothing to complete. Check for --orphan, and if it's
> found, immediately return from _git_switch() without completing
> anything.
>
> Add a test case which documents this expected behavior.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 11 ++++++++++-
>  t/t9902-completion.sh                  |  7 +++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c21786f2fd00..08d3406cf3e4 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2223,9 +2223,18 @@ _git_switch ()
>  		__gitcomp_builtin switch
>  		;;
>  	*)
> +		local track_opt="--track" only_local_ref=n
> +
> +		# --orphan is used to create a branch disconnected from the
> +		# current history, based on the empty tree. Since the only
> +		# option required is the branch name, it doesn't make sense to
> +		# complete anything here.
> +		if [ -n "$(__git_find_on_cmdline "--orphan")" ]; then
> +			return
> +		fi
> +
>  		# check if --track, --no-track, or --no-guess was specified
>  		# if so, disable DWIM mode
> -		local track_opt="--track" only_local_ref=n
>  		if [ "$GIT_COMPLETION_CHECKOUT_NO_GUESS" = "1" ] ||
>  		   [ -n "$(__git_find_on_cmdline "--track --no-track --no-guess")" ]; then
>  			track_opt=''
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index a134a8791076..9d02de167219 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1351,6 +1351,13 @@ test_expect_failure 'git switch - with -C and --no-track, complete all reference
>  	EOF
>  '
>  
> +# TODO: completion does not yet recognize --orphan
> +test_expect_failure 'git switch - with --orphan, do not complete anything' '
> +	test_completion "git switch --orphan " <<-\EOF
> +
> +	EOF
> +'
> +

I am getting "TODO passed" at 7276ffe0 (completion: add test showing
subpar completion for git switch --orphan, 2020-04-24), which hasn't
hit 'next' yet.

Perhaps we got some rebase gotcha here?

>  test_expect_success 'teardown after ref completion' '
>  	git branch -d matching-branch &&
>  	git tag -d matching-tag &&
