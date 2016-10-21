Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F8E220229
	for <e@80x24.org>; Fri, 21 Oct 2016 17:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932537AbcJURMV (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 13:12:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51567 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932467AbcJURMU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 13:12:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0FD147D1B;
        Fri, 21 Oct 2016 13:12:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kNhs7UEqi3d51i0yozkGOPfehKM=; b=pTmfMg
        QUpwfH5ZddnrKXZGF54JR3yS89R/YAaj9PhgeMoUF1LUL+s+SClQIc8rr4ET/vk7
        NQc1khoNEuv9K2hKy3oB7eOcxCY8Vqc3jBFQs0oq2MF30Tgu68VcsCmD86usY/Cd
        vK51ngJc7rxrF+I9827OomLf8SAdIeli/imOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aDMvV3MIebzYLWVvQTuFiujomyW9GM6t
        689O3U1UnIDit5j3XzzUS6XEblrvORiSbZiqzmByKXecZePJftDAhoSBiEo/1XiB
        Ma/Ci/oguwTm3VO5MlZZeczfEMb9dLIRyWFG6157O+R6ADjm6w1tojT1zCmXEifs
        eVytV5YFwFs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9854247D1A;
        Fri, 21 Oct 2016 13:12:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0ED4747D18;
        Fri, 21 Oct 2016 13:12:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] test-lib: add --verbose-log option
References: <20161021104107.vh3bjx6x6pd6izat@sigill.intra.peff.net>
        <20161021104759.hx6q7u66r3ll7l44@sigill.intra.peff.net>
Date:   Fri, 21 Oct 2016 10:12:16 -0700
In-Reply-To: <20161021104759.hx6q7u66r3ll7l44@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 21 Oct 2016 06:48:00 -0400")
Message-ID: <xmqq7f91d3tb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85C6A460-97B1-11E6-BB0C-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This patch implements option (5), which seems to work well
> in practice.

Your journey to reach this final design and implementation may have
been painful---I really like the end result.  This was an accident
waiting to happen.

Thanks for fixing it.

> @@ -319,7 +332,10 @@ fi
>  
>  exec 5>&1
>  exec 6<&0
> -if test "$verbose" = "t"
> +if test "$verbose_log" = "t"
> +then
> +	exec 3>>"$GIT_TEST_TEE_OUTPUT_FILE" 4>&3
> +elif test "$verbose" = "t"
>  then
>  	exec 4>&2 3>&1
>  else

OK, unlike "verbose" case where we give 3 (saved stdout) to 1 and 4
(saved stderr) to 2, we send 3 to the output file and 4 to the same.

Makes sense.
