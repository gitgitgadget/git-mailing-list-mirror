Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88295C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 19:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiBDTc0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 14:32:26 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59301 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiBDTcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 14:32:25 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7DF7A173F26;
        Fri,  4 Feb 2022 14:32:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WGoT+Lu/WMBooMp7OEp4nF80jeWnsSHhNW8xQ5
        YHUz0=; b=mL2oVJp76mbBw67q+PbitvBnvCm8la8xS6Kw1XlXIN0qPL7IXBLAdL
        9ml6mojU7q0sCX6+zfkJWRSKtdf/Q7ww3XyyXPRv+aDs0S/HjymkAi610ngd0so3
        G/SJqX6ryLerPGfc/4+nHk8Loy2aNUm+6IePM7BtlLZTv7hs1u2X0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 76A78173F25;
        Fri,  4 Feb 2022 14:32:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E3C76173F24;
        Fri,  4 Feb 2022 14:32:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ramkumar Ramachandra" <r@artagnon.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "Git List" <git@vger.kernel.org>,
        "Christian Couder" <christian.couder@gmail.com>,
        "Miriam R." <mirucam@gmail.com>
Subject: Re: [PATCH v2 4/4] bisect--helper: double-check run command on exit
 code 126 and 127
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
        <xmqqilus3ctf.fsf@gitster.g>
        <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
        <20987dc6-e0c7-6ca2-19fd-2b323b3f6d9f@web.de>
        <xmqqa6f7pime.fsf@gitster.g>
        <6b8ce04e-8f7b-4ed5-a1f2-42aa4d8a7438@www.fastmail.com>
Date:   Fri, 04 Feb 2022 11:32:21 -0800
In-Reply-To: <6b8ce04e-8f7b-4ed5-a1f2-42aa4d8a7438@www.fastmail.com> (Ramkumar
        Ramachandra's message of "Fri, 04 Feb 2022 19:16:03 +0100")
Message-ID: <xmqq8ruqmnqy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CF474F0-85F1-11EC-A9DB-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ramkumar Ramachandra" <r@artagnon.com> writes:

> Junio C Hamano wrote:
>> * Can we have *no* rev that is marked as "good"?  I think we made
>>    it possible to say "my time is more valuable than machine cycles,
>>    so I'll only tell you that this revision is broken and give you
>>    no limit on the bottom side of the history.  still assume that
>>    there was only one good-to-bad transition in the history and find
>>    it" by supplying only one "bad" and no "good" when starting to
>>    bisect.  And in such a case, ...
>
> Hm, this addition might be an unpleasant special-case syntax, breaking both `git bisect start [bad [good]]` and `git bisect bad ...; git bisect start`.

Interesting.  Our "start" does allow you to give one "bad" and then
zero "good" commits.  And it will sit and wait until you give at
least one "good".  So we'd need an "--assume-roots-are-good" option
or something to force bisect the whole history below the "bad" one.

