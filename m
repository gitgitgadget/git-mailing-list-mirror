Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F104BC4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 16:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22D961156
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 16:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbhHEQbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 12:31:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56430 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbhHEQal (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 12:30:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8ECE91394A6;
        Thu,  5 Aug 2021 12:30:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oCykbpcpbbw6aahWJKAX9Ml57FvCpG8+xLXPgO
        yKMJo=; b=dSpstBpt8kRxQz93JEnPLquI9qG0HWoh3EDtF/Y02F7wL4mW+KlQoO
        3waImC/GAZl1OHT7+MVFMEYWGFJlZ55Dtbi7gW3v9GjDU61PiwbBIkfxOA/kGMKI
        SS4RnxVJ249ln6RfP8oStNHrfcju53EuE7z6bC4yL9rh18pch1/PY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 877501394A5;
        Thu,  5 Aug 2021 12:30:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BEEB71394A3;
        Thu,  5 Aug 2021 12:30:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] sequencer: warn on skipping previously seen commit
References: <4d83766ab3425a5f4b361df2ac505d07fefd7899.1628109852.git.steadmon@google.com>
        <xmqqsfzonbm1.fsf@gitster.g>
        <d3f6eb6c-f2e4-b00c-3b4c-bf1e04c846b4@gmail.com>
Date:   Thu, 05 Aug 2021 09:30:02 -0700
In-Reply-To: <d3f6eb6c-f2e4-b00c-3b4c-bf1e04c846b4@gmail.com> (Phillip Wood's
        message of "Thu, 5 Aug 2021 11:13:40 +0100")
Message-ID: <xmqqpmurlur9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 631DC580-F60A-11EB-8B11-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> +	if (skipped_commit)
>>> +		warning(_("use --reapply-cherry-picks to include skipped commits"));
>> I'd be hesitant to endorse doing this kind of "here is how to use
>> this command" unconditionally.  Perhaps under --verbose, or hide it
>> under "advise.*".
>
> and use advise() rather than warning(). I'm guess this might be
> helpful but it wont help them get their commits back as there is no
> way to stop the rebase from dropping them at that point.

Yes, but aborting the current rebase and redoing from scratch should
not be a brain surgery.  Even if you had already resolved conflicts
in earlier steps, the work will be replayed automatically for you by
the rerere mechanism.
