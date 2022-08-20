Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FA6C3F6B0
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 21:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiHTVUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 17:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiHTVUd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 17:20:33 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A65C40BC9
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 14:20:32 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F325E14551F;
        Sat, 20 Aug 2022 17:20:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Sr79VkLnMPqvFyACPtnJ70JI3TUFAILu245nMb
        XdzLo=; b=kf7cunC85XbOid9aJj+RDr3keymzARt9XRhVGshw5w9HD8abjeE5Y3
        3s/zQYnCXK2OADtwJtaq/c9r79afC8VHU7T0AuwKoYC4MFpgUoUJ2TvrpjuNZE1m
        8tDpH9SiuOU+vXq12Fly2m/Ic4Q3QqG11JcE3T79ybMzJv4XABtnM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA56B14551E;
        Sat, 20 Aug 2022 17:20:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 59EC814551D;
        Sat, 20 Aug 2022 17:20:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/4] sequencer: do not translate reflog messages
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr>
        <cover.1660828108.git.git@grubix.eu>
        <ea6c65c254bb08b20ea6c4d81200b847755b555c.1660828108.git.git@grubix.eu>
        <220818.86zgg18umf.gmgdl@evledraar.gmail.com>
        <6oqr69o7-qsps-sr86-o4r9-16r7no9n5424@tzk.qr>
        <220819.86o7wg6zci.gmgdl@evledraar.gmail.com>
        <xmqq8rnkklon.fsf@gitster.g>
        <220819.864jy853qc.gmgdl@evledraar.gmail.com>
        <YwChr17RntWnoNok@coredump.intra.peff.net>
Date:   Sat, 20 Aug 2022 14:20:27 -0700
In-Reply-To: <YwChr17RntWnoNok@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 20 Aug 2022 04:56:15 -0400")
Message-ID: <xmqq5yimipd0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9F4B16A-20CD-11ED-AE3F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm not sure if you mean "where are we parsing this sequencer message
> specifically", or if you're just asking where we parse reflog messages
> at all. If the latter, try interpret_nth_prior_checkout() and its helper
> grab_nth_branch_switch().
>
> As far as I know, that's the only one we parse, so the answer for
> _these_ messages is: nowhere.

Unless translation in some language of these messages looks similar
to what 'nth-prior' wants to find.  So the answer really is "asking
if somebody parses _these_ messages is pointless" ;-)

I outlined one possible approach to allow translat{able,ed} reflog
messages without breaking 'nth-prior' and would allow us add more
code to mechanically parse them if we wanted to elsewhere in the
thread, by the way.  I do not plan to work on it soon, but without
doing something like that first, letting translated messages
randomly into reflog is asking for trouble, I am afraid.
