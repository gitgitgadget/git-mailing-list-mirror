Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CBFC4743D
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 07:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73CBB61364
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 07:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhFKHQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 03:16:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60172 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhFKHQk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 03:16:40 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 465F3134CF2;
        Fri, 11 Jun 2021 03:14:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+/ZIHk7vjPyRhYX45Ds7n0WA+qskWVIOsyVVC9
        j1GHU=; b=abfVxSSUAvL5IAa33pTkWy0otDKxForFYzm8J47iqSY9p7rr8313Fr
        nevj/vgIzmRNaj6oFlkWVLlQe8rQ/u5dIQcW/oVCysPDrqhQa6wPIDaucjtnmWTy
        jUXy1V/C8T5GEI0XCionH3fuW4ZwD/v6kDNmOI2CXE0BE4Tr+ajAU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 30818134CF1;
        Fri, 11 Jun 2021 03:14:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 636A4134CF0;
        Fri, 11 Jun 2021 03:14:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
        <20210609192842.696646-8-felipe.contreras@gmail.com>
        <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
        <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net>
        <xmqqh7i5ci3t.fsf@gitster.g>
        <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org>
        <xmqqy2bg3nqw.fsf@gitster.g>
        <07ef3a3b-4812-4fa1-c60c-b9085a268bc3@kdbg.org>
Date:   Fri, 11 Jun 2021 16:14:37 +0900
In-Reply-To: <07ef3a3b-4812-4fa1-c60c-b9085a268bc3@kdbg.org> (Johannes Sixt's
        message of "Fri, 11 Jun 2021 09:02:54 +0200")
Message-ID: <xmqqo8cc3maq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF86932C-CA84-11EB-A369-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> The case that inner conflicts are presented sub-optimally under diff3
> remains, though.

I agree that until that happens (necessary but not sufficient
condition), it is premature to recommend diff3 style to be the
default.

I notice that "git merge --help" tells what each part separated by
conflict markers mean in both output styles, but does not make a
specific recommendation as to which one to use in what situation,
and it might benefit a few additional sentences to help readers
based on what you said, i.e. the "RCS merge" style that hides the
original is succinct and easier to work with when you are familiar
with what both sides did, while a more verbose "diff3" style helps
when you are unfamiliar with what one side (or both sides) did.
