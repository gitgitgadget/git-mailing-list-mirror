Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAB6C433E0
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 20:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B427E214D8
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 20:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbhAMUMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 15:12:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63656 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbhAMUML (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 15:12:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4755AA665C;
        Wed, 13 Jan 2021 15:11:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4HV+qgmmxBSzpwro+CqKwlP1TYc=; b=RbQM61
        +F4VmfjKAETKwk3b9D1H4Lu+gBx+XyoHgUI9AUAGVPhssl1tHZAipMVBHZPN8E7+
        3rwLBwmyEA5N/vu4vOfYHncIybEda9ulxyLU/27CnY0maNu10ZCYx90RYJJEnN86
        OL3tJy85ZQR88rQu7WuZ1apzrsFF/PbSH41Qc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dSkAbJ946PUWkm+Zl0WfIo93o08bCqnA
        imHbuJJH6K9Uf/aUlMsTS50nNRWmtLROyS+oB4iluEv6Hk/FnYrqel14fdK6Fi/O
        z9BEiUGuE0eW3tZQ+8dB4tmdVTpdjmeuPtGM+KEuHxVOiKDyag7S4zoj4oKIL/YE
        qXviNrj9Onc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FA05A665B;
        Wed, 13 Jan 2021 15:11:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B6DCEA665A;
        Wed, 13 Jan 2021 15:11:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] refs: Always pass old object name to reftx hook
References: <d255c7a5f95635c2e7ae36b9689c3efd07b4df5d.1604501894.git.ps@pks.im>
        <X8n1Qf7TJyqIOE/l@ncase> <X/4Pin4Zdf58n1jc@nand.local>
        <X/7X5ku3wvMr2hw6@ncase>
Date:   Wed, 13 Jan 2021 12:11:28 -0800
In-Reply-To: <X/7X5ku3wvMr2hw6@ncase> (Patrick Steinhardt's message of "Wed,
        13 Jan 2021 12:22:14 +0100")
Message-ID: <xmqqbldsy4un.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 854ED1DC-55DB-11EB-9A80-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jan 12, 2021 at 04:07:22PM -0500, Taylor Blau wrote:
>> On Fri, Dec 04, 2020 at 09:37:21AM +0100, Patrick Steinhardt wrote:
>> > Quick ping on this patch. Is there any interest or shall I just drop it?
>> 
>> Apologies for completely dropping this from inbox. I am interested in
>> it, and the patch looks good to me. I suspect the reason that this never
>> got queued was that nobody reviewed it.
>
> No worries.
>
>> Would you consider resubmitting this patch if you are still interested
>> in pushing it forwards?
>
> I can, but does it help to resubmit the same patch? Your response bumped
> the thread up to the top anyway.

Bumping without resending would often not help people to see the
patch at all.

For example, already-read-and-old messages are not even shown to me
unless I ask my newsreader "I told you to show only the latest 200
messages, and I see this recent 'bump' message, but it responds to a
way old message so you need to show me the latest 3000 messages to
cover that era in order to see the patch message(s) it bumps."

Thanks.
