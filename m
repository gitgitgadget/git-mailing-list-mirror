Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02159C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E30C760EE2
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbhIPTOb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:14:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62422 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbhIPTOb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 15:14:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E498D768B;
        Thu, 16 Sep 2021 15:13:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LO75q942q2nV
        YbAioGlS7r6LilwadrUX+kgl1eDx50I=; b=GLobgXj6EyzLoKvXgtYxvTCxIZ6p
        Y2Na4cQbdST9w7IV0l1admhCDwNrm54DS0od4Y53NEtAvMl/xgWQh0nYrD/XOzff
        6nxLZpXHUgXLGDVfou3U83Upj/VVUHCcXbmEo6hIWoWY54OSr8aKnYseHMfZhxAf
        Vqimrs3CweqMmgY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96E55D7689;
        Thu, 16 Sep 2021 15:13:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 22253D7688;
        Thu, 16 Sep 2021 15:13:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/7] trace2: fix memory leak of thread name
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
        <5f557caee004f22cee33e8753063f0315459d7e1.1631738177.git.gitgitgadget@gmail.com>
        <87fsu5m649.fsf@evledraar.gmail.com> <YULZbQgxuyw8iJ/R@nand.local>
        <87ilz1gd24.fsf@evledraar.gmail.com>
Date:   Thu, 16 Sep 2021 12:13:08 -0700
In-Reply-To: <87ilz1gd24.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 16 Sep 2021 10:01:24 +0200")
Message-ID: <xmqqr1dotjuj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 20FEFFE6-1722-11EC-9C57-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Indeed, to be clear it was just general advice about queue-on-top.
>
> But to clarify what I was getting at here: If we just came up with the
> same diff I'd have assumed Jeff just hadn't need the change in "next",
> but since he clearly has I was confused by it being here.
>
> I.e. it doesn't *seem* like anything in the rest of the series depends
> on it, so why have it here at all since the bug is being fixed anyway?

I'd imagine that it was there just for the same reason series from
some people (yours included) tend to bloat, either over iterations
or from day one, by including "this is not necessary for the end
goal of this topic at all, but since I noticed it, I am including
this fix, which should be obvious enough" unrelated fix.

Here is a lesson to be learned.
