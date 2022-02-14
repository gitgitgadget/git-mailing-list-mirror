Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94658C433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 17:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357008AbiBNRW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 12:22:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240202AbiBNRW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 12:22:58 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3AA652EF
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 09:22:50 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D285C180D7E;
        Mon, 14 Feb 2022 12:22:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pOsWr03V8RiF
        D8bRTHHLr0E37mUnVGJ/PBwvFj9wpIQ=; b=LaNJWxgknbrB2a/c2yqf1FPFAKrJ
        MVus2jDt03EtApRMzKxCRoN8nMYAaJooIV6T+wDgxZYpyo13nNDfx/ExVNw0X4oC
        xK8yFT+e2F7bPJFnthSKy5FBzhgrWXTdVjqJKjwNElP8taTiIUhPA7GogdzCQZss
        q91B6ZYErxyNrI0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CA0AF180D7D;
        Mon, 14 Feb 2022 12:22:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 36A3B180D7C;
        Mon, 14 Feb 2022 12:22:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/6] archive: optionally add "virtual" files
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
        <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
        <49ff3c1f2b32b16df2b4216aa016d715b6de46bc.1644187146.git.gitgitgadget@gmail.com>
        <d1e333b6-3ec1-8569-6ea9-4abd3dee1947@web.de>
        <xmqqbkzigspr.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2202081406520.347@tvgsbejvaqbjf.bet>
        <xmqqbkzhdzib.fsf@gitster.g>
        <b49d396d-a433-51a4-2d19-55e175af571a@web.de>
        <xmqqk0e364h7.fsf@gitster.g>
        <6f3d288a-8c2f-0d63-ea17-f6c038a9fa3e@web.de>
        <xmqqk0e2frux.fsf@gitster.g>
        <f83ed995-6dff-bc41-8782-48ac9f1a2651@web.de>
        <xmqqk0e19jrp.fsf@gitster.g>
        <b05f916c-4b04-4db6-d203-10be0a8eb615@web.de>
        <xmqqfson706p.fsf@gitster.g>
        <2d4358db-fc6e-dc89-e647-b1b810817873@web.de>
Date:   Mon, 14 Feb 2022 09:22:46 -0800
In-Reply-To: <2d4358db-fc6e-dc89-e647-b1b810817873@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 13 Feb 2022 10:02:07 +0100")
Message-ID: <xmqqczjp4b2x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BA67468E-8DBA-11EC-A2C8-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 13.02.22 um 07:25 schrieb Junio C Hamano:
>>
>> So we do need some extra "manifest" to declare what's untracked etc.,
>> if we allow --add-file etc. to munge the tree when creating a tarball
>> out of it.
>
> Right, or get that information from the order of files in the archive,
> by having tracked files come first, then the signature file with a
> certain name and then untracked files.

That sounds like a workable approach, modulo that the details of the
"signature file with a certain name" part needs to be worked out.

We should make sure that we clearly document that "--add-file=3D" and
friends add their material after the contents that come from the
tree-ish, and make sure that the program does so and will stay doing
so.  Otherwise users cannot easily create an archive that follows
the above rule.

Thanks.
