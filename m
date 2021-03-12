Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA6FC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 21:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B55D064F72
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 21:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhCLVm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 16:42:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63336 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbhCLVl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 16:41:57 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 346A7AEFB5;
        Fri, 12 Mar 2021 16:41:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Uw9fqwc0P3oD
        P0MbSXFkiEXlGNs=; b=Yp5CrjCuSVh2DA5cgJ9e+48wsY8Mxww4pd/CJgzg/oVS
        Kq53q5kcifn5DSPuXGVrokTdFSHHxi1ivpLAyoZQzR7lWzOwW1pXf64Ljdgp03pk
        KkLXvjd06IryIJ4CRCvjJO7oSzyiETnuzGq6S3DhJc3px4GzrmV+e1mu5PWxhIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DObLDc
        W5rXj97xO13OiI/65aJnO/M3ouUqEuQ7eV8Uo46ykKThVtF2X9zroASkxG0ejkqk
        xyaN61S6lVHMJKsBvijkNEo32iwmewudZg0dIXO7RHBl/E8D7twEus8nvZbeFMC3
        iO4knA8iniwRAG6UQQBfzvy74fAXQZth6QBXg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 25B42AEFB4;
        Fri, 12 Mar 2021 16:41:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 93A5DAEFB2;
        Fri, 12 Mar 2021 16:41:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/6] tree.c API: move read_tree() into
 builtin/ls-files.c
References: <20210306193458.20633-1-avarab@gmail.com>
        <20210308022138.28166-3-avarab@gmail.com>
Date:   Fri, 12 Mar 2021 13:41:54 -0800
In-Reply-To: <20210308022138.28166-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 8 Mar 2021 03:21:34 +0100")
Message-ID: <xmqq8s6s6od9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C3ED1728-837B-11EB-9E85-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Now builtin/ls-files.c is the last user of this code, let's move all
> the relevant code there. This allows for subsequent simplification of
> it, and an eventual move to read_tree_recursive().

There is a comment in cache.h that has long been a tad stale but not
wrong.  This finally makes it incorrect.

#define ADD_CACHE_JUST_APPEND 8		/* Append only; tree.c::read_tree() */

It would be sufficient to remove the mention of tree.c::read_tree().
It does use this bit, but there are a few others, and there is not
much point in singling out the oldest user the bit was invented for.

