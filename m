Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDFAC4741F
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 22:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E49320719
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 22:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L2zwnRTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbgI3WZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 18:25:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58817 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731085AbgI3WZN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 18:25:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BCF891E85;
        Wed, 30 Sep 2020 18:25:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S68wnbD+YML5o0IUY6AM/77bdJQ=; b=L2zwnR
        Tz9GL3AD/yptrGtZfAowej8Ris/oHCcib8+PiOeHF6lT4HmEb8HofTDVrYZ5U9x4
        vaSPK2+g4RVpAM4o4lKpbyoVVYH9JV0XtMJD8vuB7BD/nY2KS59izfqD6qwFMShv
        LTj3daO/cbQ3TNWQ0hSUBcGqPJ25/S64twJAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c9OSv7bZXQZn/+IVXn6DejJk0IF4knjP
        MJyKMJcYRw5mFkROMPX6TLTQZstcZZVkVn31o1FHfZK69QiwifUd0oYFiybLRjMf
        xe4EcxnyH/a1lgmLQ2tDgt8fy2LswA8d4BbS9nVipSn6XaydG14XM9JbCaa/l87o
        3LRxyEEHQtA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02C5991E83;
        Wed, 30 Sep 2020 18:25:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 732DA91E82;
        Wed, 30 Sep 2020 18:25:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Nikita Leonov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nikita Leonov <nykyta.leonov@gmail.com>
Subject: Re: [PATCH v2 2/3] credentials: make line reading Windows compatible
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
        <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>
        <f69076036fe4dfe8b57fc1d4329c7be3f7346850.1601293224.git.gitgitgadget@gmail.com>
        <CAPUEspgW9CFO3WtbiuTUsmXp05fPqr2Cs81piDJFJ0g3KcTy3A@mail.gmail.com>
        <20200929003000.GA898702@coredump.intra.peff.net>
        <xmqqwo0difdh.fsf@gitster.c.googlers.com>
        <20200929004448.GD898702@coredump.intra.peff.net>
        <xmqqsgb1ier6.fsf@gitster.c.googlers.com>
        <20200929030043.GA905754@coredump.intra.peff.net>
Date:   Wed, 30 Sep 2020 15:25:09 -0700
In-Reply-To: <20200929030043.GA905754@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 28 Sep 2020 23:00:43 -0400")
Message-ID: <xmqqeemigawq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD414974-036B-11EB-8F6D-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Sep 28, 2020 at 05:54:37PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Yeah, that is probably what would happen. I have to admit that it's such
>> > an obscure case that I'm not sure I really care. It's unlikely in
>> > practice, and if somebody did report such a case, I think my first
>> > response would be "well, why did you have a broken entry stuck in your
>> > file?".
>> 
>> I think we know the likely answer.  "I once used Windows to edit the
>> file manually".
>> 
>> After which the file looks broken, so the user may have re-added via
>> the credential API (with LF line ending) a new entry for the host
>> and have been happily using the result.
>
> I wrote something less charitable towards the user at first, and then
> toned it down. But I think I toned it down too much. Maybe my response
> would be "garbage in, garbage out; it was lucky that it worked before".

OK, so what's the final verdict from us?  This is good enough to
move forward as-is?

