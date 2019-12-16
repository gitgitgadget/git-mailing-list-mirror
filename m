Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A39C2D0BF
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 18:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631A0206EC
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 18:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rF1GCkJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbfLPScc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:32:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54282 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729143AbfLPScb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 13:32:31 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA4063B95E;
        Mon, 16 Dec 2019 13:32:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7ndqYyd5YZkzfR8ylsI0JOMc1CA=; b=rF1GCk
        JBw7e6Y7L9Hz6I1z3tTRsUXKL6AoLcSmvyg+oueSGTq5OfhRaUIdJ1kPzAqNW74n
        DCA4edlEIhr52uLDNRd992F3I8nHNxuXOL0WkwDVnrQKa+ItwpAn88nzVSUU1CoV
        20A4HYyYydgg3g2Ty3ebvZf/ukpa9OCVFzlg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cgNnLNQw6csk3OLq23yCupzo9ZP5Bvdk
        FeIa1AB0Bll5pZRkSHVSLA/vt0ht7EX7truMIqsiSrgQ6iGI5mM+KTPkHquftEpL
        uu5PB+L8w3K6xbu/YEPw4XstEEF6RDu0QkvqltKBRcMXXb92GE5X/DSHFxIr102a
        sMB4T0EJE3I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1C943B95D;
        Mon, 16 Dec 2019 13:32:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3BF703B95C;
        Mon, 16 Dec 2019 13:32:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Ruud van Asseldonk <dev@veniogames.com>, git@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] t5150: skip request-pull test if Perl is disabled
References: <4f11b5b3-a68e-642a-c5fb-7b5dae698669@veniogames.com>
        <20191127112150.GA22221@sigill.intra.peff.net>
        <20191128013111.GA76989@google.com>
        <xmqqblsrz1uk.fsf@gitster-ct.c.googlers.com>
        <20191213074659.GA95694@coredump.intra.peff.net>
Date:   Mon, 16 Dec 2019 10:32:26 -0800
In-Reply-To: <20191213074659.GA95694@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 13 Dec 2019 02:46:59 -0500")
Message-ID: <xmqqsglkjf45.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69BC292C-2032-11EA-B4B4-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Dec 01, 2019 at 10:19:15PM -0800, Junio C Hamano wrote:
>
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>> 
>> >   Not-Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>> >
>> > --- the patch shouldn't be applied as is.
>> > ...
>> > Agreed: if we want to follow this approach, we should install stubs in
>> > place of those scripts when NO_PERL=YesPlease.  Will say more about
>> > this in a separate reply.
>> 
>> I am just leaving a note here in the thread to make sure I notice if
>> there is any progress/conclusion, until which time I'll keep the
>> patch on hold.  Thanks.
>
> Thinking on this more, it might not be a bad idea to take Ruud's initial
> patch here. It certainly makes things better for his NO_PERL case now,
> and then in the future we can either:
>
>  - stop building request-pull entirely with NO_PERL, but we'd still need
>    the tests to realize that we shouldn't be testing it
>
>  - change request-pull to not require perl, at which point we'd remove
>    this restriction

Hmph, that is a reasonable stance to take, I would think.  Let's
move it forward.

Thanks.
