Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0163220133
	for <e@80x24.org>; Fri,  3 Mar 2017 16:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752400AbdCCQKT (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 11:10:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59333 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751617AbdCCQH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 11:07:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2886A5F574;
        Fri,  3 Mar 2017 11:07:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=alEfmsueD+5SbZG03IprD81g/Cc=; b=SXcCPT
        Pml+RIr7ocVSIInnm+qHJjX/dMQCXjtYiGXzEv9FwzdMLgkGo2inqENqvqm4NlsI
        TDEM595rabG6OfbBRlwOngCjfms8rz9ef3F/KCdGDtwZeeFXSEWxwckcCiZ+gZau
        dLQ9RBTnCHl9MEnEFrfbCVSYOPsHFfbtugfeY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w/ghFy6yVtHTuKIVxd07LPiDEIJCWMt/
        qbmSIQyev0jdrC+WYSonp7XALf86ApAlr02SjbOOW3ILHCE5kPtuil3f/plpOUGT
        ZF3uBOd2iUdaip6N5GGn+AKchRBnfQh/ll+xm7WYbD4XtJZJX7B+8PG+vN39TFgi
        ZOhB4ljfLWk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 200DB5F572;
        Fri,  3 Mar 2017 11:07:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89C245F571;
        Fri,  3 Mar 2017 11:07:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: log -S/-G (aka pickaxe) searches binary files by default
References: <7a0992eb-adb9-a7a1-cfaa-3384bc4d3e5c@virtuell-zuhause.de>
        <CAPc5daVSY5Z_+cpT1dHY-cM-TzNeu+Vzv+zouoOHW08PTFRQ7A@mail.gmail.com>
        <20170303051721.r6pahs4vjtqqoevc@sigill.intra.peff.net>
Date:   Fri, 03 Mar 2017 08:07:41 -0800
In-Reply-To: <20170303051721.r6pahs4vjtqqoevc@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 3 Mar 2017 00:17:21 -0500")
Message-ID: <xmqqzih29wdu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 882453C8-002B-11E7-B8C2-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Mar 02, 2017 at 05:36:17PM -0800, Junio C Hamano wrote:
> ...
>> > Is that on purpose?
>> 
>> No, it's a mere oversight (as I do not think I never even thought
>> about special casing binary
>> files from day one, it is unlikely that you would find _any_ old
>> version of Git that behaves
>> differently).
>
> The email focuses on "-G", and I think it is wrong to look in binary
> files there, as "grep in diff" does not make sense for a binary file
> that we would refuse to diff.

Yeah, I agree.

> But the subject also mentions "-S". I always assumed it was intentional
> to look in binary files there, as it is searching for a pure byte
> sequence. I would not mind an option to disable that, but I think the
> default should remain on.

As the feature was built to be one of the core ingredients necessary
towards the 'ideal SCM' envisioned in

  <http://public-inbox.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org>

"-S" is about finding "a block of text". It was merely an oversight
that we didn't add explicit code to ignore binary when we introduced
the concept of "is this text?  is it worth finding things in and
diffing binary files?".

I do agree that it may be too late and/or disruptive to change its
behaviour now, as people may grew expectations different from the
original motivation and design, though.

