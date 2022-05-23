Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2C0C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 21:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiEWVOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 17:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiEWVOX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 17:14:23 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978FC7E1FD
        for <git@vger.kernel.org>; Mon, 23 May 2022 14:14:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5302B12282A;
        Mon, 23 May 2022 17:14:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AaxQjrgpjwLuKI2C+EPQbYXfK/ikhhSQ77Qc24
        0bTFE=; b=PpR4MHYW6bZEKfu6xrURavRcgtef+KxoMdU9wqdH02oWDqkDhhbHX7
        ZK4jdAcUQulS8kale5uuOWGFNp0KyGWe5xR9NuL6PDbngJrSLoknf3arkYL82M9x
        Vdy6eUJNbyQxyO6hTNj9oMoxkANrDKsZqHphAng1T13/A8wvheTaA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 47278122829;
        Mon, 23 May 2022 17:14:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D196122827;
        Mon, 23 May 2022 17:14:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>
Subject: Re: [PATCH] urlmatch: create fetch.credentialsInUrl config
References: <pull.1237.git.1653329044940.gitgitgadget@gmail.com>
        <xmqqr14kqdag.fsf@gitster.g>
        <7495dac8-0241-ad56-59e3-100673c88c52@github.com>
Date:   Mon, 23 May 2022 14:14:06 -0700
In-Reply-To: <7495dac8-0241-ad56-59e3-100673c88c52@github.com> (Derrick
        Stolee's message of "Mon, 23 May 2022 16:31:42 -0400")
Message-ID: <xmqqo7zoostd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48D2C582-DADD-11EC-ABB1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> This computation of at_ptr matches the one in url_normalize_1(),
> so it at least agrees about where the "username[:password]" section
> could be.

OK.

> That does mean that the password cannot contain an "@"
> symbol (unless it is special-cased somehow?).

I wasn't worried about what is valid but more about what attackers
can fool users to throw at "git clone" and make our code misbehave
(which can include garbage that would not parse correctly).

I think the while() loop will just become a no-op, anonymized buffer
is left empty and colon_ptr does not get updated at all.  Then
strbuf_addstr() after the loop will put everything from '@' to the
strbuf to be showed, and none of these should lead to any overrun or
exploit.

Thanks.
