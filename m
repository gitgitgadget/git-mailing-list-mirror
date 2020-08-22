Return-Path: <SRS0=iV/m=CA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307C2C433E1
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 19:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D23B52078A
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 19:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kNCMyLi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgHVTgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Aug 2020 15:36:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53307 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbgHVTgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Aug 2020 15:36:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C471EEC447;
        Sat, 22 Aug 2020 15:36:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d3cn4XmObtrV958LFCiGYgIMy1U=; b=kNCMyL
        i9Dxmp37oORbqXZsa7YKYIkPSih/5lo+D5IF7kSpPJ7YOZkRU6FJXbiAX44q2y+/
        5IzBErbPq8DD52UqYSByCFflMbX2uhM0v+a7cVj8u5Wd7ChjnBfhuRjMrzGkUbE4
        w3PoDFutbNU9goNCcGsfV5TlGUXPLcwMyVOPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OF94dglBQdk9Lj65yrb7A+DUtnTzK/xt
        OLZRlsVxesGB8j/UeOo3X83ShzSJv4edVVnlEMCnp+i+AJcuQa/Vjke4pin0X+CZ
        OnxoitJjQ3csHJuF/Xs1++PUru3g5ZLjl6Kew2eu19eUMAHHGkTiuL4abnalwI8W
        VaZv1bEzLW8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BE3A5EC446;
        Sat, 22 Aug 2020 15:36:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 17200EC445;
        Sat, 22 Aug 2020 15:36:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Sergii Shkarnikov <sergii.shkarnikov@globallogic.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Possible bug with git restore
References: <CAFvH=vsWyX79j-9pyC5gpxGu8rRxYyrXwywHjh-_T2opHjT8Xg@mail.gmail.com>
        <CAPig+cSCd_8YB90sypTe1bHMQhPgo+Tr2PHNucdqfCpEe+Dosg@mail.gmail.com>
        <CAFvH=vuFg+kM2GkBaE7jRqHWWcTcZMrs36KLS+-VTy8tgNZXJw@mail.gmail.com>
        <20200820134013.GA2526241@coredump.intra.peff.net>
        <c3f0d51a-d0e3-ed0a-c9ed-da092704da5c@web.de>
        <20200820182720.GA2537643@coredump.intra.peff.net>
Date:   Sat, 22 Aug 2020 12:36:09 -0700
In-Reply-To: <20200820182720.GA2537643@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 20 Aug 2020 14:27:20 -0400")
Message-ID: <xmqq364e79sm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB99D8CA-E4AE-11EA-A43A-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I think this inconsistency in pathspec matching between trees and the
> index has probably existed in git-checkout for ages (and I guess people
> don't do wildcards with trees often enough for anybody to have noticed).
> But it didn't cause the index-deletion problem, because that only
> appeared more recently with the --no-overlay mode. That's the default
> for restore, but you can trigger the problem with checkout, too:
>
>   $ git reset --hard
>   $ git checkout --no-overlay HEAD^ '*.hpp'
>   Updated 0 paths from 2668463
>   $ git status
>   On branch master
>   Changes to be committed:
> 	deleted:    incl/test_file.hpp

The --no-overlay mode is an enhancement added on top of reasonably
aged codebase relatively recently.  Most of the core code in
checkout dates back to early 2008, while --no-overlay was done as a
long-overdue-afterthought in early last year.

And it is not all that surprising that this issue took a long time
to be discovered.

Thank you all for finding, analysing and fixing it promptly.


