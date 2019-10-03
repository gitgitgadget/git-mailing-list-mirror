Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2395D1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 02:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfJCCHB (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 22:07:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50039 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfJCCHB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 22:07:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD7A41E000;
        Wed,  2 Oct 2019 22:06:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RjsCZ0lWmpifVW5qeiFtRLU1Xzo=; b=nsMCGT
        3VJaz/0v6pAqr60ozdfHDbmP++o5z2oUzBF7xHjRJHnuGYmnYL1uQIWfnt+4GQTd
        iF2c9j83eWeXvEZ5Kc+wazbV34autNwYH3uS5g2Y4lSFA1nzaFkWxzHlDcApBDDi
        PlSbpl17KpJ2whEBud1E9Y6jTH15dXdM2ohGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rgWul+98hPqfS2U4eDYqv06/WA1+Ydon
        cqC0YhaBwViaHWDuVFu4SFme+mrL2Uk+iCcKlTqsiGUBF6L9bVQZRb4XHifzrmX1
        bB9UfOxbN1l9nbnjQFvSlAZRrpbGpUWnqEpbkgXT7bYFJcpFko9vYLqfs9Wwxkjg
        i5oDw3SUfec=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1E1F1DFFE;
        Wed,  2 Oct 2019 22:06:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 196811DFFD;
        Wed,  2 Oct 2019 22:06:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH 10/10] pack-objects: improve partial packfile reuse
References: <20190913130226.7449-1-chriscool@tuxfamily.org>
        <20190913130226.7449-11-chriscool@tuxfamily.org>
        <xmqq7e6bde4z.fsf@gitster-ct.c.googlers.com>
        <20190914020225.GB28422@sigill.intra.peff.net>
        <xmqqy2yrbmqu.fsf@gitster-ct.c.googlers.com>
        <20191002155721.GD6116@sigill.intra.peff.net>
Date:   Thu, 03 Oct 2019 11:06:56 +0900
In-Reply-To: <20191002155721.GD6116@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 2 Oct 2019 11:57:22 -0400")
Message-ID: <xmqq5zl6d1kv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7ADB6F78-E582-11E9-AD42-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Hmm, I see the early parts of this graduated to 'next'. I'm not sure
> everything there is completely correct, though. E.g. I'm not sure of the
> reasoning in df75281e78 (ewah/bitmap: always allocate 2 more words,
> 2019-09-13).
> ...
> I'm sorry for being so slow on giving it a more careful review. I was
> traveling for work, then playing catch-up, and am now going on vacation.
> So it might be a little while yet.

Thanks for a status update.  I do not mind moving this topic much
slower than other topics at all (if somebody is actively working on
it, I do not even mind reverting the merge and requeuing an updated
series, but I do not think that is the case here).  It would give me
much more confidence in the topic if we can collectively promise
ourselves that we'll give it a good review before we let it graduate
to 'master'.

Thanks.
