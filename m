Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF19C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 21:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E3C23AFE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 21:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgLHVOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 16:14:22 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50927 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgLHVOV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 16:14:21 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D01B41083C9;
        Tue,  8 Dec 2020 16:13:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p3pEuanyUU1na+z6dUlTJ9A05Fo=; b=hf/+6n
        1HmCu1NjU71GV9nK26jZsWCBjPGCzkrrUFvDokAb2KX8VeDfigXPt0tHLCDsXeWh
        X7HvdzwpdGuqJuixuXU7evgXF1fb6PN7nBcc7b5zxo78eZy6lO8HuImOsGl6oaPD
        Ka8an1JoadDxQlVNtSq9eTsa40dw3QD+ZBWLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Hs0otHM690B1bL8vETlVkbhbbNWvbaJb
        E+XB6d5CMrY5PzbD0DljbMFFpqtc8AvaDjNlpQvQJmHOvU3rm1SFfTeBQB44zUo5
        rL9FEHM1gDiUSzo/t4CNGV2BJlHbJHyRkdP0bKQCb6DdYPpxaQesAtTtpWqhxYP/
        fM/sENuYr5E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C855E1083C8;
        Tue,  8 Dec 2020 16:13:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1B15C1083C7;
        Tue,  8 Dec 2020 16:13:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t5310: stop expecting the default branch name `master`
References: <pull.809.git.1607260623935.gitgitgadget@gmail.com>
        <xmqqim9dbh17.fsf@gitster.c.googlers.com>
        <X8/bYzjP569wEL5x@nand.local>
Date:   Tue, 08 Dec 2020 13:13:35 -0800
In-Reply-To: <X8/bYzjP569wEL5x@nand.local> (Taylor Blau's message of "Tue, 8
        Dec 2020 15:00:35 -0500")
Message-ID: <xmqq360g6lxc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CB60E5C-399A-11EB-AA2F-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Dec 07, 2020 at 10:35:48AM -0800, Junio C Hamano wrote:
>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>>
>> >     This one goes on top of tb/pack-bitmap, and requires an update of
>> >     js/default-branch-name-tests-final-stretch (it no longer needs to
>> >     hard-code GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME in t5310).
>>
>> As the targetted topic is not in 'next' and marked with "Needs a bit
>> of reshuffling?", I'd appreciate this patch to be also forwarded so
>> that I do not have to worry about it myself.
>
> Ah, sorry that I missed this before sending out v3. I was hoping that
> the fixup would be limited to one patch, but this needs to be either
> spread across multiple patches, or applied at the end.
>
> Since I already sent v3, how do you want to handle this?

As I have many other topics on the table to attend to, I can skip v3
and take v4 if it is not too much trouble to fix the issue at the
source.  Thanks.
