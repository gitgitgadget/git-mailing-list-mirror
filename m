Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578CBC433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F34CA207E8
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IfWpu8z8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgFQUGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:06:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62528 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgFQUGR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 16:06:17 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD7E9E2DDF;
        Wed, 17 Jun 2020 16:06:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=yrTXas9kN360j1aGkdNF1tuFEEM=; b=IfWpu8z8qPVCyxAqPnr3
        WPr3qIJfQqQxOEQchNeeU759J2kgMyhmZn3ckGcGW5i1wAssO8D/BGKoE9y4vcGj
        7PKH7KY8x11MDvY8Z4aGzOUEOJFVhoq3y6ux4Z4WfHj1btV90wW/xG4ijW4TSgkP
        an35zqI7Vm9e+f9e7Bh79TA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=bQ6e39nIa7f/Er1s3Rajm2NtSBYr7WkTtIGKOO+ctgB0Rx
        akQr1twansxrpQSxwMEcDWJr/SR38Os/yH1v/xcEAg0noAaVkNuP8sCu6sLlm7ob
        T0DKF4ZfhYpOLUf3MRnVXW8hVkr0hPYeZKGtD20Drvd9jddvsBif1uNdU6vmE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D484CE2DDE;
        Wed, 17 Jun 2020 16:06:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 295A7E2DDB;
        Wed, 17 Jun 2020 16:06:13 -0400 (EDT)
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
Date:   Wed, 17 Jun 2020 13:06:11 -0700
Message-ID: <xmqqtuz9tq30.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE75780A-B0D5-11EA-974D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Yes, the trouble with `maint` did cross my mind, but I try not to
> "overfit" to git/git. :-)

I do not think it is overfitting; if the solution cannot even
support the originating project well, there is something wrong.

Most likely, I'd be tempted to rename it myself away from any name
that is too similar to 'maint'; perhaps to 'stable' (or 'devo', h/t
tla ;-).

