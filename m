Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC8DC433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 23:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9403B61421
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 23:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbhDUX3Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 19:29:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63635 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbhDUX3X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 19:29:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A21F1A95BB;
        Wed, 21 Apr 2021 19:28:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XBLgjsYCKMM6q6o87e3pcAQABmI=; b=MjAZ0z
        IK7J4+5trIs95wTK72h6FSAMElV0Hu7PbTKKxf3ZrIv3NVsNLTsqQg3CEWMEkF3o
        zM5SOLZvmp0RBem3pzEky9WMeNclNogHppEjnsXZOK+esER7wJjMHeuNFRntD7kt
        Ly9EGGR1UsbzjzTmGJoq/DMaILbAKYcmLcDgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GGAQOH5h8kzwIL/m3rksAsWPzJWtoI5Q
        o8id1xGHEwN/REZknz20WuG7qvzQpM9vGGNDyI/uo79ezpwGqnVOBGpDVSK3FRXX
        8v0LPpr4e9o3+aRmYKBGlB2jPRvrOi+gu6Ie2PUKYK7R5IcTALykZjuIuiRAQ71l
        SgT9rO16pD8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9945EA95B9;
        Wed, 21 Apr 2021 19:28:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2201AA95B7;
        Wed, 21 Apr 2021 19:28:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v7 01/28] refs: ref_iterator_peel returns boolean,
 rather than peel_status
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
        <8103a80394aefdd4e8b5061dfbb6a6199fe5fcae.1618832276.git.gitgitgadget@gmail.com>
        <xmqq35vk7pzd.fsf@gitster.g>
        <CAFQ2z_MaS_jBof5VaqRg8K+0NN2n1GQ7mwnKnvjy__yzchwv1Q@mail.gmail.com>
Date:   Wed, 21 Apr 2021 16:28:48 -0700
In-Reply-To: <CAFQ2z_MaS_jBof5VaqRg8K+0NN2n1GQ7mwnKnvjy__yzchwv1Q@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 21 Apr 2021 12:15:40 +0200")
Message-ID: <xmqqa6prxln3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5336CB9E-A2F9-11EB-8551-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> All callers of peel_iterated_oid use it as a boolean exclusively, i.e.
>
>   if (!peel_iterated_oid( .. )) { .. }
>
> Aside from these considerations, it is also odd to return peel_status.
> For example, PEEL_IS_SYMREF is unnecessary, because the symref status
> is already returned from iterator_next().
>
>> I haven't seen a good justification given to help convince me that
>> this is a good change (and I presume it is, as I trust you or any
>> other contributores enough not to knowingly make the system worse),

I am not sure I agree 100% with

	if (!do_this()) {
		...
	}

i.e. "try doing it and do one thing upon success" is a sign that all
error conditions will ever be treated equally and justifies to squash
all the error codes the current code tries to return, but whether I
agree with it or not, I'd want to see it recorded in the proposed
log message.  It would help future developers and allow them to take
into account your motivation behind this change, when they need to
update the implementation.

>> > +/*
>> > + * Peels the current ref, returning 0 for success.
>> > + */
>>
>> And if it does make sense to squash the peel status down to "bool",
>> then the comment should mention the single acceptable value for
>> failure, not just "0 for success" which implies "different negative
>> values depending on the nature of failure".
>
> I can make it return -1 instead.

I do care more about _documenting_ it here, not just ending the
sentence with ", returning 0 for success", it should also say
"returns X upon failure", whether the value of X is 1 or -1 (and
obviously our codebase prefers -1 for an error, but that is
secondary).

Thanks.

	
