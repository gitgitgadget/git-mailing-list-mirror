Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C97C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 20:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 458A223139
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 20:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbhAFU4F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 15:56:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56231 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbhAFU4F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 15:56:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 06A3DB3965;
        Wed,  6 Jan 2021 15:55:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F2N5foa1WW0knR2Zi//gIMgIXfs=; b=G7Dc3d
        WHAJFtVslX7I1k04bqUD4a5HreDriq9jeSMWs6lP/7CQl1kWuBqGajiAGuDNuWCN
        +qnRepQLal0SMPmryw/FZYsHSFmk72mY+0no8Vkzco/Wx9hIxO6M6KgrC43QbuUz
        Q3PmHSQjG2ov4CcFsu0T2vj50+Cd3rMWI3MOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NhK2dj8wWzja0rwfDF4jNXdlOAk4liCC
        prd41JDg4kYFxcv3f4idWOqakccx4ZkCUOwAOfaxZvbM5wEAkDBr+Rv26zym4rI5
        mYoJRQl9Up5Qf+GzShSKdCpBXQn6bERn2OmJj1Bq1xmCGlh553Hq4QtLcsFF+8XS
        Pjx7ev8lUGc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F3438B3964;
        Wed,  6 Jan 2021 15:55:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 80F7BB3963;
        Wed,  6 Jan 2021 15:55:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antonio Russo <aerusso@aerusso.net>
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] t6016: move to lib-log-graph.sh framework
References: <6dc37f6b-1afd-544d-126e-2be9422571c6@aerusso.net>
        <X/K1BgP8tpsgNe2x@Abhishek-Arch>
        <xmqq1reywt7x.fsf@gitster.c.googlers.com>
        <d01e2830-d579-67c6-1076-ed44cff27ad7@aerusso.net>
Date:   Wed, 06 Jan 2021 12:55:21 -0800
In-Reply-To: <d01e2830-d579-67c6-1076-ed44cff27ad7@aerusso.net> (Antonio
        Russo's message of "Wed, 6 Jan 2021 08:21:01 -0700")
Message-ID: <xmqqlfd5rdja.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E458CDE-5061-11EB-A133-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antonio Russo <aerusso@aerusso.net> writes:

> You are correct that the A4 and A6 tags can be removed without affecting
> the output.  In fact, A4 is basically immediately deleted (in the second test).
> I can remove that, if we want to stop testing the tag deletion logic here.
> I suppose that is sufficiently validated elsewhere in the test suite.
>
> There's a (weak IMO) argument to keep the A6 tag, since ...

I see.  Thanks for explaining.

> My guiding principle when I made this patch was to be as minimally invasive
> as possible, while allowing modifications to this file to be pleasant---which
> I must admit is my ulterior motive.
>
> I can certainly remove these "extraneous" tags if desired.

I actually am _for_ keeping these tags.  It is just that I want to
see the reason why these tags, some of which are no longer needed
for the purpose of matching the output with expectation, are kept
explained in the proposed log message.

Thanks.
