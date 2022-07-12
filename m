Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76EAC43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 14:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiGLOfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 10:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbiGLOes (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 10:34:48 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E301795BD
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 07:34:30 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 486E6131DF2;
        Tue, 12 Jul 2022 10:34:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DSugHPrHRlj3nU9GOZ/SzQLaiwes2ctxUUa0IB
        W8l+M=; b=qIX3+HKdWtrXKr9NVY6LwrzVDY8bofVfS0nfZEUdrP2R6SE0ogxVWn
        mWq4oiYgUSn5xqZYPuTdhnkFcsp7bQ7fL2rF3F9+NK/wjAEXj0xkUSkSH1NVAZRb
        TJCYPzRgSNF7dpsx9QLO+KTtld00HpF1JTqc5NCu6zuqs7XG2MKyw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F806131DF1;
        Tue, 12 Jul 2022 10:34:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 985E9131DF0;
        Tue, 12 Jul 2022 10:34:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v6] ls-files: introduce "--format" option
References: <pull.1262.v5.git.1657002760815.gitgitgadget@gmail.com>
        <pull.1262.v6.git.1657558435532.gitgitgadget@gmail.com>
        <xmqqleszl2p0.fsf@gitster.g>
        <CAOLTT8RSo83ZBXbT_MLigD946_xHjnX-aS76D_K7=ScbMR=nYw@mail.gmail.com>
Date:   Tue, 12 Jul 2022 07:34:28 -0700
In-Reply-To: <CAOLTT8RSo83ZBXbT_MLigD946_xHjnX-aS76D_K7=ScbMR=nYw@mail.gmail.com>
        (ZheNing Hu's message of "Tue, 12 Jul 2022 21:53:57 +0800")
Message-ID: <xmqqh73miemj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCE744A0-01EF-11ED-B84D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>> > +test_expect_success 'setup' '
>> > +     echo o1 >o1 &&
>> > +     echo o2 >o2 &&
>> > +     git add o1 o2 &&
>> > +     git add --chmod +x o1 &&
>> > +     git commit -m base
>> > +'
>>
>> Apparently, this set-up is too trivial to uncover the above bug that
>> can be spotted in 10 seconds of staring at the code.  Perhaps add a
>> symbolic link (use "git update-index --cacheinfo" and you do not
>> have to worry about Windows), a subdirectory and a submodule?
>
> Ah, Just looking at the c code, I took a long time (more than 10 minutes) to
> find out where the mistake was.

It is OK---it tends to take a lot more time than it should for all
of us, experienced developers included, to find mistakes in our own
code than code written by other people.

> But yeah, use a subdirectory can quickly meet the error, so I need
> to add more cases here.

A pure sub-"directory" would not, I suspect.  A submodule or a
symbolic link would. 
