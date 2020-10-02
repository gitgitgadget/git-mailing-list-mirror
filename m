Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1F0C35257
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 16:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1085120719
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 16:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bCfq86O9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388060AbgJBQu6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 12:50:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50912 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgJBQu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 12:50:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B53F79F123;
        Fri,  2 Oct 2020 12:50:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EperhFX6gAkFlmTWO+DbbkSeKRA=; b=bCfq86
        O9FUDeiIt6WK7105m992Mk6XxyvLMJsa0/xPAxIBd1GsaH+i64uVB6T57Ebx8Geo
        uJ6B9kC6BQ+hISbB3xcGCrYuvljALAPWvJUXKeVDjQn1NCUqSvXsvutv/lPoe4Rz
        d3Tf4i36bHYScOOt7A7jVROeqS6iZBTwl6pG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lU6xHDy6BSkhG/KiP9nFCyy23BkfW2gH
        qI9hbYseW0u456OCdWkmJgRlAnO+6Kk8FbRRCQZEBR/raUzugdnaSdYQ6vk0HmCd
        Ql6iyhY5Cp6BqQU4cf7KMJYbubFZKpPLxwT8OqybUFwdwqqsta1vypqdrvTT5v1j
        u9DC7DXJr/g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8D979F122;
        Fri,  2 Oct 2020 12:50:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 28C559F11F;
        Fri,  2 Oct 2020 12:50:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v9 0/3] push: add "--[no-]force-if-includes"
References: <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
        <20201001082118.19441-1-shrinidhi.kaushik@gmail.com>
        <xmqqlfgqc5kq.fsf@gitster.c.googlers.com>
        <xmqq4knddg5v.fsf@gitster.c.googlers.com>
        <20201001175443.GA28444@mail.clickyotomy.dev>
Date:   Fri, 02 Oct 2020 09:50:54 -0700
In-Reply-To: <20201001175443.GA28444@mail.clickyotomy.dev> (Srinidhi Kaushik's
        message of "Thu, 1 Oct 2020 23:24:43 +0530")
Message-ID: <xmqqblhka7wx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 703056C0-04CF-11EB-BD0B-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> I didn't want want to cause a delay with this patch. Since the new
> option was seemingly working without it,...

It is a good example to help other new contributors to understand an
important point in how the development in common works, so let me
say this.

I did very much wanted to keep the bug exposed at least to the test
suite.  Since the broken helper were designed to be used in many
other places in the code, and we had a simple reproduction recipe in
this topic, using it as an opening to help debug and fix bugs in the
broken helper had higher priority than adding the "--force-if-includes"
feature.

We help the contributors who have been involved in the broken helper
by delaying this topic a bit and leaving the reproduction readily
available to them, so that they help us who are working on a piece
of code that wants to see the broken helper fixed.  

That way everybody benefits.

It's not like a corporate development where your interest lies in
shipping your piece regardless of the work done by other teams,
where it might serve you better by using the second best tool for
the task, to avoid the tool that ought to be best but does not work
well *and* you do not want to help the team that manages that best
tool, even if helping them may benefit the whole organization.

So, let's play well together.  Yield a bit to help others and let
others also help you.

Thanks.
