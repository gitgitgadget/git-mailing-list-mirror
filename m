Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E96DC433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 19:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B95A20897
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 19:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ht6ze2U/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIITrj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:47:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63647 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgIITri (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 15:47:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C3E56F757A;
        Wed,  9 Sep 2020 15:47:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZO7TUsaq+UF/L1dpHdE6Cg9JLnQ=; b=ht6ze2
        U/xLXPgwzIkSkivDWnCl+83ubGZg057bep8NWBpLBAr1Zb+rSqAXbMThdld0tNZ7
        SqHlJXdAI3ot4527N0Zph1XHwoI69Udlt8dy8iOIWIEu2oJojdfEsVuADmZH+I4t
        Z+XvTWQhbP7IQ1/kZx/P7lm7+aUWJUWeOItAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QIUIQsmwncGERFYU/OHD7TWNh7+NTzOh
        2GLfn4XODHEyqMMVLlnPPP1A2kj/6dLqcVP1KpEHANuohWe8Y7dNADu9zy6ojFNz
        8jDeExyht7d5YD4JRIuF6pI8fIkyz6rd/DzON0taRsMIcnI2RmZvdi1hmcponkqz
        BcEa/T7kQQk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BD076F7579;
        Wed,  9 Sep 2020 15:47:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1783CF7578;
        Wed,  9 Sep 2020 15:47:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] config: complain about --worktree outside of a git repo
References: <3dfd33eda3f9cbd0d87ba7bb31f4501aa7b8b8a8.1599657308.git.matheus.bernardino@usp.br>
Date:   Wed, 09 Sep 2020 12:47:30 -0700
In-Reply-To: <3dfd33eda3f9cbd0d87ba7bb31f4501aa7b8b8a8.1599657308.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Wed, 9 Sep 2020 10:16:08 -0300")
Message-ID: <xmqqeenavijx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CF1E360-F2D5-11EA-939D-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> Running `git config --worktree` outside of a git repository hits a BUG()
> when trying to enumerate the worktrees. Let's catch this error earlier
> and die() with a friendlier message.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  builtin/config.c  | 12 ++++++++----
>  t/t1300-config.sh | 13 ++++++++-----
>  2 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index 5e39f61885..53e411d68a 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -628,11 +628,15 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		usage_builtin_config();
>  	}
>  
> -	if (use_local_config && nongit)
> -		die(_("--local can only be used inside a git repository"));
> +	if (nongit) {
> +		if (use_local_config)
> +			die(_("--local can only be used inside a git repository"));
> +		if (given_config_source.blob)
> +			die(_("--blob can only be used inside a git repository"));
> +		if (use_worktree_config)
> +			die(_("--worktree can only be used inside a git repository"));
>  
> -	if (given_config_source.blob && nongit)
> -		die(_("--blob can only be used inside a git repository"));
> +	}

OK.  The updated structure makes it more obvious that we handle
three special cases.  Good jobs.

Thanks.

>  
>  	if (given_config_source.file &&
>  			!strcmp(given_config_source.file, "-")) {
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 97ebfe1f9d..825d9a184f 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1836,11 +1836,14 @@ test_expect_success '--show-scope with --show-origin' '
>  	test_cmp expect output
>  '
>  
> -test_expect_success '--local requires a repo' '
> -	# we expect 128 to ensure that we do not simply
> -	# fail to find anything and return code "1"
> -	test_expect_code 128 nongit git config --local foo.bar
> -'
> +for opt in --local --worktree
> +do
> +	test_expect_success "$opt requires a repo" '
> +		# we expect 128 to ensure that we do not simply
> +		# fail to find anything and return code "1"
> +		test_expect_code 128 nongit git config $opt foo.bar
> +	'
> +done
>  
>  cat >.git/config <<-\EOF &&
>  [core]
