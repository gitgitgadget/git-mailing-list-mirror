Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 698EF1F609
	for <e@80x24.org>; Thu,  6 Jun 2019 16:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfFFQNH (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 12:13:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65342 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbfFFQNH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 12:13:07 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA91316A047;
        Thu,  6 Jun 2019 12:13:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jczQy0TCA2Ri9PrePkyqDCSB6Ws=; b=Rvru32
        lOwCUBHrslRzvteAU9oLb761msj2OjfpKLKgHnx10LlQzCSIzP4egqpS2THDGGSV
        yCK7qo+LpdVH+qC9fjh8UataJKUq4hy5/44Z+EjzMdSoVLHsd2TVsrpH96cAEOZS
        iOWHZp+aLk6ECWEAdYNvvZlNUVRBkiAW3CSLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j6n0RL1rNdiOhy+EXgxo2I0SPsmyVnz5
        PilOLlk7WU7NZRsESQWcuHI6WwfTvWiN+NUmFFLmb8rJCO8Hg2sBjcIlJayxIPA3
        VYpxoKSXGNQVqUcoM+NaiLoWaetbqY7PWqRCVkyjWKW1PbDM5Y7J/LLNp9wNrzzO
        2KADb9WyrYw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1D5A16A046;
        Thu,  6 Jun 2019 12:13:04 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5350516A045;
        Thu,  6 Jun 2019 12:13:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC/PATCH 0/5] Fix fetch regression with transport helpers
References: <20190604021330.16130-1-felipe.contreras@gmail.com>
        <nycvar.QRO.7.76.6.1906051005060.1775@tvgsbejvaqbjf.bet>
        <20190605112713.GA14027@sigill.intra.peff.net>
        <CACsJy8DKWoerME5BykVmihyX2eX10YTO0BNyVc7MGjwp_Shg2Q@mail.gmail.com>
        <nycvar.QRO.7.76.6.1906061505310.42@tvgsbejvaqbjf.bet>
Date:   Thu, 06 Jun 2019 09:13:03 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1906061505310.42@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 6 Jun 2019 15:07:02 +0200 (CEST)")
Message-ID: <xmqqr286r8ts.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6BB95A6-8875-11E9-8CBE-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I vaguely recall seeing just one 'x' once. I think last time I had a
>> problem with truncating st_ino, but that should be fixed in e66ceca94b
>> (clone: fix colliding file detection on APFS, 2018-11-20). So no idea
>> how this happens again.
>
> Good catch. I think the reason it happens again is simply that Junio
> picked a base commit that is older than the commit you referenced.

Yeah, that is because the patch specifically targetted a single
commit as culprit, so naturally the topic that introduced that
commit was the place to be "fixed" ;-)

I was wondering if the base commit _before_ the fixes, i.e. e198b3a7
("fetch: replace string-list used as a look-up table with a
hashmap", 2018-09-25), failed the same test you saw problems with.
It does predate e66ceca9 ("clone: fix colliding file detection on
APFS", 2018-11-20), so my current theory is that it was broken
already adn these patches that fixed a breakge had nothing to do
with the t5601 tests failing.

