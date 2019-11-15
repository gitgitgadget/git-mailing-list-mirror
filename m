Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8C5C1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 05:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfKOFgm (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 00:36:42 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58192 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfKOFgl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 00:36:41 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8147A8F8A5;
        Fri, 15 Nov 2019 00:36:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PvROMx5Gfh/mB3jmFg90gSkUHUQ=; b=K+LTuc
        I07flBCuzvvHdeJIxm4Qi6TA7NWZ/Yt34/OvDyrQd+90ahpBl/GJc5TUruXyKK4T
        OmubTsK+6GH3l13FaiOVIHn0oREesuqlmkDZ1Pp0Bu8gq+bwXbZjFCQpxYeqpnyz
        0FPnKUfZxIhgH0WgCyvGD2MU61DmcRoHQs9I4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ydTCiAe/TIlfCToC2DnTIzXGQ83AiwJs
        hciEAc8MD32cB3q+fg/B2yTOaiaJKlq0f9qztkqu/czhnqlldx2To543VIsr59hN
        WBmmgVgw2PngHTofSsEcn8YhMQhgf/9epYCBL2UPrEsfhmP5HcatdRDmhfd45sAI
        hvUW6DlrQ7k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 79D038F8A4;
        Fri, 15 Nov 2019 00:36:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A79D78F8A3;
        Fri, 15 Nov 2019 00:36:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 24/27] t5004: ignore SIGPIPE in zipinfo
References: <cover.1573779465.git.liu.denton@gmail.com>
        <d27ee1e627339f2fc6a8fdf3b1be79435c9a4bc6.1573779466.git.liu.denton@gmail.com>
Date:   Fri, 15 Nov 2019 14:36:36 +0900
In-Reply-To: <d27ee1e627339f2fc6a8fdf3b1be79435c9a4bc6.1573779466.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 14 Nov 2019 17:01:26 -0800")
Message-ID: <xmqqo8xd7laz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E53AEA98-0769-11EA-9427-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In a future patch, we plan on running tests with `set -o pipefail`.
> Since zipinfo is killed by SIGPIPE, it will return an error code which

s/is killed/may be killed/ for the reasons I wrote for 23/27, I think.

Otherwise the idea behind the patch is good.

Thanks.

> will propogate as a result of the pipefail.
>
> Mask away the return code of zipinfo so that the failure as a result of
> the SIGPIPE does not propogate.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/t5004-archive-corner-cases.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
> index 3e7b23cb32..4c6d42d474 100755
> --- a/t/t5004-archive-corner-cases.sh
> +++ b/t/t5004-archive-corner-cases.sh
> @@ -153,7 +153,9 @@ test_expect_success ZIPINFO 'zip archive with many entries' '
>  
>  	# check the number of entries in the ZIP file directory
>  	expr 65536 + 256 >expect &&
> -	"$ZIPINFO" many.zip | head -2 | sed -n "2s/.* //p" >actual &&
> +	{
> +		"$ZIPINFO" many.zip || :
> +	} | head -2 | sed -n "2s/.* //p" >actual &&
>  	test_cmp expect actual
>  '
