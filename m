Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7632F1F4C1
	for <e@80x24.org>; Mon, 28 Oct 2019 01:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfJ1Bj5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 21:39:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58761 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfJ1Bj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Oct 2019 21:39:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1414A1FCA1;
        Sun, 27 Oct 2019 21:39:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xp9R/A2NpEcRrrnhR5U8qCpBlcg=; b=nQKJ44
        nWUivqqGg68wgOH5Avp1JamYUZoIZZmzs5gNJv6wsaD0Ri8z0AWDAS3jqkawM4S/
        eobIizmSKPrbNu5uOa5LQwuIJUN9GL7ZP6CYvDhyOKKWmazjO1xfDLaAAgyeN+O2
        pINcVppic/dhLvnVHA1iNMz7zQey7zulZl8vM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IcMMh2TXon+3NZTmgTXeJk4FcUyXJjVT
        HFwMnGzDT8idu9CbOAdHO1U9ZSO5SN+zfZbWs50SKnkiWZV/8kjlyBXxXjyaD3y6
        4Qc+qQCpEhH3jzsjm1Duh8uqto2bdW/gOY0eEhVzpkj3/NVwoGzi196QV5vB5ZXB
        SXM6XW2MVlc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0AD581FCA0;
        Sun, 27 Oct 2019 21:39:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 69FD51FC9F;
        Sun, 27 Oct 2019 21:39:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v1 5/5] sequencer: directly call pick_commits() from complete_action()
References: <20190925201315.19722-1-alban.gruin@gmail.com>
        <20190925201315.19722-6-alban.gruin@gmail.com>
        <67c98856-55dc-df95-c4a6-61f1af85c480@web.de>
        <9b81e879-091b-bbf7-2d1b-51236d19ee9a@gmail.com>
Date:   Mon, 28 Oct 2019 10:39:53 +0900
In-Reply-To: <9b81e879-091b-bbf7-2d1b-51236d19ee9a@gmail.com> (Alban Gruin's
        message of "Sat, 26 Oct 2019 13:27:21 +0200")
Message-ID: <xmqqeeyxbqc6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D76683CC-F923-11E9-8438-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> Junio, how do you want me to fix that?  Should I reroll the series
> altogether, send a "fixup!" commit, or send a standalone patch?

Normally a topic that is not yet in 'next' or more stable tracks can
and should be rerolled (or in a rare case like changing just a
single typo on a line in the last patch in a series, can be
corrected with a "fixup!" squashed in); once the topic is in 'next'
or more stable integration branch, there needs a normal freestanding
patch that may say "earlier we did X, which is broken for such and
such reasons.  correct it this way."

But during a pre-release feature freeze period, the rules can be a
bit different ;-) Typically a topic that is not in 'master' that is
not a bugfix will never graduate from 'next' until the release
happens, and after the release, the tip of 'next' gets rebuilt from
the newly cut release, at which point a topic that wants a fresh
start (in order to avoid "oops, this was wrong, and here is a fix"
follow-up patch) can be granted one.

So I'd probably just send a "fixup!"to be queued on top of the
series to fix a leak in 'next' for now, remind the maintainer not to
merge it to 'master' before the release, and once the upcoming
release is made, send another reminder to the maintainer to squash
the "fixup!" in before rebuilding 'next', if I owned this series.

Thanks.
