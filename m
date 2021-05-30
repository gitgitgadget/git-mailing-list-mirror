Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A984C47091
	for <git@archiver.kernel.org>; Sun, 30 May 2021 22:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F12CF60BBB
	for <git@archiver.kernel.org>; Sun, 30 May 2021 22:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhE3WZA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 18:25:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53798 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhE3WY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 18:24:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F248A13539B;
        Sun, 30 May 2021 18:23:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TGpI7dqXTg7L5FUYFdznBQIQvWoUDdz5ANN4CM
        SWcsY=; b=jHckaMpxLXP6k/POe0UP+ocIHiQMxSKD4SPJHh5bjpvpQCdoZbx73H
        XfJ4CCPX2iea2LPL+8XAp/4DF9rVt03ZVH3RRkfTQJlZILyZcJGB2cerF/T7Ksyz
        UVHcPv+QFo2odzkAeGe5wythZv1JqGOaBcHo8Y6nEFdVc9qbeB1h0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EAE8513539A;
        Sun, 30 May 2021 18:23:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 40256135396;
        Sun, 30 May 2021 18:23:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Yuri <yuri@rawbw.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG REPORT] File names that contain UTF8 characters are
 unnecessarily escaped in 'git status .' messages
References: <f7e2e271-dcec-2886-f33e-62778a429850@rawbw.com>
        <xmqq35u9ax5j.fsf@gitster.g>
        <6318ccec-ec96-91a8-fd65-85daf4a9a22b@rawbw.com>
        <20210527045628.uvesihyhtqrfyfae@tb-raspi4>
        <YK+mWZP+sl3zXECx@coredump.intra.peff.net>
        <4dd22f16-72f0-a28a-8be0-aec622acf0d3@rawbw.com>
        <50e2780a-21f3-499f-7960-76bf24f550f0@gmail.com>
        <6fef4b1e-1ec7-b697-c311-59caf6408b29@rawbw.com>
        <20210529092752.kifzqt3haddzgsob@tb-raspi4>
        <YLQHPu0bIy4qHEWP@coredump.intra.peff.net>
Date:   Mon, 31 May 2021 07:23:16 +0900
In-Reply-To: <YLQHPu0bIy4qHEWP@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 30 May 2021 17:44:30 -0400")
Message-ID: <xmqqmtsb2757.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A256536A-C195-11EB-B1F6-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yes. If we're going to do anything, I think it would be to say "most
> terminals and programs deal with high-bit characters OK these days, so
> switching the default is more likely to fix things than break them".

Amen to that.  The conservative setting was from v1.5.3 days in
2007, and it would be highly disappointing if the situation hasn't
changed in the 14 years.
