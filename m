Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3509C43461
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 22:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0E4A610FB
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 22:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbhDOWYr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 18:24:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58831 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbhDOWYa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 18:24:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AA17C846B;
        Thu, 15 Apr 2021 18:24:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=c95riAWBY+ZL
        weKG7lty2LRs/sA=; b=WAmDv4Re92BTHCSqrf2T/+CY/3cuBx3IhM+Wgb6Dym12
        TJZsUfjF/7mkKkBSumaidrvzTv4DOjUqNPbAx9lvMlG2RDkq22hsI8x6uOEq2m6f
        CYTPLs/6rWdA6ueFr3r8LY0UceVDrsCa+bQ86NoIzlM4YTA6zDsdlT8WPpbmDJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SHux0m
        BQ2ve2KOIbMH+X79NQ4Bf+EBJ3j+JP2xTcn3GtMcafmuDf/bD13sh/4S+r3F36xv
        die4bwBoAKWJVso7E53r8TZGjur67koxfpto9wumFC2TnXeXUSgNhAxR1BxympkQ
        nP1IMbTuh6Mjpol4vvC5fiXW7B0EfcgqHHj54=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E72AC846A;
        Thu, 15 Apr 2021 18:24:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 96701C8468;
        Thu, 15 Apr 2021 18:24:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 15/16] Revert and amend "test-lib-functions: assert
 correct parameter count"
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
        <patch-15.16-0cd511206c4-20210412T110456Z-avarab@gmail.com>
        <20210415220526.GO2947267@szeder.dev>
Date:   Thu, 15 Apr 2021 15:24:04 -0700
In-Reply-To: <20210415220526.GO2947267@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message
        of "Fri, 16 Apr 2021 00:05:26 +0200")
Message-ID: <xmqqfszrnq4b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 49F9D2FC-9E39-11EB-B302-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> ...  suppress '-x' output
> from test helper functions, and then this issue will become moot
> anyway.

That is certainly a better approach than tweaking each call site of
BUG.

The interface to BUG is "write a code to determine condition and
then die by calling BUG", which means under '-x' you are bound to
see the trace from "code to determine condition" part.

I wonder if introducing a BUG_ON helper function that

 - turns off '-x' trace upon entry;
 - takes a condition as one of its arguments and evals it;
 - issues a message and dies if needed;
 - otherwise arranges to turn '-x' trace on and return.

would solve it well?

Thanks.
