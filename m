Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05D0C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 21:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96596613C2
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 21:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343702AbhDFVfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 17:35:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54132 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242075AbhDFVfk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 17:35:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ACD91BA232;
        Tue,  6 Apr 2021 17:35:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cN7orWLOPNPd6Til3MQzM13igKk=; b=YQOVOk
        3Kun8hDcBPYsW/Gm9E4NhKKcdPTPBWdOBryFR0/IAtj4NKP4RxgnKpUIonHsUxDX
        sJSx4vf5sSCzVZcImNJBCNA2p6cQAJuGIJY98LBXLJOs/1ZTzzMX0peXQ/dLaLnw
        fBLk7TWtxVZd2pdsBf/Pxy0JuKECQ9j9uIxV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bnYOt42gY3fk8aYvvkZAnupOdbP63U26
        plb4OyeuPJ7j5jtYPzjEygL5b9PtJ1VuxwCqmZBtadzeW1xD4mrYn3IEtmvJQS2V
        S5GSEAo2hm6j4+P1J+30SRLLQoaJINrxcfeDOcDFklqRoQ8eM2EVJ//APbCPtMxy
        LWS3b9JE7+I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A390ABA231;
        Tue,  6 Apr 2021 17:35:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3398EBA230;
        Tue,  6 Apr 2021 17:35:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2021, #01; Mon, 5)
References: <xmqqy2dw2pai.fsf@gitster.g>
        <6000ac2f-5d6d-09a2-c44d-4090e3d4c804@gmail.com>
Date:   Tue, 06 Apr 2021 14:35:29 -0700
In-Reply-To: <6000ac2f-5d6d-09a2-c44d-4090e3d4c804@gmail.com> (Derrick
        Stolee's message of "Tue, 6 Apr 2021 08:57:22 -0400")
Message-ID: <xmqqwntf14gu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 028991CA-9720-11EB-9F19-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 4/5/2021 9:08 PM, Junio C Hamano wrote:> * ds/clarify-hashwrite (2021-03-26) 1 commit
>>   (merged to 'next' on 2021-03-30 at 701f5c0696)
>>  + csum-file: make hashwrite() more readable
>> 
>>  The hashwrite() API always resulted in a call to write(2), even
>>  when writing a small amount of bytes that would still fit in the
>>  internal buffer held by the hashfile struct.  It has been updated
>>  to delay the writing until the buffer is filled or the hashfile
>>  concluded for performance.
>
> Sorry for not noticing earlier, but this branch description is
> based on my erroneous understanding of the change in v1. The
> commit now only rearranges and comments the method to be more
> clear that it is correctly buffering the data. Perhaps this
> could be a substitute?
>
>   The hashwrite() API uses a buffering mechanism to avoid calling
>   write(2) too frequently. This logic has been refactored to be
>   easier to understand.

Thanks, yes I did recall we replaced this topic with an updated
version that concentrates on readability.  The proposed text looks
good.

>> * ds/sparse-index (2021-03-30) 21 commits
>> ...
>>  (this branch is used by ds/sparse-index-protections.)
>> 
>>  Both in-core and on-disk index has been updated to optionally omit
>>  individual entries and replace them with the tree object that
>>  corresponds to the directory that contains them when the "cone"
>>  mode of sparse checkout is in use.
>
> I believe this one has been stable for a little while. Do you
> think it could be a candidate for 'next' soon? Alternatively,
> you could wait and merge ds/sparse-index and
> ds/sparse-index-protections at the same time. I just know that
> the second series is causing some merge contention with other
> topics.

I was planning to give this another scan before marking it as "Merge
to 'next'", hopefully before the end of this week.

Thanks.
