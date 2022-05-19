Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F656C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 15:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239121AbiESPVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 11:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbiESPVS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 11:21:18 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37C85643C
        for <git@vger.kernel.org>; Thu, 19 May 2022 08:21:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CAFEA191952;
        Thu, 19 May 2022 11:21:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qDENc7xJFQWK
        7VN8KHD43GM+xeMwfRqJ6lwLgIZnsgU=; b=KEOn6j14ySh/nuMPvxJJfnS8RyIH
        tNBluLPESIXvjdZefXPMA2evrn0ss5RY0XNaL93/5eHTPnVpVRo1PU8FCgubb155
        r21orWHfS/vzhAa9uQmBiy1ieZFXg8yI69PvM9j6OQF/jnpm0A2vDMjuezGl7hri
        jTV6JizZF4U5T2c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C4DC0191950;
        Thu, 19 May 2022 11:21:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 67BA319194F;
        Thu, 19 May 2022 11:21:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        derrickstolee@github.com, jrnieder@gmail.com,
        larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v4 02/17] pack-mtimes: support reading .mtimes files
References: <cover.1638224692.git.me@ttaylorr.com>
        <cover.1652915424.git.me@ttaylorr.com>
        <8f9fd21be9fcdda5c73d800fc66d1087d61a6888.1652915424.git.me@ttaylorr.com>
        <220519.86zgjd4wvk.gmgdl@evledraar.gmail.com>
Date:   Thu, 19 May 2022 08:21:10 -0700
In-Reply-To: <220519.86zgjd4wvk.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 19 May 2022 12:40:56 +0200")
Message-ID: <xmqqr14pr1jt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 50993DE0-D787-11EC-A243-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, May 18 2022, Taylor Blau wrote:
>
> Nit:
>
>> +  - A 4-byte magic number '0x4d544d45' ('MTME').
>> +
>> +  - A 4-byte version identifier (=3D 1).
>> +
>> +  - A 4-byte hash function identifier (=3D 1 for SHA-1, 2 for SHA-256=
).
>
> Here we let it suffice that later we'll say "All 4-byte numbers are in
> network order".
>
>> +  - A table of 4-byte unsigned integers in network order. The ith
>
> But here we call out "network order" explicitly, shouldn't this just be
> s/ in network order//?
>
>> +    value is the modification time (mtime) of the ith object in the
>> +    corresponding pack by lexicographic (index) order. The mtimes
>> +    count standard epoch seconds.
>> +
>> +  - A trailer, containing a checksum of the corresponding packfile,
>> +    and a checksum of all of the above (each having length according
>> +    to the specified hash function).
>> +
>> +All 4-byte numbers are in network order.
>
> I.e. this is sufficient.

Very good eyes.  One explicit mention among several others can
indeed be misleading the readers.

When asked for "network order", all your search engines show are
entries about "network byte order", so let's use that longer form of
spelling.

Thanks.
