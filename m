Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD28C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 05:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C63161450
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 05:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhD2FOJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 01:14:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50834 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhD2FNL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 01:13:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E381D131793;
        Thu, 29 Apr 2021 01:12:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Z5iW3b6tgBu5
        J9+PHjkIRktWOKPUC/WkTA1BTD/hoH8=; b=U+dfns2kKF+4Xdd0PI6PYghbRBeQ
        cCYdnR69y0aq9CnaHZH0wB4ZsX/f9S3lIH+41mF+P2jVNnMUcpJQn+U43CIXWpjP
        sYsOPSIylqE1oSXBo0UbGPtSNh4yL4AZrdXnrcSdIlY5lbrd+fPrU/22Q7qCVF1R
        75lMn5LumFQ07h0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CDC3B131792;
        Thu, 29 Apr 2021 01:12:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0916E131791;
        Thu, 29 Apr 2021 01:12:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: Nesting topics within other threads
References: <87k0omzv3h.fsf@evledraar.gmail.com>
        <patch-1.1-e1d8c842c70-20210428T161817Z-avarab@gmail.com>
        <1ecb3727-106f-3d04-976a-36aa03a61caf@gmail.com>
Date:   Thu, 29 Apr 2021 14:12:20 +0900
In-Reply-To: <1ecb3727-106f-3d04-976a-36aa03a61caf@gmail.com> (Derrick
        Stolee's message of "Wed, 28 Apr 2021 15:09:28 -0400")
Message-ID: <xmqqsg397jyj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7AF134D4-A8A9-11EB-B70B-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 4/28/2021 12:26 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Simplify the setup code in repo-settings.c in various ways, making the
>> code shorter, easier to read, and requiring fewer hacks to do the same
>> thing as it did before:
>
> This patch is interesting, and I'll review it when I have some more
> time. Probably tomorrow.
>
> But I thought that I would point out that this pattern of adding a
> patch within the thread of a larger series makes it very difficult
> to separate the two. I use an email client that groups messages by
> thread in order to help parse meaningful discussion from the list
> which otherwise looks like a fire hose of noise. Now, this patch is
> linked to the FS Monitor thread and feedback to either will trigger
> the thread as having unread messages.
>
> I find it very difficult to track multiple patch series that are
> being juggled in the same thread. It is mentally taxing enough that
> I have avoided reviewing code presented this way to save myself the
> effort of tracking which patches go with what topic in what order.

I do find it distracting to have a full "ah, I just thought of
something while discussing this unrelated series" patch fairly
irritating for the same reason.  It however is unavoidable human
nature that we come up with ideas while thinking about something not
necessarily related.  So it largely is a presentation issue.

I really appreciate the way some people (Peff is a stellar example,
but there are others who are as good at this) handle these tangents,
where the message sent to an existing thread is limited to only give
an outline of the idea (possibly with "something like this?" patch
for illustration) and then they quickly get out of the way of the
discussion by starting a separate thread, while back-referencing "So
here is a proper patch based on the idea I interjected in the
discussion of that other topic."  And the discussion on the tangent
will be done on its own thread.


