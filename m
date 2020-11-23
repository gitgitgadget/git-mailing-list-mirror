Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18E2C63798
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B7A20738
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m5iiebJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbgKWTPn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 14:15:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59327 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbgKWTPn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 14:15:43 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D5748BCD7;
        Mon, 23 Nov 2020 14:15:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bi8+j1ipcfu+24oFv8WNlsn9ih4=; b=m5iieb
        JYvyJjo/wdL1u4w6hkknSSgO7HkOhkQTztzXeSKgMGoful+InPB+jFeWD/EGfuo0
        W0sxI7ZjALL1Ny6hbNRofkQOeTqF0B7Huu3NrUF6SlxZixJtwpq1cDmdy6HXm555
        hqjuRjuqwOFQKv3NM0N2yMsd5hLIJaMD8JwZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dG+cJs2IfnWNSVMvV7DiDMyzm/ZfkjFs
        E7fmTFMf+ku7iyX6W3Hu/kZClJxcRE56qoH37WS5TtWvZZLbJm9VH9ez9p9LSSV7
        azXcMLmszHWb4oVDVJEn4E3JR5qoCE8LF0Uf0x31z6BeTfMGXKxl4PL3RWfQ4lbC
        ScGtqaCWd9g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 363ED8BCD6;
        Mon, 23 Nov 2020 14:15:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD1ED8BCD5;
        Mon, 23 Nov 2020 14:15:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: ag/merge-strategies-in-c [was Re: What's cooking in git.git
 (Nov 2020, #04; Thu, 19)]
References: <xmqqwnyeqpw9.fsf@gitster.c.googlers.com>
        <8c92f1d0-3f17-d8b2-ca93-c70ee887f37d@gmail.com>
Date:   Mon, 23 Nov 2020 11:15:40 -0800
In-Reply-To: <8c92f1d0-3f17-d8b2-ca93-c70ee887f37d@gmail.com> (Alban Gruin's
        message of "Sun, 22 Nov 2020 13:43:38 +0100")
Message-ID: <xmqqd003oper.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46A6FBF0-2DC0-11EB-A5BC-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> There is some behaviour changes and regressions in this iteration that I
> intend to fix.  Expect a reroll soon.

Thanks for a heads-up.

> I also noticed that I can show which branch has made a branch when there
> is a conflict with the "resolve" strategy, like "recursive" already
> does.  Should this change be part of this series, or should it be a
> separate patch?

Depends.  If it is already a separate patch on your end, keeping it
separate, and even holding it off until the other/larger parts of
the series solidifies, would be a good idea, as I expect it would be
fairly straight-forward change once you have the fundamentals ready.

Thanks.
