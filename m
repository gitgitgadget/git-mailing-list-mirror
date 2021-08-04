Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35ADC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 02:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C18E960E78
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 02:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbhHDCFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 22:05:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57093 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbhHDCFv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 22:05:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 034C4D8636;
        Tue,  3 Aug 2021 22:05:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k9pfPeCTn7Mw6Yo34OQvS3YwO5GjcSv7qaCC/m
        sdIgw=; b=DlMnTZb1GFpLR8+d9QGpihvKOn5T68m0W3IXRwvRZKUMk3WHy6Quo0
        s5a6gDVVlJUiN7+PF0Wn5jhdqWDQ6MT+MtviZt9oW9Szg9qEaxMxX9Pbh0cwDV14
        DmRRCDY0Z+IHAXjivCCmBvIffevrAXRtGBH+V0wILfwzOhR9PQ6mc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EE5FFD8635;
        Tue,  3 Aug 2021 22:05:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 795F3D8634;
        Tue,  3 Aug 2021 22:05:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 07/10] merge-strategies.txt: explain why no-renames
 might be useful
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
        <7eecf879d608d8be17d4aa0ae087fb610156019c.1628004920.git.gitgitgadget@gmail.com>
        <xmqqeebarr36.fsf@gitster.g>
        <CABPp-BGKbV7WPKmMdzetXgzaqzzaGGQ6SRuKHENkQh98-huotw@mail.gmail.com>
Date:   Tue, 03 Aug 2021 19:05:37 -0700
In-Reply-To: <CABPp-BGKbV7WPKmMdzetXgzaqzzaGGQ6SRuKHENkQh98-huotw@mail.gmail.com>
        (Elijah Newren's message of "Tue, 3 Aug 2021 18:44:27 -0600")
Message-ID: <xmqqr1faq80e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76968928-F4C8-11EB-9341-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> >  no-renames;;
>> > -     Turn off rename detection. This overrides the `merge.renames`
>> > -     configuration variable.
>> > -     See also linkgit:git-diff[1] `--no-renames`.
>> > +     Turn off rename detection, which can be computationally
>> > +     expensive.  This overrides the `merge.renames`
>> > +     configuration variable.  See also linkgit:git-diff[1]
>> > +     `--no-renames`.
>>
>> Other reasons are that we may find a pair that the user did not
>> intend to when they made the change (i.e. it was done purely a
>> creation and a deletion but we found similarity), or we may find a
>> wrong original to consolidate changes from a side branch into, and
>> these are fundamental as it is our early design choice not to
>> record renames at the time of committing.
>
> Good points.  Trying to describe all of that makes it somewhat
> lengthy; does it make sense to include all of that, or should I just
> drop this patch?

What do the git-diff page say?  If it is not worth saying there,
perhaps we should not have to do so here, either.

We should have _somewhere_ that lists these pitfalls that the users
may want to be aware of, that is common to all the features that
ends up using and relying on the rename machinery.  I do not think
merge strategies documentation is the place.


