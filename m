Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED69C433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 07:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9398464E85
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 07:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhBYHSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 02:18:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62377 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhBYHRb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 02:17:31 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8AEB49A911;
        Thu, 25 Feb 2021 02:16:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sdEH+yECPkqxEOs4/mVbIwD3CYM=; b=gFNIra
        tokqehkIJYBlpFsAEJ7Z6URAe5OtE7WZFngogNiIERTmV2dQ3x7HDcE3AfaHqaym
        q//OyOP6GISqXLT3DRjClefWEbr4jyxPbuoe9y/lCCJNrcmWGqnKqoXJCDR8Vw1v
        P3iz4DkskJ4Y6MY8VlhiYV9WtsSQ/yDIsck2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AAj4yVYDh3yi9QkUUrcEzByzaaPSLXIV
        HPJsjEH1glbslpHdAEUQL3Gz5bWbr0R0T3Ge//QfbcHtWhsSEGhpBzNMDHpqtqCW
        M2Cfb81+efY4KzvxAnUofXbusMBJ+FNp9zROUBoXXup6AobMjgzpaPE9HtUW/3Kw
        vWnmyGQ4cgg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 829689A910;
        Thu, 25 Feb 2021 02:16:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1302A9A90F;
        Thu, 25 Feb 2021 02:16:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Neeraj Singh <nksingh85@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git List <git@vger.kernel.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH] read-cache: make the index write buffer size 128K
References: <pull.877.git.1613616506949.gitgitgadget@gmail.com>
        <f52df30b-4ab0-fd6f-17f8-70daed81df39@jeffhostetler.com>
        <xmqqv9ana05b.fsf@gitster.g>
        <CANQDOdeEd=JjWL4gb5CWHL_HkvJMnFumW74ew4DXJahh4BKvfQ@mail.gmail.com>
        <xmqqo8gd8tyr.fsf@gitster.g>
        <CANQDOdfJApBOEm2gPMwtz9T0ETPoDk107mF7LYRGCmjFLi3Jxg@mail.gmail.com>
        <xmqqmtvswvp7.fsf@gitster.g>
        <CAPx1GvdA1prtO+y-bJ7yu8oZP6Lp9mHQ5gv-fXvS193NFospkA@mail.gmail.com>
Date:   Wed, 24 Feb 2021 23:16:42 -0800
In-Reply-To: <CAPx1GvdA1prtO+y-bJ7yu8oZP6Lp9mHQ5gv-fXvS193NFospkA@mail.gmail.com>
        (Chris Torek's message of "Wed, 24 Feb 2021 22:58:36 -0800")
Message-ID: <xmqqeeh4wrad.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6973378A-7739-11EB-945B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Torek <chris.torek@gmail.com> writes:

> Linux/BSD/etc `stat` system calls report st_blksize values to tell
> user code the optimal size for read and write calls.  Does Windows
> have one?  (It's not POSIX but is XSI.)
>
> (How *well* the OS reports `st_blksize` is another question
> entirely, but at least if the report says, say, 128k, and that's
> wrong, that's no longer Git's fault. :-) )
> ...
> 128K is correct for ZFS; 64K is typically correct for UFS2; 8K is
> the old UFS1 size.  Anything under that has been too small for
> a long time. :-)

That's rather tempting.  After opening a locked index to write
things out, the value is a single fstat() away...

