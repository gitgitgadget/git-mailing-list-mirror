Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEB6C20281
	for <e@80x24.org>; Thu, 21 Sep 2017 06:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbdIUGSL (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 02:18:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60527 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751450AbdIUGSK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 02:18:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8F31961F5;
        Thu, 21 Sep 2017 02:18:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/wVDaqeOoGshE0o2+wHmIMX2cqw=; b=MkSK0E
        jni24EbWjqjWcMnzW02kjcUBhZejK5DEJcxvcb32HIWlPAGjMeDPFvJ34Lj65WIn
        iK5LNDAM6sseCyTIVffUkjzDi7Tu0y7x9k0+byTZsECGRQIw+NL+76wRiCHUJg9H
        xdFmvQGrpEviFDNEirXwjv+ccMCkJ3WORyZVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XQ4V3VNC6Ximz7ZXZpE3vakdpHMpgisE
        oynaL6py5S+CjrDnGvXHVuNSOVqGF0MfV02nOb8Vf8ywcUtgNwBngKd/CbO+rEvy
        ShVbwX2J0d2VKrmRhFk4CPXw6NEGf8tpI4XSpQ6F+1O+zdJ9mlIz036f77Xv9ex4
        XwMsP3cPJu8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1166961F4;
        Thu, 21 Sep 2017 02:18:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0AF95961F3;
        Thu, 21 Sep 2017 02:18:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Ben Peart <Ben.Peart@microsoft.com>,
        Karsten Blees <blees@dcon.de>
Subject: Re: [PATCH] Win32: simplify loading of DLL functions
References: <f5a3add27206df3e7f39efeac8a3c3b47f2b79f2.1505834586.git.johannes.schindelin@gmx.de>
        <20170919180742.GC75068@aiede.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1709202235300.219280@virtualbox>
        <20170920212310.GF27425@aiede.mtv.corp.google.com>
Date:   Thu, 21 Sep 2017 15:18:07 +0900
In-Reply-To: <20170920212310.GF27425@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 20 Sep 2017 14:23:10 -0700")
Message-ID: <xmqqwp4sk21s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A35368FC-9E94-11E7-B148-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Johannes Schindelin wrote:
>> On Tue, 19 Sep 2017, Jonathan Nieder wrote:
>
>>> Could this example go near the top of the header instead?  That way,
>>> it's easier for people reading the header to see how to use it.
>>
>> Funny, I am *so* used to examples being at the very end, from tutorials to
>> man pages.
>>
>> If my experience is any indication, I would rather keep this order.
>
> Sorry for the lack of clarity.  I meant "near the top of the header
> *file*".

Yeah, I think it would help to have something like that near the top
of the header file for the potential users of the helper.

> FWIW nothing I noticed came to the level of requiring a v2 imho.  If any
> of the ideas I mentioned seems good, they can go in patches on top.

True, too, and additional "doc in header" can also be done as a
follow-up.

But as I heard "v2 in a few days", I'll throw it in the "Expecting a
reroll" bin for now.

Thanks, both.
