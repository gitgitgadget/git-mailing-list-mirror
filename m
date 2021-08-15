Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72985C4338F
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 18:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44B696112D
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 18:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhHOSAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 14:00:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59494 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhHOR7y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Aug 2021 13:59:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6ABAE1456E5;
        Sun, 15 Aug 2021 13:59:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kOM921C2Fr0OayNOgHmIaif4CetEdRPM6FaphY
        ZasAU=; b=Uy6044FRhMN1Gj7Eacf7cYo1ViivByrYJNIuKWveRWKjb8mCD0T5RJ
        F6Tw6DTiJSqYxpUUW5TZ15hw7soCQNHp5B4KYXuYDyDQEAuNsv9LMX8dpwqNfVzY
        uWyFjihfx2UCHMbjxGWLwdiecqlzdSkoqcWTMpf8d5WWBxISk/rgg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5680E1456E3;
        Sun, 15 Aug 2021 13:59:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 91E9A1456E2;
        Sun, 15 Aug 2021 13:59:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Kim Altintop <kim@eagain.st>, git@vger.kernel.org,
        jonathantanmy@google.com, bwilliams.eng@gmail.com,
        jrnieder@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v6 0/3] upload-pack: treat want-ref relative to namespace
References: <20210730135845.633234-1-kim@eagain.st>
        <20210731203415.618641-1-kim@eagain.st>
        <20210804203829.661565-1-kim@eagain.st>
        <20210804205951.668140-1-kim@eagain.st>
        <20210809175530.75326-1-kim@eagain.st>
        <20210813062237.10403-1-kim@eagain.st>
        <nycvar.QRO.7.76.6.2108142344570.59@tvgsbejvaqbjf.bet>
Date:   Sun, 15 Aug 2021 10:59:19 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2108142344570.59@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sat, 14 Aug 2021 23:46:49 +0200 (CEST)")
Message-ID: <xmqqeeausi6g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84C1F996-FDF2-11EB-9626-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> My only comment is that I would find the diff to `upload-pack.c` much
> easier to parse if the `arg` variable hadn't been renamed.

If we only look at the patch text, perhaps.

What is left in the resulting file is what people will be reading in
the coming years, and because instead of just one string (whose name
did not matter and a short-and-sweet arg was a perfect name for it),
we now have to deal with two strings (one is the full and real name,
and the other is the name without namespace prefix) we need to be
clear which is which, the rename is an essential part of the patch
to keep the result easier to understand.

When I apply a patch to my tree to review it (e-mailed patch review
is merely an efficient way to transmit the change---I do not expect
that I can always review all non-trivial patches without stepping
out of my MUA).  My review, after noticing typos, style glitches and
design issues, of code and its correctness will begin after that.

"git show" can be driven with different options and in some cases
use of certaion options helps seeing what is going on quite well.
"--diff-algorithm" shifts which preimage lines match which postimage
lines and sometimes helps reduce the clutter greatly. "--word-diff"
is a great tool to see where in reflowed documentation patch actual
changes are. "--color-moved" lets reviewer skip pure code movement,
various options to "ignore space" sometimes helps declutter the
patch. etc.

I wonder if we already have an option (or if there isn't, if we can
design such a new option cleanly), that would help in this case.
Essentially, what you want is an "I know what used to be arg is
renamed to refname_nons in this patch; take advantage of that
knowledge and show a diff that is less cluttered" option.

Thanks for a comment, anyway.
