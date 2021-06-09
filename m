Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA821C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 07:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F99261002
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 07:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbhFIHSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 03:18:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64560 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhFIHSd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 03:18:33 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3EA4A1473C5;
        Wed,  9 Jun 2021 03:16:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fMMPKoXBoUnB
        91ysrldZEpdCYKF3AspdY9pm0v7Bd0c=; b=kbS3Ph7goLibVC6keUqHwojz6FC/
        a79s5r+PbWR3pf3fdZO5mLwVcaprDxPXEqrCWmUB13z8wPbrnpOn0hkgJ16AlRyx
        P3lKEvaLjTE+HkxXxD0T6fpwJda+Fy3Nafn026GMnnmm7WpYyULcIN3RN0SseUv5
        1faRcdXXK7TukOc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C6DC1473C4;
        Wed,  9 Jun 2021 03:16:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 65F2A1473C3;
        Wed,  9 Jun 2021 03:16:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 0/4] [GSOC][RFC] ref-filter: add %(rest) atom
References: <pull.976.git.1623163082.gitgitgadget@gmail.com>
        <xmqqtum7ln9m.fsf@gitster.g>
        <CAOLTT8RURwom91VqFATjMEGGe5NJRgyWSojCC=TH8DwG+7MeSA@mail.gmail.com>
Date:   Wed, 09 Jun 2021 16:16:34 +0900
In-Reply-To: <CAOLTT8RURwom91VqFATjMEGGe5NJRgyWSojCC=TH8DwG+7MeSA@mail.gmail.com>
        (ZheNing Hu's message of "Wed, 9 Jun 2021 11:55:43 +0800")
Message-ID: <xmqqzgvzik31.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A071091E-C8F2-11EB-BF1D-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> It=E2=80=99s worth mentioning that this patch still fails the github CI=
 test. [1]
>
> t6300-for-each-ref.sh:
> 274: Verify sorts with raw
> 275: Verify sorts with raw:size
> 278: empty raw refs with %(if)
>
> There is no such breakage on my local machine.
>
> [1] https://github.com/gitgitgadget/git/pull/976/checks?check_run_id=3D=
2774963705

It's one of the two 32-bit jobs, I think.  If the other one fails
the same way, that means the code does not work on 32-bit systems,
most likely something in your code assumes certain types are 64-bit
when they aren't.
