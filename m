Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05158C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 01:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0D1F6139A
	for <git@archiver.kernel.org>; Thu,  6 May 2021 01:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhEFBkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 21:40:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60826 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhEFBk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 21:40:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8ECEEBE1BA;
        Wed,  5 May 2021 21:39:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=679+oE2UL2Oo9AR2xTeigrYsLDLfOevskRFmZ4
        dTm8o=; b=VltSOzGpGrUCCVcxZnjzfJE0nGA41fSt8yWP3JUCaIR9BNx4ALsCQW
        ixsmpxJm9u9cWPt/cqNau1ass9V9gIXeNiEickVW46KXcUFtz/QFXzSToIblZrjw
        wAf+lfZ4V/ZqIQ3mllxP3zw/UAt1TJ56nx4AuA1OrRo3/FDODfnEQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 863DABE1B9;
        Wed,  5 May 2021 21:39:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 121AABE1B6;
        Wed,  5 May 2021 21:39:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?G=C3=A1bor?= Farkas <gabor.farkas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git switch/restore, still experimental?
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
        <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
        <877dkdwgfe.fsf@evledraar.gmail.com> <87sg3155dt.fsf@osv.gnss.ru>
Date:   Thu, 06 May 2021 10:39:28 +0900
In-Reply-To: <87sg3155dt.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
        05 May 2021 22:48:14 +0300")
Message-ID: <xmqqk0oc1vzj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5F5E128-AE0B-11EB-9309-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Isn't --merge a different (and inferior) way to achieve what we already
> have elsewhere with --autostash? Does it make sense to get rid of --merge
> here in favor of --autostash?

Not really.

The "--autostash" might appear to be applicable to cases that can
induce larger conflict, but once the diversion gets larger than what
one comfortably can deal with "checkout -m", the user is better off
to work by forking a branch there and create a WIP commit, than deal
with the stash.  So if anything, I'd rather get rid of "--autostash"
than "-m", to help users get in a better work habit.


