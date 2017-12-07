Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D94CB20954
	for <e@80x24.org>; Thu,  7 Dec 2017 15:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbdLGPYq (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 10:24:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52710 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754616AbdLGPYb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 10:24:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96254C021C;
        Thu,  7 Dec 2017 10:24:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=okbaLb05BmxaFskPJyyRVdBLzu4=; b=XX+zI3
        Rnyw4wHgexndxFlNdFyk5S8efkZgf6QbzK4mx2zcO735UG3iEjTSlBw6A112i+mX
        2eCeQpfCzpr2Ab8cIZsdbpxhcweX17+N4fBxPSNII5VbwZEhQGY+N0yOdwsPr1YA
        9ERUrgomFHweSumEBtrrghVOqGLhekhf79se0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Dmgn3szX5Mzypg+25d5EjNOoaCI+oHEQ
        +85w603gRX2hzvbluUfLr6syo359f+GslCQtm7WXVSPuBUbp7Oi+/Js6cFnFHwbD
        svE9Na962q3U3V4T+N6QHDKcKXsVpP1Xh9w4kSpOMTkCOkBWqQjsarYiW08Bug/M
        vDOUGCEA5KI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8EC83C021B;
        Thu,  7 Dec 2017 10:24:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D5226C021A;
        Thu,  7 Dec 2017 10:24:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: git commit file completion recently broke
References: <CA+P7+xotDPa+=G5ypfyD7gySp6r2SKRAjMSw_0BmvuyyfcjxBw@mail.gmail.com>
        <CA+P7+xouqMi4xo7psM-PmpqcpKre2X1YyYZBLfMDYSSZ8tD_VQ@mail.gmail.com>
        <20171207002234.GA21003@sigill.intra.peff.net>
        <20171207002439.GB21003@sigill.intra.peff.net>
        <CA+P7+xpoaa5zaF13ageKKjpPKTECU6XjaRdSZy6WOP7Q0TX+yA@mail.gmail.com>
        <20171207005639.GB1975@sigill.intra.peff.net>
        <CAP8UFD3iL_sRgvhm7YO_jVG5RiNn1=JRW0qvhBEPcUtCorWdYA@mail.gmail.com>
Date:   Thu, 07 Dec 2017 07:24:28 -0800
In-Reply-To: <CAP8UFD3iL_sRgvhm7YO_jVG5RiNn1=JRW0qvhBEPcUtCorWdYA@mail.gmail.com>
        (Christian Couder's message of "Thu, 7 Dec 2017 09:14:31 +0100")
Message-ID: <xmqq8teeftn7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8077ECC-DB62-11E7-839B-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> I do think it may make sense for
>> the "short" one to use NULL, like:
>>
>>   skip_to_optional_val(arg, "--relative, &arg)
>>
>> but maybe some other callers would be more inconvenienced (they may have
>> to current NULL back into the empty string if they want to string
>> "--foo" the same as "--foo=").
>
> I discussed that with Junio and yeah there are many callers that want
> "--foo" to be the same as "--foo=".

Yup, the original thread has details and me saying that assuming all
of them want --foo and --foo= the same is questionable.  The likely
fix would be to use the _default variant with NULL, which was added
exactly for cases like this.

