Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905C0C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 18:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC4E611F1
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 18:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbhGLSuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 14:50:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59399 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhGLSuO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 14:50:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13BD2CBEBF;
        Mon, 12 Jul 2021 14:47:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7MubPbh+yEe02g5M9pYnhO2klq6LtmdUZAdBdO
        ok5uo=; b=j/bwYkY46Z6teS/85sW/ox05RdbpvZAaZRnagyvcpHBm4kOurAwrxj
        XdhneUODIgdcsSPfKAtOn4a2oqXcwe2TseEqva/tlC4JLyteCirQFpdzLG3QuFHo
        HXvL4ZoU4kcSQtrpr3bdcAJLQtYTXXyEqXeaSt+8gLoyb9rcVqEXs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AE34CBEBE;
        Mon, 12 Jul 2021 14:47:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 86B3FCBEBD;
        Mon, 12 Jul 2021 14:47:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] revision: allow pseudo options after --end-of-options
References: <20210708150316.10855-1-worldhello.net@gmail.com>
        <YOcvaFL7+6qcIOUa@camp.crustytoothpaste.net>
        <CANYiYbGYzbMoU_2wb4duppASoYUjGLsJsr692Xe3GaVBOXUsBA@mail.gmail.com>
        <YOoXCJV2ssef/KsN@camp.crustytoothpaste.net>
        <YOyByjmGu1oDXK4X@coredump.intra.peff.net>
Date:   Mon, 12 Jul 2021 11:47:23 -0700
In-Reply-To: <YOyByjmGu1oDXK4X@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 12 Jul 2021 13:54:18 -0400")
Message-ID: <xmqqim1f5pz8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99167988-E341-11EB-91BE-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't think fully-qualifying refs is a complete solution, though. The
> common use case for --end-of-options is that you're passing along names
> from somewhere else, and you don't know how to qualify them. E.g., in:
>
>   git rev-list --end-of-options "$rev" --
>
> you need to behave differently if you got "1234abcd" versus "foo" versus
> "refs/heads/foo".

I suspect that you can prefix "^^" unconditionally, just like --not
can be emulated away by unconditionally prefixing "^".

> For --not, I do think using "^" is a complete solution. It's a little
> more work for the caller to prepend to each argument, but there's no
> policy logic they have to implement.
