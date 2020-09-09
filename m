Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F650C433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 20:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBFD21D7D
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 20:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="b735bKqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgIIUGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:06:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51614 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIIUGM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 16:06:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B761F8B49C;
        Wed,  9 Sep 2020 16:06:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fkAbrBfX2jR8
        tRQD2l74nJC2ZBM=; b=b735bKqydwLNtOhkundvwfalB5D4EZMwKsBz5Yp2Y9TH
        eBM1t/mYPlsyUsBsKZX4afDKbR77D1KEYjMC8BohBaUfyCpMFpkPurqPuc1R6c0E
        JHIGOHeoEKbG5rz7fBg1rUinAxB4amKcMBhLHKc3L/Tk/Vl1978NErRS5P5deV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=XUv/sG
        tfxyRMI6HOW9sk9yasNA/7qnyg9Ab7u3Yf0R900ukE1jXu0cJBt7rT1qB0bZ8Na2
        kS8FRWb2obyq6SFDlmsS7Pwax4yceYNTf9CBseXg6zjFWmoLZdo3nlorWWyi12CF
        trj0DaISc3IoxvavW70hkr7Ve7dzUQL+OsPzU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD3C08B49B;
        Wed,  9 Sep 2020 16:06:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 26DE08B49A;
        Wed,  9 Sep 2020 16:06:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        whydoubt@gmail.com, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] blame.c: replace instance of !oidcmp for oideq
References: <20200907171639.766547-1-eantoranz@gmail.com>
        <ce94b41f-e829-d7ca-a5f5-e41748caea81@gmail.com>
        <20200909091149.GB2496536@coredump.intra.peff.net>
        <CAOc6etZS3mGxsPPh25XFi2-qR0TNzq0Gx1NrydgQwmHbsjxejA@mail.gmail.com>
        <20200909191345.GA2511547@coredump.intra.peff.net>
        <20200909191746.GA2514794@coredump.intra.peff.net>
Date:   Wed, 09 Sep 2020 13:06:09 -0700
In-Reply-To: <20200909191746.GA2514794@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 9 Sep 2020 15:17:46 -0400")
Message-ID: <xmqq5z8mvhou.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E75D9E7E-F2D7-11EA-A0A9-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>  @@
> -struct object_id *OIDPTR1;
> -struct object_id *OIDPTR2;
> +expression OIDPTR1;
> +expression OIDPTR2;
>  @@
>  - oidcmp(OIDPTR1, OIDPTR2) =3D=3D 0
>  + oideq(OIDPTR1, OIDPTR2)
> @@ -71,8 +71,8 @@ expression E1, E2;
>    ...>}
> =20
>  @@
> -struct object_id *OIDPTR1;
> -struct object_id *OIDPTR2;
> +expression *OIDPTR1;
> +expression *OIDPTR2;
>  @@
>  - oidcmp(OIDPTR1, OIDPTR2) !=3D 0
>  + !oideq(OIDPTR1, OIDPTR2)

With an extra insight from the counter-example R=C3=A9ne pointed out in
your message, I think the above two are safe but all the others are
unsafe.

