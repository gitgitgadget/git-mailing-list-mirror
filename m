Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7AFC433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41ACE2087C
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="c5iLgdxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgGaUZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:25:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59239 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgGaUZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 16:25:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3FCF7734A;
        Fri, 31 Jul 2020 16:25:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5Dt5ef5mfW7Seq7jMBSjnBFkLOI=; b=c5iLgd
        xGnN2qEEy8AiaPi5aPMcOPUVnqUw0sLKKEDddiznCc9kxHVnRl4B9d6BRK84+qb+
        pIcyEVwj3y7GFKR50ZWs3zOSDkJqY18tZOpPGLax0uWFJsvQ2VRUgDkw7L+uryas
        86loBn23lGD6o0u/oBj7hcn3ARe0xoRkI4vPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KgdFLahg0FV8DXrcugZQDbv4NLjHZAWW
        t7kgPZir+26NQ5PlLDbO4Ks8/+kqrYLsv/kJjbCK9jnMgwQ05ICqRzsHLTssnJKu
        F7iNtsBSVAFh2nlbu76JjjrrmCBL2moGWKhQ+hsqrhRg62ZebHRbUwh+NWrzSiO1
        JTa35vQ4Sjk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E4C3677349;
        Fri, 31 Jul 2020 16:25:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C4EA377348;
        Fri, 31 Jul 2020 16:25:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt Rogers <mattr94@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: Diff --stat for files that differ only in whitespace
References: <CAOjrSZtQPQ8Xxuz+7SGykR8Q-gFDEZANSE5yQASqKjpbUAq_5Q@mail.gmail.com>
        <20200731174149.GB843002@coredump.intra.peff.net>
        <CAOjrSZskJRj+TVV35fEp-Mhd+proVV72rh3vAcVFnNfhRy2ayA@mail.gmail.com>
Date:   Fri, 31 Jul 2020 13:25:03 -0700
In-Reply-To: <CAOjrSZskJRj+TVV35fEp-Mhd+proVV72rh3vAcVFnNfhRy2ayA@mail.gmail.com>
        (Matt Rogers's message of "Fri, 31 Jul 2020 15:26:16 -0400")
Message-ID: <xmqqeeor300w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EBBDA4EA-D36B-11EA-9C49-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt Rogers <mattr94@gmail.com> writes:

> On Fri, Jul 31, 2020 at 1:41 PM Jeff King <peff@peff.net> wrote:
>>
>> This seemed familiar, so I dug up some prior discussion here:
>>
>>   https://lore.kernel.org/git/1484704915.2096.16.camel@mattmccutchen.net/
>>
>> We didn't come to a resolution there, but there is a patch to play with,
>> and I think nobody was opposed to the notion that with the right
>> code change we could be suppressing these whitespace-only stat lines
>>
>> -Peff
>
>
> I think for now I'm going to feed --numstat into a script like Junio suggested.
> Out of curiosity what would it take to get that patch into git? Is it just a
> matter of someone just verifying it and submitting it?

After re-reading the thread, I think it takes a bit more than just
re-reading and testing, because even the author of the patch said
(and I think I still agree with the assessment) that the patch does
one thing that is not exactly what we want it to do.  So we'd need
to tweak it more to do what we want to do, I would suspect.
