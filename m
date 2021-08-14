Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660C2C4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 23:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4783B60F4B
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 23:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhHNXhR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 19:37:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53502 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbhHNXhR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 19:37:17 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D8FBD13F68B;
        Sat, 14 Aug 2021 19:36:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8yA6jDHJKVw9IiKTX96gFckeqpY9oenRQKFE8O
        HazSU=; b=TD+BvqtmCGP/gVkjtOL6nQ7VTnSNTAXs20r5zpb+8ldQ0Qbb4XNWis
        JOQLU7oW0QDW9FZxxATlTN61o5BobVWjeHIe3Fh3pYBPpJNPx2s6PHbb++hYexUH
        JZywFDSXiGqd4wiLR85AmgE8aqtwGjzOT1tXja8KmjK9saMYjuebM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D1A7113F68A;
        Sat, 14 Aug 2021 19:36:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2ACAB13F687;
        Sat, 14 Aug 2021 19:36:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Ben Goldberg <ben@benaaron.dev>, git@vger.kernel.org
Subject: Re: send-email issue
References: <24a88faf-5339-8449-80c4-f6085bd1e098@benaaron.dev>
        <b4b1dda4-6bf7-f4b1-88c5-9d579a7c56d3@benaaron.dev>
        <20210813180056.ctzivmakj4bj5apa@nitro.local>
Date:   Sat, 14 Aug 2021 16:36:43 -0700
In-Reply-To: <20210813180056.ctzivmakj4bj5apa@nitro.local> (Konstantin
        Ryabitsev's message of "Fri, 13 Aug 2021 14:00:56 -0400")
Message-ID: <xmqq35rbtx84.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C74E0B8-FD58-11EB-87E8-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> I know that this is confusing terminology, but "tls" stands for "StartTLS",
> which works on port 587, and "ssl" starts for "smtps" on port 465.

This reminds me of an earlier discussion we had that somehow petered
out before it resuted in usable improvement,

  https://lore.kernel.org/git/xmqqtuo9kgo0.fsf@gitster.g/

I do not think it is feasible to immediately rename the two choices
to SSL/TLS vs StartTLS without transition period, but the first
patch in the three-patch series there to update the documentation
alone may have helped this case.

We may also want to error out when seeing an unknown option other
than 'ssl' and 'tls', as the necessary first step to make it
possible to later safely accept StartTLS as a synonym for 'tls' and
'ssl/tls' as a synonym for 'ssl'.

