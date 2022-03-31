Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235CAC433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 20:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbiCaUOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 16:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiCaUOB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 16:14:01 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9791F6842
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 13:12:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1AA34188A68;
        Thu, 31 Mar 2022 16:12:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=l724UcKSxVhW
        Svj39RFnfUS0L/yvIkNzCwOvzDR+rIg=; b=KD9SmsQ2W/DIQfW45ngNKk24wQsh
        wirYDFL9RWHnyEgJkYoou5H5Zf7WtS+8HLaHDRZ7vH2kr7hsMHGWZAeeUh2Dsm2k
        7xJhKhFVaxs8B+Q6d+y4QFJyKAfMpz/xoLlYD6V/6x0dm2Y4oT09FJ6QRH91vcKy
        HXVgwN8bk4yej5M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 131D2188A67;
        Thu, 31 Mar 2022 16:12:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 72C6B188A62;
        Thu, 31 Mar 2022 16:12:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] CodingGuidelines: give deadline for "for (int i = 0; ..."
References: <xmqqy20r3rv7.fsf@gitster.g>
        <220331.86v8vuqv95.gmgdl@evledraar.gmail.com>
Date:   Thu, 31 Mar 2022 13:12:09 -0700
In-Reply-To: <220331.86v8vuqv95.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 31 Mar 2022 12:10:20 +0200")
Message-ID: <xmqqo81l286e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D8C1EBE2-B12E-11EC-A3DC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> A separate weather balloon for C99 as a whole was raised separately
>> in 7bc341e2 (git-compat-util: add a test balloon for C99 support,
>> 2021-12-01).  Hopefully, as we find out that all C99 features are OK
>> on all platforms we care about, we can stop probing the features we
>> want one-by-one like this
>
> Unfortunately this really isn't the case at all, the norm is for
> compilers to advertise that they support verison X of the standard via
> these macros when they consider the support "good enough", but while
> there's still a long list of unimplemented features before they're at
> 100% support (and most never fully get to 100%).
>
> We also need to worry about the stdlib implementation, and not just the
> compiler, see e.g. the %zu format and MinGW in the exchange at
> https://lore.kernel.org/git/220318.86bky3cr8j.gmgdl@evledraar.gmail.com=
/
> and
> https://lore.kernel.org/git/a67e0fd8-4a14-16c9-9b57-3430440ef93c@gmail.=
com/;
>
> But I think we're thoroughly past needing to worry about basic language
> features in C99 such as these inline variable declarations.

Well, that makes it sound like the C99 weather balloon was almost
useless, doesn't it?

In any case, I'll strick the last paragraph from the final log
message, as the patch text itself is about one specific feature, and
not about deciding what our policy for various C99 language
feeatures ought to be.

Thanks.
