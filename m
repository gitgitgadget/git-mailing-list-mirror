Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E65EC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 18:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F4DE60F9F
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 18:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbhIMSYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 14:24:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56686 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239703AbhIMSYH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 14:24:07 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC1AEE6E3A;
        Mon, 13 Sep 2021 14:22:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ji0pR7IhDdq8
        ka9iynSY0m+RsS8g6AqMFKlBtcMjtrg=; b=LzxSYM+7c4k1Wa+8MiOy25Q08+fr
        civWepKsDDu95CWw8gJ7rPKgEQYPByHWB+L3KwClhk20W6LEkafzaLL/O602dvQ+
        4kC37TVDaVGTVV9HLsXGsWwoL5/yKD5Y5d9DSLI33gGvPGRyx88UxDvW1G202KtC
        J5/seUYFjZIClag=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D41E1E6E39;
        Mon, 13 Sep 2021 14:22:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C06CE6E38;
        Mon, 13 Sep 2021 14:22:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] refs/files-backend: remove unused open mode parameter
References: <ea424e3d-6269-f50d-1a4a-643bb95cfa12@web.de>
        <CAFQ2z_NAXsOzbWujpm=jGxODJi+xsC9iFYd-W+dTqn9j5DybjQ@mail.gmail.com>
Date:   Mon, 13 Sep 2021 11:22:49 -0700
In-Reply-To: <CAFQ2z_NAXsOzbWujpm=jGxODJi+xsC9iFYd-W+dTqn9j5DybjQ@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 13 Sep 2021 12:12:03 +0200")
Message-ID: <xmqqilz4fi86.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9A6F5264-14BF-11EC-B073-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Thu, Sep 9, 2021 at 11:46 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>
>> We only need to provide a mode if we are willing to let open(2) create
>> the file, which is not the case here, so drop the unnecessary paramete=
r.
>
> I was #today years old when I learned that C supports (a limited form
> of) function signature overloading.

I do not think it is that kind of magic.

Like printf(3) that allows its early parameter to affect the way how
its later parameters are recognised, it just allows the flags word
to decide if it needs to grab one extra mode_t out of va_list or
not, which can be done as a plain vanilla varargs function, i.e.

	extern int open(const char *path, int flags, ...);

