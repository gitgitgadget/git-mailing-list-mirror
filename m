Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F4AC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 21:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245749AbiCGVg6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 16:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245675AbiCGVgY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 16:36:24 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48A3887B2
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 13:35:01 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E11E717B967;
        Mon,  7 Mar 2022 16:35:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b3RRXSn119QPtGOKE+sB/nXp1Sx8ZuBP2UqCNr
        7a30g=; b=Cf3KkX/PGZAa5zIFovvvDKjYXk/d3ITmVQa59mjtZ6d9UTPDNK6xei
        8TaXGo3AXmV6nep+fr3r0tUxruapZww08PdFNF9i0zWEH7X+/jvrr9bFgThsF51a
        FcJM8WOYPca3Rt5FzPKnTNSs05xCWKqe8L/DrAAplsIC3jQFz0XSs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DA74F17B966;
        Mon,  7 Mar 2022 16:35:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4F7A617B963;
        Mon,  7 Mar 2022 16:34:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: tb/cruft-packs (was Re: What's cooking in git.git (Mar 2022,
 #01; Thu, 3))
References: <xmqqv8wu2vag.fsf@gitster.g>
        <0870b8f0-976a-cf2f-f34f-7e966b9c426f@github.com>
        <YiZJiPVMZwPXbfrK@google.com> <YiZMhuI/DdpvQ/ED@nand.local>
        <ebfac323-7567-6327-f5e6-0fd9e0356550@github.com>
        <YiZoojeTodMr+Ypw@google.com>
        <332f9b54-edfb-50e7-46a7-2e46d3b574e4@github.com>
Date:   Mon, 07 Mar 2022 13:34:57 -0800
In-Reply-To: <332f9b54-edfb-50e7-46a7-2e46d3b574e4@github.com> (Derrick
        Stolee's message of "Mon, 7 Mar 2022 15:51:40 -0500")
Message-ID: <xmqqpmmxqwe6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FEABF3C-9E5E-11EC-A5DD-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> ... Git does not
> support parallel writers doing significant updates like full
> repacks and GCs and instead relies on the user to control the
> concurrency there.

At least when we set out to give our users Git, allowing such
concurrent writing without corrupting repositories was what we aimed
to achieve.  If you did two simultanenous repacks, one of the may
fail while trying to acquire a lock or two, so from waste-avoidance
perspective, there is a strong incentive on the user's side to make
sure such housecleaning tasks are not triggered needlessly and
simultanously, but it shouldn't lead to repository corruption.

Have we broken that over the course of adding new commits and
developers?  If so, we have stuff that needs fixing, and also ensure
that the developer and end-user expectations are aligned.

Thanks.


