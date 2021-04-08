Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8004EC433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 17:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545936102A
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 17:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhDHRpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 13:45:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54654 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhDHRpY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 13:45:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03DEEB2359;
        Thu,  8 Apr 2021 13:45:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2xQougqNl1ca2bFjiBJoju9JtBc=; b=RLX3xD
        fLlWOqZSff9UBfrYFClN+FHLelFo6zHya6ROs7mx0ouCWN+6rtmITL1l4hs/sr3Q
        iCs3ekG1lIhilr8AISrfVk2OceJ4zQfDz9EDCoJPv3OZaWji3n84oB2wEZB1twbB
        8jr3QA4oFBBxpT9xgMGynItRyY15K+itXiDtk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oYIJW3PR88wqERDGQ6UEsOWaU5ly5fFB
        MWu1XT8rungv1hw7np8iuB1CvzvPjDR790vN327IZoouO/JRkFWWpv7E7jnegY+/
        A8lBqZTOL5A5MNMPuru+VGkFKfsJjmf+oydYSls9jLL4y875urog/L/SuCa7rjYS
        FcDURBLTiO0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EBEDFB2358;
        Thu,  8 Apr 2021 13:45:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F505B2357;
        Thu,  8 Apr 2021 13:45:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: unifying sequencer's options persisting, was Re: [PATCH v2]
 sequencer: fix edit handling for cherry-pick and revert messages
References: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com>
        <pull.988.v2.git.git.1617070174458.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2103301200020.52@tvgsbejvaqbjf.bet>
        <CABPp-BGwAtpsQJ8U5N1q21PMkideptY2MB2PNgbPqvya+XuyHg@mail.gmail.com>
        <nycvar.QRO.7.76.6.2103311533340.52@tvgsbejvaqbjf.bet>
        <3b117e65-bf9f-af13-b093-28bbbd6f9bb3@gmail.com>
        <xmqqa6qg4d0i.fsf@gitster.g>
        <CABPp-BEzayZkEZ36CFNBGz9X3jv0MNUnWa2EhzKKmWcb83yRmw@mail.gmail.com>
        <xmqq7dlk2ug9.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2104080438080.54@tvgsbejvaqbjf.bet>
Date:   Thu, 08 Apr 2021 10:45:09 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2104080438080.54@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 8 Apr 2021 04:40:46 +0200 (CEST)")
Message-ID: <xmqqzgy8u0uy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A090636-9892-11EB-9F18-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > ...  It's enough of a speedup that if backward
>> > compatibility won't allow such a method to be used by default, I'd
>> > still make yet another backend that could be optionally used.  And I'd
>> > have the default rebase and cherry-pick start printing annoying
>> > deprecation notices so that users become aware of a faster option.
>>
>> A faster and less powerful interface is good; I doubt deprecation
>> would work well. If a workflow depends on things like post-commit
>> hook, the affected users deserve some way to migrate to --exec or
>> whatever method to compensate the loss of functionality.
>
> I could imagine that there is opportunity to "persist on disk only when
> needed". For example, if no `pre-commit` hook is installed that needs to
> be run, there is no need to update the worktree nor HEAD until the rebase
> is done.
>
> And this type of `only write to disk when needed` functionality could
> probably be abstracted away so much as to make the rest of the code
> look elegant again.

Yes, we are on the same page.  What Elijah proposed as "another
backend" would unfortunately be different, and needs to be adjusted
with such an "only when needed" tweak.  The check hopefully needs to
be done only once (e.g. do we have this hook enabled?  do we have
that hook enabled? do we have a commit with this trait in the range
being worked on? etc. etc.) upfront and for certain workflows may
not require any persistence.

And until that happens, "annoying deprecation notices" will never be
a viable step to take.
