Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B01C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C468060F02
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhJ1Tbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 15:31:51 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63356 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhJ1Tbu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 15:31:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 681F0154C5F;
        Thu, 28 Oct 2021 15:29:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sxy+PJVV5YxNI4yTBnpPEJbhWlvot52B9YqGLS
        qB66U=; b=g1MLK3+aJn5NKo09suLyAzaaWjhLbhU6s0aRSgh3XXF2dp+5e8XYVJ
        KorJEueH3pERS8obvGewHvaF4I6QyHWNxrfgv0cXqaegNexyJj98EqziXRcmJN7o
        d05BSNb7v5ZX4JJOfzPMCTmt4MJe9kQgC5Z/gljAfoL1qc2I1VO9s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4D4F5154C5E;
        Thu, 28 Oct 2021 15:29:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7B758154C5B;
        Thu, 28 Oct 2021 15:29:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] allow disabling fsync everywhere
References: <20211028002102.19384-1-e@80x24.org>
        <YXq1g4Zwfq8gJEoC@coredump.intra.peff.net>
        <20211028182824.GA1307@dcvr>
Date:   Thu, 28 Oct 2021 12:29:19 -0700
In-Reply-To: <20211028182824.GA1307@dcvr> (Eric Wong's message of "Thu, 28 Oct
        2021 18:28:24 +0000")
Message-ID: <xmqqilxhq774.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5952E668-3825-11EC-9AC6-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Jeff King <peff@peff.net> wrote:
>> On Thu, Oct 28, 2021 at 12:21:02AM +0000, Eric Wong wrote:
>> 
>> > "core.fsync" and the "GIT_FSYNC" environment variable now exist
>> > for disabling fsync() even on packfiles and other critical data.
>
> Fwiw, I'm questioning the need for core.fsync.  GIT_FSYNC alone
> may be sufficient.
>
>> > This will also be useful for 3rd-party tools which create
>> > throwaway git repositories of temporary data.
>> 
>> Do you mostly just care about the tests, or is the third-party tool
>> support important to you? I ask because most of us switched to running
>> the tests with --root=/some/tmpfs long ago to achieve the same speedup.
>
> Third-party tools and OSes which don't have a tmpfs mounted by
> default (I don't think most *BSDs have tmpfs enabled by
> default).
>
> I try to use libeatmydata everywhere I can; but that's not
> always installed.
>
> I'm also strongly considering making GIT_FSYNC=0 the default for
> our own test suite since it's less setup for newbies.

If the primary focus is for testing, perhaps GIT_TEST_FSYNC would be
better?  I do not think we want to even advertise an option for not
syncing at all for end users working with any real repositories.
Not even when they promise that the end user accepts all the
responsibility and will keep both halves when things got broken.

Thanks.
