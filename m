Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33435C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 20:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240738AbhKVUnW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 15:43:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50870 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239361AbhKVUm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 15:42:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E2E0BE8BE6;
        Mon, 22 Nov 2021 15:39:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=35bub7zHCEAtiT0R8SgpkW8qUuMCIyL2AKFLwn
        hW7Zo=; b=Hco+MXkMtNa22kQxHUd3qEcVSEHN0HaUX8fhWl6b+2uwYopIkXk2NZ
        53UXE+TpGHY6j1+QyEDNhZjJBiXr+DtL1uJiN7SFCvHlIcI/2SG/D2zpsuzYoDRD
        81+K5Ew0Lo9zbezE85Z/VLR/ge7StN4bU6ZNTluBIniAkxndY+tyU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D9E11E8BE4;
        Mon, 22 Nov 2021 15:39:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4B724E8BE3;
        Mon, 22 Nov 2021 15:39:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Enzo Matsumiya <ematsumiya@suse.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] pager: fix crash when pager program doesn't exist
References: <20211120194048.12125-1-ematsumiya@suse.de>
        <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net>
        <xmqqfsrplz3z.fsf@gitster.g>
        <20211122153119.h2t2ti3lkiycd7pb@cyberdelia>
        <211122.86a6hwyx1b.gmgdl@evledraar.gmail.com>
        <20211122164635.6zrqjqow4xa7idnn@cyberdelia>
        <xmqqk0h0gjnh.fsf@gitster.g> <xmqq35nogijg.fsf@gitster.g>
        <YZvjhF+KM/gzu7vN@coredump.intra.peff.net>
Date:   Mon, 22 Nov 2021 12:39:49 -0800
In-Reply-To: <YZvjhF+KM/gzu7vN@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 22 Nov 2021 13:37:56 -0500")
Message-ID: <xmqqzgpvexgq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 56CFDB2C-4BD4-11EC-81D4-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Just grepping around on GitHub, I don't see many uses, but this one[1] for
> example might get confused:
>
>   export GIT_PAGER=cat # disable pager when running interactively

Yeah, that is an excellent example that argues against changing
this.

> So I dunno. It is probably unlikely to have much fallout. On the other
> hand, I kind of wonder if the benefit is worth changing now.
