Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7119EB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 14:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjGUOLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 10:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjGUOLF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 10:11:05 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C562737
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 07:10:56 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AEB9F2D772;
        Fri, 21 Jul 2023 10:10:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cycg+3eC9zkT
        fkk8iVHtskqUuhEETBf6kzEKyA6/rBk=; b=Bc6gceqnAOouVs8qH7g/zLYJAN7F
        csAvxuPlQCgp3uRSqcxuGoLF53qCbCTgsz372ITY+M5uKmIuGFZp26maqp025Sc1
        V2XSzxqtpOlbk15Nmar7OW1d3BQUpz59kA7GhN/3Zvummrlpjrd0BEowgLtSiwPP
        2NpJyi5OkDUWDhw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 930F22D771;
        Fri, 21 Jul 2023 10:10:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 115832D770;
        Fri, 21 Jul 2023 10:10:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: fix --no-exact-match
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
        <xmqqo7k9fa5x.fsf@gitster.g>
        <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de>
Date:   Fri, 21 Jul 2023 07:10:50 -0700
In-Reply-To: <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 21 Jul 2023 15:41:33 +0200")
Message-ID: <xmqqzg3pz76d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6677856E-27D0-11EE-AFAA-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Since 2c33f75754 (Teach git-describe --exact-match to avoid expensive
> tag searches, 2008-02-24) git describe accepts --no-exact-match, but it
> does the same as --exact-match, an alias for --candidates=3D0.  That's
> because it's defined using OPT_SET_INT with a value of 0, which sets 0
> when negated as well.
>
> Let --no-exact-match set the number of candidates to the default value
> instead.  Users that need a more specific lack of exactitude can specif=
y
> their preferred value using --candidates, as before.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Or should we just forbid --no-exact-match?

We could do that, but setting it back to the default was also what I
did in my version I sent (<xmqqy1jcgbiv.fsf@gitster.g>) a few days
ago.
