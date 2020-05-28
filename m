Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D58C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 16:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A379521532
	for <git@archiver.kernel.org>; Thu, 28 May 2020 16:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N/PhxxjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404922AbgE1QPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 12:15:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60255 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404861AbgE1QPG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 12:15:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AFD25CC22F;
        Thu, 28 May 2020 12:15:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kHY6AHhtW3WqNUWntb7+KldSBJ4=; b=N/Phxx
        jQ6sUnjmbrK8XhtCu7xpSSeZVZburixfd9zpredAyRzmpagto2dIXDZuZ1jE7Ehj
        /yXIyKGt6imz7J2VC0Yem9zqjj/6Ohlz2aef0gHkS+F3wzsWiCJFgPli1rdz3ORM
        dgN3aEKwaY8TyBoSoLa/dTXZQAu480aWasGdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=stTd2tMrHmjGcc6/GxP2Ms4QGnKtZKWe
        AqcLBwZxBoyd+vMufpsSgdg0pydoAzz/ZfsRM/JLMP44S4yjSLzg0d7uuqi2k0N8
        K5/Krqttok5x0y+viAL8cA4UT3GuvnqrcCaUgaf0KMgPswnP7S2QKRQ7F0wsszNA
        c7FxjzjYS6o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D93BCC22E;
        Thu, 28 May 2020 12:15:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2AF96CC229;
        Thu, 28 May 2020 12:15:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Marco Trevisan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Marco Trevisan <mail@3v1n0.net>
Subject: Re: [PATCH] completion: use native ZSH array pattern matching
References: <pull.645.git.1590520398132.gitgitgadget@gmail.com>
Date:   Thu, 28 May 2020 09:14:59 -0700
In-Reply-To: <pull.645.git.1590520398132.gitgitgadget@gmail.com> (Marco
        Trevisan via GitGitGadget's message of "Tue, 26 May 2020 19:13:17
        +0000")
Message-ID: <xmqq8shc3ukc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61DFE980-A0FE-11EA-8738-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Marco Trevisan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =?UTF-8?q?Marco=20Trevisan=20=28Trevi=C3=B1o=29?= <mail@3v1n0.net>
>
> When clearing the builtin operations on re-sourcing in the ZSH case we
> can use the native ${parameters} associative array keys values to get
> the currently `__gitcomp_builtin_*` operations using pattern matching
> instead of using sed.

"We can" may be a statement of fact, but by itself it does not make
a convincing argument why we should have this change in our
codebase.  

Is this change about correctness?  Is it about performance?
Or something else?

If it is about correctness, "the current code fails in this way
given this input, but with the new code the breakage is gone" would
be a good justification to give in the proposed log message.  If it
is about performance, of course a measured performance numbers would
make an objective justification that is hard to argue with,
especially if you can convince people that the patch does not change
the behaviour in any negative way.  If it is about something else,
well, there would be an appropriate way to justify the change,
depending on what it is ;-)

Thanks.
