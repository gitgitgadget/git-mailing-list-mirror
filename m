Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28A651F461
	for <e@80x24.org>; Mon,  9 Sep 2019 18:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbfIISIo (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 14:08:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63274 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730105AbfIISIn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 14:08:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBB25696B6;
        Mon,  9 Sep 2019 14:08:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dG8Ptbhg9aE3WsVTeZ8zremK0y0=; b=UAepuL
        wEZ+iR6mtDJ+rNi2dUW9o076e/SyaODBuB8ORHHt4eKwlZI+EVNaV+yJftHkQrmT
        7mImGQLjASbMIuiyed3db9XNLjGYVKnbxPbE8Q62d8aH6bmCaWFG5VK10eyfFEVj
        +dfzL5RbV1fYLP4vBZhn9Gv9MhFI2XpkYcEi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aZDSSV+ZEXrFGem6CgLxCK6xgv5inEOZ
        HpjST4QVJQJc9BlBmX/AZWqMrwtHwXPva3suikCvZd82znhPHWAqBRCGmRw9Mvcg
        ApIuN0kaxL0JU1iC5Qqk+O+9njtJXZZoTtuP4IWs9a42VvH08Mv50hVnudavvj+t
        mORk+l0nwUk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B45AD696B4;
        Mon,  9 Sep 2019 14:08:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E025E696AC;
        Mon,  9 Sep 2019 14:08:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Freese <ericdfreese@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] for-each-ref: add '--no-symbolic' option
References: <20190907213646.21231-1-ericdfreese@gmail.com>
        <20190907213646.21231-2-ericdfreese@gmail.com>
        <20190908100543.GB15641@sigill.intra.peff.net>
        <xmqq8sqyn6ek.fsf@gitster-ct.c.googlers.com>
        <xmqq4l1mmn8i.fsf@gitster-ct.c.googlers.com>
        <CAAikoA+MvORDJ6y=VSk_1s6v7110UeOfU2X2G7=9ChV+m+COxQ@mail.gmail.com>
Date:   Mon, 09 Sep 2019 11:08:36 -0700
In-Reply-To: <CAAikoA+MvORDJ6y=VSk_1s6v7110UeOfU2X2G7=9ChV+m+COxQ@mail.gmail.com>
        (Eric Freese's message of "Sun, 8 Sep 2019 22:01:33 -0600")
Message-ID: <xmqq1rwpl4uz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D94E4F8E-D32C-11E9-967E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Freese <ericdfreese@gmail.com> writes:

> However, this still prints an empty line for each ref that does not match the
> condition. This can be cleaned up by piping through `grep .`, but what would
> you think of adding a new optional flag to git-for-each-ref to prevent it from
> printing empty expanded format strings?

Offhand I do not think of a reason why anybody wants to give a
format that results in a total blank, so it might not even need to
be an optional behaviour, but certainly a new option that triggers
such a behaviour would be a safe thing to add.
