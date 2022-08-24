Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025ADC00140
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 15:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbiHXP6b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 11:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbiHXP61 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 11:58:27 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697887CAB6
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 08:58:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E1DA81ACB7D;
        Wed, 24 Aug 2022 11:58:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7wd+isRCwjpE
        dTxtFOgtJHY/2jN18AJWsnIahw5eai8=; b=nXZLdnUdvQWWGGXeOsgAn3H5qOyr
        1E46877qOF09Kb482zCF/uoS35VY3Xd++b+jKMtMB5kB6BsgbGXC+pELPk0rsoPS
        ixWiBxOs/Nnmk1G/hFkEM4YaDT2QPBaFCgRilrfUCOHydRE/NbQiw/HzhSwG1cae
        KaNsdl6GJBfsE0Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D9ADB1ACB7C;
        Wed, 24 Aug 2022 11:58:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 84FE91ACB7B;
        Wed, 24 Aug 2022 11:58:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] promisor-remote: fix xcalloc() argument order
References: <20220822213408.662482-1-szeder.dev@gmail.com>
        <20220823095733.58685-1-szeder.dev@gmail.com>
Date:   Wed, 24 Aug 2022 08:58:21 -0700
In-Reply-To: <20220823095733.58685-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Tue, 23 Aug 2022 11:57:33 +0200")
Message-ID: <xmqqwnax8wgy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9484943E-23C5-11ED-8702-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Patch generated with:
>
>   make SPATCH_FLAGS=3D--recursive-includes contrib/coccinelle/xcalloc.c=
occi.patch
>
> Our default SPATCH_FLAGS ('--all-includes') doesn't catch this
> transformation by default, unless used in combination with a large-ish
> SPATCH_BATCH_SIZE which happens to put 'promisor-remote.c' with a file
> that includes 'repository.h' directly in the same batch.

Our default SPATCH_FLAGS is actually

    SPATCH_FLAGS =3D --all-includes --patch .

and I am wondering how "--patch ." part (or droppage thereof due to
overriding it from the command line) affects the outcome.

In any case, good finding how the header file inclusion was affected
with batch-size and this option that solved a mystery.  Thanks.
