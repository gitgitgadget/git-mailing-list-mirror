Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04BDC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 19:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB05760E0B
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 19:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243319AbhHZTGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 15:06:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59739 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbhHZTGK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 15:06:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04EEBD494C;
        Thu, 26 Aug 2021 15:05:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jMZOEkyMM+We
        lMl1CNLXGRJYk3uLx/rS80UcoCmMXxU=; b=gddXGrSPoKFyNDd6LFAAFmJ+e6Am
        zYBllOVuEGeqD6xygPTmsTHyCTu3BccV4UHI6l8kWwV8acVs8XTE2foclvWmFLBE
        7UZVNo7u6z8T7nfDoad+kRbKYpcr1fc+WnhyvOlWFbdm8W5eEpI0BgtSawGYq1hv
        r/Dy3ZiORvo/EDo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F09D9D494B;
        Thu, 26 Aug 2021 15:05:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82083D494A;
        Thu, 26 Aug 2021 15:05:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2] branch: allow deleting dangling branches with --force
References: <7894f736-4681-7656-e2d4-5945d2c71d31@web.de>
        <325d64e9-8a31-6ba0-73f2-5e9d67b8682f@web.de>
Date:   Thu, 26 Aug 2021 12:05:20 -0700
In-Reply-To: <325d64e9-8a31-6ba0-73f2-5e9d67b8682f@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 26 Aug 2021 20:19:15 +0200")
Message-ID: <xmqqk0k8do27.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8F9B1B5C-06A0-11EC-8026-D601C7D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> +	hash=3D$(git rev-parse HEAD) &&
> +	objpath=3D$(echo $hash | sed -e "s|^..|.git/objects/&/|") &&
> +	git branch --no-track dangling &&
> +	test_when_finished "test -f $objpath.x && mv $objpath.x $objpath" &&

Do we need test -f here?

> +	mv $objpath $objpath.x &&
> +	git branch --delete --force dangling &&

> +	test -z "$(git for-each-ref refs/heads/dangling)"

It is not wrong per-se, but maybe

	git show-ref --quiet refs/heads/dangling

is more straight-forward.

Thanks.
