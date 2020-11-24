Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF494C56202
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 02:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED8920708
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 02:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vWsMI5r8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgKXCSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 21:18:47 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50394 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgKXCSq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 21:18:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EE0C810B76A;
        Mon, 23 Nov 2020 21:18:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=prl3CiaiK7cG4igmL1VJNwEdn0Y=; b=vWsMI5
        r8R2Si3YmI1YGOIBMFHlf7Iie4Xgrr/UMt0vMWxCOr3Uq18dvI1ygZ3XnOgJwX8F
        EPOykJeWjkEEvAHzyrNQD7L718fRsHIh9J1A1KL91eLtrgX0+mVdv59RG3ocOSVo
        K7BQTYkpdg87+U/GwrM9Tsftfh4NJI0SghpMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q52PAanNAIVNwYTY9GjRkQOL/iVD+IHV
        T7mrTRKoTr5lmY9PSXTU4FUq3v3/28m71ugWtVaYsgga9Bllpi1ozaQ5pMUN1q1m
        Kp6Et0nlh/3gZoGuv+5o0Z5WlTkKCdQdSlrAa7XhfvPYITpp93+NOz+YP3bc1Zk7
        WmfDdhcDCZQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E5FB210B769;
        Mon, 23 Nov 2020 21:18:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3798C10B767;
        Mon, 23 Nov 2020 21:18:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alex Henrie <alexhenrie24@gmail.com>,
        =?utf-8?Q?V?= =?utf-8?Q?=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Pick the right default and stop warn on `git pull`
References: <742df4c2-2bc5-8a4b-8de1-cd5e48718398@redhat.com>
        <CAMMLpeRLsE=zNDjCRKmEMFxJBYcnTOdDGxEL9cZuVhuDMF=sLg@mail.gmail.com>
        <20201123191355.GA132317@mit.edu>
        <CAMP44s3cKVxKa0gOPfi3XRKbGbV=DweFE5pL0HM+v0kECFyPWA@mail.gmail.com>
        <20201123202003.GB132317@mit.edu>
        <CAMP44s27oEjScrJjeDVoNcWcvRsn173L_Kx+TOPfchOwge9zUQ@mail.gmail.com>
        <X7wuMvHRURK1QS/Q@coredump.intra.peff.net>
        <CAMP44s0QOcMnYQqFFSE1jV_T6=e4=xTM0zr_06C6+aYb7oqb4A@mail.gmail.com>
        <X7xWSs3/vVqKl6sK@coredump.intra.peff.net>
        <CAMP44s1Z4tDXO4jstGMtYVOYzkQQnZMHp45pYPOimk+=jwFHcw@mail.gmail.com>
        <X7xgow4pchnhf2iY@coredump.intra.peff.net>
Date:   Mon, 23 Nov 2020 18:18:40 -0800
In-Reply-To: <X7xgow4pchnhf2iY@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 23 Nov 2020 20:23:47 -0500")
Message-ID: <xmqqy2irjy4f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F3792C0-2DFB-11EB-9903-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Ah, that's what I was missing. I agree it would be nice for it to behave
> consistently in both cases (though why one would set both pull.ff=only
> and pull.rebase=true, I don't know).

So an obvious thing we could do, if pull.mode is too much of a
change, is to make "pull --rebase" codepath honor pull.ff as well,
perhaps?  I.e. those who set pull.ff=only are saying that "please
stop me when I have any local change---I want to be notified if my
pull on this branch results in anything but a fast-forward from the
upstream".

And then making an unconfigured pull.ff to default to pull.ff=only
may give a proper failure whether you merge or rebase.  I dunno.
