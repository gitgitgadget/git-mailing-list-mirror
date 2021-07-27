Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23233C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 02:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0EFB60FA0
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 02:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbhG0Bk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 21:40:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51655 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhG0Bk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 21:40:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B9DA8139C39;
        Mon, 26 Jul 2021 22:20:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HIkLxGPAkt+ZJ2ITnZfOAtodPTqMK/4ftISfo5
        N2Tz8=; b=NCWjJVGOKBFKNctsX3VYTz2K79LB3u3i/AqE6wpuCULthqIU+Yv9UA
        yE7/Ks7i1BWTEHLvzaEyepFjUamQjgt+mxMyqiJwTv9jXu1CpyAmrMMrQDjEIDuZ
        J4PLwM4vKmtneYPF9iHmjeE1GTd1J5bT+7nyXARlY8v+yPPMrcr0U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B2618139C37;
        Mon, 26 Jul 2021 22:20:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 029A9139C36;
        Mon, 26 Jul 2021 22:20:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Evan Miller <emmiller@gmail.com>, git@vger.kernel.org
Subject: Re: Exit code 255 after large clone (32-bit PowerPC)
References: <D3C1583B-8CC8-434B-8AF5-B9827A7FD037@gmail.com>
        <YP8ykvsZie4mPE5o@camp.crustytoothpaste.net>
        <874kcgsh94.fsf@evledraar.gmail.com>
        <YP9jU194U7S1PFxS@camp.crustytoothpaste.net>
Date:   Mon, 26 Jul 2021 19:20:52 -0700
In-Reply-To: <YP9jU194U7S1PFxS@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Tue, 27 Jul 2021 01:37:23 +0000")
Message-ID: <xmqq8s1sfqez.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44F8C2A2-EE81-11EB-8592-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> That message comes from OpenSSH.  I've seen it quite frequently in
> various other (non-Git) cases.  I think it's fair for us to exit
> unsuccessfully if OpenSSH exits unsuccessfully in this case.  For
> example, an attacker could try to tamper with the connection and send
> additional data, which OpenSSH would detect and exit unsuccessfully for.
> We also in general need to detect truncation attacks, which OpenSSH will
> do for us here.
>
> It's possible that if there's an older version of OpenSSH being used,
> that the problem happens to be related to a bug of some sort.  There
> were some versions which had various bugs that could be triggered by a
> rekey, which, if the threshold is set low enough, could be the cause of
> this particular problem.
>
> I think the fact that it's not being seen with HTTPS is the ultimate
> clue here.

This suspiously sounds familiar.  Asking for "close ssh connection"
in the lore.kernel.org archive finds this:

  https://lore.kernel.org/git/YKTg8nYjSGpKbq8W@coredump.intra.peff.net/

