Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2641C2021E
	for <e@80x24.org>; Wed,  9 Nov 2016 22:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754752AbcKIW6l (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 17:58:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52222 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751919AbcKIW6k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 17:58:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38E474E4E4;
        Wed,  9 Nov 2016 17:58:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Bce44VKTRwTW4bMmpRISkxlYaqY=; b=mewEX7Ktj/GcxMONj9Ey
        B07YplUj6go0qHlb2vQPfjJG8oof9WQjUjaWIfZv7u1FTxVCSW4EYqg/jM3BYlN7
        hhqYLgHNY1yB7ev45WMHiZCTz9RZ/NvZ/fmJBLthz/PGrSSnM77HBTYt2YgVl3zm
        qlFcPyExQb7wIeZNazXGFgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=JfjPJFOC4ipmqTQhwjDX70gbrgFmPRvjEHZrZEP22WeYKg
        gll6es+3OXO2Hfsb2zKCL9xYw7qWMum09yVKMDbcwL9b0eVI7poytFKJO1499tyR
        CrcPpiiQbQTnvL7OCk8Yi24IT3DhBACF17b0wi8EaMBJeJhj1XLP15AKg/oC4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3059E4E4E3;
        Wed,  9 Nov 2016 17:58:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9CB9C4E4E0;
        Wed,  9 Nov 2016 17:58:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] attr: do not respect symlinks for in-tree .gitattributes
References: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
        <20161102130848.qpigt4hxpoyfjf7x@sigill.intra.peff.net>
        <CACsJy8AO2KtpxFu=wRjW1DoCA9bfpF1VoJUn__2ib-ML0XT66w@mail.gmail.com>
        <20161107211010.xo3243egggdgscou@sigill.intra.peff.net>
        <20161107211522.vzl4zpsu5cpembgc@sigill.intra.peff.net>
        <CACsJy8BoEXDjwe=ZX5ZOC_mvaMjYrB3i7wcMmiOP3mm5-rwC5Q@mail.gmail.com>
Date:   Wed, 09 Nov 2016 14:58:37 -0800
Message-ID: <xmqqmvh88dlu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D38BDB6-A6D0-11E6-97ED-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Let's err on the safe side and disable symlinks to outside repo by
> default (or even all symlinks on .gitattributes and .gitignore as the
> first step)
>
> What I learned from my changes in .gitignore is, if we have not
> forbidden something, people likely find some creative use for it.

Yup.  Supporting any symlink in-tree is like requiring Git to be
used only on symlink-capable filesystems.  Not allowing it sounds
like a very sensible option and unlike true contents, there is no
downside to give that limitation to things like .git<anything>.

Shouldn't we do the same for .gitmodules while we are at it?

