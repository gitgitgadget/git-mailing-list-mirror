Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B749C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbiGSUQe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiGSUQd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:16:33 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4523940BF1
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:16:33 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9C23219CA62;
        Tue, 19 Jul 2022 16:16:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=05D/63CypQdPtStg9utEt1etw9nkfnpfGIPkgp
        nnE4o=; b=TOZAjDKSAA1Pdt4wnmN7NoAfRqFPbuyEBLhomrZlF9v21duhL4RYri
        Y2qfri+itpM38IekvszOFIK7EKVHwYILuyD+aLKZg8+/5LNv4y6hu/+Mm22375T+
        LiY0ct0fPlfMsOLxO13N/NIryD0iQ3FUmAQOOsg/tWYJmEpgNA43g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 92CE419CA60;
        Tue, 19 Jul 2022 16:16:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 246F819CA5F;
        Tue, 19 Jul 2022 16:16:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, newren@gmail.com,
        levraiphilippeblain@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v5] submodule merge: update conflict error message
References: <20220712231935.2979727-1-calvinwan@google.com>
        <20220718214349.3379328-1-calvinwan@google.com>
        <xmqqzgh5d2s5.fsf@gitster.g>
        <CAFySSZDqMVV=Zv9hVa+S9=fhuvCTZvZUL50qMfSJHh4KTpm5RA@mail.gmail.com>
Date:   Tue, 19 Jul 2022 13:16:27 -0700
In-Reply-To: <CAFySSZDqMVV=Zv9hVa+S9=fhuvCTZvZUL50qMfSJHh4KTpm5RA@mail.gmail.com>
        (Calvin Wan's message of "Tue, 19 Jul 2022 12:30:13 -0700")
Message-ID: <xmqqfsiwamec.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC622860-079F-11ED-B1A3-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

>> The stuff to help reviewers who may have seen earlier round are
>> usually written in the cover letter, or after the three-dash line.
> Ah I see since this patch doesn't have a cover letter, I should put
> all the reviewer-centric stuff after the three-dash line.
>
>> > +     if (csub && csub->nr > 0) {
>> > +             int i;
>> > +             printf(_("Recursive merging with submodules currently only supports trivial cases.\n"
>> > +                     "Please manually handle the merging of each conflicted submodule.\n"
>> > +                     "This can be accomplished with the following steps:\n"));
>>
>> This makes me wonder if these "helpful but verbose" messages should
>> use the advise mechanism.
>
> I agree. The only loss of information if someone turned off this message
> would be the commit id that possibly needs to be merged.

If the commit found by find_first_merges() are useful, then it is
losing information, so it is one argument against using the advise
mechanism.
