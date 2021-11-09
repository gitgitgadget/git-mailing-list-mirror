Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B69AC433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05ACB610CF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbhKIXGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 18:06:03 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52720 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbhKIXGD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 18:06:03 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B4FC9152953;
        Tue,  9 Nov 2021 18:03:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H1YGXrOfgRFkrma760Ymno6G2SXs0Snb+tBQN6
        btyj4=; b=diZ6CPH02we40O31ubADfGFq/HPRmz5ZnGTb4Fl+TUD3AsM9zllwK7
        21n1TsW0ngIxsLFAz/OnPOIINrA0xUD3JpGVGlWCWvIpYqMWdWv7VB64qAgC7mgP
        mGBJQOTfr3zZ1pxijUo1837TW9WfYTODCR474lWO0HrwkLGH1dwyE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE54C152950;
        Tue,  9 Nov 2021 18:03:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0F9FB15294F;
        Tue,  9 Nov 2021 18:03:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robin Jarry" <robin@jarry.cc>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        <git@vger.kernel.org>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Jan Smets" <jan.smets@nokia.com>,
        "Stephen Morton" <stephen.morton@nokia.com>,
        "Jeff King" <peff@peff.net>
Subject: Re: [PATCH v2] receive-pack: ignore SIGPIPE while reporting status
 to client
References: <20211104133546.1967308-1-robin.jarry@6wind.com>
        <20211106220358.144886-1-robin@jarry.cc> <xmqqzgqd11dp.fsf@gitster.g>
        <CFLKOIVJ8EX0.2PWQ6PCXZ340A@diabtop>
Date:   Tue, 09 Nov 2021 15:03:12 -0800
In-Reply-To: <CFLKOIVJ8EX0.2PWQ6PCXZ340A@diabtop> (Robin Jarry's message of
        "Tue, 09 Nov 2021 22:38:45 +0100")
Message-ID: <xmqq5yt10w5r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37AE1010-41B1-11EC-A58B-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robin Jarry" <robin@jarry.cc> writes:

>> > +		sigchain_push(SIGPIPE, SIG_IGN);
>> >  		if (pack_lockfile)
>> >  			unlink_or_warn(pack_lockfile);
>>
>> Shouldn't we start ignoring SIGPIPE here, not before we try to
>> unlink the lockfile?
>
> I initially wanted to avoid getting SIGPIPE'd while printing a warning
> if the lockfile cannot be unlinked. Maybe this means the repository
> integrity is compromised and we are well beyond ensuring post-receive is
> executed or not. I do not know git internals well enough to be sure.
>
> What do you think?

I think that push/pop pair should surround the part that reports the
status, as the proposed commit log message said.

Thanks.

