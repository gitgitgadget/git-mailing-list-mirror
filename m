Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4372C433E9
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E5C164E99
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354600AbhCDBDp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:03:45 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51641 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451303AbhCDA4i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 19:56:38 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F63F10F642;
        Wed,  3 Mar 2021 19:55:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R3TINW2FbSUeCo5187BlJPTK6E8=; b=W+LEWB
        Rd+EUML0ljkzssBs71IFPFiIFGCah3CywHPSD2WVd3BVV8kdSzjKaoFyh+DkaauJ
        sQA4SSEMYo2KOLeL0X6Be5ywUCwDvsZ9groyD2I8u0jwCltnSo4u+c2p+VdzoUAs
        EDSneQ7NIZiEDAsHmRCBJV8EKMcBeJUpbJ5gA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ggIpq0bVy/yyWDyGDeMWnFbjh2SyJNqP
        Wixll3BQzJyPeqwRf339pMNgcqYmAfv/DN/aMpBoRgQ7Risyw1m9FHuiCxlWYXoM
        yH7h1EXJHdjTg15k//he9vcvPYYeYznFrRrh4gve4zODKDSqiNXZSypD6eqgXR2B
        SHQXog7/1Is=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 482F110F640;
        Wed,  3 Mar 2021 19:55:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 94D3F10F63F;
        Wed,  3 Mar 2021 19:55:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     anatoly techtonik <techtonik@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Round-tripping fast-export/import changes commit hashes
References: <CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com>
        <CABPp-BGDB6jj+Et44D6D22KXprB89dNpyS_AAu3E8vOCtVaW1A@mail.gmail.com>
        <CAPkN8xK9__74a3aEFsevfdW_hQ-vzWE+c=QypRacTktuZOfdSw@mail.gmail.com>
        <87mtvolbuj.fsf@evledraar.gmail.com>
        <CAPkN8xLE68d5Ngpy+LOQ8SALNgfB-+q4F3mFK-QBD=+EOKZSVg@mail.gmail.com>
        <xmqqblc2srq0.fsf@gitster.c.googlers.com>
        <CAPkN8xKM0zi-AB1xKRGp=whEQTZAbn78w0JjvUXfGfRDky0C=w@mail.gmail.com>
        <08f31194-dce6-9434-c362-94d9a2d97563@kdbg.org>
Date:   Wed, 03 Mar 2021 16:55:54 -0800
In-Reply-To: <08f31194-dce6-9434-c362-94d9a2d97563@kdbg.org> (Johannes Sixt's
        message of "Wed, 3 Mar 2021 08:13:13 +0100")
Message-ID: <xmqqlfb3g2jp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60305540-7C84-11EB-B5D8-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 02.03.21 um 22:52 schrieb anatoly techtonik:
>> For my use case, where I just need to attach another branch in
>> time without altering original commits in any way, `reposurgeon`
>> can not be used.
>
> What do you mean by "attach another branch in time"? Because if you
> really do not want to alter original commits in any way, perhaps you
> only want `git fetch /the/other/repository master:the-other-one-s-master`?

Yeah, I had the same impression.  If a bit-for-bit identical copy of
the original history is needed, then fetching from the original
repository (either directly or via a bundle) would be a much simpler
and performant way.

Thanks.
