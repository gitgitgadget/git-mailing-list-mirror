Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CFF51F4DD
	for <e@80x24.org>; Wed, 23 Aug 2017 22:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751026AbdHWWY0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 18:24:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61223 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750715AbdHWWYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 18:24:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7D1EA1FDB;
        Wed, 23 Aug 2017 18:24:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ifoItpzjcjdNWaJ6NB0RrEQtD9M=; b=evonAB
        2kWpd45jmpxAa9rG1OMqwZpQlq7ERlNIzBOZvxj0gECpIUR1fkQTldjK0uD/ks1X
        ke8DvF3h0VLjx91i5MzkP4FcItVohs+kOj2Xu7YMfDq8E7Ox4L6yJUUNnmifNowC
        TNeM2Bg53Ca1Xn/9Ii4LZh0/wA3/veGATVyqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cxeGQB+edlmNKuJEw/6eRC+zufHwy2/e
        2AI/JI879WS8VmVw4e7c0LFl/spGop0cVPfMgfMIPQsi24aupFhKSdjrU8Qe1z0c
        cBLPA6pqKaA9amTmVqJMyXXGgGxUQdjhKEOEdX3K6odocQ+OQzozccBD26M6mXms
        q/kKEGFGumw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0CD4A1FDA;
        Wed, 23 Aug 2017 18:24:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2E537A1FD9;
        Wed, 23 Aug 2017 18:24:24 -0400 (EDT)
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
Date:   Wed, 23 Aug 2017 15:24:22 -0700
In-Reply-To: <CA+sFfMe56itAMDXOJybf0yHj+BqU1Ai1aU7inoTG3FJtdtZxyw@mail.gmail.com>
        (Brandon Casey's message of "Wed, 23 Aug 2017 14:20:23 -0700")
Message-ID: <xmqq378hylbd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D139D12E-8851-11E7-B26F-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Casey <drafnel@gmail.com> writes:

> On Wed, Aug 23, 2017 at 2:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Brandon Casey <drafnel@gmail.com> writes:
>>
>>> So is there any reason why didn't do something like the following in
>>> the first place?
>>
>> My guess is that we didn't bother; if we cared, we would have used a
>> single instance of const char in a read-only segment, instead of
>> such a macro.
>
> I think you mean something like this:
>
>    const char * const strbuf_slopbuf = "";

Rather, more like "const char slopbuf[1];"
