Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B52C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 16:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71DA220706
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 16:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ojnj7Bmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404682AbgFXQAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:00:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58729 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404137AbgFXQAc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 12:00:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75D2B76670;
        Wed, 24 Jun 2020 12:00:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iIyiBxrx6gWbcobFx89yaCEa2MA=; b=Ojnj7B
        mddYbw5p/ZYzva2AlPRqSCJAxbfUy0WBobeq4rfOJSLpPEPZOYWjm0wc4KaVPn0O
        VEOdTWmsQxqb6bR9BiY4iwzDcg4ftyyGtGVDAj8WpF8jGkqZmHap8S40QujQdsTj
        GZHQHdT4H9MphfRmzY2A5keQmwoDdWijZtbt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nX/wsdCUXlyJsUfMnl41ugmA0Z01bgHr
        i10hooEZcZqeQe/Di7mzvoZdImrokdKkdskYWiA7LkTeo74i55JhRX0qADeEOL6H
        7YCKcs/UAiOZsvSjlHsI48wZ7d7uwHLj9TuVx2K/XKQ08PmSNQV9qj/ZvAgMgxLY
        SizUu+D771c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6861E7666F;
        Wed, 24 Jun 2020 12:00:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D90AF7666E;
        Wed, 24 Jun 2020 12:00:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5.2] lib-submodule-update: pass 'test_must_fail' as an argument
References: <7b9c19b3606f31b12a79591a41847dcb0a071751.1592942452.git.liu.denton@gmail.com>
        <9ea9d3ff08266e9f1062632c4b1ff1e5f23733bd.1592981264.git.liu.denton@gmail.com>
Date:   Wed, 24 Jun 2020 09:00:27 -0700
In-Reply-To: <9ea9d3ff08266e9f1062632c4b1ff1e5f23733bd.1592981264.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 24 Jun 2020 04:50:18 -0400")
Message-ID: <xmqqd05o8ndw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D27B429E-B633-11EA-9791-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> +# Ensures that the that the arg either contains "test_must_fail" or is empty.
> +may_only_be_test_must_fail () {
> +	test -z "$1" || test "$1" = test_must_fail || die

No error message?  I guess it is OK as this is to only catch a bug
in the test script, not a bug in Git being tested.

> @@ -17,7 +17,8 @@ git_rebase () {
>  	git status -su >actual &&
>  	ls -1pR * >>actual &&
>  	test_cmp expect actual &&
> -	git rebase "$1"
> +	may_only_be_test_must_fail "$2" &&
> +	$2 git rebase "$1"
>  }

I would have expected the sanity check for incoming arguments would
be done at the very beginning, but I guess it is OK (the same
comment applies to all the others).

> @@ -15,7 +15,12 @@ git_revert () {
>  	git status -su >expect &&
>  	ls -1pR * >>expect &&
>  	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
> -	git checkout "$1" &&
> +	may_only_be_test_must_fail "$2" &&
> +	$2 git checkout "$1" &&
> +	if test -n "$2"
> +	then
> +		return
> +	fi &&

The addition to "git_rebase" does not need this "if must-fail was
given, return early" because it was at the end of the helper, but
here we have some post procedure that relies on the checkout to
be successful, so after correctly failing the checkout we return.

It is somewhat tricky, but OK.  The same for the next one.

> diff --git a/t/t3906-stash-submodule.sh b/t/t3906-stash-submodule.sh
> index 6a7e801ca0..a52e53dd2d 100755
> --- a/t/t3906-stash-submodule.sh
> +++ b/t/t3906-stash-submodule.sh
> @@ -8,7 +8,12 @@ test_description='stash can handle submodules'
>  git_stash () {
>  	git status -su >expect &&
>  	ls -1pR * >>expect &&
> -	git read-tree -u -m "$1" &&
> +	may_only_be_test_must_fail "$2" &&
> +	$2 git read-tree -u -m "$1" &&
> +	if test -n "$2"
> +	then
> +		return
> +	fi &&
>  	git stash &&
>  	git status -su >actual &&
>  	ls -1pR * >>actual &&

Looking good.  Will replace.

Thanks.
