Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A4DC433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 19:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243481AbiAJTa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 14:30:56 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59405 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241847AbiAJTaz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 14:30:55 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EE7518621A;
        Mon, 10 Jan 2022 14:30:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ESy4MqF6zWFA
        RRSIICq42gDidAQac0O9WMZOoKHKBgo=; b=kJjwwHDimuYFexvcN4XsHUloydL/
        6SiJDTpiPlRiHjZnkClMnE7QGNB1YvcQhJ4InD9OE1u93pilHMzv47ZCuwctqzUq
        5bndffYFaxCfL32g/tkYxihjYcrqsYrlsKC5pAUNUfkExzmLX8IaJ96IlkHUKDG7
        fNyEv4nDmClI630=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 97641186219;
        Mon, 10 Jan 2022 14:30:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CB330186218;
        Mon, 10 Jan 2022 14:30:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] cache.h: drop duplicate `ensure_full_index()` declaration
References: <20220110184134.18675-1-martin.agren@gmail.com>
        <c0a0798d-96fb-936b-3234-88e500eb86d0@github.com>
Date:   Mon, 10 Jan 2022 11:30:51 -0800
In-Reply-To: <c0a0798d-96fb-936b-3234-88e500eb86d0@github.com> (Victoria Dye's
        message of "Mon, 10 Jan 2022 13:57:21 -0500")
Message-ID: <xmqqfspvz8us.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D2ECAD00-724B-11EC-8650-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Martin =C3=85gren wrote:
>> There are two identical declarations of `ensure_full_index()` in
>> cache.h.
>>=20
>> Commit 3964fc2aae ("sparse-index: add guard to ensure full index",
>> 2021-03-30) provided an empty implementation of `ensure_full_index()`,
>> declaring it in a new file sparse-index.h. When commit 4300f8442a
>> ("sparse-index: implement ensure_full_index()", 2021-03-30) fleshed ou=
t
>> the implementation, it added an identical declaration to cache.h.
>>=20
>> Then 118a2e8bde ("cache: move ensure_full_index() to cache.h",
>> 2021-04-01) favored having the declaration in cache.h. Because of the
>> double declaration, at that point we could have just dropped the one i=
n
>> sparse-index.h, but instead it got moved to cache.h.
>>=20
>> As a result, cache.h contains the exact same function declaration twic=
e.
>> Drop the one under "/* Name hashing */", in favor of the one under
>> "/* Initialize and use the cache information */".
>>=20
>> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
>> ---
>>  cache.h | 2 --
>>  1 file changed, 2 deletions(-)
>>=20
>> diff --git a/cache.h b/cache.h
>> index 5d7463e6fb..281f00ab1b 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -350,8 +350,6 @@ void add_name_hash(struct index_state *istate, str=
uct cache_entry *ce);
>>  void remove_name_hash(struct index_state *istate, struct cache_entry =
*ce);
>>  void free_name_hash(struct index_state *istate);
>> =20
>> -void ensure_full_index(struct index_state *istate);
>> -
>>  /* Cache entry creation and cleanup */
>> =20
>>  /*
>
> Thanks for cleaning up the duplicate, looks good to me!

Thanks, both.
