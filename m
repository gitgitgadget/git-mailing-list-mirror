Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BBCC352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 06:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19B320714
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 06:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CAh055SC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgBKGK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 01:10:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63744 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgBKGK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 01:10:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E01D3EC05;
        Tue, 11 Feb 2020 01:10:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+xfUoIX49cKLQu7dFLysNnBuTwo=; b=CAh055
        SCqWAF4mO9uihYiZxOPMWRrv8PUMnNj2WeiRdBBjQRawZ7Oe7Gzxz+7OfRpft+pl
        qW3WQIWCORmLC1HTvI2sJwPrd1PeU5MWegsF/mayUmpp/Edxlc9amolTtj3g2lUZ
        /LjQYdtACKeYhnlAtFl0L7J36X77sh1/+5VhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HTP3+r2CI+Lj0yau+D7wksSh8MkkR5ZE
        nxGAMNs1TzWGMbeKG25FJ5bkBEdmUwqKIiW44Rjvkl7L0Vh5vjRc4jKR4vjjMzqc
        5L2xBSKAuVZNiJTGoREfdKCIAvo0t3kD39bPYOMB3HtEYAwTSQNxgwUISQSmKptf
        GjEtVNPHoVA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 82D783EC04;
        Tue, 11 Feb 2020 01:10:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D74C53EC01;
        Tue, 11 Feb 2020 01:10:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt Rogers <mattr94@gmail.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v7 04/10] config: make scope_name non-static and rename it
References: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
        <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
        <14b0f278196ab9ab130402c2ef79adb0543655ef.1581294660.git.gitgitgadget@gmail.com>
        <xmqqd0am1fsc.fsf@gitster-ct.c.googlers.com>
        <CAOjrSZvm-3qVw4880MeDVk59ToCwp9vMC1zFp-SYaDsFd3Y=8g@mail.gmail.com>
Date:   Mon, 10 Feb 2020 22:10:53 -0800
In-Reply-To: <CAOjrSZvm-3qVw4880MeDVk59ToCwp9vMC1zFp-SYaDsFd3Y=8g@mail.gmail.com>
        (Matt Rogers's message of "Mon, 10 Feb 2020 19:30:22 -0500")
Message-ID: <xmqq5zgdy7pu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 432B9E66-4C95-11EA-A6D6-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt Rogers <mattr94@gmail.com> writes:

>> How are you reviewing the patches in your own series before sending
>> them out?  This round is better than the previous rounds where we
>> didn't have a matching change to the tests so "make test" may not
>> have passed in the middle of the series, though...
>>
>
> I went through each patch individually using rebase -i and built/tested it.
> Although just to save time I only did t1300 and t1308 since I believe those were
> the only ones that should be affected.  I can write a script that
> would run the whole
> test suite overnight for me and make sure the series shakes out okay,
> if you'd like.

What I like does not matter.  

What I pointed out for 04/10 wouldn't have been caught by your
testing anyway, as both the code and the test had matching
unnecessry changes.  I was wondering if you are relying too heavily
on just tests and without actually proofreading the changes to see
if they still make sense in the context of the updated series, and
if my suspicion was correct, if there are something reviewers can do
to help the authors.


