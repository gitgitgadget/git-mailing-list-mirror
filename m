Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA666C43457
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 15:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2EA21D41
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 15:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LF097IsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388357AbgJOP70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 11:59:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59673 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730085AbgJOP70 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 11:59:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A6BB487D63;
        Thu, 15 Oct 2020 11:59:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qhFvw2GU1khKG6RYgxihPPKSRu4=; b=LF097I
        sFXFYjcJnWL6KSH8lvj+FAO2NnEKU6ZP5Wt1NrBo6+/6W6p87Iu99hmXIzJMB12S
        df8edBBv5MqUI/JCrhWzelyqMz95pPLvgH5Ld/JjLdWw58IdBHmPNCkhYcE5CJkB
        /HZgMMW2E//QH7L7ges75GLdUeUFi5idWKmJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xY4TnmhXyzzrlQxDLQE+O+P5+7EJStsc
        d+yXrq8QAL8b0zWgUxwHDcxkHeXs6jwa2ytZ4b5tY8fmdAph4ynPk6nzXORkxCo/
        4uBQEo2g0jzPh6nwsfiOVmAKnA3emksrBHFTbq9Tw3mnQO7KO/fkGsEqF+nte/xR
        WwvEZmCfD08=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DB2A87D62;
        Thu, 15 Oct 2020 11:59:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C95287D61;
        Thu, 15 Oct 2020 11:59:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/3] test-lib: allow selecting tests by
 substring/regex with --run
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
        <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
        <41e2528e83ba7087c9d21f0b15efed416f1512f8.1602616786.git.gitgitgadget@gmail.com>
        <20201014170413.GB21687@coredump.intra.peff.net>
        <CAPc5daVa4j5mDvTzCFCX2bLr1qVFLO=P=nSakT+mDG1kqeXa+g@mail.gmail.com>
        <20201014180707.GB24279@coredump.intra.peff.net>
        <CAPc5daU_aw=yWPKHG1XGt4X5A1AkEXeLfCmHqqVfZ+FzBD7nxg@mail.gmail.com>
        <CABPp-BE0_u=TAJKUGUTLrZbg8vk2MFYmfscT_+MgYwAS2rV8Aw@mail.gmail.com>
Date:   Thu, 15 Oct 2020 08:59:21 -0700
In-Reply-To: <CABPp-BE0_u=TAJKUGUTLrZbg8vk2MFYmfscT_+MgYwAS2rV8Aw@mail.gmail.com>
        (Elijah Newren's message of "Wed, 14 Oct 2020 12:41:00 -0700")
Message-ID: <xmqqeelziip2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63EA7DD4-0EFF-11EB-8972-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Oct 14, 2020 at 12:24 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> > > If you define the pattern is not regexp but is glob, you can use
>> > > case/esac to do this without any forking.
>> >
>> > Yes, that would probably be OK for most purposes, though I admit my real
>> > love for regex support is the ability to use "." instead of space to
>> > avoid quoting arguments. ;)
>>
>> I use "?" for the same purpose for globs. For things that are casual,
>> I find that
>> it tends to make the end-user (read: my) experience simpler to use globs than
>> to use regexp, largely for your ".*" vs "*" reasons.
>
> Oh, I thought you were arguing for globs over regexes here just due to
> performance reasons.

Heh, but no, not me.

You and Peff were the ones who were talking about performance by
counting forks.  I more often than others come from usability's
point of view.  When we are not dealing with uncontrollable and
unbounded possiblity of end-user generated contents, I find it
easier to forego the power and flexibility of regexp and instead
settle on simpler globs---matching against the test titles is a
good example use case, I would imagine.

But if we are exposing regexp to those who run and debug test
scripts already, I am perfectly fine with using regexp with 'expr'.

Thanks.


