Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473AAC433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 05:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D79B4613C0
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 05:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243870AbhDFFws (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 01:52:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50469 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhDFFwr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 01:52:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05ED2B43D5;
        Tue,  6 Apr 2021 01:52:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Mi5Za8lt77j2VoRsNiioGiEaXmk=; b=pXiXvE
        fYgRfXJpfZzEclDTXrDk2hernR0JuQcEGuzgJ0u8o+7Tg56Zgqi6ZL6dYyVWr0Ux
        +7B05+MEjYr5RxVolbFEmXMcHshcwsthZAkDOugjBUvxp2skqrHxT4sqdJr527Uj
        SOE20LvVSIY/TXr9PxGTjUO6TLYp1nzS45lTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v+G2+Vl8NhNknaiUeesaEVF/1HpPW6rZ
        zsU3nwVg33Z+hwLbQmnVBRuKV4xsSFWBs9Qz7IOVyC99lzb5xOq6prG2BvcoFS4m
        kVXa2U49kj7m3I75IeR1HHotg9OzsI7tckW4rmnRg/bf80KeQCIF/H2jncAN14Kq
        JhtWDFD0wzU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F1C7AB43D4;
        Tue,  6 Apr 2021 01:52:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E7D5B43D3;
        Tue,  6 Apr 2021 01:52:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Ross Yeager <ross@skydio.com>,
        Abraham Bachrach <abe@skydio.com>,
        Brian Kubisiak <brian.kubisiak@skydio.com>,
        Jerry Zhang <jerryxzha@googlemail.com>
Subject: Re: [PATCH V2] git-apply: Allow simultaneous --cached and --3way
 options
References: <20210403013410.32064-2-jerry@skydio.com>
        <20210405221902.27998-1-jerry@skydio.com> <xmqqr1jo4aex.fsf@gitster.g>
        <CAMKO5CuLpa9Sn_oXMpgP6oGE9NFA8aLeTfeyaW6TOTErE0KgEg@mail.gmail.com>
Date:   Mon, 05 Apr 2021 22:52:38 -0700
In-Reply-To: <CAMKO5CuLpa9Sn_oXMpgP6oGE9NFA8aLeTfeyaW6TOTErE0KgEg@mail.gmail.com>
        (Jerry Zhang's message of "Mon, 5 Apr 2021 19:52:06 -0700")
Message-ID: <xmqqh7kk2c49.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BC7C8EA-969C-11EB-B410-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> Thanks for the comments! I've updated v3 with the changes. Let me know
> if you have any
> more thoughts on whether to block / warn the user before clobbering their cache.

Please do not top-post on this list.

I've already said that I think we should ensure the index is clean
by default, because, unlike the case where the application is done
on the working tree files, the use of "--cached" is a sign that the
next step is likely to write a tree out.  As I've already said so in
earlier reviews, there is nothing more from me to add on that issue.

>> Give an order to the codebase to "be like so".  Here is my attempt.
>>
>>     Teach "git apply" to accept "--cached" and "--3way" at the same
>>     time.  Only when all changes to all paths involved in the
>>     application auto-resolve cleanly, the result is placed in the
>>     index at stage #0 and the command exits with 0 status.  If there
>>     is any path whose conflict cannot be cleanly auto-resolved, the
>>     original contents from common ancestor (stage #1), our version
>>     (stage #2) and the contents from the patch (stage #3) for the
>>     conflicted paths are left at separate stages without any attempt
>>     to resolve the conflict at the content level, and the command
>>     exists with non-zero status, because there is no place (like the
>>     working tree files) to leave a half-resolved conflicted merge
>>     result to ask the end-user to resolve.

I wrote the above as an example to illustrate the tone and the level
of details expected in our proposed commit log message.  The
behaviour it describes may not necessarily match what you have
implemented in the patch.

For example, imagine that we are applying a patch for two paths,
where one auto-resolves cleanly and the other does not.  The above
description expects both paths will leave the higher stages (instead
of recording the auto-resolved path at stage #0, and leaving the
other path that cannot be auto-resolved at higher stages) and the
command exits with non-zero status, which may not be what you
implemented.  As an illustration, I didn't necessarily mean such an
all-or-none behaviour wrt resolving should be what we implement---I
do not want to choose, as this is your itch and I want _you_ with
the itch to think long and hard before deciding what the best design
for end-users would be, and present it as a proposed solution.  An
obvious alternative is to record auto-resolved paths at stage #0 and
leave only the paths for which auto-resolution failed in conflicted
state.

Thanks.
