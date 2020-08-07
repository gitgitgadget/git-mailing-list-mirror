Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91377C433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F0992177B
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qPrqhxen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgHGVFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:05:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63478 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGVFT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 17:05:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6599E6C1C3;
        Fri,  7 Aug 2020 17:05:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bS+ZwkOYmXrh
        Axum/JAN4v//IgQ=; b=qPrqhxen3CC3+/KQnAmoR/GaqgXWm//PPVARpB13Terh
        rlbMoBOc3RH9PUv8cu11BgVPUsB9K5fALko6twQ3RcubwpDzWV5y/yUCnENPvrsu
        38WT1XFNnoujGqhAH8l6Gka/w+WAXjVNrvJONbTZU2RuWk7YJrjNXoGfZU1dfUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pC3o04
        clT89rs4BUu9r8V4kUjTh2AvUfudvMEg7g39KrRgPRfg+LoC6EYjdysrybmVX6pD
        YvbxCfGIlAmqBB4NWxhzVXsDmLW+5cWTSQdRkyLEbumXYAl4sYnX2PIuLDis85q2
        swxCahgfThjRKp2lU4AAW/A+tTYEMCdalAuj0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D2A86C1C2;
        Fri,  7 Aug 2020 17:05:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D4AA16C1C1;
        Fri,  7 Aug 2020 17:05:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Aaron Lipman <alipman88@gmail.com>, git <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v4 0/5] Introduce --first-parent flag for git bisect
References: <20200801175840.1877-1-alipman88@gmail.com>
        <20200804220113.5909-1-alipman88@gmail.com>
        <CAP8UFD1Z1V6+iPO2CMOqdHhUGkmTdvCK+TDNtoOcX8QvC4coNQ@mail.gmail.com>
Date:   Fri, 07 Aug 2020 14:05:16 -0700
In-Reply-To: <CAP8UFD1Z1V6+iPO2CMOqdHhUGkmTdvCK+TDNtoOcX8QvC4coNQ@mail.gmail.com>
        (Christian Couder's message of "Wed, 5 Aug 2020 07:55:53 +0200")
Message-ID: <xmqqmu36f9pv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B1BCEEA0-D8F1-11EA-A0A4-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Wed, Aug 5, 2020 at 12:04 AM Aaron Lipman <alipman88@gmail.com> wrot=
e:
>>
>> OK, here's take 4! Responding to Junio's feedback, first:
>
> [...]
>
>> Martin, thanks for your suggestions
>
> [...]
>
> It's better to have the people you are replying to as recipients of
> your emails (in the "To:" field). I have added them into "Cc:".
>
>> > (Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>, FWIW.)
>>
>> I'm still getting used to the conventions - should I add your name as
>> a signed-off-by tag, a thanks-to tag, or both?
>
> We often use the following trailers:
>
> - "Helped-by:" when someone helped you
> - "Suggested-by:" when someone suggested the main idea in the patch
> - "Reported-by:" when someone reported an issue fixed by the patch
> - "Acked-by:" when someone explicitly acked the patch
> - "Reviewed-by:" when someone explicitly gave their "Reviewed-by:"
>
> If your patch is based on a patch from someone else, you can also keep
> the "Signed-off-by:" and other trailers that the person already put in
> the commit message. If you haven't made a lot of changes to a patch
> initially from someone else you can also keep them as the author.

OK.  It appears that the patches themselves do not have fundamental
issues, perhaps other than test style updates for [2/5]?

Aaron, Eric, can we have the hopefully final update to close this
topic, if that is the case?

Thanks.
