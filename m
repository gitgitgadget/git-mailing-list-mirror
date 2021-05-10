Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5188C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 01:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A3E6112F
	for <git@archiver.kernel.org>; Mon, 10 May 2021 01:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhEJBQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 21:16:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61235 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhEJBQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 21:16:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3759512D252;
        Sun,  9 May 2021 21:15:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bicYiBYRKH/zabaJmUb3445AGaHkjc9COPgqn9
        ndReU=; b=H0nA76D4srlRZjo4EZyUIGD6HjdjOe455fm9+ABZMliMVFzfUZjBHE
        cWRt/KylprcnOLZEjq9Q7LE4ZAidQvAC33KtJkBhmqy0qOZ44FAKtAzph6lQnJBK
        ETHOL6iyUBSzXXds3vGoIy8iTT98XzJVN2FMLBmmzvSc0fGjAhXco=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 318AE12D24F;
        Sun,  9 May 2021 21:15:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6028412D24D;
        Sun,  9 May 2021 21:15:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Will Chandler <wfc@wfchandler.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH] refs: cleanup directories when deleting packed ref
References: <YJVQpaDwkQH/aCee@mini.wfchandler.org>
        <YJW3n6lVWVAuLQap@coredump.intra.peff.net>
        <YJW46fsdKaUv2Fln@coredump.intra.peff.net>
        <YJXF4xA0GFx2/2v4@coredump.intra.peff.net>
        <YJYTQYk5q8g6HaIm@mini.wfchandler.org>
        <YJYa+7yUyt2YD16r@mini.wfchandler.org>
        <1bb65e54-a18d-852d-bb01-130cc57cce1b@gmail.com>
        <xmqqmtt5vj2x.fsf@gitster.g> <YJgt2UzAdhFfrDHm@mini.wfchandler.org>
Date:   Mon, 10 May 2021 10:15:49 +0900
In-Reply-To: <YJgt2UzAdhFfrDHm@mini.wfchandler.org> (Will Chandler's message
        of "Sun, 9 May 2021 14:45:45 -0400")
Message-ID: <xmqqzgx3s81m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 429BDBD4-B12D-11EB-8C60-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Will Chandler <wfc@wfchandler.org> writes:

> Thank you, Junio. Would it be helpful if I sent a separate '[PATCH v2]'
> email?
>
> Apologies for not following the correct procedure for the revised patch.
> I was relying on 'SubmittingPatches', but I've since found the detailed
> instructions on submitting revisions in 'MyFirstContribution.txt'.

I am not sure if there is anything to apologize for on your part.
The procedures we use have grown over time, and there certainly
would be documentation gaps.

I think the best current practice is

1. In a thread that originates at a non-patch message, or in a
   review discussion thread for a patch, it is welcome to use "How
   about doing it this way?" patches as an illustration to explain
   your idea in a more concrete way than just in prose.  But it is
   unwelcome to leave the patch buried in the discussion, without
   making it easier to find it (see 3.)

2. In such a thread, "By the way, I thought of this unrelated
   tangent, and here is a patch to demonstrate the idea" is not
   entirely unwelcome, but keep it brief and make sure you get out
   of the thread quickly to avoid distracting the main discussion.

3. In either case, it makes it easier to find the final submission
   of the patch if it is not buried deep in the discussion.

   a. It is OK to start a new thread (without in-reply-to), with
      "here is a polished version of the patch and/or the idea I
      floated in <message-id>" under the three-dash line (for a
      single patch) or in the cover letter (for a series).

   b. An updated iteration of a multi-patch series sometimes is made
      as a direct response to the cover letter of the previous
      iteration (iow, the cover letter for vN+1 has the message id
      of the cover letter for vN on its in-reply-to header).

I think the "b4" tool prefers 3b. over 3a., and it may be also easy
on human readers who read the list in threaded mail/news reader.

Thanks.
