Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8018220372
	for <e@80x24.org>; Fri, 13 Oct 2017 00:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753513AbdJMAtM (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 20:49:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63648 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753327AbdJMAtL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 20:49:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 19859A6BF9;
        Thu, 12 Oct 2017 20:49:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6mAQGJNSu6Mprr882NnOkA58G54=; b=l8KDLa
        WvxgSEfRMTSw+UHk3I6m2UAtOqdYLLQPHy9KYY+w5SBX2cBjWYi4TsT0CIfnv1Js
        5sLayBc5TQAUNm2HsLkNlvnKWalaTP5seNSG6YN/O3JObiNr7bUlenISdJeIi0uE
        uy/CMLPm87dcJz8xrE4BjnX2wqzlllezK47g4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=URyFSMHyds2Yv6Xon0rRkyVWstV/5+Bu
        u1A+W5tysGfTavNtyXXRGUIayqg98mSuJPqyhQyTGw5WCi70V6g90XNMjOphlTQL
        mJ1g5R2jxfbCT1sky3l2qEqyoki7iMLLttcqTB398FdTZHIMti0XKvzyQs0/V420
        9uyZD9BwQzA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11E66A6BF8;
        Thu, 12 Oct 2017 20:49:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 78505A6BF7;
        Thu, 12 Oct 2017 20:49:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jameson.miller81@gmail.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jamill@microsoft.com,
        peff@peff.net, sbeller@google.com
Subject: Re: [PATCH v2 5/5] Add tests around status handling of ignored arguments
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
        <20171011133504.15049-1-jamill@microsoft.com>
        <20171011133504.15049-6-jamill@microsoft.com>
        <xmqqefq91041.fsf@gitster.mtv.corp.google.com>
        <06a99e74-441e-ab22-fb4c-45302523d5cb@gmail.com>
Date:   Fri, 13 Oct 2017 09:49:09 +0900
In-Reply-To: <06a99e74-441e-ab22-fb4c-45302523d5cb@gmail.com> (Jameson
        Miller's message of "Thu, 12 Oct 2017 16:16:38 -0400")
Message-ID: <xmqqo9pbx46y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 535BB836-AFB0-11E7-B500-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jameson.miller81@gmail.com> writes:

>> Hmph, having some tests in 3/5, changes in 4/5 and even more tests
>> in 5/5 makes me as a reader a bit confused, as the description for
>> these two test patches does not make it clear how they are related
>> and how they are different.  Is it that changes in 1/5 alone does
>> not fulfill the promise made by documentation added at 2/5 so 3/5
>> only has tests for behaviour that works with 1/5 alone but is broken
>> with respect to what 2/5 claims until 4/5 is applied, and these "not
>> working with 1/5 alone, but works after 4/5" are added in this step?
>
> Correct. The changes in 1/5 are to implement "--ignored=matching"
> with "--untracked-files=all" with corresponding tests in 3/5. The
> changes in 4/5 are to implement "--ignored=matching"
> with "--untracked-files=normal" and the corresponding tests are
> in 5/5.
>
> Do you have a preference on how I organized this work? I see
> several possible ways to split up this work. Maybe it would be
> less confusing to have the implementation in the first two
> commits, then 1 commit with all the tests, and then a commit with
> the documentation? I think it makes sense to have the logic for
> the different flag combinations split into their own commits, but
> I am open to any suggestions.

Yeah, there are some alternatives, all valid.  

Support matching/all combination in 1/5, document that in 2/5, test
that in 3/5 and then do the same 3-patch series to support
matching/normal combination in 4/5, 5/5 and 6/5 would be one.  Doing
code, doc and test for matching/all in one patch and doing code, doc
and test for matching/normal in another patch, resulting in a
two-patch series may be another.  Or your "code for matching/all in
1/5, code for matching/normal in 2/5, doc and test for both in
subsequent steps" is fine, too.  All of these would not leave things
in inconsistent state when we interrupt the series in the middle,
which is a desirable property for those who want to understand the
topic.

