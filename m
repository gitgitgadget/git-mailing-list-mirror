Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D718EC433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63A4022248
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lad2WkjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389163AbgJOQUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 12:20:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64047 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388461AbgJOQUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 12:20:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 362D9865B5;
        Thu, 15 Oct 2020 12:20:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2e0yyIje5VjmaPVMXJQnJk8sdu0=; b=lad2Wk
        jOn1p6c2OuIQ75xebTqyLXAGTfLXfBtcH4tt+GZR5S1NsAkNhFF6mMQ/ga/fmkI0
        34Fi5NzGPF1qVd1OzXxjKglNJDYSC+bbnHPWJ/rPhP9x/MDVxVJcciqg5osVzQK1
        QkXt7iBKP/dOhAUlz/4ogPRssPqVReg0Y1gCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kjpWah/+PRGb/JxX/jA8aU+6A4V0uf8h
        NHM40kiutskSUBg1YaA94IMiaFww6lGsea7B7UQiuKQdWPkmyZxP3fPhhmbcWSFn
        nDdzvJkNBpHaqCESOepiHoG7ps60FGboGC9a9dYg2CP0WpRx5JDy3sE+WWY3cOfU
        c6mGdIE4AtI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E73B865B4;
        Thu, 15 Oct 2020 12:20:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A9521865B3;
        Thu, 15 Oct 2020 12:20:13 -0400 (EDT)
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
Date:   Thu, 15 Oct 2020 09:20:13 -0700
In-Reply-To: <20201014170413.GB21687@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 14 Oct 2020 13:04:13 -0400")
Message-ID: <xmqq1rhzihqa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4DF3C1E0-0F02-11EB-88EF-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Oct 13, 2020 at 07:19:44PM +0000, Elijah Newren via GitGitGadget wrote:
>
>> Many of our test scripts have several "setup" tests.  It's a lot easier
>> to say
>> 
>>    ./t0050-filesystem.sh --run=setup,9
>
> I like this direction very well.
>
> There was a small discussion recently that we might be better off
> dropping test script numbers entirely,...

I think I missed that one.  A pointer, if you have one handy?

Thanks.
