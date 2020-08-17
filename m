Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC306C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 22:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B730206DA
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 22:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mgq3XPYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgHQWtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:49:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58892 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgHQWtw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 18:49:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 028B570FEB;
        Mon, 17 Aug 2020 18:49:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x6PLbKCfeC1qnlxesmjKDzaGrn0=; b=Mgq3XP
        YoZxWVJzm3Ds7v6KO1frLSvz6sYKiJZSGkbU3E8ns3Xhx8vBcokAHoTMSSZ+xcmn
        hn7qlYun6WzTvJ3xmdLy5NJeGgrQgrkzBjMZYVqv3klOY894vbqmm/EdhfaY0DDh
        Pm0rZNu1Jkm4ddw/YwEJ4TAfvirH3JZExmVeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GTjPSeMrL5QF2YBhOP+2Ct7s8DnhNa60
        FvSvR9J/Sr9jSKXXN9vR6iCrh7Ld4dpQo0mG/J8n0U/4+izj53YKCLkgtWCDeCd8
        ya6LNP+DvYKnV0akqzjMeTG8Jl2acQJkj0j3Fuj6qhUN0FaASN6D8LP5WEXdQELX
        yVxvZRL1few=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ECF8970FEA;
        Mon, 17 Aug 2020 18:49:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E3D370FE9;
        Mon, 17 Aug 2020 18:49:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] progress: create progress struct in 'verbose' mode
References: <20200710014242.1088216-1-emilyshaffer@google.com>
        <20200710014242.1088216-2-emilyshaffer@google.com>
        <xmqq365zro2u.fsf@gitster.c.googlers.com>
        <20200714001504.GI3189386@google.com>
        <20200817221938.GA331156@google.com>
        <xmqqlficzydj.fsf@gitster.c.googlers.com>
Date:   Mon, 17 Aug 2020 15:49:48 -0700
In-Reply-To: <xmqqlficzydj.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 17 Aug 2020 15:44:08 -0700")
Message-ID: <xmqqh7t0zy43.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F480157C-E0DB-11EA-86B3-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Emily Shaffer <emilyshaffer@google.com> writes:
>
>> The main concern I saw here was "we are doing a lot of work that isn't
>> used if the user doesn't want to log traces" - should I approach a
>> reroll of this topic by trying to be smarter about whether to set
>> 'quiet' or 'print' or 'verbose' or whatever it is renamed to, based on
>> whether there is a trace destination? Then for systems which are logging
>> traces the extra work is worth it, but for everyone else it can function
>> as before.
>>
>> I don't love it from a design perspective - it feels a little like
>> progress module is looking a little too closely at trace module
>> internals.
>
> Isn't that primarily due to the decision to tie progress and trace
> too closely?  If so, perhaps that needs to be revisited?

Or the "too close coupling" needs to be accepted as the cost of
doing so (as "progress is often a good cue for an event worth
tracing" was a convenient way to cheat by programmers not to spend
too many braincycles to decide adding trace points---they
automatically got them when they decided to show progress output).

>
> I dunno.
