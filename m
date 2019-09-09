Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29D191F463
	for <e@80x24.org>; Mon,  9 Sep 2019 18:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbfIIStj (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 14:49:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59193 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfIIStj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 14:49:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 28B629309D;
        Mon,  9 Sep 2019 14:49:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8vUBXEWwkQ/O
        7QYtx5baHDaP4Hw=; b=IgB0sYeUsncq+AU2349mSaqvC2iu/Hgoal1tsWoOrMyx
        g8Rmr/zAo6KUHiNBtEzlrzwILKGVEOB+u0cpQPfLmLq8HeV6EfrcW5E0NtHJvjAe
        fEeWjGPGYTuCo6s98FPHfNaq7cZOerAe/eybC8qKOtSTxMSiJJsM5M5EMnRJFHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dMZC08
        ITJZWHWwPBo6mXShiw4qKDDf1t8eBtn85sy522I0tQLdt/wwuZSz/+u4EbNSukeT
        BnQ3/oMxasknuXjcUY9LRGgiWNWBoZSSFUQWwCytwSkIMGmxq4MfRIe4V30O1nWS
        4iu1URUN76wR5FYh4XsKQ/RBKMLwandjAbiwY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1F9AA9309C;
        Mon,  9 Sep 2019 14:49:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4CF329309A;
        Mon,  9 Sep 2019 14:49:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v2] grep: skip UTF8 checks explicitly
References: <xmqq5znrs9d0.fsf@gitster-ct.c.googlers.com>
        <20190828145444.31588-1-carenas@gmail.com>
        <CAPUEsphatmoBg3jV9p_xLF_zYe0qn=S=5UTYBCHKjnuNZm4_VA@mail.gmail.com>
        <CAPUEspi+OXR8pjcJgTdqCCGMxE0dv8L6y-0SaX8jzB6z9mXaRw@mail.gmail.com>
Date:   Mon, 09 Sep 2019 11:49:31 -0700
In-Reply-To: <CAPUEspi+OXR8pjcJgTdqCCGMxE0dv8L6y-0SaX8jzB6z9mXaRw@mail.gmail.com>
        (Carlo Arenas's message of "Mon, 9 Sep 2019 08:07:29 -0700")
Message-ID: <xmqq5zm1joec.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 90D6451C-D332-11E9-A26B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> ping
>
> any feedback on code/approach highly appreciated

I'd prefer to see others weigh in before starting to merge the pcre
stuff to 'next'.

I do not mind taking this updated one that limits the scope to pcre1
as a pure regressino fix, if others agree.  Thanks for keeping a tab
on these pcre issues.

>> While =C3=86var made a point[1] that this wasn't a solution to the pro=
blem,
>> it was because PCRE2 could have a better one (still missing but based
>> on ab/pcre-jit-fixes), and it was expected that PCRE2 will be used a
>> lot more and so it wasn't a good idea for it (something that doesn't
>> apply to PCRE1)
>>
>> the patch was based on maint (like all bugfixes) but applies cleanly
>> to master and next, it will conflict with pu but for easy of merge I'd
>> applied it on top of cb/pcre1-cleanup and make it available in
>> GitHub[2]; that branch could be used as well as a reroll for that
>> topic (if that is preferred)
>>
>> the error message hasn't been changed on this patch, as it might make
>> sense to improve it as well for PCRE2, but at least shouldn't be
>> triggered anymore (ex, from running a freshly built git without the
>> patch and linked against a non JIT enabled PCRE1):
>>
>> $ ./git-grep -P 'Nguy=E1=BB=85n Th=C3=A1i.Ng=E1=BB=8Dc'
>> .mailmap:Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>> fatal: pcre_exec failed with error code -10
>>
>> Carlo
>>
>> [0] 685668faaa (grep: stop using a custom JIT stack with PCRE v1, 2019=
-07-26)
>> [1] https://public-inbox.org/git/87lfwn70nb.fsf@evledraar.gmail.com/
>> [2] https://github.com/carenas/git/tree/pcre1-cleanup
