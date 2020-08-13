Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A613C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 17:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C45DA2078D
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 17:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QfWQloK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgHMRzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:55:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53405 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgHMRzh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 13:55:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AC1BBDFD8C;
        Thu, 13 Aug 2020 13:55:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hixGpTi397gRzB5en5VjAYgQyQM=; b=QfWQlo
        K7JwnQSPl+EeUkU0LjwX446pJSAuBakrs3CfN2fFx1BGptwFIThGXJ+SQSjKpw9A
        6ZgppilSgnTydNH/bOWwgM+c0gdW1zoqUZ1IkLYSQXUpBZBoSLad612ls8N+7EEX
        hEZW4qH0QX8FFmozw9E6BdYaCKQBGfDhOc9lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K2Na155dBriF4qsTmzk49dsIsDfpZ+K+
        56gfG8MXz2ectI2xlV13ORy9Ln8QXSw2LHFPIovMjqLAmAzIsk3I6X2UOVANxpZw
        6r+P6WHRzxG7slZwUe6bJ9UfCWALe4RBh7aNnYpq4U+w+KL+xiINt2AWZ4fSekPc
        Gr5QItdBKdo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A42ACDFD8A;
        Thu, 13 Aug 2020 13:55:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F008DDFD89;
        Thu, 13 Aug 2020 13:55:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/5] make credential helpers builtins
References: <20200813145515.GA891139@coredump.intra.peff.net>
        <20200813145855.GB891370@coredump.intra.peff.net>
        <20200813150839.GB2244@syl.lan>
        <20200813151410.GA892741@coredump.intra.peff.net>
Date:   Thu, 13 Aug 2020 10:55:30 -0700
In-Reply-To: <20200813151410.GA892741@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 13 Aug 2020 11:14:10 -0400")
Message-ID: <xmqqv9hm2zxp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EE36DAA-DD8E-11EA-8346-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Aug 13, 2020 at 11:08:39AM -0400, Taylor Blau wrote:
>
>> On Thu, Aug 13, 2020 at 10:58:55AM -0400, Jeff King wrote:
>> > There's no real reason for credential helpers to be separate binaries. I
>> > did them this way originally under the notion that helper don't _need_
>> > to be part of Git, and so can be built totally separately (and indeed,
>> > the ones in contrib/credential are). But the ones in our main Makefile
>> > build on libgit.a, and the resulting binaries are reasonably large.
>> 
>> Could you clarify which helpers you mean here? Git's own
>> credential-cache and store make sense to convert, but the helpers in
>> contrib definitely don't.
>> 
>> For what it's worth, I'm almost positive that you mean the in-tree
>> helpers (where in-tree means "in git.git but not in contrib"), in which
>> case I'm in favor of this direcftion.
>
> Yes, I mean the helpers in the Makefile that we build and install by
> default with a regular "make".

Makes sense, especially because none of the in-tree ones need to
link with any extra dependency at runtime, we do not even have to
debate if dynamic linkage overhead still matters ;-)
