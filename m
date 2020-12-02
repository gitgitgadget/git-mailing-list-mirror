Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7921C64E7A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 00:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8250220679
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 00:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgLBAV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 19:21:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64108 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgLBAV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 19:21:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 41C8290B45;
        Tue,  1 Dec 2020 19:21:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S0Rhzsp1R8FMH6MxQspP6MEtJ5M=; b=tNaAWx
        2wk8DqjkAZ9XwZw2hulJ6Zz3P7z/tKDsh8rsFmIbrHgtgcThZbHSM8IsAmGiWR0v
        c9B1aO8B4KOb6a8ux5QZ4iH87z5ltfplHxJRj436l1nCC3oFWF4NAON9df2GCnIP
        zBDtYSYzmsL0w6ysbYvOeOxAzmT8q/RJod/wM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ElCGRZBg27XdgRHTmocHSGkJZoN8bbfu
        xuO/KJnj5u4UrgDxN503k/oFpBaI41sMNH+G9cGbmI3HHbIgklQTuS1EOeZN9yK2
        8MtYXz/U6mRQPmxQCDjoSt4Rj2jYeBT846SkJ9oblfF6lpygvUlBeXEkCcr6t31W
        FZl9hj4vYW0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3ADB290B44;
        Tue,  1 Dec 2020 19:21:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AA85D90B43;
        Tue,  1 Dec 2020 19:21:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] apply: don't use core.sharedRepository to create
 working tree files
References: <xmqqpn3tqugm.fsf@gitster.c.googlers.com>
        <3f0403b84ab06b9deb7c5c189792bebe1db586a7.1606866276.git.matheus.bernardino@usp.br>
Date:   Tue, 01 Dec 2020 16:21:14 -0800
In-Reply-To: <3f0403b84ab06b9deb7c5c189792bebe1db586a7.1606866276.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Tue, 1 Dec 2020 20:45:04 -0300")
Message-ID: <xmqqmtyxm51h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A7617DC-3434-11EB-8287-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

8361e1d4 (Use sha1_file.c's mkdir-like routine in apply.c.,
2006-02-03) is the ancient source of this behaviour change, it
seems.
