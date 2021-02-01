Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229A0C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E208264E9C
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhBAR5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 12:57:34 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61058 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbhBAR5V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 12:57:21 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 62233120037;
        Mon,  1 Feb 2021 12:56:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WumUCnzi6rP0
        URiwnfIR8PUFExA=; b=X83Xq0SPrbCi4S9MN+/LaxOapCKElAmg803DpKh1CKkA
        5OrXZhS88tyjAYNzNuklUXSwAg8mYF/HTq/YtTrFi1EWPjVgkjGNY2X3z9FtwVKJ
        JBg47qZklENNrW8adGa2x77HzA4C2BEpqMhqIb6BVE/LImjvr0ZV1bmJBoC+9HM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Zw5X1O
        Pf+hhIGHTMkt9rf/moFarvyAbEc761W2CyvEvk1eFaRz0N/3yLuVEULSCqYCdTag
        oWMY2Y22SxaeqridOc7C6Y4XH0QyP1T8oUZXhHfMBa7jWcNL3SWw8SEj9rTIt59y
        LI4RUT9fNd6OuH8c6isUDCA1z6pEOPqCiUniE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B7D8120036;
        Mon,  1 Feb 2021 12:56:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A16C0120035;
        Mon,  1 Feb 2021 12:56:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?6Zi/5b6354OI?= <adlternative@gmail.com>
Subject: Re: [PATCH v2] alloc.h|c: migrate alloc_states to mem-pool
References: <pull.857.git.1612011569489.gitgitgadget@gmail.com>
        <pull.857.v2.git.1612175966786.gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 09:56:32 -0800
In-Reply-To: <pull.857.v2.git.1612175966786.gitgitgadget@gmail.com>
 (=?utf-8?B?IumYv+W+t+eDiA==?=
        via GitGitGadget"'s message of "Mon, 01 Feb 2021 10:39:26 +0000")
Message-ID: <xmqqpn1jn033.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D2B3D67C-64B6-11EB-A148-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"=E9=98=BF=E5=BE=B7=E7=83=88 via GitGitGadget"  <gitgitgadget@gmail.com> =
writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> "alloc_state" may have similar effects with "mem_pool".

What "similar effects" do you have in mind?  "mem_pool" may have
more than one "effects" to multiple things that are affected, but it
is unclear which effect that "mem_pool" exerts on what you are
referring to.

> Using the new memory pool API may be more beneficial
> to our memory management in the future.

Many things may or may not be "beneficial" in the future.  We do not
build things on a vague "hunch".

Are you seeking performance (e.g.  number of objects that can be
allocated per minute)?  Are you seeking better memory locality
(e.g. related objects are likely to be stored in the same page,
reducing number of page faults)?  Are you seeking reduced wasted
memory (e.g. custom allocator packs objects better than bog-standard
malloc(3))?  Are you seeking functionality (e.g. you have this and
that specific codepaths and usecase where you wish to be able to
release all the objects instantiated for a particular repository,
without having to go through the list of all objects, and use of
mempool is one way to allow us do so)?

It is not even clear in your problem description what kind of
benefit you are seeking, let alone how much quantitative improvement
you are getting with this change.

