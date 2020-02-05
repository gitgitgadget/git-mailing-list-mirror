Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9F3C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2520220730
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f9wnF0s+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgBEWSm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:18:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61585 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgBEWSm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 17:18:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DED0445B96;
        Wed,  5 Feb 2020 17:18:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HZbtk1f5TY6JIX7iqq8Ub7nTYOc=; b=f9wnF0
        s+bPnm29z7jZnoBsgwM1VGXaGwsKW0rDPOI4VX+LWf8kxf9IUkZdKYEdUeIgXGKz
        GAzLrriRL4hRlz7La4x8Be6t21QZ3ghG/CKdGOT8V3jISfKlbyvjFjF9BOAUj1CU
        QEacxVolwgqnzq/rw80OA3+qR2uMd3Gv10Hp8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u63N+U06/1qUB2GqfFDqDQSf3ZjTKo/J
        o3P/3GT9hcu1qXUoRLZNW1UY2CDGyDQJ1myZhnGoaleG+J+G3NY0GJ+RGVT98AZP
        6p+M0VFJty5F487sG+R3evh1vjMr6Q0P/0ZNiuQ41fCqWds1T5fv3X0vUZfhJzIG
        QWqaDa7lJdQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D475F45B95;
        Wed,  5 Feb 2020 17:18:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F8D445B94;
        Wed,  5 Feb 2020 17:18:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heba Waly <heba.waly@gmail.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3] add: use advice API to display hints
References: <pull.508.v2.git.1578438752.gitgitgadget@gmail.com>
        <pull.508.v3.git.1580346702203.gitgitgadget@gmail.com>
        <xmqqimksbo73.fsf@gitster-ct.c.googlers.com>
        <CACg5j27pTKuhZpZtgNUDNEkhG0+tGx5O=LJCr5E8+2q8v6Zu1w@mail.gmail.com>
        <xmqq7e10hgwn.fsf@gitster-ct.c.googlers.com>
        <CACg5j252=wKyh7Ar9vxTwxdYXgkjNvbMA=bJCKOc6UZRJfJmUg@mail.gmail.com>
Date:   Wed, 05 Feb 2020 14:18:38 -0800
In-Reply-To: <CACg5j252=wKyh7Ar9vxTwxdYXgkjNvbMA=bJCKOc6UZRJfJmUg@mail.gmail.com>
        (Heba Waly's message of "Thu, 6 Feb 2020 11:05:33 +1300")
Message-ID: <xmqqy2tgfzk1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75C2047A-4865-11EA-8361-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heba Waly <heba.waly@gmail.com> writes:

> No, I agreed with my mentors to wait on this update until that branch
> is merged in master.

The users will first has to set advise.addnothing and then later has
to set something different if you do so, no?

I do not think that is a good decision, and I am not happy to see
people making such a decision that would hurt our users off list.

> So no need to worry about it.

Yes, I do have to worry about our users.
