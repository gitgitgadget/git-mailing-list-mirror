Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5283420365
	for <e@80x24.org>; Tue,  3 Oct 2017 08:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751146AbdJCIes (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 04:34:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58669 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751059AbdJCIes (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 04:34:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 049B9AA81E;
        Tue,  3 Oct 2017 04:34:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5rdJBVEQouLWtdheCsO5f9uYQIM=; b=T103dS
        DIN3GP0CEPd5YePsikfIplZ21ELWZMToD6fo7METHZvEVeCc3Y63Sd4/dn+o/7oh
        V1e90sHUzHZHsA1ruwQf4Anp6Omzqr0EkyuZlGbaKS+CfvKU+cNd2i9lgXtsc1LL
        yK9e0w93YLqRvEXdF1qDNisdT7GU7kSlfF1Nk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kp2BQMb3mndauJyjyVd9p029XkwX9aip
        KKMcYWp1+IZKVPE/ZTs90E9KcSQ8T9jo9cTMRcaIr3ruspueOLuaWPDZXM0l/y9d
        7bGA/zswh7AjPpadwBCpaJVoEMdyaDfsM//mSPW777rsHDqh5SjivV1bn0+tYoBv
        xwEJVWYzLVM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0D84AA81D;
        Tue,  3 Oct 2017 04:34:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 63696AA81C;
        Tue,  3 Oct 2017 04:34:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
        <20171002230017.GT19555@aiede.mtv.corp.google.com>
        <xmqqpoa5kp0c.fsf@gitster.mtv.corp.google.com>
        <xmqqinfxklw7.fsf@gitster.mtv.corp.google.com>
        <20171003061515.72l35fpvcf63vsf6@sigill.intra.peff.net>
        <xmqqinfwiu5n.fsf@gitster.mtv.corp.google.com>
        <20171003071622.el6zqibfyrjc2mra@sigill.intra.peff.net>
Date:   Tue, 03 Oct 2017 17:34:40 +0900
In-Reply-To: <20171003071622.el6zqibfyrjc2mra@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 3 Oct 2017 03:16:22 -0400")
Message-ID: <xmqqefqkiq8v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B35058AC-A815-11E7-B931-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I agree it's not quite the same thing, and I agree the problem was made
> much worse by 4c7f1819b.  But I still think color.ui=always is
> inherently a foot-gun, and in either case it is the user that sets it
> that is harmed (and they are the ones who have the power to fix it).

Yeah, but it is inherently a foot-gun only for those who write
scripts around porcelain commands, which are expected to honor
color.ui=always.  If you write a script using the plumbing commands
because you did not want to get broken by color.ui=always, and then
your script gets broken because plumbing commands you relied on
suddenly start paying attention to color.ui---is that the user's
fault who used color.ui?  

The end-users have the power to work the breakage around by not
using "always".  The script writers have the power to work the
breakage around with "--no-color".  But these are workarounds that
shouldn't have been needed in the first place, no?
