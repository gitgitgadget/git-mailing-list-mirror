Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 105CB20899
	for <e@80x24.org>; Sun, 20 Aug 2017 15:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbdHTPv7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 11:51:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53142 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753064AbdHTPv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 11:51:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB12499084;
        Sun, 20 Aug 2017 11:51:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n417mh2w0EfG1EPYVSOkxSCt2L8=; b=OuyLvo
        JjivFNTrlHmjxQBUyO6+6iLmdFas3Bq1ckdFV4XfDmQKwuQYoIg3w6h0OrxbdvIh
        pMoK8J8RwJd4LUU86P5oyPNt40JEJN/S+jLb5gXp7KBH2yrXWQvfHvRPait+5LGZ
        OSZOGMYu1D8L8a0sl3jOx+TtuALFtb6ki9Hi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n/uhjFSKn0UPLr9GK40IPv04BtHif/HO
        EzYYZ7g6gKxpxglzEGdQUpe7z3+eoDQ2busw1Ht1SgD8SQXuoNvXfaGufdHao/+p
        G0A14lB6spTfwax+Gg04dg3KqoF1Cb28Ns+8p64H1rhX60rI9fSPaBHQLLv8B8nl
        CDL+US8+KTQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2BE099083;
        Sun, 20 Aug 2017 11:51:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 24EC499082;
        Sun, 20 Aug 2017 11:51:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kevin Daudt <me@ikke.info>,
        "Carlsson\, Magnus" <Magnus.Carlsson@arris.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git fetch with refspec does not include tags?
References: <1502960406180.9006@arris.com> <1502960572292.1402@arris.com>
        <20170817092853.hteuzni5lxia4ejf@sigill.intra.peff.net>
        <xmqq1soagf1p.fsf@gitster.mtv.corp.google.com>
        <20170817202257.GC3839@alpha.vpn.ikke.info>
        <xmqqk222expv.fsf@gitster.mtv.corp.google.com>
        <20170817204312.GD3839@alpha.vpn.ikke.info>
        <20170820074728.4dawjlnaufjdf4j5@sigill.intra.peff.net>
        <20170820075001.gmsxeh3fh4f2topg@sigill.intra.peff.net>
Date:   Sun, 20 Aug 2017 08:51:51 -0700
In-Reply-To: <20170820075001.gmsxeh3fh4f2topg@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 20 Aug 2017 03:50:02 -0400")
Message-ID: <xmqq8tie8cfc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7BE10948-85BF-11E7-944F-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Aug 20, 2017 at 03:47:28AM -0400, Jeff King wrote:
>
>> Yeah, I don't think we want to go back to the original behavior. I agree
>> that it is partially to blame for the inconsistency that started this
>> thread, but I think on balance it has saved much more confusion than it
>> has started. And we can address that inconsistency with better tag rules
>> (like the "autofollow if we wrote any real refs" thing).
>> 
>> I don't have a patch for that yet, so if anybody feels like taking a
>> look, it would be much appreciated.
>
> Also: I don't think we've seen a patch yet for documenting the current
> auto-follow behavior.  Even if we don't make a behavior change, let's
> not forget to improve that, which should be much less work. :)

Thanks for two thoughtful follow-ups.
