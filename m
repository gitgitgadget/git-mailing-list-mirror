Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A230EC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FF5F22210
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R0zDpS/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389207AbgJOQK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 12:10:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56397 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388461AbgJOQK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 12:10:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5DB4AF5F72;
        Thu, 15 Oct 2020 12:10:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=INHAuBjtVIFYDgIj7B7Gh1Es1as=; b=R0zDpS
        /bO3/PqvB+nFLCL2AQiAryA1r7kv9LiBmpeb37Bn/dELS8FGeVQH74PXkPLjMb2H
        3c/tn95VGkElkUaI3SmlMtdCqMved+aoUwDFAzQv5m91++/xLhxpxEhXzUMzBn/M
        JttQeHqYoYfomLj22cMNYTO9RlTSsFmjsQgQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pbUVcG+JSZZ4zi05OS0ih1oebMpMh/+G
        T8kDewVGDDp1lK7Q39v0AkLNIo7lXWeQ+UBRybvJ26aI5aukwr/e/HX1RIetCmaf
        bAcQJc4QzCrl8SoG9ff5fyG02ZP0kUicFb8h1WTOEZGgjEAqxgg9c/O9rjCts9Ps
        Tx+LatBM8jU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 56002F5F71;
        Thu, 15 Oct 2020 12:10:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A1575F5F70;
        Thu, 15 Oct 2020 12:10:21 -0400 (EDT)
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
        <CABPp-BEOrYhUBZ112Z7qFgwUYojmus6_Ra0G0Ts4y+n=-D5vMw@mail.gmail.com>
        <CAPc5daU+w2U_5FBrSYEVO5PB2sOV_fxvBQ1=51_=NMTZooZGmA@mail.gmail.com>
        <CABPp-BGBG=wh41BrvFZdzsN6biUPvuDkrA9EZURM4GKLx8kC0A@mail.gmail.com>
Date:   Thu, 15 Oct 2020 09:10:20 -0700
In-Reply-To: <CABPp-BGBG=wh41BrvFZdzsN6biUPvuDkrA9EZURM4GKLx8kC0A@mail.gmail.com>
        (Elijah Newren's message of "Wed, 14 Oct 2020 12:12:22 -0700")
Message-ID: <xmqq5z7bii6r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED1292A8-0F00-11EB-90E7-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Oct 14, 2020 at 10:57 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> > are you suggesting dropping the regex handling and limit it to
>> > substring matching?  In either case, does using expr save us anything
>> > (isn't expr a shell command)?
>>
>> I had something along this line in mind, not to do a regex but a glob.
>>
>> case "$title" in $selector) found=1 ;; esac
>
> Interesting.  Since it needs to handle substring searching (e.g.
> ./test-script.sh --run=setup,rename), I think this would need to be
> tweaked to be
>    case "$title" in *${selector}*) include=$positive ;; esac

Yup, of course we need to un-anchor with surrounding asterisks.
Thanks.
