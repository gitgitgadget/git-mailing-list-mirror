Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FBE21F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 07:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbeKQRVd (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 12:21:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63761 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbeKQRVc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 12:21:32 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D2A910CBBC;
        Sat, 17 Nov 2018 02:05:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nhiItL/9xKAv+UZJOtzeWX4k2gA=; b=IFUrk/
        /O/u6REAH+vc4qVoS+uJnFWlqVRt/zdRLTiSCy5y83c9qcok2qvWzfqziXdwm7sD
        QgRdOTv3WRgotO7rx9rfU1tE4EkHrvit8xvJ8AyLTxx5PnlrLDZyqFyREae/3VDS
        Pj7yZsFNUa1C/F/t6fm4clPPY2XckGQ6/YaSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XokAeTBqJkgKMxEmMwYGSM4+L5VSlFt4
        QHHEjGZ0f5kkEtXpZdwKv+cOwQnpfrWQpIfw4Yk8jVGamjEVzmZV71jJoLgpt6aY
        SjTqyIS9Im7Pjudh/bRak0LqOkTZ2qTbD05+CUJEo3SRnV90YG2jMp3Uh8tKIbK5
        +vG4f4jUNP8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 83F7410CBBB;
        Sat, 17 Nov 2018 02:05:46 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EBAE710CBBA;
        Sat, 17 Nov 2018 02:05:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        =?utf-8?Q?Ga=C3=ABl?= Lhez <gael.lhez@gmail.com>
Subject: Re: [PATCH] bundle: dup() output descriptor closer to point-of-use
References: <pull.79.v2.git.gitgitgadget@gmail.com>
        <c88887f05a145709be9e86d56f4c1e620eb5ea89.1542209112.git.gitgitgadget@gmail.com>
        <CAN0heSqsjKksKnBHjffVMDEyX4A2DAY6Naw4tbBXEm+AdhOLtA@mail.gmail.com>
        <CAGZ79kZ_wrQ=OdJ6xWbL+F5RDb38YAmzc87o8A=Zb8zBywMJBQ@mail.gmail.com>
        <20181115043409.GA3419@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1811151354150.41@tvgsbejvaqbjf.bet>
        <20181115133749.GA26164@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1811151725310.41@tvgsbejvaqbjf.bet>
        <20181115164300.GA29290@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1811152059060.41@tvgsbejvaqbjf.bet>
        <20181116094358.GA6054@sigill.intra.peff.net>
Date:   Sat, 17 Nov 2018 16:05:44 +0900
In-Reply-To: <20181116094358.GA6054@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 16 Nov 2018 04:43:59 -0500")
Message-ID: <xmqqk1lci3p3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3481EA4E-EA37-11E8-BF6F-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Actually, I realized there's an even simpler way to do this. Here it is.
>
> -- >8 --
> Subject: [PATCH] bundle: dup() output descriptor closer to point-of-use
>
> When writing a bundle to a file, the bundle code actually creates
> "your.bundle.lock" using our lockfile interface. We feed that output
> descriptor to a child git-pack-objects via run-command, which has the
> quirk that it closes the output descriptor in the parent.
>
> To avoid confusing the lockfile code (which still thinks the descriptor
> is valid), we dup() it, and operate on the duplicate.

Yes...

> We can solve this by moving the dup() much closer to start_command(),
> shrinking the window in which we have the second descriptor open. It's
> easy to place this in such a way that no die() is possible. We could
> still die due to a signal in the exact wrong moment, but we already
> tolerate races there (e.g., a signal could come before we manage to put
> the file on the cleanup list in the first place).
>
> As a bonus, this shields create_bundle() itself from the duplicate-fd
> trick, and we can simplify its error handling (note that the lock
> rollback now happens unconditionally, but that's OK; it's a noop if we
> didn't open the lock in the first place).

... I found this way too clever for me, but by following the
codeflow, it was easy to convince myself that this does the right
thing.  Almost magical ;-)

Will queue, with a Tested-by: with Dscho's name on it.

TAhanks, both.
