Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D549C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422492072B
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oYB/NBXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbgAPVkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:40:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61059 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730059AbgAPVkq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 16:40:46 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C2CF5386A5;
        Thu, 16 Jan 2020 16:40:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/diPGqT773TlAVHZm0uxeEy38kc=; b=oYB/NB
        XDBRwgiFSEH2wv78oCoEslYP76UXB0EnmSdGpOSDTe0bZC7tIXZpjU87DLjQqNKg
        lH85JA0VXzjX7srdkPlLqQQ9IT870huS6qFXdGnEIKzfSneg1ZNp4XQvM1tCRkwo
        ynlFQEfwdRMv0Yycq/LnexL6wvKXA2Hrm+dOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Tz+ed7kPDehkDGJNPmGb0X52qn205h4h
        m0kdmBk6Mqy+Gu3ZlSW1R4JKnFYeakANkSuejHLh9526P4XarigRc8Wif9IXMjN9
        vlmVHUTQxBKtKs1DKuvXwY6OCRbdRD9f1+Qo/NEXKuygEJwCxXSPXYLFFeJaZ/wt
        2KutUfzcTIQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA23E386A4;
        Thu, 16 Jan 2020 16:40:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F1E6386A3;
        Thu, 16 Jan 2020 16:40:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/8] t1091: use check_files to reduce boilerplate
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
        <9f7791ae5ee8df9d84d25407a014fb2c63e09b38.1579029963.git.gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 13:40:38 -0800
In-Reply-To: <9f7791ae5ee8df9d84d25407a014fb2c63e09b38.1579029963.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 14 Jan 2020
        19:25:55 +0000")
Message-ID: <xmqq8sm7gjvt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6FD9992-38A8-11EA-94A2-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> When testing the sparse-checkout feature, we need to compare the
> contents of the working-directory against some expected output.
> Using here-docs was useful in the beginning, but became repetetive
> as the test script grew.
>
> Create a check_files helper to make the tests simpler and easier
> to extend. It also reduces instances of bad here-doc whitespace.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1091-sparse-checkout-builtin.sh | 215 ++++++++++-------------------
>  1 file changed, 71 insertions(+), 144 deletions(-)
>
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index ff7f8f7a1f..20caefe155 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -12,6 +12,13 @@ list_files() {
>  	(cd "$1" && printf '%s\n' *)
>  }
>  
> +check_files() {
> +	DIR=$1
> +	printf "%s\n" $2 >expect &&
> +	list_files $DIR >actual  &&

It is unclear if the script is being deliberate or sloppy.

It turns out that not quoting $2 is deliberate (i.e. it wants to
pass more than one words in $2, have them split at $IFS and show
each of them on a separate line), at the same time not quoting $DIR
is simply sloppy.

And it is totally unnecessary to confuse readers like this.

Unless you plan to extend this helper further, I think this would be
much less burdensome to the readers:

        check_files () {
                list_files "$1" >actual  &&
                shift &&
                printf "%s\n" "$@" >expect &&
                test_cmp expect actual
        }

This ...

>  	test_cmp expect repo/.git/info/sparse-checkout &&
> -	list_files repo >dir  &&
> -	cat >expect <<-EOF &&
> -		a
> -		folder1
> -		folder2
> -	EOF
> -	test_cmp expect dir
> +	check_files repo "a folder1 folder2"

... is a kind of change that the log message advertises, which is a
very nice rewrite.

And ...

>  test_expect_success 'clone --sparse' '
>  	git clone --sparse repo clone &&
>  	git -C clone sparse-checkout list >actual &&
> -	cat >expect <<-EOF &&
> -		/*
> -		!/*/
> +	cat >expect <<-\EOF &&
> +	/*
> +	!/*/
>  	EOF

... this is a style-fix that is another nice rewrite but in a
different category.  I wonder if they should be done in separate
commits.

Other than that, makes sense.

Thanks.
