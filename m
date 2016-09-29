Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5803207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 21:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934340AbcI2VDo (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:03:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56025 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933330AbcI2VDn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:03:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E039542A15;
        Thu, 29 Sep 2016 17:03:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vz4FKyWcNfrV611DyKuUW/Uapfw=; b=OqDozu
        iZDFLAlz7zObUeQhmW3BC84cXFOrnIMiwv3ChQugXMXw6QpOjgQlCRARGZnQy5eF
        bAQ1TdchfU7ZD/dmJkGooNQ2q8ifmR62pzq2J7MCAefY3H5CXRcbtgW5Lk8xwZGK
        GdhjY/Fg+QI+6zZ+orj27JtRIsjFrbUHbsHqE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YAoIZT/nOTTmrVHMwRpCdoce06xSV8eD
        Tw/wEV4koZkT2NER5QRMKo6gwdCEbnJn8fmWf/aMHPMKAfvVaplcLUse4RfNFG5M
        Ms822wq4qG4aYdwW/fmebC5urRjhrzaq716bjdZ3EQ69AJUJrjUy5p+X0/zIH/5J
        0EYAaFvu1Jc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D833442A13;
        Thu, 29 Sep 2016 17:03:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 62C9542A10;
        Thu, 29 Sep 2016 17:03:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 2/4] t13xx: do not assume system config is empty
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
        <20160928233047.14313-1-gitster@pobox.com>
        <20160928233047.14313-3-gitster@pobox.com>
        <20160929090108.hf2jzfcvbcsfaxw7@sigill.intra.peff.net>
        <xmqqintefuau.fsf@gitster.mtv.corp.google.com>
        <20160929182621.lobihscwl7amtu7s@sigill.intra.peff.net>
        <xmqq60pefrvc.fsf@gitster.mtv.corp.google.com>
        <20160929192613.o6q2fqp3mjntz2l6@sigill.intra.peff.net>
Date:   Thu, 29 Sep 2016 14:03:39 -0700
In-Reply-To: <20160929192613.o6q2fqp3mjntz2l6@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 29 Sep 2016 15:26:14 -0400")
Message-ID: <xmqqoa36e7v8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33355294-8688-11E6-8909-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Good description.
>
> Signed-off-by: Jeff King <peff@peff.net>
>
> of course.
>
>> @@ -1304,6 +1315,7 @@ test_expect_success '--show-origin with --get-regexp' '
>>  		file:$HOME/.gitconfig	user.global true
>>  		file:.git/config	user.local true
>>  	EOF
>> +	GIT_CONFIG_SYSTEM_PATH=$HOME/etc-gitconfig \
>>  	git config --show-origin --get-regexp "user\.[g|l].*" >output &&
>>  	test_cmp expect output
>>  '
>
> This is one is trying to do a multi-file lookup, but we couldn't look in
> the system config before. But to naturally extend it, it ought to look
> like this on top:
>
> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index d2476a8..4dd5ce3 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -1310,11 +1310,12 @@ test_expect_success '--show-origin with single file' '
>  
>  test_expect_success '--show-origin with --get-regexp' '
>  	cat >expect <<-EOF &&
> +		file:$HOME/etc-gitconfig	user.system true
>  		file:$HOME/.gitconfig	user.global true
>  		file:.git/config	user.local true
>  	EOF
>  	GIT_ETC_GITCONFIG=$HOME/etc-gitconfig \
> -	git config --show-origin --get-regexp "user\.[g|l].*" >output &&
> +	git config --show-origin --get-regexp "user\.[g|l|s].*" >output &&
>  	test_cmp expect output
>  '

Makes sense modulo you inherited useless vertical bars from the
original.  I'll squash something like that in but without || ;-)

Thanks.
