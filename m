Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2697C0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 18:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF4020679
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 18:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KhklIOKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732340AbgCPScE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:32:04 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50680 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731967AbgCPScD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 14:32:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A0A8EAC71E;
        Mon, 16 Mar 2020 14:31:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8MI5te8LuPmfUYQcouN3TgjQWQI=; b=KhklIO
        KRhzERdSNjy0FHshnzIMNNQX2dZaQ1AGUKHLwR8XgyzQwGQLuwUMQE6YGB2uAOn9
        9gAHv3TyuBof7q/BgY3Gc7XcWsDl0lqKIoxJ/OS2my+Bu59F31uUtSG30BrVMxLZ
        wMMLObZb6h2C5/WL8AEVShonyWGJz1Wv4Xth4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EOd1S7IgrfkEnTxSovmiA+6aIwfwPw1K
        gihX7QAFl3ZbmiMdlvPYNLhQvAFvKR0lt6SEyhUovoo0b1mExxC17CGfq2hVxsDp
        42TcSoGGkTvaG8LE/WYb1p85y2i5DIDkGFjxE1DyCfxJPNwd5X/zp1HBzqbm+lEK
        xEgZ6aO9Gb0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 97BB2AC71D;
        Mon, 16 Mar 2020 14:31:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DC385AC717;
        Mon, 16 Mar 2020 14:31:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] dir: improve naming of oid_stat fields in two structs
References: <cover.1584329834.git.matheus.bernardino@usp.br>
        <6fee28469e49d501e5184162bc820350f60cc3de.1584329834.git.matheus.bernardino@usp.br>
        <xmqq1rpsako1.fsf@gitster.c.googlers.com>
        <CAHd-oW4OpoW0Qbp6_HfFiXRXasLXVnw3hDkzDG3S4WR3yH9Wuw@mail.gmail.com>
Date:   Mon, 16 Mar 2020 11:31:54 -0700
In-Reply-To: <CAHd-oW4OpoW0Qbp6_HfFiXRXasLXVnw3hDkzDG3S4WR3yH9Wuw@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Mon, 16 Mar 2020 14:22:53
        -0300")
Message-ID: <xmqqsgi8882t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A0C258E-67B4-11EA-81E6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

>> I also am wondering if we can do without any prefix, i.e. just call
>> them "info_exclude" and "excludes_file", because the field names are
>> private to each struct and there is no strong reason to have a
>> common prefix among fields in a single struct.  Rather, it is more
>> important for the fields of the same type in a single struct to have
>> distinct names so that the reader can easily tell them apart and the
>> reason for their use is straight-forward to understand, and the two
>> names without any prefix convey their distinction pretty well, I
>> would think.
>
> Yes, I guess removing the prefix wouldn't make the names less
> descriptive. However, especially for "ss_excludes_file", I think using
> just "excludes_file" might induce the reader to think that the field
> refers to a "char *" holding a path. (We also have a "excludes_file"
> global variable in environment.c which is used like that). What if we
> renamed them to "oidst_info_exclude" and "oidst_excludes_file", would
> that be too verbose?

The potential for confusion with "path to these files" is real, I
would think, so they may benefit from some prefix.

But instead of basing the prefix on their type, can we name it after
what this struct holds about the excludes file, and what the data
the struct holds is used for?  Is "oidst" something that conveys it
well to the readers of the code?

I guess the definition of "struct oid_stat" in dir.h should say what
it is for and why it is called oid_stat, or even better yet, rename
it to what is better than "this is a random bag to hold the file
stat data and an object id for an unspecified purpose".  IOW, it
would be better for the name of a structure to say what's in it, but
what the data it holds are for.

In a sense, this struct is a pared down version of cache_entry that
keeps the filesystem stat data to allow us quickly find if the path
was modified, and also lets us know if two contents are the same
without comparing bytes.  It is a mechanism for us to tell validity
of our cached data.  "struct path_validity" perhaps?  I dunno.
