Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24171208DC
	for <e@80x24.org>; Thu, 24 Aug 2017 16:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753658AbdHXQwP (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 12:52:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61727 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753500AbdHXQwN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 12:52:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E435598F34;
        Thu, 24 Aug 2017 12:52:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nWAdCrUlms3bcXXTIdVcsFosXDc=; b=BVAn1z
        xhOJGM7uYgSYwggnFjIsWoP1WXIgShz8+Q/OqfcOZpMCQbusZVVuZq+oRudRxa1g
        ODQvHn+SlHF+stMD63gDvyzTXnLm8U1BXYWHLOZFzjYP1zDFM+4BclBtJ9fr2VOz
        NWiupYxEJizFGNlK6dm7L2EyGqCux1j60JOBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M/1WQJEfRyWFiDHSfqKRYaybZOdOIWsW
        kOZQqpeT95CsZ1GIctD388J7T+6qCHSvVFOLbNot27IyJwyXivKJjPOMjMIva+Pl
        PB3AsGnLgDjR6FAqZv3SV984eswxlsGmHYPUXf6IP6IRi7gT3Aik0j55Vvo11HUn
        xh/ZYvvkpBQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD18A98F33;
        Thu, 24 Aug 2017 12:52:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 514F498F31;
        Thu, 24 Aug 2017 12:52:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Casey <drafnel@gmail.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] strbuf_setlen: don't write to strbuf_slopbuf
References: <cover.1502780343.git.martin.agren@gmail.com>
        <cover.1503323390.git.martin.agren@gmail.com>
        <dccd3e75fcd1b2de93263e8373a3b4cd5da0dd32.1503323391.git.martin.agren@gmail.com>
        <CA+sFfMdXv+nqpXmwfLTHtkRLuGkAEAwWXZCvOryVZ=aLb_UmbA@mail.gmail.com>
        <xmqqh8wyxag1.fsf@gitster.mtv.corp.google.com>
        <CA+sFfMe56itAMDXOJybf0yHj+BqU1Ai1aU7inoTG3FJtdtZxyw@mail.gmail.com>
        <CA+sFfMdMgrGBhECegBe09c38nRM+Zt5JK4gJaZ96DO-9zC-8qA@mail.gmail.com>
Date:   Thu, 24 Aug 2017 09:52:11 -0700
In-Reply-To: <CA+sFfMdMgrGBhECegBe09c38nRM+Zt5JK4gJaZ96DO-9zC-8qA@mail.gmail.com>
        (Brandon Casey's message of "Wed, 23 Aug 2017 14:54:56 -0700")
Message-ID: <xmqqpobkx610.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9353900C-88EC-11E7-B3F9-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Casey <drafnel@gmail.com> writes:

> Ah, you probably meant something like this:
>
>    const char strbuf_slopbuf = '\0';
>
> which gcc will apparently place in the read-only segment.  I did not know that.

Yes but I highly suspect that it would be very compiler dependent
and not something the language lawyers would recommend us to rely
on.

My response was primarily to answer "why?" with "because we did not
bother".  The above is a mere tangent, i.e. "multiple copies of
empty strings is a horrible implementation (and there would be a way
to do it with a single instance)".

>    #define STRBUF_INIT  { .alloc = 0, .len = 0, .buf = (char*) &strbuf_slopbuf }
>
> respectively.  Yeah, that's definitely preferable to a macro.
> Something similar could be done in object.c.

What is the main objective for doing this change?  The "make sure we
do not write into that slopbuf" assert() bothers you and you want to
replace it with an address in the read-only segment?
