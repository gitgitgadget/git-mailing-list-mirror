Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1103C12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 16:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1B5611C1
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 16:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhGUQOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 12:14:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58958 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhGUQOE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 12:14:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 925DB14275F;
        Wed, 21 Jul 2021 12:54:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LqoqABbrrUwBGeHk2j2xCjtXRnojlVjuzyPfCE
        21q+k=; b=uhfJgu0VzNZZWMO42R4QkQoHxQRWEqS5QxNFA2G7ZdruSXNRn7K98p
        86GCfo0UoXt6sYqFUh+uu2M4LfRJ0jylMZ26CoYABnMBVd+b6cqLlFvqS4jvc4ZT
        aHT5JqplkZRdo+YajjgzanNa+E3S+ow8fftw0dioooz4XTagVrbKc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B94014275D;
        Wed, 21 Jul 2021 12:54:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D510214275B;
        Wed, 21 Jul 2021 12:54:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v3 6/6] commit-graph: show usage on "commit-graph
 [write|verify] garbage"
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
        <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
        <patch-6.6-5c1694e071e-20210720T113707Z-avarab@gmail.com>
        <20210720174739.GA2025@szeder.dev> <20210720175530.GA23408@szeder.dev>
        <YPcU3LSpa/r5nFCP@nand.local> <87lf60vfyn.fsf@evledraar.gmail.com>
        <YPdEeBGi3RVrB/fu@nand.local> <87im14unfd.fsf@evledraar.gmail.com>
        <YPfWA4uA6OTKeOd9@coredump.intra.peff.net>
Date:   Wed, 21 Jul 2021 09:54:36 -0700
In-Reply-To: <YPfWA4uA6OTKeOd9@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 21 Jul 2021 04:08:35 -0400")
Message-ID: <xmqqmtqfehf7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 558CFB92-EA44-11EB-A56D-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> But I think I've been losing that argument recently, e.g. after [1]
>> (which I argued we should put into git-ls-files) even things like git's
>> basic idea of the state of the index are exposed in some helpers, but
>> not corresponding plumbing.
>
> Yeah. I wish "ls-files --debug" showed more of the extension data, for
> example.

Let me second that ;-)  With extensions and even more drastic things
like sparse index entries, "pretend that the index is a flat list of
<mode, object, path>" is sometimes not useful in debugging (as bugs
and design mistakes might lie in the code that makes us pretend).

Even with packed objects, we still "pretetend that an object file is
a single line '<type> SP <len> NUL' followed by payload bytes,
deflated", as if packed objects do not exist.  I do not offhand
recall we have a good debugging option in the plumbing, or a
dedicated debugging tool, but because the format for packed objects
has been stable, we are probably OK.  Contrast to that, the index is
designed to be more ephemeral and its format is subject to change,
so we may in more need for a good debugging option.

> Yeah, I'd agree with that. The most valuable helpers to me are the ones
> that help us understand what Git is seeing, or what's in a binary file
> format. Obscure-case "functional" helpers are less likely to be
> generally useful.

Yup
