Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBB9C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA81960F42
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbhH3Rrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 13:47:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61989 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhH3Rro (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 13:47:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4CB2D3158;
        Mon, 30 Aug 2021 13:46:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FsJ7BnTM2XAH
        qfEoOk0Sj4E2feeHby/mTKURV+aEDrc=; b=PA9iCe8DrirWX5AwPGQNd1f3rFhM
        YU5XpBj6r0A4oXySgfaj0d79e2PpbrMoa2m1HTIuPEwBbxb7kEvWAL4DGTQAGA6V
        4WMD3Y/VeYOcgIuUYSOzc+CieGPvrxZ2dAkDRJtD/JZ4CIjMrgpgO7BkSLvWXVmD
        gD86w+A7QEFgIZc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD5C3D3157;
        Mon, 30 Aug 2021 13:46:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5AA63D3156;
        Mon, 30 Aug 2021 13:46:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Clemens Fruhwirth <clemens@endorphin.org>,
        Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>,
        Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
Subject: Re: [PATCH v3] pull, fetch: fix segfault in --set-upstream option
References: <patch-v2-1.1-9e846b76959-20210823T125434Z-avarab@gmail.com>
        <patch-v3-1.1-68899471206-20210830T144020Z-avarab@gmail.com>
Date:   Mon, 30 Aug 2021 10:46:48 -0700
In-Reply-To: <patch-v3-1.1-68899471206-20210830T144020Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 30 Aug
 2021 16:41:18
        +0200")
Message-ID: <xmqqilzm4ygn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 40974A04-09BA-11EC-B53B-D601C7D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> There was an earlier submitted alternate way of fixing this in [1],
> due to that patch breaking threading with the original report at [2] I
> didn't notice it before authoring this version. I think the more
> detailed warning message here is better, and we should also have tests
> for this behavior.

I do not think it is necessarily an improvement to give more info,
if it is irrelevant to explain what the error is.  And the point of
the error message here is that we cannot set the upstream of
detached HEAD, no matter what the value of old source ref or new
source ref are.

The original from Clemens gives a warning message that omits the
piece of information that does not contribute to the error.

Testing the new behaviour is a good idea.  I also agree with you
that die() would be more appropriate and does not risk regression,
if the original behaviour was to segfault.

Thanks.
