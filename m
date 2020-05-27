Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5747BC433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F05CA2071A
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VJp/rAKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391458AbgE0QpW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 12:45:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65195 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391452AbgE0QpV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 12:45:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6F41ACA354;
        Wed, 27 May 2020 12:45:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nJ61ZA/RUSsBJgfU4apGrQD5EBA=; b=VJp/rA
        KVeljJ+JL2Owkr17UwUUYsyZl3d4M0/ySkbilU35dxIIsux5zDG7Eg91bzTNAZCi
        eCaEirUTJhwMvMxF1DOPvRGyKKwYE4H4gMQPQ3J9HnO9ZX5UzbebVawpQgyDV8xr
        6jyVcUN6/bc6vG0pMiBX/N7Ubaa2zr/VQcmMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U+dvTUw/zszLCTRS0xcoe26UjqG5xwT3
        M87wfsxPrwMDp1PnouMlGbWfYQfTay5oXqVqpfdwo3XiU9laOhVXoEXYgJq4aO+b
        PdfEcc2xRDyEFm2LesGWu2RpT5nmUPzPxc2u5R5iqMNmaJdshjt9Y0aoKPe0CSId
        LO9ZxpCgrFA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 66680CA352;
        Wed, 27 May 2020 12:45:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A821ACA351;
        Wed, 27 May 2020 12:45:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Simon Ser <contact@emersion.fr>
Cc:     git@vger.kernel.org, me@ttaylorr.com,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] grep: add configuration variables for --heading
References: <4WK2xPaKLXPbLE0jjY0rBR9M_BVt69rzJKBN17M0ily4VPYuMNC_a2kXsIKWR8y6lc7j58WpBmaIqdbJ1whnjonrfEWz7YE-WpdQqCu_lN0=@emersion.fr>
        <C5PlGbi78_QpceNrgFm_-Wt6BooqbntaL8OdH7XjxjXCtyIfsisyeOQMslLOwNY68Dg7iUxGIvzLPAvUEWyMIC0GdpTgeWwgwD5sWlsyrSM=@emersion.fr>
Date:   Wed, 27 May 2020 09:45:13 -0700
In-Reply-To: <C5PlGbi78_QpceNrgFm_-Wt6BooqbntaL8OdH7XjxjXCtyIfsisyeOQMslLOwNY68Dg7iUxGIvzLPAvUEWyMIC0GdpTgeWwgwD5sWlsyrSM=@emersion.fr>
        (Simon Ser's message of "Wed, 27 May 2020 15:45:46 +0000")
Message-ID: <xmqqeer5mina.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70F72AF2-A039-11EA-92D6-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simon Ser <contact@emersion.fr> writes:

> There are already configuration variables for -n and --column. Add one
> for --heading, allowing users to customize the default behaviour.
>
> Signed-off-by: Simon Ser <contact@emersion.fr>
> ---
>
> v2: add a test
>
>  Documentation/git-grep.txt | 3 +++
>  grep.c                     | 5 +++++
>  t/t7810-grep.sh            | 5 +++++
>  3 files changed, 13 insertions(+)
>
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index a7f9bc99eaf1..ed4f05d885a2 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -47,6 +47,9 @@ grep.lineNumber::
>  grep.column::
>  	If set to true, enable the `--column` option by default.
>  
> +grep.heading::
> +	If set to true, enable the `--heading` option by default.
> +

OK.

Naturally it follows that a command-line option

	$ git config grep.heading yes
	$ git grep --no-heading -e pattern

is a way to countermand the configured default per invocation
basis.

> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 991d5bd9c03f..1acc6fe89c51 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -1556,6 +1556,11 @@ test_expect_success 'grep --heading' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'grep with grep.heading=true' '
> +	git -c grep.heading=true grep -e char -e lo_w hello.c hello_world >actual &&
> +	test_cmp expected actual
> +'
> +

When writing new tests, we often get too excited and stop at showing
off how well the shiny new feature works, but we should make sure
that we test the "negative" case, too, i.e. that the "feature" can
be disabled when the user does not want to trigger it, and that the
"feature" notices incorrect invocations and fails appropriately.

E.g.

	git -c grep.heading=yes grep --no-heading ...

should not leave the opt->heading true, and

	git -c grep.heading=nonsense grep ...

should fail, saying "grep.heading must be a bool" (or something
along that line).

Thanks.

>  cat >expected <<EOF
>  <BOLD;GREEN>hello.c<RESET>
>  4:int main(int argc, const <BLACK;BYELLOW>char<RESET> **argv)
