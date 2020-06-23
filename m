Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD6EC433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC36207E8
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DqNjEk0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390822AbgFWVcs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:32:48 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64853 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388979AbgFWVcn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 17:32:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 82869D0E17;
        Tue, 23 Jun 2020 17:32:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eq2Le0SJt1K7b86MdRPxUZtGTmI=; b=DqNjEk
        0sZ+9zvExWL172zBCnp+L1CnxSdVRJPgN0IklVT+neLR2gchrXwhV4Lh4zf0ZGTY
        gIxoHrb1cYMl+SjJ9ZPwKHo6onkiiwkEJNAfCIgCJf/Y+UuxTsDXaQrmpeJ87BQ1
        x9yJ3WqiYc9anf9SnZGsBR86lPgEJYFiW2Bm8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SjBrV2Md0pcXRyPGYZlHxtx2pz9mXap+
        BCw5N0ZCtvfFwJA395zx+5iYpMJf+4pq9a/XlBAIQvLiJWiABEKOd9nhCt/EJ88x
        P+FE/NCBJAeQspHidQ4h5NxRlLSF+pvNOjRtHfDphQOLNqe/0ONwFPcm49Qcul5N
        cniRJfd5hOA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 79DFFD0E16;
        Tue, 23 Jun 2020 17:32:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BF8E9D0E15;
        Tue, 23 Jun 2020 17:32:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, Matt Rogers <mattr94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com, Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH 8/9] fast-export: respect the possibly-overridden default branch name
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com>
        <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com>
        <20200610233912.GU6569@camp.crustytoothpaste.net>
        <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com>
        <xmqq3672cgw8.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet>
        <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006121451100.56@tvgsbejvaqbjf.bet>
        <xmqqy2os2u55.fsf@gitster.c.googlers.com>
        <405521ec-aed7-ff76-5b48-70e9d11018e6@kdbg.org>
        <xmqqv9jvylt7.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006131645380.56@tvgsbejvaqbjf.bet>
        <xmqqeeqiztpq.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006141053170.56@tvgsbejvaqbjf.bet>
        <xmqqtuz9tq30.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006232309190.54@tvgsbejvaqbjf.bet>
Date:   Tue, 23 Jun 2020 14:32:37 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2006232309190.54@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 23 Jun 2020 23:11:10 +0200 (CEST)")
Message-ID: <xmqqpn9pbh8q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0FCE8660-B599-11EA-A9CB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> You could also use `next` instead of `master`, which would make intuitive
> sense because the commits that make it into that branch are slated to be
> part of the next major Git version.
>
> And a relatively obvious name for the current `next` might be `cooking`.
>
> I refrained from proposing this earlier, thinking that this would be too
> disruptive, but since `pu` was renamed to `seen`...

Renaming 'pu' away from two-letter has a positive technical and
social effect.  Using 'next' for anything but what it currently
means does not have any such upside and only the downside of
confusing people.

As to 'cooking', I am not sure.  Personally I consider that the
topics that are in 'next' plus those that are soon to be in 'next'
are all 'cooking'.  But I do not think anybody's dying to rename
'next', so...


