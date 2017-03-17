Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4389520323
	for <e@80x24.org>; Fri, 17 Mar 2017 05:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751072AbdCQFYg (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 01:24:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63021 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750866AbdCQFYf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 01:24:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 337E77165C;
        Fri, 17 Mar 2017 01:24:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GsivTDWsPf86vXbgFLOvkMkG6U0=; b=YjMwYW
        KL63DP7plFcrNYZIJsMPkFLnbBrMEqYruVE93U8ulsMXPbXRbCo4Bj5cZ2Ktk7ej
        LZKDiD9RtrxjBddYKlzhREfHr7eaQVn1F6pZtj1DhZxeQ3PRwDiK2jQe2JOBhrcU
        EWTAU+JYWBzj7/Z/vr6yDjTXq9tEfHsTC3IU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YucISiKB26DhcntYwBHJrQTOA7GRMWyl
        AyHaufkfvttoGFux71tggJV6OOYTXBKNXVxj3csDMKARIJHQNJjNF77k8F+iyAW5
        JqfLHnO6PeVPA7YYCgW1c+4Pv85QNKzY2E1+5vaAN/02u8V3h+yReL+msBMm+qnZ
        aRnCk6HDVMo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 280277165B;
        Fri, 17 Mar 2017 01:24:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8CB017165A;
        Fri, 17 Mar 2017 01:24:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] Makefile: add USE_SHA1DC knob
References: <20170316220456.m4yz2kbvzv6waokn@sigill.intra.peff.net>
        <20170316220911.43zernzq643m5mmk@sigill.intra.peff.net>
        <xmqqtw6salmm.fsf@gitster.mtv.corp.google.com>
        <20170317001115.xau6nzp6i7ilkqxv@sigill.intra.peff.net>
Date:   Thu, 16 Mar 2017 22:24:32 -0700
In-Reply-To: <20170317001115.xau6nzp6i7ilkqxv@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 16 Mar 2017 20:11:16 -0400")
Message-ID: <xmqqh92sa31r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01184964-0AD2-11E7-98EC-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Mar 16, 2017 at 03:43:13PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > +ifdef USE_SHA1DC
>> > +	LIB_OBJS += sha1dc/sha1.o
>> > +	LIB_OBJS += sha1dc/ubc_check.o
>> > +	BASIC_CFLAGS += -DSHA1_SHA1DC
>> 
>> The name of this CPP symbol is one difference between this and
>> Linus's version.  Wouldn't "-DSHA1_DC" make more sense?
>
> I'm fine with either. Somehow SHA1_DC felt too short, but it doesn't
> really matter in practice.

I'm fine with either, too.  It was just double SHA1 felt a bit
strange, when the naming convention was SHA1_ followed by the
characteristic attribute of the implementation (e.g. came from
Mozilla, etc.) and I thought "Detecting Collision" was the notable
characteristic of this one.

>> Another difference is that your version adds USE_SHA1DC to
>> GIT-BUILD-OPTIONS in patch 5/5; I thought GIT-CFLAGS forces
>> rebuilding and that was sufficient, but GIT-BUILD-OPTIONS is
>> available to tests for introspection, so adding it is needed
>> for that reason.
>
> Yep, exactly.

Thanks.
