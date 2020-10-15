Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E08C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 20:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB7E42073A
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 20:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ECAnor6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388856AbgJOUIa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 16:08:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63780 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729327AbgJOUIa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 16:08:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C77D6F4A6A;
        Thu, 15 Oct 2020 16:08:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=40J81x5kSPDviE0jCGXcQ0ttEP4=; b=ECAnor
        6WUkRdY1MzJ5WdhO5vvLVwFGgtm/SRoFAibZiryoRXyeNILyonWNNl6vAkK4dzQ0
        PBs7kgc0gX3jreV/RgUciDyNioitLLuA8BvX0hcQruMQhbiW2LAZSNT2kxUhp7KF
        KdFabi4P+VM96S06GlETjM9gbkOFnGIVRPp+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jujvCVwZpO6MLlqNnOm1f+CAgnyuul1A
        Mc9kSc2N54PtnMcqxMLUi0Mop6aBLpsbtm7FwDf1ujXoU3tPfDQ3U8C7usxfae3r
        ZMeD0TfCtSCsnqHAP/XKZpHLqWdKF+dJBJVqNeRDgi5IdAGjDMK5PmleMRbBERhm
        etCFEfssj2E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF8CFF4A69;
        Thu, 15 Oct 2020 16:08:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0CEE2F4A68;
        Thu, 15 Oct 2020 16:08:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/3] test-lib: allow selecting tests by
 substring/regex with --run
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
        <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
        <41e2528e83ba7087c9d21f0b15efed416f1512f8.1602616786.git.gitgitgadget@gmail.com>
        <20201014170413.GB21687@coredump.intra.peff.net>
        <xmqq1rhzihqa.fsf@gitster.c.googlers.com>
        <20201015194648.GB1490964@coredump.intra.peff.net>
Date:   Thu, 15 Oct 2020 13:08:22 -0700
In-Reply-To: <20201015194648.GB1490964@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 15 Oct 2020 15:46:48 -0400")
Message-ID: <xmqq7drrfe15.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E0ACED0-0F22-11EB-9FEB-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Oct 15, 2020 at 09:20:13AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > On Tue, Oct 13, 2020 at 07:19:44PM +0000, Elijah Newren via GitGitGadget wrote:
>> >
>> >> Many of our test scripts have several "setup" tests.  It's a lot easier
>> >> to say
>> >> 
>> >>    ./t0050-filesystem.sh --run=setup,9
>> >
>> > I like this direction very well.
>> >
>> > There was a small discussion recently that we might be better off
>> > dropping test script numbers entirely,...
>> 
>> I think I missed that one.  A pointer, if you have one handy?
>
> The sub-thread between me and Jonathan starting here:
>
>   https://lore.kernel.org/git/20201005082448.GB2862927@coredump.intra.peff.net/
>
> but specifically:
>
>   https://lore.kernel.org/git/20201005084946.GE2862927@coredump.intra.peff.net/

Ah, I see.  I actually do use "git ls-files t/ | grep ..." to look
for tests that are relevant to the issue I have at hand quite often,
so unlike what Jonathan said in the thread, having a good name does
matter to me.

As far as I can tell, the numbers in the test names serve only two
purposes.

One is as a unique key to avoid colliding in the test result
aggrevation database, and the other is as a unique key to use in
GIT_SKIP_TESTS (which in turn is used by the Meta/Make wrapper I
use, found on the todo branch, like 'Meta/Make --test=0050,1400
test').

I would be heavily inconvenienced if we decide to remove numbers
becuase it would rob the latter use case from me, but I'd survive if
we just are going to lift the requirement that numbers must be
unique.  I may end up running irrelevant 0050 and 1400 when the
tests I really want to run are the other 0050 and 1400 with
"--test=0050,1400", but when I am trying to run only 2 among 900+
scripts, running 2 extra ones I didn't have to run only because
their prefix collide is still much better and tolerable.

Thanks.
