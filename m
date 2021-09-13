Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DBEC433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 18:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C488610E7
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 18:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347270AbhIMSc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 14:32:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56755 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345477AbhIMScK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 14:32:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1FCE515F01F;
        Mon, 13 Sep 2021 14:30:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rq80BixwoynYAfc7c7fQfcYhQ4Q6TsZ4cVvFPU
        EgtgQ=; b=YjHWbUZmOBWeOYRvgPvTPbsQHEJdgbNAur29CA8pQHNS+mKTHdL0Vw
        volyf/qn8beWjMGpbQNMsr2UTLK9FO3R6wtvTHcRWOTty+HTexGAZ3+OI2qlwcPx
        ZiDBrckhKwcVTQc31oM3fLWDJf4U8uOg2y0LkFLLLsUvYeNpBKpbw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 186DC15F01E;
        Mon, 13 Sep 2021 14:30:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 37AF315F01C;
        Mon, 13 Sep 2021 14:30:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 00/19] Adds reftable library code from
 https://github.com/hanwen/reftable.
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
        <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
        <xmqq7dfpxzfw.fsf@gitster.g>
        <CAFQ2z_Pa+KmCYV224XwMXO1iFCNA=PXj5iKaQU3LYGYTK_+qsw@mail.gmail.com>
Date:   Mon, 13 Sep 2021 11:30:49 -0700
In-Reply-To: <CAFQ2z_Pa+KmCYV224XwMXO1iFCNA=PXj5iKaQU3LYGYTK_+qsw@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 13 Sep 2021 12:14:34 +0200")
Message-ID: <xmqqee9sfhuu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B90BAA1E-14C0-11EC-972F-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Thu, Sep 9, 2021 at 10:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > The reftable format is described in Documentation/technical/reftable.txt.
>> >
>> > This is a fully reentrant implementation of reading and writing the reftable
>> > file format, and should be suitable for embedding in libgit2 too. It does
>> > not hook the code up to git to function as a ref storage backend yet.
>>
>> Not a question for Han-Wen, but I am wondering how much style and
>> other consistency guidelines we have in our C code to the files in
>> this directory.
>
> I am Han-Wen, but I'm not sure what you are saying here.

Sorry, the sentence is unreadable because I missed a verb above
(insert "should apply" between "code" and "to").  

I was asking for opinions on how we should treat this piece of code.
We loosen "style guidelines" on borrowed code that is maintained
elsewhere to ease re-importing, but code we maintain in-tree are
subject to our style guide.  I am not sure how this part that is
meant to be reusable in other projects like libgit2 should be
treated.

>> I am guessing that rules like "no decl after statement" and "no decl
>> in the set-up part of the for loop control" (i.e. "for (int i = 0;
>> ..."  is a no-no) should apply equally to this code, but it might be
>> OK to deviate from rules that are only meant to help human readers [*]
>> without affecting compilation.
>>
>> Opinions?
>
> The code has a different style because I wrote it separately from Git.
> I'm not wedded to its current style, and most styling can easily be
> changed. If you have specific things that should be addressed, let me
> know.

The question was for other reviewers to help us come up with what
the "specific things" ought to be.  I saw style differences around
comments and code formatting (everything I listed in the footnote,
plus, // comment which I forgot to mention) which may or may not
turn out to be part of that "specific things", because they do not
break compilation.
