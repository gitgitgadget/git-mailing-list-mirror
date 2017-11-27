Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA36C20A40
	for <e@80x24.org>; Mon, 27 Nov 2017 06:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751082AbdK0GEA (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 01:04:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58677 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750945AbdK0GD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 01:03:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E940BB2C1E;
        Mon, 27 Nov 2017 01:03:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+jB7mBwu4s8twGd+yXXBdknBWtE=; b=Ski7Gu
        Hie7P6QaYhiDnZ7d6av0ZFxVdZNK0t76H2TXf+31Z55l5infvNrkfE5aWRoeVKIR
        tA5hTKdfLpTotcWTVv3QsCxBV+Uq8nzCCv94TgrVQQW0o0xAEmApf8sna2eT2rOX
        PkYDQkWfDAwYAbWq9vh2h5rb4V+4NCLntLkGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VR3+svhsmph6ra4svMn6k9IN2lW1iYHS
        rEADA4dy1vXg3Mf7tpIgLxMlXlYxSwitvHeabcZdH0y+d2ISVBUIhlcZzFAiu2Wj
        DquyOyCUGbjMBITv8cKeKE7XOxfLW8PjlRBEq6bZNPhNAhd7NSVpEyWRoMK5pfMO
        e51w5NDzCh0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DFE45B2C1D;
        Mon, 27 Nov 2017 01:03:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 45F4EB2C1C;
        Mon, 27 Nov 2017 01:03:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org
Subject: Re: git status always modifies index?
References: <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org>
        <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
        <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
        <20171122202720.GD11671@aiede.mtv.corp.google.com>
        <20171122211729.GA2854@sigill>
        <20171122215635.GE11671@aiede.mtv.corp.google.com>
        <20171122220627.GE2854@sigill>
        <alpine.DEB.2.21.1.1711252240300.6482@virtualbox>
        <20171126192508.GB1501@sigill>
        <alpine.DEB.2.21.1.1711262231250.6482@virtualbox>
        <20171127052443.GB5946@sigill>
Date:   Mon, 27 Nov 2017 15:03:57 +0900
In-Reply-To: <20171127052443.GB5946@sigill> (Jeff King's message of "Mon, 27
        Nov 2017 00:24:44 -0500")
Message-ID: <xmqqmv38cl6a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1F3F3FC-D338-11E7-99F1-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Again, maybe the bit above explains my viewpoint a bit more. I'm
> certainly sympathetic to the pain of upstreaming.
>
> I do disagree with the "no good reason" for this particular patch.
>
> Certainly you should feel free to present your hunches. I'd expect you
> to as part of the review (I'm pretty sure I even solicited your opinion
> when I sent the original patch). But I also think it's important for
> patches sent upstream to get thorough review (both for code and design).
> The patches having been in another fork (and thus presumably being
> stable) is one point in their favor, but I don't think it should trumps
> all other discussion.

I haven't been following this subthread closely, but I agree.  I
think your turning a narrow option that was only about status into
something that can be extended as a more general option resulted in
a better design overall.

I am guessing that a little voice in his head said "this may be
applicable wider than Windows and it will be better to be humble and
receptive to others' suggestions by going to the list and get this
patch reviewed" was overridden by other needs, like expediency, when
he did the initial "covers only status and its opportunistic writing
of the index" as a Windows only thing, and Dscho is now regretting
not following that initial hunch, as that resulted in unnecessary
pain for both himself and his users.  I am sympathetic, but we are
all normal human and I do not think and mistakes like this can be
avoided.  Often we are blinded by the immediate issue in front of us
and we lose sight of a bigger picture, and it is OK as long as we
learn from our (or better yet, others') mistakes.

Thanks.
