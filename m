Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35C452021E
	for <e@80x24.org>; Thu, 10 Nov 2016 00:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754131AbcKJAZO (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 19:25:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56143 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754760AbcKJAZL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 19:25:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 463474EF63;
        Wed,  9 Nov 2016 19:18:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rdWjRvtCczKmLqIU1C0NLtSDU6s=; b=gnfZPE
        1pruZIMtmb2GV4JAWxENl104MI/HqtaK3xPm7hzg+gS4/2yY5QlmzKReUnfR6mwJ
        fuw/yLDpCquo33HD7fEsDObSTWG0/d75dm1EKuo54n3KWOAht/vZzKUBBLrVd9QY
        x4erai+SmeGpA6xCCHUArNbFsgr58ke73Md7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hxt4CzlssDo6J/4FspKX5j9NLM0aHJzd
        83jSSe7uargv46uXLvt4RhXO5Oa9vEfp7Vpf1/jbrrVft25y1SqXIcF96RvfplMk
        4E9mVTsRZjOR8bPDYU7hlsg5ACv3ElTL4AeQWXyqRcwlqQ/KDJG/S00ShGS8Bmdw
        KQwMfajoGUk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D69A4EF62;
        Wed,  9 Nov 2016 19:18:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B56354EF5F;
        Wed,  9 Nov 2016 19:18:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] attr: do not respect symlinks for in-tree .gitattributes
References: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
        <20161102130848.qpigt4hxpoyfjf7x@sigill.intra.peff.net>
        <CACsJy8AO2KtpxFu=wRjW1DoCA9bfpF1VoJUn__2ib-ML0XT66w@mail.gmail.com>
        <20161107211010.xo3243egggdgscou@sigill.intra.peff.net>
        <20161107211522.vzl4zpsu5cpembgc@sigill.intra.peff.net>
        <CACsJy8BoEXDjwe=ZX5ZOC_mvaMjYrB3i7wcMmiOP3mm5-rwC5Q@mail.gmail.com>
        <xmqqmvh88dlu.fsf@gitster.mtv.corp.google.com>
        <20161109231720.luuhezzziuhx4r75@sigill.intra.peff.net>
Date:   Wed, 09 Nov 2016 16:18:29 -0800
In-Reply-To: <20161109231720.luuhezzziuhx4r75@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 9 Nov 2016 18:17:21 -0500")
Message-ID: <xmqqoa1o6vca.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3588E81C-A6DB-11E6-BA6D-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Nov 09, 2016 at 02:58:37PM -0800, Junio C Hamano wrote:
>
> I'm slightly confused. Did you mean "supporting any in-tree symlink to
> an out-of-tree destination" in your first sentence?

I was trying to say that these "control files used solely by git"
have no business being a symbolic link pointing at anywhere, even
inside the same tree; actually, especially if it is inside the same
tree.

