Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A51C433E6
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 02:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E05FD2388C
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 02:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732268AbhALCCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 21:02:46 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55975 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbhALCCp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 21:02:45 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 87808F8A7C;
        Mon, 11 Jan 2021 21:02:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bpHL6pvYXc3rPDjIChUhBJqqwpE=; b=D2XyIn
        IENhm/DH5BU6k6IEKFtYGfiQwXOy61G/GQ3uCgTKboHmMuPUPAA6RXwfcH2TsOj1
        Iy6AMPi3DzVXkmBVDK2PJrbO5YoJfy4u2W+HYcio0YWQ/nLKaeM6lxsSvEvmr3Ka
        278RKgyhOIhIUTfPbzFPQYYgNkIL3iMr4lzqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pTtoszyBKAbSx9r5VRGYOTQogxk26b9p
        VIx299wtHlB2g4XujxHda7ZHRc19/NIsS093YAMXXZnVIGJR3kfdpEVw0ytBYkmf
        umkvHA6VIpQnnMpBdNsZ35agqwC2hOE3GO4fGfdreCtl6yEM4Al5CJJw/NE0okR/
        GlBS++jDRAY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 808ADF8A7B;
        Mon, 11 Jan 2021 21:02:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CDD73F8A78;
        Mon, 11 Jan 2021 21:02:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nipunn Koorapati <nipunn1313@gmail.com>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/2] negative-refspec: fix segfault on : refspec
References: <pull.820.v4.git.1608599513.gitgitgadget@gmail.com>
        <pull.820.v5.git.1608609498.gitgitgadget@gmail.com>
        <xmqq1rfijpyf.fsf@gitster.c.googlers.com>
        <CAN8Z4-VQJsXWmJPNg0Fdu98csK7ZQ0yDNzxPqRhsbuw9CUJjnw@mail.gmail.com>
        <xmqq8s9o5aza.fsf@gitster.c.googlers.com>
        <CAN8Z4-UpQzvQguhEqwCJHVZ_0phOXtGouHFNFNwa8jwSpugxSw@mail.gmail.com>
Date:   Mon, 11 Jan 2021 18:01:58 -0800
In-Reply-To: <CAN8Z4-UpQzvQguhEqwCJHVZ_0phOXtGouHFNFNwa8jwSpugxSw@mail.gmail.com>
        (Nipunn Koorapati's message of "Mon, 11 Jan 2021 20:22:51 +0000")
Message-ID: <xmqqk0si6hgp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28959E06-547A-11EB-9FBF-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nipunn Koorapati <nipunn1313@gmail.com> writes:

>> Eventually by backporting, but a fix typically goes to the current
>> development track first so it would happen after 2.30 is finished, I
>> would think.
>
> I wanted to bump this idea - now that it appears that 2.30 is complete
> and the new maint branch. Given that this patch makes matching-refspec
> unusable in 2.29, would it make sense to backport a fix to the 2.29
> release?

Yes, it does make sense.

If we were to spend engineering effort to cut a 2.29.1, however,
we'd better make sure not just this fix but all the other fixes
relevant to the 2.29 track that are already well tested are included
in it.  We just issued 2.30 and not many people are using it to
exercise a relatively new negative pathspec feature yet, so it
probably is a good idea to spend a weeks or two to enumerate what
other things we want to be in the 2.29 maintenance track.

I personally do not have time for doing that myself right now, but
luckily it is something contributors like you can step in to help
;-)

Thanks.

