Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAB7620A40
	for <e@80x24.org>; Mon, 27 Nov 2017 04:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbdK0E4o (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 23:56:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51106 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751126AbdK0E4o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 23:56:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6588FB1D3F;
        Sun, 26 Nov 2017 23:56:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aQevqAyxBDOqgq/mbG3nkcze5V0=; b=wuyD6k
        ssBhiqifzdxzthPsLpuCrTlqGzumC6p8G+hXVVNxKhlWTv3fzlhDsx1vu7hkYjyG
        N7BijzMuGK4aLhvhEComBuk9pKhHKF2SMaH+V09FH2rjxxoeTwpbFTQ1VeD7qLlw
        PQ4etByw6rYaIWldKU9KZ3cBcCAgKPMQ2wYMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=flWtLQPpLsiUofxf4L12jGykgEqMSPPp
        1PEkZxb2lX3+W9j5wNyD7l8V3uLXeNrCsr1+W/9YX2PYm7C3zZpUEinGTIj4r+gx
        dxIWuZlbk8KOLJjuLoSr0YjEq51FMjICCjZ0Vp5IyVymoVDeeoMYMUA8yeyNXl4l
        576825k3oN0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C801B1D3E;
        Sun, 26 Nov 2017 23:56:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CBB4FB1D3D;
        Sun, 26 Nov 2017 23:56:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git status always modifies index?
References: <20171122153028.olssotkcf3dd6ron@LykOS.localdomain>
        <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org>
        <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
        <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
        <20171122202720.GD11671@aiede.mtv.corp.google.com>
        <20171122211729.GA2854@sigill>
        <20171122215635.GE11671@aiede.mtv.corp.google.com>
        <20171122220627.GE2854@sigill>
        <xmqqwp2diuki.fsf@gitster.mtv.corp.google.com>
        <xmqq7eudidqb.fsf@gitster.mtv.corp.google.com>
        <20171127044314.GA6236@sigill>
Date:   Mon, 27 Nov 2017 13:56:41 +0900
In-Reply-To: <20171127044314.GA6236@sigill> (Jeff King's message of "Sun, 26
        Nov 2017 23:43:14 -0500")
Message-ID: <xmqqd144e2uu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C987AEA-D32F-11E7-82E9-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I actually consider "--no-optional-locks" to be such an aspirational
> feature. I didn't go digging for other cases (though I'm fairly certain
> that "diff" has one), but hoped to leave it for further bug reports ("I
> used the option, ran command X, and saw lock contention").

OK, then we are essentially on the same page.  I just was hoping
that we can restrain ourselves from adding these "non essential"
knobs at too fine granularity, ending up forcing end users to use
all of them.
