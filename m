Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F186AC2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 16:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE5C21D7F
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 16:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xQO8pKIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgIZQyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 12:54:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60459 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgIZQyX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 12:54:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 67F39FAF4B;
        Sat, 26 Sep 2020 12:54:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lgWe8kQtyqV5o4Nr8+KD2K59bz4=; b=xQO8pK
        IbVaPE15vYm6UdXAR5nJFyJ4TYvDhKfk67MfOBoW0xbNkt/8uxrvHVTsh0c5GEY2
        O5vwwifp9SZPh99kOBLbP+Ou825EPNeIqZ4ykSjyMeYEz+KH9lUtSQHRKrzQKwlt
        6JY3EinraDcQr7BT4GIHoivK6vqlNOU3gyoeM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D3RzXB26RTGNRs5DjY0IPnd828z9VnhR
        EtGQqXeQCrWnzM2Wa9cYuZE0QY/aDRZi+mprLZN9JAV8b3hTRo+MjHngcpOwGadC
        6Eq4BdRevycFansmX9dNbz0BO4FzYg+ziZRRtq28TX3YAxXhkzLKfiTMrDQC5X9d
        PhnfH/jUNLc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61695FAF4A;
        Sat, 26 Sep 2020 12:54:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ABE8BFAF48;
        Sat, 26 Sep 2020 12:54:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 10/10] hashmap_for_each_entry(): work around MSVC's
 run-time check failure #3
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
        <dc46d39611df4ebd90d9308364d887e638c1bc30.1601044119.git.gitgitgadget@gmail.com>
        <xmqq8scxln10.fsf@gitster.c.googlers.com>
Date:   Sat, 26 Sep 2020 09:54:13 -0700
In-Reply-To: <xmqq8scxln10.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 25 Sep 2020 11:38:35 -0700")
Message-ID: <xmqqy2kwiimi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E93BFB8E-0018-11EB-88A7-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Whoa, wait.  If it is just that macro, can we perhaps do something
> like the attached patch?

I looked at all the uses of OFFSETOF_VAR() and I think the one used
for hashmap_for_each_entry() is the only instance that 'var' given
to it can legitimately be uninitialized, if typeof() were available.

Here are the findings.

#define hashmap_put_entry(map, keyvar, member) \
	container_of_or_null_offset(hashmap_put(map, &(keyvar)->member), \
				OFFSETOF_VAR(keyvar, member))

The keyvar is a pointer to the entry being placed in the map; it
must hold a valid one so the pointer-diff implementation of
OFFSETOF_VAR() should work fine, or we are putting garbage in to the
map.

#define hashmap_remove_entry(map, keyvar, member, keydata) \
	container_of_or_null_offset( \
			hashmap_remove(map, &(keyvar)->member, keydata), \
			OFFSETOF_VAR(keyvar, member))

The keyvar is used to match against an existing entry in the map to
be removed---it must have a valid value.

#define hashmap_for_each_entry(map, iter, var, member) \
	for (var = hashmap_iter_first_entry_offset(map, iter, \
						OFFSETOF_VAR(var, member)); \
		var; \
		var = hashmap_iter_next_entry_offset(iter, \
						OFFSETOF_VAR(var, member)))

This, as you discovered, can be fed an uninitialized var and the
first thing it does is to use OFFSETOF_VAR() on it in order to call
hashmap_iter_first_entry_offset().  After that, i.e. when we called
that function to start the loop, var is defined and we would be OK.

The trick I suggested is to initialize var to NULL before making the
call to hashmap_iter_first_entry_offset(), i.e.

	for (var = NULL, \
	     var = hashmap_iter_first_entry_offset(map, iter, \
						OFFSETOF_VAR(var, member)); \

#define hashmap_get_entry(map, keyvar, member, keydata) \
	container_of_or_null_offset( \
				hashmap_get(map, &(keyvar)->member, keydata), \
				OFFSETOF_VAR(keyvar, member))

Must be OK for the same reason _put_entry() is OK.

#define hashmap_get_next_entry(map, var, member) \
	container_of_or_null_offset(hashmap_get_next(map, &(var)->member), \
				OFFSETOF_VAR(var, member))

This tries to go to the next-equal-pointer starting from var, so var
must be valid already.

So, perhaps the attached may be a viable replacement that would be
more futureproof with less maintenance cost, I suspect.

Thanks.

--- >8 ----- cut here ----- >8 ---
Subject: hashmap_for_each_entry(): workaround MSVC's runtime check failure #3

The OFFSETOF_VAR(var, member) macro is implemented in terms of
offsetof(typeof(*var), member) with compilers that know typeof(),
but its fallback implemenation compares &(var->member) and (var) and
count the distance in bytes, i.e.

    ((uintptr_t)&(var)->member - (uintptr_t)(var))

MSVC's runtime check, when fed an uninitialized 'var', flags this as
a use of an uninitialized variable (and that is legit---uninitialized
contents of 'var' is subtracted) in a debug build.

After auditing all 6 uses of OFFSETOF_VAR(), 1 of them does feed a
potentially uninitialized 'var' to the macro in the beginning of the
for() loop:

    #define hashmap_for_each_entry(map, iter, var, member) \
            for (var = hashmap_iter_first_entry_offset(map, iter, \
                                                    OFFSETOF_VAR(var, member)); \
                    var; \
                    var = hashmap_iter_next_entry_offset(iter, \
                                                    OFFSETOF_VAR(var, member)))

We can work around this by making sure that var has _some_ value
when OFFSETOF_VAR() is called.  Strictly speaking, it invites
undefined behaviour to use NULL here if we end up with pointer
comparison, but MSVC runtime seems to be happy with it, and most
other systems have typeof() and don't even need pointer comparison
fallback code.

---
 hashmap.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git c/hashmap.h w/hashmap.h
index ef220de4c6..b011b394fe 100644
--- c/hashmap.h
+++ w/hashmap.h
@@ -449,7 +449,8 @@ static inline struct hashmap_entry *hashmap_iter_first(struct hashmap *map,
  * containing a @member which is a "struct hashmap_entry"
  */
 #define hashmap_for_each_entry(map, iter, var, member) \
-	for (var = hashmap_iter_first_entry_offset(map, iter, \
+	for (var = NULL, /* for systems without typeof */ \
+	     var = hashmap_iter_first_entry_offset(map, iter, \
 						OFFSETOF_VAR(var, member)); \
 		var; \
 		var = hashmap_iter_next_entry_offset(iter, \
