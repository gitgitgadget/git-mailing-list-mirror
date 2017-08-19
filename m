Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D306C20899
	for <e@80x24.org>; Sat, 19 Aug 2017 07:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751004AbdHSHdO (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 03:33:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60085 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750852AbdHSHdO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 03:33:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A8AAA837D;
        Sat, 19 Aug 2017 03:33:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/pWcKElyuY1CztRLTRwGq+BMx44=; b=r+beA3
        Ux/GBKoTV9b1pjwqGu0+GDXJx1E4GEz6WOH0cQ9bSTIxZTNVhUHO+Ol0KqsmeQ6X
        7HREZYHFu4VPs2CeMunDLVo24HsunFs97AhPYnBxCfWm2s5g2x4RsAhYl1+mPorK
        9bA5mwHQk1ulAsuEzoMmYwGZT66I27uQvp34I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V6AnjwWB5PLfc2VOj9ZEfQiH63WvcaUd
        jJDp2IHqpZqlYbdeGJDfK2Kt+tplqM9npbP8v21QZruzMDKKQtK1lo/hbCH3yXu6
        bqRIKU6AP5I2nHgpjsZTyrnBVghXHhewAJguQMJe9/j9+B3q+x/yLEDvtgy0Tn0L
        ZZP9xaZr3p8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03652A837C;
        Sat, 19 Aug 2017 03:33:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65CC6A8379;
        Sat, 19 Aug 2017 03:33:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: Re: [PATCH v3 00/23] Move exported packfile funcs to its own file
References: <cover.1502220307.git.jonathantanmy@google.com>
        <cover.1503094448.git.jonathantanmy@google.com>
Date:   Sat, 19 Aug 2017 00:33:03 -0700
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Fri, 18 Aug 2017 15:20:15 -0700")
Message-ID: <xmqqk2209fm8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3BD6B9C-84B0-11E7-BAD7-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> You'd need to double check, but I think the topics that cause
>> trouble are rs/find-apck-entry-bisection and jk/drop-sha1-entry-pos;
>> you can start from v2.14.1 and merge these topics on top and then
>> build your change on top.  That would allow you to start cooking
>> before both of them graduate to 'master', as I expect they are both
>> quick-to-next material.  There might be other topics that interfere
>> with what you are doing, but you can easily find out what they are
>> if you do a trial merge to 'next' and 'pu' yourself.
>
> OK - in addition to the 2 you mentioned, I have found some others
> (likely added after you wrote that). The complete list is:
>  - rs/find-pack-entry-bisection
>  - jk/drop-sha1-entry-pos
>  - jt/sha1-file-cleanup (formerly part of this set)
>  - mk/use-size-t-in-zlib
>  - rs/unpack-entry-leakfix
>
> I have merged all of these and rebased my patches on top.
>
> Other changes:
>  - Used packfile.h instead of pack.h (following most people's
>    preference)
>  - Ensured that I added functions to packfile.h retaining the order they
>    were originally in, so that if you run "git diff <base> --color-moved
>    --patience", there are much fewer zebra stripes
>
> The merge base commit can be accessed online [1], if you need it.
>
> [1] https://github.com/jonathantanmy/git/commits/packmigrate

Thanks.

I have to say that this was a painful topic to integrate.

As you may know, the mk/use-size-t-in-zlib topic is being retracted
and getting rerolled as a larger size_t series, most of which still
needs help in reviewing.

The jt/sha1-file-cleanup topic is the only one among the other four
that are still not in 'next', and I think that topic, as well as the
other three, are all good and serve as a good base to build on top.
So I first rebuilt your patches on top of these four topics.  This
took some time but it wasn't all that painful.

The result cleanly merged to 'pu', I think, but it resulted in a
rather noisy conflict when I attempted to merge it to 'next'.  I
want to see both of a merge to 'next' and a merge to 'pu' to be
reasonably clean for any topic to be viable [*1*].  Otherwise,
"initially queue in 'pu', then cook in 'next', and eventually
graduate to 'master'" workflow would not work well.

Anyway, I _think_ I finally got the conflict resolutions right for
merges of the topic to 'next', 'jch' and 'pu', so I will push the
result of merging to 'pu' out.  This unfortunately makes Martin's
ongoing size_t topic unmergeable to any of the integration branches
as-is, but let's make sure that topic is reviewed properly first (I
haven't seen people comment much on the individual patches other
than just selected few).


[Footnote]

*1* There is an intermediate point between 'master' and 'pu' called
    'jch', and I try to make sure any new topic to merge cleanly to
    that branch, too, when accepting it.  That is the branch I use
    for everyday work as an early guinea-pig.
