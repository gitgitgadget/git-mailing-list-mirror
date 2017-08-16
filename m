Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F76F1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 21:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752376AbdHPVeD (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 17:34:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50258 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752259AbdHPVeC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 17:34:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD57EA8DA9;
        Wed, 16 Aug 2017 17:33:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0LiQ0IWxiOLEXmL5CYhGWCdLcWk=; b=TFuH34
        7RGncm/YW9auGU6zSBYAlepyVrscpOYS7SqRTIkyuO4fvd9eDUVM41FbOXfDwn06
        J/4VtLcMmSUV68iPAP7l/fq+CA9jgIpIez+bN/I0c40Op0f/N1plEibNCsS2iPvs
        oqBIxhbA1pb2yZkA7GqyraO44NA9NHNV8ZhbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dY7rHP/z5sULMQxOn0A5ePtHDuQbaojl
        MtQPX0evvyz2PuiB7ZJvwnIbNHLZJg7kcI4fkHdmLN2a7u5ilq3GH8EZaszbdXBT
        KTDDc5lqip6hGSoWmnx2cwqTYraWeJF44poN0F3kg2221v2DQBsyviKbkrWIsuPb
        gvCfyvhyoAw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5A79A8DA8;
        Wed, 16 Aug 2017 17:33:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 07536A8DA7;
        Wed, 16 Aug 2017 17:33:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [Patch size_t V3 00/19] use size_t
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
Date:   Wed, 16 Aug 2017 14:33:52 -0700
In-Reply-To: <1502914591-26215-1-git-send-email-martin@mail.zuhause> (Martin
        Koegler's message of "Wed, 16 Aug 2017 22:16:12 +0200")
Message-ID: <xmqq1sobjiyn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A38448A-82CA-11E7-A609-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Koegler <martin.koegler@chello.at> writes:

> From: Martin Koegler <martin.koegler@chello.at>
>
> This patchset is for next [24db08a6e8fed761d3bace7f2d5997806e20b9f7].
> Its a complete collection of all patches. Some errors were fixed and
> it sticks with off_t for length in (pack) files. Object sizes are handled
> as size_t.

Thanks for an update.

I am in the middle of today's integration cycle already, so I won't
be able to apply them to my tree, see how it interacts with various
other topics, and if I can rebase it off of 'next' as of yesterday
(I am hoping that I can update 'next' with a few new topics today)
to give it a more appropriate base, at least until late this evening.  

Making it "a complete collection" is very much appreciated, as I can
forget about random pieces that were picked up so far.  I haven't
looked at the patch text, but I agree that the use of off_t for
something that could become a location in a file and use of size_t
for objects that we handle in-core would be a good place to start
(and probably a good place to stop, at least for now).

> Martin Koegler (19):
>   delta: fix enconding size larger than an "uint" can hold
>   Convert size datatype to size_t
>   Convert zlib.c to size_t
>   delta: Fix offset overflows
>   Convert sha1_file.c to size_t
>   Use size_t for sha1
>   Convert parse_X_buffer to size_t
>   Convert fsck.c & commit.c to size_t
>   Convert cache functions to size_t
>   Add overflow check to get_delta_hdr_size
>   Use size_t for config parsing
>   Convert pack-objects to size_t
>   Convert index-pack to size_t
>   Convert unpack-objects to size_t
>   Convert archive functions to size_t
>   Convert various things to size_t
>   Convert ref-filter to size_t
>   Convert tree-walk to size_t
>   Convert xdiff-interface to size_t

Usually we try to make these more like

    delta: fix enconding size larger than an "uint" can hold
    pack-objects: use size_t for sizes, not ulong
    tree-walk: use size_t for sizes, not ulong

or (perhaps even better for this series)

    size_t: convert pack-objects away from ulong
    size_t: convert tree-walk away from ulong
    ...

so that readers of "git shortlog --no-merges" can visually spot
a group of patches that are around the same theme.

>  95 files changed, 525 insertions(+), 489 deletions(-)

That's a lot of changes.  Let's see how well it goes.

Thanks.
