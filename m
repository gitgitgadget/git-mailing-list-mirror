Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C46320A40
	for <e@80x24.org>; Sun,  3 Dec 2017 01:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbdLCBSx (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 20:18:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65503 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752261AbdLCBSw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 20:18:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1198BB8BBA;
        Sat,  2 Dec 2017 20:18:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7gWGK+Pp8T+mMGd5oDLAzH1Ru5A=; b=hh1uQp
        0f635i6lfXdH8f18sdGm0YdaVcOx7++cRIf4aszIsjrl2oCUSapovuxQvXWevH9N
        6TEJNSyF3ak84MeCSLO1zK18OfNpM0XT8SnnZRbpzE3x49ZDxLgj+uMgZ2FzYGrB
        TlJfipPr1teM7qm58RLK84ux/64B/HmGEHd/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j1KdjkWPfThUULn8TKBeO/uK+0bC6aSt
        KO9izVfyl3+z82GM/XyzaY1qtXnEgzAlG8ax3NDtMAbKmjVCysZUA84KrPFrgZ54
        /zdFtLk+FkfrwInuFj8xo7iyNNfcYmLwFqFAseDLvrpzGuOxgDAtGvudjHk4/7jj
        b94KSmEPsE0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A133B8BB8;
        Sat,  2 Dec 2017 20:18:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 48763B8BB7;
        Sat,  2 Dec 2017 20:18:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     liam Beguin <liambeguin@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH 4/5] rebase -i: learn to abbreviate command names
References: <20171127045514.25647-1-liambeguin@gmail.com>
        <20171127045514.25647-5-liambeguin@gmail.com>
        <alpine.DEB.2.21.1.1711272344290.6482@virtualbox>
        <b4331bb3-db5d-e4f5-54db-f04d77385ae7@gmail.com>
        <alpine.DEB.2.21.1.1711292236010.6482@virtualbox>
Date:   Sat, 02 Dec 2017 17:18:50 -0800
In-Reply-To: <alpine.DEB.2.21.1.1711292236010.6482@virtualbox> (Johannes
        Schindelin's message of "Wed, 29 Nov 2017 22:40:52 +0100 (CET)")
Message-ID: <xmqqk1y4libp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EBD43B94-D7C7-11E7-A3C4-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I am a fan of not relying too heavily on compiler optimization and e.g.
> extract code from loops when it does not need to be evaluated every single
> iteration. In this case:
>
> 	const char *pick = abbreviate_commands ? "p" : "pick";
> 	...
> 		strbuf_addf(&buf, "%s %s ", pick,
> 			    oid_to_hex(&commit->object.oid));

I would have called that variable "pick_cmd", not just "pick"; this
preference is minor enough that I would probably reject a patch to
rename from one to the other if the above were already part of the
existing codebase.

I find that the code suggested above easier to follow, simply
because it expresses clearly the flow of thought and that flow of
thought matches how I personally think: we decide how this command
is spelled in the output upfront, and then use that same spelling
consistently throughout the loop.

I do not think it matters performance-wise either way, but I value
how easy it is to follow the code for humans, and it matters much
more in the longer run.  If a compiler does a poor job, we can
eventually notice and help it to produce better code that still does
what we wanted it to do (or it may not be performance critical and
we may not even notice).  If a code is hard to follow, on the other
hand, what we wanted it to do in the first place becomes harder to
figure out.
