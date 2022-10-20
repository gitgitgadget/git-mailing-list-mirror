Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266EEC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 17:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJTRnM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 13:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiJTRnL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 13:43:11 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C6D1E744B
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 10:43:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 719E014F521;
        Thu, 20 Oct 2022 13:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=84LYNfZLbwgy
        jiuQ0VF+VrgAQ1ZaZvtkYbrJ1sM7EUI=; b=tzrPH5TU4ghEOzZLOSIUNooAuKEu
        sdeVce0aghZzQFuzlDNxP5LiY9rZ9AJFOBrx8rGRs5Aprltkzz9IbW1AEummRI1u
        ix+ThZkrKstz1CaWPwo3X9Irso8bptmImlSI7JHl8AjrJbe4I07g3e9PRJ4oJKf/
        82vhre4jdYpJmls=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A30D14F51F;
        Thu, 20 Oct 2022 13:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6ED114F51E;
        Thu, 20 Oct 2022 13:43:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org, alexander.s.m@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v5 1/1] diff.c: When appropriate, use utf8_strwidth()
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
        <20220914151333.3309-1-tboegi@web.de> <xmqqpmfx52qj.fsf@gitster.g>
        <20220926184308.5oaaoopod36igq6i@tb-raspi4>
        <xmqq35bv1gu5.fsf@gitster.g>
        <20221020154608.jndql5sio3jyii3z@tb-raspi4>
Date:   Thu, 20 Oct 2022 10:43:07 -0700
In-Reply-To: <20221020154608.jndql5sio3jyii3z@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Thu, 20 Oct 2022 17:46:09
 +0200")
Message-ID: <xmqqy1tas85w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A9035700-509E-11ED-8862-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> What more is needed ?
> To fix all other bugs/issues/limitations in diff.c ?
> If yes, they need to go in separate commits anyway, or do I miss
> something ?

At least leave some NEEDSWORK comment in the code that is known to
need more work, to remind others that the fix in the area of the
code is not done, perhaps.  Otherwise, much of the effort in the
review gets lost.

I offhand recall at least two (please go back to the original thread
to find the details of them).  One that measures the width of
long/path/name in bytes to determine where to start chomping in the
diffstat filename (because it still mixes display columns and
bytes), and the other one that measures the width of leading graph
segment in bytes without ignoring the ANSI color sequence, which
should be using utf8_strnwidth() but is using strlen().

https://lore.kernel.org/git/xmqqpmfx52qj.fsf@gitster.g/

Thanks.
