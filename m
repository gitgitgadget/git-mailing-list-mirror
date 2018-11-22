Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC5C71F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 00:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391140AbeKVLYG (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 06:24:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54351 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbeKVLYF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 06:24:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 400BA11642C;
        Wed, 21 Nov 2018 19:47:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PpaBxQ6Jb62o7BSeglhPf6mJDmE=; b=DLWOP0
        gkUceFd2m8pmE4WV58mVRYXIAmL9ybLWz928aXgZvadXn9yGQk+cA/oFmg7xOsaS
        SX80JxudGwFqgiuJgoFa+kcIxSf3LnEqQrIviaMlNWSmG56y2xlqlWLvuynXLAUl
        XelTggNmvwLrdV1/VD1m+hlZsj8yQVVBj+bbw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LoEYrTcDO5AHdbITf0b/6nldQoV+WOmI
        VK+tZrdBxo1fbIU2zIq5upJWVYhSddLpoWe1cC+meOdnmSLUiksiB8IbwEauD8nG
        pXQWjXkLqKXcPwNwOH6ZmyE1JAkY98TBnZc1T4HF4YNZ+Zb/rA1lpTR1ufgLA2Qm
        F6tGF2alhkA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3829811642A;
        Wed, 21 Nov 2018 19:47:15 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C0D6116428;
        Wed, 21 Nov 2018 19:47:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ben Peart <peartben@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>,
        jonathantanmy@google.com
Subject: Re: [PATCH 1/5] eoie: default to not writing EOIE section
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20181010155938.20996-1-peartben@gmail.com>
        <20181113003817.GA170017@google.com>
        <20181113003938.GC170017@google.com>
        <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
        <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
        <20181120060920.GA144753@google.com>
        <20181120061147.GB144753@google.com>
        <efa1d7fb-1da3-c093-1cb1-873a2e1c445c@gmail.com>
        <20181120132151.GA30222@szeder.dev>
        <20181121164619.GA13860@sigill.intra.peff.net>
Date:   Thu, 22 Nov 2018 09:47:13 +0900
In-Reply-To: <20181121164619.GA13860@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 21 Nov 2018 11:46:20 -0500")
Message-ID: <xmqqefbe546m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 279102B8-EDF0-11E8-8C84-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yes, there are two ways to write this. With a conditional to initialize
> and return or to return the default, as we have here:
>
>> > >+	if (!git_config_get_bool("index.recordendofindexentries", &val))
>> > >+		return val;
>> > >+	return 0;
>
> Or initialize the default ahead of time, and rely on the function not to
> modify it when the entry is missing:
>
>   int val = 0;
>   git_config_get_bool("index.whatever", &val);
>   return val;
>
> I think either is perfectly fine, but since I also had to look at it
> twice to make sure it was doing the right thing, I figured it is worth
> mentioning as a possible style/convention thing we may want to decide
> on.

I too think either is fine, and both rely on the git_config_get_*()
to modify the value return only when it sees that it is set.

I'd choose the latter when the default value is simple, as the
reader does not have to even know what the return value from the
git_config_get_*() function means to follow what is going on.

On the other hand, the former (i.e. the original by Jonathan) is
more flexible, and it makes it possible to write a piece of code,
which computes a default that is expensive to build only when
necessary, in the most natural way.  The readers do need to be aware
of how the functin signals "I didn't get anything" with its return
value, though.

I do not mind standardizing on the latter, though.  A caller with an
expensive default can initialize val to an impossible "sentinel"
value that signals the fact that git_config_get_*() did not get
anything, as long as the type has a natural sentinel (like -1 for a
bool to signal "unset"), and code that comes either immediately
after git_config_get_*() or much much later in the control flow can
check for the sentinel to see if it needs to compute the expensive
default.

