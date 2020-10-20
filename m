Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A173DC4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 19:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2502D2224A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 19:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vZgwhzjR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438021AbgJTTPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 15:15:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62067 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438018AbgJTTPC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 15:15:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 504DB85EC4;
        Tue, 20 Oct 2020 15:15:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uX1tCSBmzQo4VyeluuEHjBl2Wsk=; b=vZgwhz
        jRJRIlm5mpVCZbRyc3T4oeqomGJq8bHYOb+K7cmHERtR69lbR7njzB1vdCTK4gUX
        ruL0CiFmNPQYw2viR4nrYH0WLrS8OLPNOgKEF2d0LTgO4aAzXWQFX7MwQ1Fgk1lr
        jNjQLXAJmfGpoW6re7Ymt2UZKhQSuIpPXq0BA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m3ecRpOm7PaP3JS685It3VC3faTAunG3
        nPsH40mspk8on6fZBzECDePj/gjAM9CcoPMqJueQvYH/3zolAUL1fhQyIl0IcpDL
        XpoiWnFzRzyNXCiDb911ArEFGdSk/E0KApR+RjAm6swPGqJNBS/UsvUjUemSvCsl
        esUYKeJnZCM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4373A85EC2;
        Tue, 20 Oct 2020 15:15:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BCF5885EC1;
        Tue, 20 Oct 2020 15:14:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 16/19] parallel-checkout: add tests for basic operations
References: <cover.1600814153.git.matheus.bernardino@usp.br>
        <64b41d537e68a45f2bb0a0c3078f2cd314b5a57d.1600814153.git.matheus.bernardino@usp.br>
        <20201020013558.GA15198@google.com>
        <CAHd-oW7=Bd+StX_t+6iuaas0SWzEdbQCj5aWgasoOYT2kfVw7g@mail.gmail.com>
Date:   Tue, 20 Oct 2020 12:14:59 -0700
In-Reply-To: <CAHd-oW7=Bd+StX_t+6iuaas0SWzEdbQCj5aWgasoOYT2kfVw7g@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Tue, 20 Oct 2020 00:18:21
        -0300")
Message-ID: <xmqqy2k0btfw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C35930C-1308-11EB-9D4C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> Oh, I didn't know about the portability issue with \+. This is already
> in `next`, but I guess it's worth sending a follow-up patch to fix it,
> right? (I see we have a second \+ occurrence in t7508, which could be
> changed in the same patch.)

Note that soon, typically a week, after a release, the tip of the
next branch is rewound and all the topics that did not graduate to
master has a chance to get a clean start.  This may be a good use
case for that chance.
