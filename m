Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32507C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 00:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10AA8613CC
	for <git@archiver.kernel.org>; Wed,  5 May 2021 00:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhEEAYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 20:24:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64022 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhEEAYC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 20:24:02 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CAA4DCB1E3;
        Tue,  4 May 2021 20:23:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1MObASarQw1f
        w9wBX9kJFeYhcsyfHT2y9fJlhxUeGvc=; b=x7ViF2emPbwuBNQqyH3V0o2/7CZ6
        9qxMVEz4YjVfuUSTJQqx4YZlnSpT0hdYetsdQbkP8GsKlWk1Hjy+KmjDfeTkMRvC
        kPCyVkr1UF+pbMsooiVuNif/3mKEYuByJ/hTGMN0PqPEpMSrNuuW/Z63e2nZuV4U
        X6NijlFUpdhZ+KQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8AFFCCB1E2;
        Tue,  4 May 2021 20:23:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D802ECB1E1;
        Tue,  4 May 2021 20:23:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Mark Amery <markrobertamery@gmail.com>, git@vger.kernel.org
Subject: Re: Bug: Changing folder case with `git mv` crashes on
 case-insensitive file system
References: <CAD8jeghpOQoibk0xM0QgLsOwLNw9GdM=4rhYuzV-NSkw8LinMQ@mail.gmail.com>
        <20210504151954.aczbvml4rh7t2svc@tb-raspi4>
Date:   Wed, 05 May 2021 09:23:05 +0900
In-Reply-To: <20210504151954.aczbvml4rh7t2svc@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Tue, 4 May 2021 17:19:54
 +0200")
Message-ID: <xmqqtuni58ra.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0FC25F06-AD38-11EB-A39B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> To my undestanding we try to rename
> foo/ into FOO/.
> But because FOO/ already "exists" as directory,
> Git tries to move foo/ into FOO/foo, which fails.
>
> And no, the problem is probably not restricted to MacOs,
> Windows and all case-insenstive file systems should show
> the same, but I haven't tested yet, so it's more a suspicion.
>
> The following diff allows to move foo/ into FOO/
> If someone wants to make a patch out if, that would be good.

Is strcasecmp() sufficient for macOS whose filesystem has not just
case insensitivity but UTF-8 normalization issues?


