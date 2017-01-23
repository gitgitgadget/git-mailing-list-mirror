Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D05D920A17
	for <e@80x24.org>; Mon, 23 Jan 2017 18:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbdAWSNI (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 13:13:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63132 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750765AbdAWSNI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 13:13:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F302E61AE3;
        Mon, 23 Jan 2017 13:13:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S+VI59hRd9xr2YBbUFwArRyjWRI=; b=v0OGOD
        3o7YVMn8tkMuMvGi1rXMGo2m5iYzi5bWvymwmCcQU3tPaL2t1F7dIq2aTLFTRWbg
        kKnSVQPG7TcPX7Bs0Gq2bnorB9Qkh810qCz+FdQwU8/HPRM15WQVTEmrpvbkBrwB
        NiEPWQsaMze3yJr0jSVIbXHYf1q6DabRosvFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e3WS3qmqjjVCw+3ea0VCOgllLpMyZn10
        BVxRgh/stgvKeg5g4xRMTxf9r32N2umRC4rx6xk9NjfUO+x7uq9atuujzMobGW7y
        81mAQ69GvEvHNJUAvmYUjDuaqcnCoXagYmfg0caYYJd+kRuncxTBEF6R9duGg/Qh
        XvrNfBye5rc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA9CC61AE2;
        Mon, 23 Jan 2017 13:13:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5804761AE1;
        Mon, 23 Jan 2017 13:13:06 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH] rebase: pass --signoff option to git am
References: <20170121104904.15132-1-giuseppe.bilotta@gmail.com>
Date:   Mon, 23 Jan 2017 10:13:05 -0800
In-Reply-To: <20170121104904.15132-1-giuseppe.bilotta@gmail.com> (Giuseppe
        Bilotta's message of "Sat, 21 Jan 2017 11:49:04 +0100")
Message-ID: <xmqqh94ptzke.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9690B38C-E197-11E6-A0DA-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  Documentation/git-rebase.txt | 5 +++++
>  git-rebase.sh                | 3 ++-
>  2 files changed, 7 insertions(+), 1 deletion(-)

Should we plan to extend this to the interactive backend that is
shared between rebase -i and rebase -m, too?  Or is this patch
already sufficient to cover them?

> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 67d48e6883..e6f0b93337 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -385,6 +385,11 @@ have the long commit hash prepended to the format.
>  	Recreate merge commits instead of flattening the history by replaying
>  	commits a merge commit introduces. Merge conflict resolutions or manual
>  	amendments to merge commits are not preserved.
> +
> +--signoff::
> +	This flag is passed to 'git am' to sign off all the rebased
> +	commits (see linkgit:git-am[1]).
> +
>  +
>  This uses the `--interactive` machinery internally, but combining it
>  with the `--interactive` option explicitly is generally not a good
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 48d7c5ded4..e468a061f9 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -34,6 +34,7 @@
>  autosquash         move commits that begin with squash!/fixup! under -i
>  committer-date-is-author-date! passed to 'git am'
>  ignore-date!       passed to 'git am'
> +signoff!           passed to 'git am'
>  whitespace=!       passed to 'git apply'
>  ignore-whitespace! passed to 'git apply'
>  C=!                passed to 'git apply'
> @@ -321,7 +322,7 @@ run_pre_rebase_hook ()
>  	--ignore-whitespace)
>  		git_am_opt="$git_am_opt $1"
>  		;;
> -	--committer-date-is-author-date|--ignore-date)
> +	--committer-date-is-author-date|--ignore-date|--signoff)
>  		git_am_opt="$git_am_opt $1"
>  		force_rebase=t
>  		;;
