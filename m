Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7891CC433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 22:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiANWDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 17:03:33 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62844 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiANWDd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 17:03:33 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 13462169CB8;
        Fri, 14 Jan 2022 17:03:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EufwpeiV1bUyRzwMVIlAz6nprQOi9XttkCZT41
        9wrb0=; b=iVw8WRMTq6o3eztgNVMLPyT3wAK97SidMVwhxro9d9XphmtX1U/srY
        MHEP7HCcThgVmzZilBmkH+K6IccpJ1Aqi+mElLB3onn2iLFTmDNs37Hsmjwzw1dz
        2j4uPhQzrfmL+egLhEGIIELD/xVG2zVn0muxYgC5oNv03izV0lrEI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0C395169CB7;
        Fri, 14 Jan 2022 17:03:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 797A8169CB3;
        Fri, 14 Jan 2022 17:03:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2022, #03; Thu, 13)
References: <xmqq35lrf8g4.fsf@gitster.g> <xmqqk0f3dk5o.fsf@gitster.g>
        <CABPp-BFGxKBzi5RYDuiJv6Vz7yyGYTOdJC9cL_EkPGNJ5BksYQ@mail.gmail.com>
        <xmqqmtjyaylt.fsf@gitster.g>
        <CABPp-BGOqK0YJXna3PqnFmTcW_KxzAGbqjpUvRjgAxAwYzG4bw@mail.gmail.com>
Date:   Fri, 14 Jan 2022 14:03:28 -0800
In-Reply-To: <CABPp-BGOqK0YJXna3PqnFmTcW_KxzAGbqjpUvRjgAxAwYzG4bw@mail.gmail.com>
        (Elijah Newren's message of "Fri, 14 Jan 2022 13:49:11 -0800")
Message-ID: <xmqqfspq9dqn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE5FA818-7585-11EC-8E99-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> In contrast, if we leave the leak-checker failing and the failing job
> spreads to next and master, then we'll just end up training everyone
> to ignore it -- both for their own PRs and in general.  To me, that's
> what making the leak-checker serve no useful purpose would look like.

What you proposed is no better than that.

Marking a test as "OK to fail", because somebody added a new leak,
is a small step of removing the leak-checking job from the CI.
Among 226 such tests, you killed one of them and 225 more to go.

And after you are done, nobody's PR will be blocked because they do
not see a leak-checker breakage.
