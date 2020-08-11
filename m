Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2E0C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 18:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 692DC2076B
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 18:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MS4Hp7uL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgHKS7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:59:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52861 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgHKS7x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 14:59:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB04C8E7F6;
        Tue, 11 Aug 2020 14:59:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZqYEncfZXZtPw2lR1MmaMPd6cXk=; b=MS4Hp7
        uLlTtY5DTrmYe3vkTU7WNAeyIIqYgGwLJKEO+Yc2p5HsA2sN0t+kxqa6XOm6NXfn
        Km/GfaUQ1OStCeXz1HIdskgmksagoRHt2kY90RmRTDNW9R/H/GAH8ZOUCIOHPy+f
        uOTTW1UkRFIO94uUu4AifOIXioWmxRlEy/IA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W2KkQT3DS9wU6gLf8FACJef1J8xQs3qy
        s2kwxuFZkLQmNsQrLq2saKTaTFkhdwsTsjNZ5mCXIfnjN5J/n/GdYPm2clmUESyg
        xRfRj/o1FdI9CtmyvbDqiKXw3oYkzu2o/7+2wMMJ6a05bK8jA05ljak/Xzh0FRzF
        kktoNCRwodY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C26988E7F5;
        Tue, 11 Aug 2020 14:59:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5672C8E7F4;
        Tue, 11 Aug 2020 14:59:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v2 12/14] commit-graph: add large-filters bitmap chunk
References: <cover.1596480582.git.me@ttaylorr.com>
        <cover.1596646576.git.me@ttaylorr.com>
        <100b26d7c8a5e7ce21a950f33791eadab74e8e70.1596646576.git.me@ttaylorr.com>
        <xmqqbljoolhy.fsf@gitster.c.googlers.com>
        <20200805211730.GJ9546@syl.lan>
        <xmqqh7tgn37w.fsf@gitster.c.googlers.com>
        <20200805222531.GA30420@syl.lan> <20200811134807.GA26715@syl.lan>
Date:   Tue, 11 Aug 2020 11:59:50 -0700
In-Reply-To: <20200811134807.GA26715@syl.lan> (Taylor Blau's message of "Tue,
        11 Aug 2020 09:48:07 -0400")
Message-ID: <xmqqo8nh9ffd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5D5028A-DC04-11EA-BE7F-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I'm back :). Let's squash the following into patch (bearing in mind that
> you'll have to drop a '&' in the final patch of this series as a result
> of this change):

Let's have replacement patches for those steps (or a full series is
also fine).  Don't make me squash and clean-up.

That would give us (well, mostly the contributor) a chance for the
final proofreading before sending.

Thanks.
