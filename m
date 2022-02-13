Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7626C433EF
	for <git@archiver.kernel.org>; Sun, 13 Feb 2022 06:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbiBMGZa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Feb 2022 01:25:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiBMGZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Feb 2022 01:25:27 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F052E5E77C
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 22:25:21 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 331A5110D91;
        Sun, 13 Feb 2022 01:25:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LxtfOeRI6RIk
        6UQnZog/+kLDGWDVJd16iNjhzyL/sP4=; b=MmmWs4PvLOiUef21aLJYiGbWJnNJ
        8h/UU0NzJRxpevZ5JYLkJb+aKaQTG5E9shcDf40XPTGPZ+4sMJ7sbxg9wvnhSHUf
        ILVEsbzb9iXkBZz+XZz++91OCckUO0WlvzkEDFOcOETTz+ZKpY+q1MPOCci6kmPh
        oguM4FKPJLzVFCU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29771110D90;
        Sun, 13 Feb 2022 01:25:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.67.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6CEDA110D8F;
        Sun, 13 Feb 2022 01:25:19 -0500 (EST)
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
Date:   Sat, 12 Feb 2022 22:25:18 -0800
In-Reply-To: <b05f916c-4b04-4db6-d203-10be0a8eb615@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 12 Feb 2022 10:12:30 +0100")
Message-ID: <xmqqfson706p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B748668E-8C95-11EC-B61C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> The verifier has a tarball.  In addition, the verifier knows the
>> object name of the Git tree object the tarball was taken from, and
>> somehow trusts that the object name is genuine.  We can do either
>> "untar + git-add . && git write-tree" or its equivalent to see how
>> the contents hashes to the expected tree (or not).
> ...
> Right, but the tree hash does not directly allow to see which objects
> are tracked or not.

Ah, of course---it was silly of me to overlook this obvious fact X-<.
So we do need some extra "manifest" to declare what's untracked etc.,
if we allow --add-file etc. to munge the tree when creating a tarball
out of it.

