Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37970C433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 22:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7BB204EA
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 22:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wcu/ZHtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgH1Wpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 18:45:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55998 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgH1Wpb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 18:45:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 980FFFF337;
        Fri, 28 Aug 2020 18:45:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mJ8s6h8SY29D71uJYW3+RAtm0dE=; b=Wcu/ZH
        tSJXyDqSFspSQq26FHz6WbhAIMKM9PROTaYFQZoAGD9fLsQYIT6/1vzINnT62Aem
        Fz+NIL3yH12/RwEuh7MfRyI5iMoafUSN/SCjfKwrder10OZe0Tzp8/bhqvsi83he
        7juPpvl5dYpxWoiX+Nbkhy+3T0nr4KA5NxvgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QCSbL+/LcqOLV2aavf4JWS9g+rEYyZiS
        5IHrS8LiURzVV1wXWZtxqsL7WIoVHfBdNabVLahk4R3uyM9dL11M7M5yWe1kkHfB
        8ho6xXvfstkXARFLIFf9dRnjlxqy9Gmv2e25D3k1MtXi/x9tyrQtaxowRfn2WChk
        oiD67LzVHqQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91961FF336;
        Fri, 28 Aug 2020 18:45:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D2E0AFF335;
        Fri, 28 Aug 2020 18:45:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH] pack-redundant: gauge the usage before proposing its removal
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
        <20200825022614.GA1391422@coredump.intra.peff.net>
        <xmqqtuwq1zux.fsf@gitster.c.googlers.com>
        <20200825172214.GC1414394@coredump.intra.peff.net>
        <xmqqh7sq1u0a.fsf@gitster.c.googlers.com>
        <20200825182745.GA1417288@coredump.intra.peff.net>
        <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>
        <20200828091454.GA2140991@coredump.intra.peff.net>
Date:   Fri, 28 Aug 2020 15:45:25 -0700
In-Reply-To: <20200828091454.GA2140991@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 28 Aug 2020 05:14:54 -0400")
Message-ID: <xmqqwo1imltm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AA5651A-E980-11EA-B5BD-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Aug 25, 2020 at 03:45:52PM -0700, Junio C Hamano wrote:
>
>> The subcommand is unusably slow and the reason why nobody reports it
>> as a performance bug is suspected to be the absense of users.  Let's
>> show a big message that asks the user to tell us that they still
>> care about the command when an attempt is made to run the command,
>> with an escape hatch to override it with a command line option.
>
> I was looking at the history here and noticed this topic, which I
> somehow missed when it happened:
>
>   $ git show -s cf0879f7e98d2213503622f780d2ab0dd3f93477
>   commit cf0879f7e98d2213503622f780d2ab0dd3f93477
>   Merge: 3710f60a80 0e37abd2e8
>   Author: Junio C Hamano <gitster@pobox.com>
>   Date:   Thu Mar 7 09:59:54 2019 +0900
>   
>       Merge branch 'sc/pack-redundant'
>       
>       Update the implementation of pack-redundant for performance in a
>       repository with many packfiles.
>       
>       * sc/pack-redundant:
>         pack-redundant: consistent sort method
>         pack-redundant: rename pack_list.all_objects
>         pack-redundant: new algorithm to find min packs
>         pack-redundant: delete redundant code
>         pack-redundant: delay creation of unique_objects
>         t5323: test cases for git-pack-redundant
>
> So it sounds like:
>
>   - somebody does care enough to use it
>
>   - it may not be horrifically slow anymore
>
> So it may not be worth trying to follow through on the deprecation
> (though the fact that neither of us realized this makes me worried for
> the general state of maintenance of this code).

OK.  Just dropping the topic is the easiest ;-)  Thanks.
