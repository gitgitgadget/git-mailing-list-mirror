Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80397C47254
	for <git@archiver.kernel.org>; Fri,  1 May 2020 05:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394C920731
	for <git@archiver.kernel.org>; Fri,  1 May 2020 05:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HoUh9RWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgEAF12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 01:27:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63227 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgEAF12 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 01:27:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F4BF54F33;
        Fri,  1 May 2020 01:27:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7/X0dvd4exQNCHMFPuT7Vg20PxY=; b=HoUh9R
        WgPSwH6CH/T7MJfja1v+w7tqJXB0bhJyZNSCHj43ic/9+5u5VDg4GZ5tmTkczw8Y
        KSw5Jo6PPOnYbLrH4t3KAvP1JGb+4f6fKb8lyE490NV76w6UESNlxfDZz/PjTVnD
        bNS7itaS8YoZtoTfR/zvqxjyoch+RBj6PqnkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oLPmeEneJ2ZquTBQKN08gnnWmMUgqZbg
        A/blq0lNipB7l/GUFc6chbT7DuzgJ/4jI5Wu0yK9HK/wowZHbkqi2dyo0ZZIyICS
        j2PNOFoILhnv+0w27PvdoOuGxGbCCnXhfP9aqaCRFW5q9LOUIUZ2taMwNJJlc5Qb
        oDYpCEIw788=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F5D454F32;
        Fri,  1 May 2020 01:27:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B32BB54F2E;
        Fri,  1 May 2020 01:27:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net, jrnieder@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v9] credential-store: warn instead of fatal for bogus lines from store
References: <20200430011959.70597-1-carenas@gmail.com>
        <20200430160642.90096-1-carenas@gmail.com>
        <xmqq1ro4sp1p.fsf@gitster.c.googlers.com>
        <20200501003041.GD33264@Carlos-MBP>
        <xmqqimhgph3z.fsf@gitster.c.googlers.com>
        <CAPUEspiD10bYsCDoHM6PJdidyofNadJL0bexjiNNZCXNU+Ay_Q@mail.gmail.com>
Date:   Thu, 30 Apr 2020 22:27:24 -0700
In-Reply-To: <CAPUEspiD10bYsCDoHM6PJdidyofNadJL0bexjiNNZCXNU+Ay_Q@mail.gmail.com>
        (Carlo Arenas's message of "Thu, 30 Apr 2020 19:24:14 -0700")
Message-ID: <xmqqees4p6mb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 707401AE-8B6C-11EA-BBF7-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> PS. should we really do the warn even in store/erase operations as a
> followup or is the warning not useful as is, and probably then all
> operations should be quiet (as Jonathan suggested originally?) and we
> could do warn (and maybe fix) in a different change (maybe adding a
> fsck command of sorts)?

Yeah, I think I like the "no warning, just ignore" much better.  The
implementation I suspect would become a lot simpler, right?

Thanks for thinking one extra step.
