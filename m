Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB48C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 04:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 902D26140C
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 04:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhFOEsa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 00:48:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65450 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhFOEs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 00:48:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 96008125D67;
        Tue, 15 Jun 2021 00:46:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AidwM8QPmnpXkVZJBsDrffKrd276lO8YFzx1Ed
        974o4=; b=vul/dWjTbzvmvs8dqsl4QqBou9gTKl7V3LHvNB9roto5CKBpUEYDyx
        a22k7YULfSI1BdaEllk0UAX2kgXG2QXADTqeSNGbWaqPKYtiffCEfmETHGSZm5tb
        Niwk33+qiQifma36jn5Wp0lKl7luo1DpY9FLYVjXT2wublDowXvEg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8E9F9125D66;
        Tue, 15 Jun 2021 00:46:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D5602125D65;
        Tue, 15 Jun 2021 00:46:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/4] sideband: append suffix for message whose CR in
 next pktline
References: <87im2s5jjm.fsf@evledraar.gmail.com>
        <20210612050711.4057-4-worldhello.net@gmail.com>
        <xmqqim2hyuj1.fsf@gitster.g>
        <CANYiYbGtfgZepnfTWGjbmOh2bxa8tZ7bvgtVTo6qTQpCP9MPag@mail.gmail.com>
        <xmqqk0mwylhc.fsf@gitster.g>
        <CANYiYbG6bKwheThWz2ecHUTh7JFmTsi-F9FtYkcoS0az=f=m6Q@mail.gmail.com>
        <0pqq6s9-n238-95ss-nsqr-42o75sr933r@syhkavp.arg>
        <CANYiYbFsqj9j_UT9-mF+BSOAHU4=On+BUxCU4w6rXhhMaeo=zg@mail.gmail.com>
        <r8ss67nn-31s4-o429-828p-s787sr2481@syhkavp.arg>
Date:   Tue, 15 Jun 2021 13:46:20 +0900
In-Reply-To: <r8ss67nn-31s4-o429-828p-s787sr2481@syhkavp.arg> (Nicolas Pitre's
        message of "Mon, 14 Jun 2021 23:26:35 -0400 (EDT)")
Message-ID: <xmqqh7hzwx9f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1D55534-CD94-11EB-8737-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Pitre <nico@fluxnic.net> writes:

> On Tue, 15 Jun 2021, Jiang Xin wrote:
>
>> The issue this patch try to fix is like the following example:
>> 
>>     PKTLINE(\2 "<progress-1>" CR "<progress-2>")
>>     PKTLINE(\2 CR "<message-3>" LF)
>> 
>> The message "<progress-2>" is displayed without a proper clear-to-eol
>> suffix, because it's eol (CR) is in another pktline.
>
> I'd fix this issue with the following logic:
>
> bool pending_clear_to_eol;
>
> my_putchar(c) {
> 	switch (c) {
> 	case '\r':
> 	case '\n':
> 		pending_clear_to_eol = true;
> 		break;
> 	default:
> 		if (pending_clear_to_eol) {
> 			clear_to_eol();
> 			pending_clear_to_eol = false;
> 		}
> 		break;
> 	}
> 	putchar(c);
> }
>
> In other words, you clear the line after printing "remote:" but only if 
> there is a non \n or \r coming next.

What puzzles me the most in this discussion is why we do this for
LF.  I do understand why we need it for CR---the line we are going
to show message on after emitting CR would be full of leftover
letters we previously have written before emitting CR, so we'd show
the message (to overwrite the initial part enough to show our own
message) and then clear to the end with either ANSI sequence of
sufficient number of whitespaces.  But line feed would take us to a
fresh and blank line---there is nothing to clear, no?

Thanks.
