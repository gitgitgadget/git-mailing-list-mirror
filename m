Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A7DC433DB
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 21:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8122A22D50
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 21:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbhAPVvz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 16:51:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61338 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbhAPVvy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 16:51:54 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0599CAFCF4;
        Sat, 16 Jan 2021 16:51:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=06s+fp4U2Wqo5xcePHwIPivgt
        4I=; b=OLsegyCWIrbMex8V/GTShkTH/SlWdMg+qrV6lMORitUdwVn0shaa4Ktqv
        wED9kAclIrn7UKz0b7245d+zgKicmVVyRVTnS57svDYw9j904yxRAeF2kL5fX9iI
        6jVUi3klrunpt9iVihkkLBr3E4rWtni9ifG3euVSz5mz6yNjFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=sZ3RSMl/r7ctfqFkhzG
        P1l87yRs9DDD7J3uppJvT8IE2rhi0+8ig1CyDCDyiWFev0m6vjKZ3KDv/Q20LRGF
        Z6ZZAQX2E6deF5D02oNSspW/fAY0GvHiBmSQy6Z+dVoTVHkKaAL3Wqk6vUqtsblI
        a7XXnq90YjaR0PXcWGCzO+f4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F19A1AFCF3;
        Sat, 16 Jan 2021 16:51:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7CAF9AFCF2;
        Sat, 16 Jan 2021 16:51:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 06/11] git-svn tests: rewrite brittle tests to use
 "--[no-]merges".
References: <20210114233515.31298-1-avarab@gmail.com>
        <20210116153554.12604-7-avarab@gmail.com>
Date:   Sat, 16 Jan 2021 13:51:10 -0800
Message-ID: <xmqqo8hoo8j5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F28CDE54-5844-11EB-8651-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> From: Jeff King <peff@peff.net>
>
> Rewrite a brittle tests which used "rev-list" without "--[no-]merges"
> to figure out if a set of commits turned into merge commits or not.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> Commit-message-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
.com>

The last two entries are not chronological, but when you relay a
patch by others with tweaks, we typically do it more like this:

    From: Jeff King <peff@peff.net>

    Rewrite a brittle ...

    Signed-off-by: Jeff King <peff@peff.net>
    [=C3=86AB: wrote commit message]
    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>

e.g. cf. 155067ab4f, a9ecaa06a723, 567ad2c0f9

Thanks.
