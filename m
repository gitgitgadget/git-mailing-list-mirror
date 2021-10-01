Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF05C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 18:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5817061A57
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 18:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhJASpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 14:45:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64364 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhJASpX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 14:45:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C335F3646;
        Fri,  1 Oct 2021 14:43:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VzDgdMiQPP3ltOUulR0UUCj4o2d82ZGr4MxoE9
        XUJC4=; b=nUuzH0WCHodtE4GHUKe9KaKNNVIEt8jLOmdzC/epop/p59uKgywfFA
        SYIuFLahDtEALUXqV9XuYkHJoKqCcHCDAnYBD4c1j5fakoIcBxuBWjTk63jF5ubC
        1oeel8eE/riutUJaF+i3Bvz4ZnYSMxoAffl71FMZzE+8BmU16SrSA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62E1FF3645;
        Fri,  1 Oct 2021 14:43:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C344DF3642;
        Fri,  1 Oct 2021 14:43:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Git List <git@vger.kernel.org>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v2] receive-pack: not receive pack file with large object
References: <20210930121058.5771-1-chiyutianyi@gmail.com>
        <20210930132004.16075-1-chiyutianyi@gmail.com>
        <87pmsqtb2p.fsf@evledraar.gmail.com>
        <YVaw6agcPNclhws8@coredump.intra.peff.net>
Date:   Fri, 01 Oct 2021 11:43:33 -0700
In-Reply-To: <YVaw6agcPNclhws8@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 1 Oct 2021 02:55:37 -0400")
Message-ID: <xmqqv92g7fhm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B9A75D6-22E7-11EC-AE0A-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Unlike the patches here, ours is limiting the logical size of an object
> (so a 100MB blob limit is on the uncompressed size). It happens in
> sha1_object(), where we have that size.

I like it when I hear people doing things in the "right" way (the
definition of being "right" in this case is to apply the limit to
the size that is end-user facing---otherwise you cannot justify an
arbitrary limit).  ;-)
