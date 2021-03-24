Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B5FC433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 17:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F4561A1C
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 17:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbhCXRN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 13:13:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50201 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237051AbhCXRNu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 13:13:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86C8FC2917;
        Wed, 24 Mar 2021 13:13:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oGEHKWxHlFwYMcDkZz80KmPovRY=; b=aeDP3Z
        Vqip0YaHWv7PquI3zvW1/I1ohgNDalkE+vS9TAt7f6JghLCNUjVU47i/mMYHU7Bn
        9dy7GxhzsTX/eQzvGTitq2gHGDwqjSoo7QLvG/qBIExrRe0O9PlsWwFI/SGtA6mo
        zTUqsJDB9h4J2s3Y3kKeQU7PPxJpPsO7ExeGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nXzY1kgsmAELnWgZPvCzJiW68bSVjhry
        rw2f6Q+Cy7J+ISwqgc7RQ0OZD20BuJeB0CotRqnYGnXAZG0R401T9aH2K4wEwNvp
        04LiNSUDKUOMJk8ohn+mi+3At2dvsMJIgwoqjqRgAZAYFgPWRozZi/AUF4GXHGUf
        PhrR7MIavAs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D5B7C2916;
        Wed, 24 Mar 2021 13:13:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 094F3C2915;
        Wed, 24 Mar 2021 13:13:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: ag/merge-strategies-in-c, was Re: What's cooking in git.git
 (Mar 2021, #07; Mon, 22)
References: <xmqq35wm5y6d.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2103241142220.50@tvgsbejvaqbjf.bet>
Date:   Wed, 24 Mar 2021 10:13:48 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2103241142220.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 24 Mar 2021 11:43:57 +0100 (CET)")
Message-ID: <xmqqpmzozd83.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C8A2674-8CC4-11EB-9629-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 22 Mar 2021, Junio C Hamano wrote:
>
>> * ag/merge-strategies-in-c (2021-03-17) 15 commits
>>  - sequencer: use the "octopus" merge strategy without forking
>>  - sequencer: use the "resolve" strategy without forking
>>  - merge: use the "octopus" strategy without forking
>>  - merge: use the "resolve" strategy without forking
>>  - merge-octopus: rewrite in C
>>  - merge-recursive: move better_branch_name() to merge.c
>>  - merge-resolve: rewrite in C
>>  - merge-one-file: rewrite in C
>>  - update-index: move add_cacheinfo() to read-cache.c
>>  - merge-index: add a new way to invoke `git-merge-one-file'
>>  - merge-index: drop the index
>>  - merge-index: libify merge_one_path() and merge_all()
>>  - t6060: add tests for removed files
>>  - t6060: modify multiple files to expose a possible issue with merge-index
>>  - t6407: modernise tests
>>
>>  The resolve and octopus merge strategy backends have been rewritten
>>  in C.
>>
>>  Ready?
>
> I set aside some time to review this, and based on my suggestions, Alban
> seems to be preparing one (final?) iteration. See e.g.
> <b9d48a96-7e76-8a83-4ca2-c47fca326123@gmail.com>

Ack.  Thanks.
