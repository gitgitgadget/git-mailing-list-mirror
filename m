Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6081C433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 18:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A979207F7
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 18:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kzw24fMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgFLSq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 14:46:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53928 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgFLSq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 14:46:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23FD5788AB;
        Fri, 12 Jun 2020 14:46:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q7XU3a6ih8ZQB7CSzvRQEVaeFzs=; b=Kzw24f
        MTb+fNdEeZiIOWKLMTxwo6swrnCXnphQskiSgsM40OnxsKyfNcoIkcay56xU86yu
        7sd3x8kQP5KFD9vP1uoV1zN2xHDl2m/ZN/3mjqtBfnsOy/O0lTwlw1fdB1h+Pbzq
        xv/MG8SF9lhUDvyj5S2eW0g7RGwx528Vk6rcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hqg8PwOXv0kIwndgGqOJNsdhBrJ7XqzF
        +0Cvl5zMcfx9kd3d+DHM6qnaQYGBgDnl58jY5ypVOwnWSOA9zmKFk3fYinzvlST6
        wQuCty1sTE6k64bh4pTs0JWu99oMetoEx9MBqOQbY4xE3HHAUnknC3McuQzEXnzr
        sM1IgHYSs4w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 19D64788AA;
        Fri, 12 Jun 2020 14:46:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8A56F788A9;
        Fri, 12 Jun 2020 14:46:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/4] lib-submodule-update: use callbacks in test_submodule_switch_common()
References: <cover.1588162842.git.liu.denton@gmail.com>
        <cover.1591897173.git.liu.denton@gmail.com>
        <74e6086da451a4ce2ac52b04a2399ef332d61047.1591897173.git.liu.denton@gmail.com>
Date:   Fri, 12 Jun 2020 11:46:23 -0700
In-Reply-To: <74e6086da451a4ce2ac52b04a2399ef332d61047.1591897173.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 11 Jun 2020 13:41:50 -0400")
Message-ID: <xmqqy2os15s0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03914988-ACDD-11EA-A489-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>  test_submodule_switch_common () {
> -	command="$1"
> +	command="$1" # should be a git command
> +	before="$2"
> +	after="$3"
> +
> +	if test -z "$before"
> +	then
> +		before=true
> +	fi
> +
> +	if test -z "$after"
> +	then
> +		after=true
> +	fi
> +

	command="$1" before=${2:-true} after=${3:-true}

should be sufficient?  Spelling 'true' as ':' would make it even
shorter but probably too cryptic ;-)

> diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
> index 788605ccc0..d31e6487bd 100755
> --- a/t/t3426-rebase-submodule.sh
> +++ b/t/t3426-rebase-submodule.sh
> @@ -16,11 +16,10 @@ git_rebase () {
>  	git revert HEAD &&
>  	git status -su >actual &&
>  	ls -1pR * >>actual &&
> -	test_cmp expect actual &&
> -	git rebase "$1"
> +	test_cmp expect actual

We used to run "git rebase" in this helper, but that is the thing we
expect to succeed or to fail, so with the revamped test framework,
this is split out to just be the "before testing" helper function?

Makes sense.

> -test_submodule_switch_func "git_rebase"
> +test_submodule_switch_func "rebase \$arg" "git_rebase"

>  git_rebase_interactive () {
>  	git status -su >expect &&
> @@ -34,11 +33,10 @@ git_rebase_interactive () {
>  	ls -1pR * >>actual &&
>  	test_cmp expect actual &&
>  	set_fake_editor &&
> -	echo "fake-editor.sh" >.git/info/exclude &&
> -	git rebase -i "$1"
> +	echo "fake-editor.sh" >.git/info/exclude
>  }
>  
> -test_submodule_switch_func "git_rebase_interactive"
> +test_submodule_switch_func "rebase -i \$arg" "git_rebase_interactive"

Likewise.
