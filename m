Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFE1C433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 22:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FDBB61351
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 22:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348745AbhKOWQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 17:16:18 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63372 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352916AbhKOWNr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 17:13:47 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8334A1589DC;
        Mon, 15 Nov 2021 17:10:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BhjGqQFTuSn6S4cqUm5aWiXNSDp261uCczyEP0
        zCg7k=; b=X+SxtyVdqCRTHmlIlR7DCnwkwB/jaI8puksb6b9ZlrRh7uYO+bgkWr
        vjs71pgxUbN/tM1g25LcTeiISc7ymXHQkAwUxX55o5MrDMdXd83hjm+4qyX5NUVO
        ERQpVRPbds7gPr/1x/n5/hcZyV7Z1otmLkEc4jimgoVyEzuJKfk5I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7B6081589DB;
        Mon, 15 Nov 2021 17:10:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C4CF61589DA;
        Mon, 15 Nov 2021 17:10:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] test-lib: show missing prereq summary
References: <20211115160750.1208940-1-fs@gigacodes.de>
        <20211115160750.1208940-2-fs@gigacodes.de>
        <211115.865ysts45o.gmgdl@evledraar.gmail.com>
        <xmqq8rxpfgqh.fsf@gitster.g> <20211115195609.g6vq6qfjhyootcqt@fs>
Date:   Mon, 15 Nov 2021 14:10:43 -0800
In-Reply-To: <20211115195609.g6vq6qfjhyootcqt@fs> (Fabian Stelzer's message of
        "Mon, 15 Nov 2021 20:56:09 +0100")
Message-ID: <xmqqk0h9cboc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E10DFB80-4660-11EC-85FC-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

>>I am not sure '\n' is a good idea from portability perspective.  I
>>thought I wrote '\012' in the illustration in my review?
>
> Yes, i was wondering why you did that. When i played around with your
> variant i used \n since it's what i commonly use and find more readable.
> And i'm by far no expert on partability. What platforms would have an
> issue with \n ?

I think I misremembered.  b3b753b1 (Fit to Plan 9's ANSI/POSIX
compatibility layer, 2020-09-10) does talk about a system whose
"tr" does not fully emulate POSIX and wants an octal, but that
is not a platform we target for to begin with.

$ git grep '^[      ]*tr .*\\012['\''"]'
$ git grep '^[      ]*tr .*\\n['\''"]'

show the same number of hits, even back in v2.0.0.  You have to go
back to v1.6.0 (which I consider is the oldest and still usable
release of significance) to see the source tree without any hit for
the latter.  The first introduction of tr "\n" (which I consider is
a mistake---if we write octal, we do not have to worry about anybody
not supporting it) seems to be dea4562b (rerere forget path: forget
recorded resolution, 2009-12-25) made by me X-<.

