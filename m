Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E464C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 17:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC1D20758
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 17:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vOnx9LxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388236AbgJBRDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 13:03:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60016 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgJBRDY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 13:03:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E2619F219;
        Fri,  2 Oct 2020 13:03:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zwcr5bTuS1Ukmj4+2J2xZnbH1ro=; b=vOnx9L
        xLd+66qZySGzAIN3E50izD9+teSrqO2Rg2mJw6W61Oi1LS9Z2tdtS7gTUONd3Ufm
        RFI1062HBOFfor2ft+ileR/8ig8MmSs83VwnIjjjCXYflhAj8j857mOxJbSg5mnF
        TG+49g9GEycPVBfpMb4gDTo1up5Jb0e2y5y58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yfaeE5zzyRw/bwBXOtsfd4QMtrHBusyf
        fc/ItymdIRmN9Vi8lZwHLq5aBaAYd0S8Q3vBR1lZeA11fmazmzu3e8+stISY0vt+
        0wlrHyEXBnWG9NrhgpFC61RAivXF65S6BVXxC5JBmZVG4bfu+MYivRwNNFwCbYn6
        FaS37ITi4MQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3501F9F218;
        Fri,  2 Oct 2020 13:03:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF17E9F217;
        Fri,  2 Oct 2020 13:03:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Carlo Arenas <carenas@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] range-diff: fix some 'hdr-check' and sparse warnings
References: <e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com>
        <41a60e60-d2c0-7d54-5456-e44d106548a4@kdbg.org>
        <xmqqy313p5hn.fsf@gitster-ct.c.googlers.com>
        <ec635d0d-00ca-2419-3c1a-9b0343b46daa@kdbg.org>
        <xmqq1rytpqse.fsf@gitster-ct.c.googlers.com>
        <CAPUEspgD8E02FcNvBx96neGEejdqMDWoH8NgpsHyGPo_KM09FA@mail.gmail.com>
        <nycvar.QRO.7.76.6.1907151647110.47@tvgsbejvaqbjf.bet>
Date:   Fri, 02 Oct 2020 10:03:21 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1907151647110.47@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 15 Jul 2019 16:47:32 +0200 (CEST)")
Message-ID: <xmqq4knca7c6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D29F960-04D1-11EB-9F98-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 13 Jul 2019, Carlo Arenas wrote:
>
>> On Sat, Jul 13, 2019 at 2:29 PM Junio C Hamano <gitster@pobox.com> wrote:
>> >
>> > I wish if we could say
>> >
>> >         struct patch patch = {};
>>
>> that is actually a GNU extension that is supported by gcc and clang (at least)
>> and that sparse also recognizes as valid; it is also valid C++ so it might be
>> even supported by MSVC.
>
> It seems to be supported by MSVC, at least as of VS2019.

In <nycvar.QRO.7.76.6.2010021555290.50@tvgsbejvaqbjf.bet> on Fri, 2
Oct 2020 15:57:45 +0200 (CEST), it was said:

> Before you further split it up, I encourage you to include these patches
> without which the CI builds will continue to fail (Junio, could I ask you
> to either cherry-pick them from https://github.com/git-for-windows/git's
> shears/seen branch, or apply them from the mbox?):
>
> -- snipsnap --
> From e485e006f34922439f2e971a1c5c38b8ca56c011 Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Wed, 30 Sep 2020 14:46:59 +0200
> Subject: [PATCH 1/3] fixup??? reftable: rest of library
>
> 	struct abc x = {}
>
> is a GNUism.

Perhaps VS2020 no longer allows it?

;-)

Jokes aside, I think we agreed in that old thread I am responding to
that "= { 0 }" was the way to go, so let's keep doing so.

Thanks.
