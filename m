Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FABBC54E49
	for <git@archiver.kernel.org>; Sat,  9 May 2020 20:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B51020A8B
	for <git@archiver.kernel.org>; Sat,  9 May 2020 20:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hfj48SKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgEIU15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 16:27:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55591 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgEIU14 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 16:27:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ABBC8B8B90;
        Sat,  9 May 2020 16:27:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+BJF23+PuwHA
        Tv4egUGkjUTHADw=; b=Hfj48SKLqpE7Xlw0VRGU0nuCnWX9p51yABKcH/3NPHpt
        QkcxSLg994GszvXn+lvnGvzCvLPfiUThxXPKCT3nehxNwhWCZaApt4qeW1ZB4+Vq
        W9qnsrbuNINoNXvj2KdsRt8apgEfS+rEpeldBEQp7kCFNLk/xMv1R2gEnzFAz3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nW+rhI
        /1/O7W0NKp3zLtK/UjLl+APK5Ab1w4k7FWOXHDCj8pt+wIWycNAQrd9s3CJO8hfa
        lURI2X/u0t7p0sOsU4/Qs59Nrotll9n+LS+cXLbzAkFyyS8dEOYyGFMfQhjg5tUQ
        ulBpYUF1ltDOn85an1mAaXz5OThUHBd7aI9Rk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A37EBB8B8F;
        Sat,  9 May 2020 16:27:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EC5EBB8B8E;
        Sat,  9 May 2020 16:27:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Brandon Williams <bwilliamseng@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: invalid tree and commit object
References: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
        <d963242a-72f3-7f42-7c95-ea5148f74804@web.de>
        <xmqqpnbduiec.fsf@gitster.c.googlers.com>
        <938f0818-7e57-b883-009f-01db88ef8f65@web.de>
Date:   Sat, 09 May 2020 13:27:50 -0700
In-Reply-To: <938f0818-7e57-b883-009f-01db88ef8f65@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 9 May 2020 21:24:43 +0200")
Message-ID: <xmqqh7wovoop.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8E7DC022-9233-11EA-8307-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Hmm, this could lead to quadratic behavior in the worst case, can't it?

Oh, absolutely.  But as you have shown, you'd need a specially
crafted tree with early entries that are prefixes of later ones,
which would rather be rare, and most of the time the bottom pointer
would advance by one every time we consume one path. =20

So it is trading (hopefully rare) worst-case runtime with reduced
storage cost.

> We could, however, reduce the names we add to the string_list to
> those that are possible candidates for conflict -- blobs followed by an
> entry whose name starts with the blob name followed by a dot and trees
> that follow an entry whose name matches in the same way.

Yes, that is a valid solution that strikes a different balance
between allocation and runtime.

We may want to survey how commonly "bad" trees appear in real
projects.  Depending on the result, we might want to update the
"limit re-scanning using the bottom pointer" hack we have been using
in the unpack-trees code.

Thanks.
