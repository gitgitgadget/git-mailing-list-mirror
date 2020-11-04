Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB91C4741F
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F7C2071A
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v1o0dawj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbgKDRAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 12:00:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50949 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbgKDRAx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 12:00:53 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CFEFA1E83;
        Wed,  4 Nov 2020 12:00:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DMW2QBXOWqaUBKHi+MF2t35+z8s=; b=v1o0da
        wj6oq42zS8nTK4UKrIe8hsBQE7uH86QYmHl0aR9WqmxHfRpqSyFvXMAXvWRr0+5Q
        yV+4uOE2ulDAzM7y+AsD0Beloxckb1Xy8086BwMFVigKaVZ3JOBt2UbkWcpnRyje
        YznPLx67f/77oYuj1Rmsz/1rEPXb5tCAfYD8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wtASaYwghkWq6v87ilfzG5t6ttXp3EJ1
        wHHDB2Qc/PmYLv+5DeUnLMHN/Gzcss/KAtL9ht1rG/N80aZORQsuzQGEDSTZpl5a
        2I2nZq3Mw1A0nLrmQLdOzV6HJM8JkxsntryV081X/sCQLZOo8KenHMjb+c8w3hx0
        LjRRcPM2C84=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 333C5A1E82;
        Wed,  4 Nov 2020 12:00:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AAEF2A1E81;
        Wed,  4 Nov 2020 12:00:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/3] Maintenance IV: Platform-specific background
 maintenance
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
        <xmqqmtzyqjil.fsf@gitster.c.googlers.com>
        <022c5792-e66c-71d8-fbf4-ead9231030ad@gmail.com>
        <xmqqo8keoyy8.fsf@gitster.c.googlers.com>
        <af2befd7-7d93-5981-42c8-700e49f3999a@gmail.com>
Date:   Wed, 04 Nov 2020 09:00:50 -0800
In-Reply-To: <af2befd7-7d93-5981-42c8-700e49f3999a@gmail.com> (Derrick
        Stolee's message of "Wed, 4 Nov 2020 08:02:34 -0500")
Message-ID: <xmqqblgdnjjx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B6208A2-1EBF-11EB-907E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 11/3/2020 5:30 PM, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>>> I'm hoping that parts 3 and 4 can make it in time for 2.30,
>>> so the feature is universally available for all platforms.
>>> I realize that's not entirely up to just me.
>> ...
>> I was wondering if I should propose making these two parts into one,
>> so we may be pretty much on the same page.
>
> I'm happy to have the two topics be merged into one series, but
> I'd prefer to only re-roll these three patches during review.
> Of course, by keeping them together we have the ability to re-
> roll all of the patches, but part-3 has a decent length and has
> been stable for a while.
>
> I defer to what is easiest for you.

Two topics, one on top of the other, is fine, as long as I can
remember (and you help me by reminding) to keep them together,
and the bottom one is reasonably solid that I do not have to do the
rebasing myself ;-)

