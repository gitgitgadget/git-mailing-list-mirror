Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAADC433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 714F3212CC
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vfr65ZEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393618AbgJPUZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 16:25:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56658 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393585AbgJPUZc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 16:25:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F085392D7A;
        Fri, 16 Oct 2020 16:25:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZY4zEtzmARl9Ml56IHvWJvFjnfU=; b=vfr65Z
        EKJUJfa+MuZPWQrZUjUhbeKjwlEDUUme3dhLmFNWxEC411E+gILXbSVQ65lXAU9d
        Mr16dSVzrSaEUsgycwXwvA/i8ZdmuD3Wqyvi4ZREJWear7f85DtsrOUk6u2umJ+N
        IEmZv8XGskHNpZLiZVv277FFrhXne0DYZGd60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y0KlIXRPFMg9I3wybbfO9BRI/ihkkZkj
        qtZJK2HVUnd4kqsEFzCteq8rdHK3G7ER40srGqTQWERc2mZO515M8kGYdv8N6vOn
        m4fv2hUuZqNAI6r4nHBomZ+WUgh2zZV/EEV4ds05wyZyFxEoK5uk/lceY7UMpUxM
        Y9gQSiT7l1c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E738892D79;
        Fri, 16 Oct 2020 16:25:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66C4A92D78;
        Fri, 16 Oct 2020 16:25:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 0/3] Make test selection easier by specifying
 description substrings instead of just numeric counters
References: <pull.878.v3.git.git.1602710025.gitgitgadget@gmail.com>
        <pull.878.v4.git.git.1602876532.gitgitgadget@gmail.com>
Date:   Fri, 16 Oct 2020 13:25:28 -0700
In-Reply-To: <pull.878.v4.git.git.1602876532.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Fri, 16 Oct 2020 19:28:49
        +0000")
Message-ID: <xmqqzh4lapfr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBA0215C-0FED-11EB-92D0-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v3:
>
>  * Added text to the README explaining what to do if the substring you want
>    to search on includes a comma or whitespace (namely, use the '?' glob
>    character instead)

That would work just as well with or without forbidding spaces.

>      ++The argument to --run is split on commas and whitespace into separate
>      ++strings, numbers, and ranges, and picks all tests that match any of
>      ++the individual selection criteria.  If the substring of the
>      ++description text that you want to match includes a comma or space, use
>      ++the glob character '?' instead.  For example --run='unnecessary?update
>      ++timing' would match on all tests that match either the glob
>      ++*unnecessary?update* or the glob *timing*.

OK.

Will queue.
