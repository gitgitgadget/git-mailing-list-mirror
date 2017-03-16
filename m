Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87D7820323
	for <e@80x24.org>; Thu, 16 Mar 2017 19:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbdCPTrg (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 15:47:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59308 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751957AbdCPTrf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 15:47:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88AE085F44;
        Thu, 16 Mar 2017 15:46:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HMgWQoY5wSD+lW9Jkckijgj1LAc=; b=u0LUpS
        swY/D5owSTdrfZtCPXrMxS/Z/BcngkpzOz7CEitsdi4sttOU8x6+yBnWrZmNJvg3
        BJQaocKub1aRunxvrN7FCCBa3gWVoxFmaQUizNMmT1DEGdE3nhnjf82hkbTL+jpK
        /lnZ3ODZk+ycxJ+8OgSvYYDuWbINsr59zK1CA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T7/Aw9L3J6KnWFRMB9Lf9WP/8grlsb9J
        KhrbgtjgKKEmffv2J9Hd5joXVhFEaWJ1oGyFgjBY5UYq1cPQ+9XDIEuJu8mo9+9u
        4fU5aEFelnTFHL2jw8VciF/nM+XuqsPhoiIErFoLoZGoEwUPJISlBuiNewnBnNXF
        QeT/7GsQDt8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80E8285F43;
        Thu, 16 Mar 2017 15:46:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E4AA385F42;
        Thu, 16 Mar 2017 15:46:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: USE_SHA1DC is broken in pu
References: <CA+55aFzJ3NFVoN6K9__nM_LWYfegxGo_YxB0OudTNBCG+qq+3Q@mail.gmail.com>
        <20170316194110.756ipu7xud2s3w2m@sigill.intra.peff.net>
        <CA+55aFzp_dxevLEbRVWCmbx=zY=8hwqEBKK=Pcs7Au+rdg4pRQ@mail.gmail.com>
Date:   Thu, 16 Mar 2017 12:46:25 -0700
In-Reply-To: <CA+55aFzp_dxevLEbRVWCmbx=zY=8hwqEBKK=Pcs7Au+rdg4pRQ@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 16 Mar 2017 12:44:11 -0700")
Message-ID: <xmqqbmt1atta.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E3F3CCC-0A81-11E7-BA11-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Mar 16, 2017 at 12:41 PM, Jeff King <peff@peff.net> wrote:
>>
>> Potentially we should just eject sha1dc from "pu" for the moment. It
>> needs re-rolled with the most recent version of the collision library
>> (and I see Marc just posted that they hit a stable point, which is
>> perhaps why you're looking at it).
>
> I looked at it, and even created a patch, and then decided that you'd
> probably do it.
>
> But yes, re-integrating entirely (rather than creating a patch against
> the previous SHA1DC) might be simpler.
>
> Junio, which way do you want to go?

That's easy to answer.  What we have on 'pu' is a fair game for
wholesale replacement.  That is the whole point of not merging
topics in flux to 'next' and declaring that 'pu' will constantly
rewind.
