Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523B4C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 02:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D181220897
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 02:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gT3rd0lS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393739AbgJPCah (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 22:30:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56198 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393736AbgJPCah (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 22:30:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B1E048AD7A;
        Thu, 15 Oct 2020 22:30:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j15V8HQ3UDXhsbKZLZsGfZyggAk=; b=gT3rd0
        lS52kR0/JR5J9z86uwQGri+GPv5c2/swLPBWfqkxtbqf8HZGZwH61ZMUfQfkz1z4
        mqcuzTtaXiNMGunpABJ0XDZ9bjOXnegJnYybVVztIZZM6gRe/2kxRTyhaqnXiCPy
        dtXRke8GzYpSTDjZExaxb+S0IjlTNiP8vHTiM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CZxqxHD+JgaE5NoXwadYgHhPzDtLR3Yj
        /lR04iO408PedYWzzsGU6i5xtPklDdICPpsmhWx2gwNL/BBN/QXEL2tz6OpPeocp
        hmgUmA/jwH4K9CSJOtdU6iEYrdc0son3viAuFY0RK5Y0f2FXKL4X9FfMEaKiaWLP
        319p8LIeDDY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A93988AD79;
        Thu, 15 Oct 2020 22:30:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2ABCC8AD78;
        Thu, 15 Oct 2020 22:30:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] Clarify and expand description of --signoff
References: <20201015215933.96425-1-bkuhn@sfconservancy.org>
        <59E3B060-63E3-41C2-A7C4-5B2C888F8D68@gmail.com>
        <CAPc5daWenXds=0BW0CXa=4MOF2UxDeQ8DF2+7V9-WkKwCFCDBw@mail.gmail.com>
        <20201016015937.GA3335046@coredump.intra.peff.net>
Date:   Thu, 15 Oct 2020 19:30:34 -0700
In-Reply-To: <20201016015937.GA3335046@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 15 Oct 2020 21:59:37 -0400")
Message-ID: <xmqqft6eewc5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 920EB498-0F57-11EB-AF91-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We do already say pretty clearly what signed-off-by means in the
> project:
>
>   $ grep -A14 '\[\[sign-off]]' Documentation/SubmittingPatches 
>   [[sign-off]]
>   === Certify your work by adding your "Signed-off-by: " line
>   
>   To improve tracking of who did what, we've borrowed the
>   "sign-off" procedure from the Linux kernel project on patches
>   that are being emailed around.  Although core Git is a lot
>   smaller project it is a good discipline to follow it.
>   
>   The sign-off is a simple line at the end of the explanation for
>   the patch, which certifies that you wrote it or otherwise have
>   the right to pass it on as an open-source patch.  The rules are
>   pretty simple: if you can certify the below D-C-O:
>   
>   [[dco]]
>   .Developer's Certificate of Origin 1.1
>
> What should we change there? We could perhaps bring up signoffs earlier
> or more prominently. Or tie it in to the git-commit docs by saying
> explicitly: these are _our_ project rules for signoffs.

That is almost good enough, but you can easily see that it was
written back when the world only had choice between "Linux-style
signed-off-by that means Linux-style DCO requirement" and "not
signing off", and we chose to be in the former camp.

I think the most important clarification Bradley's making is that we
no longer live in such a world.  "signed-off-by" means different
things for different projects, and what we use is this one.  That
choice may have been adopted from the Linux project and may have
been identical to what they used back when we adopted it, but that
is of secondary importance (most importantly, if they changed what
it means, that won't directly affect this project).

Perhaps I'd rewrite these two paragraphs like so:

    To improve tracking of who did what, we use the "sign off"
    procedure.  By adding the "Signed-off-by:" line in the trailer
    of your commit, you certify to this project the below D-C-O that
    you have the right to pass your patch on under the same license
    as ours.  Without such a sign-off, we cannot accept your patch:

    [[dco]]
    .Developer's Certificate of Origin 1.1

    ...

and after the DCO text, add this paragraph as a historical reference.

    This procedure originally came from the Linux kernel project, so
    our rule is quite similar to theirs, but what exactly it means
    to sign-off your patch differs from project to project, so it
    may be different from that of the project you are accustomed to.

either before or after the "Random J Developer" example.  I think we
should remove the "you can do this automatically by giving -s" or at
least the word "automatically" from that sentence, while we are at
it.

Thanks.


