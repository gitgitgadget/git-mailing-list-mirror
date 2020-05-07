Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4949AC38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 15:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A2F2083B
	for <git@archiver.kernel.org>; Thu,  7 May 2020 15:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IVBGlStV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgEGPCN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 11:02:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50004 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgEGPCN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 11:02:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BCCD405BB;
        Thu,  7 May 2020 11:02:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EygUi/N98KLWT9GNb4lQ2NgcI70=; b=IVBGlS
        tVQKsAp84iVqcsTqazC4eXU6WzpiP0EH35B5yoarrR0bL/2n3YK1d7ucQJ9rxRjz
        xPvAvOdI0amgT+FFnOEn0vR5xQ8pBvKwT4ni2Cd0KZYuHfwbQQQlPLZ5omszqmm6
        JR5ZikR4wILy7gkR/tomkyAhyWCytqOoTGns8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TW2s1bWPKGQkNVWSAy3rul5gyxWraS5i
        BgtJWK7NiMres4XdWdghgbEzIzJL/cmZVZ6oJBfaVxo2jMvWs8SCLFzcZaQxhKff
        upuZMCaP7oGDT26DEg6099c6MZTHYT3Z+nubYbasj6M8tatzT4jLYrOEsrxXc2nz
        MnjeFksJJ44=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64234405BA;
        Thu,  7 May 2020 11:02:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C339E405B9;
        Thu,  7 May 2020 11:02:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Hariom Verma <hariom18599@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 1/2] fetch-pack: remove fetch_if_missing=0
References: <pull.606.git.1587412477.gitgitgadget@gmail.com>
        <eb0cbeeeed080596c130f657186894999ae6121b.1587412477.git.gitgitgadget@gmail.com>
        <CAP8UFD2b_27VeLFg3BrbacoJ5+GAxa+JrF3E2jS_dN-xyCRP_Q@mail.gmail.com>
Date:   Thu, 07 May 2020 08:02:09 -0700
In-Reply-To: <CAP8UFD2b_27VeLFg3BrbacoJ5+GAxa+JrF3E2jS_dN-xyCRP_Q@mail.gmail.com>
        (Christian Couder's message of "Thu, 7 May 2020 15:17:26 +0200")
Message-ID: <xmqqmu6j4wlq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9A01A46-9073-11EA-A657-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Apr 20, 2020 at 9:57 PM Hariom Verma via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Hariom Verma <hariom18599@gmail.com>
>>
>> Commit 6462d5e ("fetch: remove fetch_if_missing=0", 2019-11-08)
>> strove to remove the need for fetch_if_missing=0 from the fetching
>> mechanism, so it is plausible to attempt removing fetch_if_missing=0
>> from fetch-pack as well.
>
> It's ok to refer to a previous commit, but I think it would be better
> if you could repeat a bit the reasons why removing the
> fetch_if_missing global is a good idea, and not just rely on the
> previous commit.
>
> "it is plausible" also doesn't make it very clear that it's what the
> patch is actually doing.

I had the same reaction.  You could even write a random gibberish in
your patch and write "it's plausible this set of random changes made
without understanding what is going on in the current code might
have some chance to work" in your log message, and we would not even
want to touch such a patch with 10-foot pole.

The proposed log message above unfortunately makes this patch
indistinguishable from such a trash, unless we follow the codepaths
that are *not* touched by this patch and think about ramifications
of the removal *ourselves*.  In other words, it does nothing to help
the readers to support the change.

