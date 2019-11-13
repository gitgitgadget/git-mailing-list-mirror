Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16E8A1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 01:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfKMBJb (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 20:09:31 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51448 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfKMBJb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 20:09:31 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0592FA39C6;
        Tue, 12 Nov 2019 20:09:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xo+agoei0YroRT3zBwHSVblzTfE=; b=fgFT74
        14irsF34/qUokHk2pWDcCabGwyLz4QO50526Nu2FGhC5Y2CZy/1FZmpM+YW8xelm
        8UQw4+pACSI2Ky0zWZBL1TAWpIKG0GEnKqj2J76RqsK+6yaTZr5HFYxWjH0oPHdC
        O4bKSAwd2ke6zZYr4t8s3FeTPf1BJ6SJcjcVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XLHmLEMcLv0FR4/UnPDAxTEQSsCGM9oh
        FRxnvzo0YWeZ9VQ9meqqqLWw4jiRIxVl/bKZcyZpDQIBc9PSlGDKsCpT6kzEV4FO
        vB9LvPTOo8/ZUHAACp81//AaaekWg6jI0UJDH5H31a7FeLB2TQtjGFSCWti642eQ
        +zLeiq1UhJQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F0951A39C4;
        Tue, 12 Nov 2019 20:09:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1754EA39C3;
        Tue, 12 Nov 2019 20:09:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] hex: drop sha1_to_hex()
References: <20191111090332.GA2275@sigill.intra.peff.net>
        <20191111090418.GB12545@sigill.intra.peff.net>
        <20191111141805.GK4348@szeder.dev>
        <20191111142904.GB1934@sigill.intra.peff.net>
        <xmqqa791hgu1.fsf@gitster-ct.c.googlers.com>
        <20191112105759.GA9714@sigill.intra.peff.net>
        <xmqqimnpe2lj.fsf@gitster-ct.c.googlers.com>
        <20191112121537.GB12074@sigill.intra.peff.net>
Date:   Wed, 13 Nov 2019 10:09:23 +0900
In-Reply-To: <20191112121537.GB12074@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 12 Nov 2019 07:15:37 -0500")
Message-ID: <xmqqbltgeg58.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C3BDA82-05B2-11EA-B99B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Nov 12, 2019 at 08:49:44PM +0900, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >>     @@ cache.h: int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
>> >>        * buffers, making it safe to make multiple calls for a single statement, like:
>> >>        *
>> >>      - *   printf("%s -> %s", sha1_to_hex(one), sha1_to_hex(two));
>> >>     -+ *   printf("%s -> %s", oid_to_hex(one), oid_to_hex(two));
>> >>     ++ *   printf("%s -> %s", hash_to_hex(one), hash_to_hex(two));
>> >>        */
>> >>       char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash, const struct git_hash_algo *);
>> >>       char *oid_to_hex_r(char *out, const struct object_id *oid);
>> >
>> > This one-liner leaves the types of "one" and "two" unspecified. :) So
>> > it's not wrong to use hash_to_hex(), but maybe it's better to be pushing
>> > people towards oid_to_hex() as their first choice? It probably doesn't
>> > matter too much either way.
>> 
>> The pre-context of that comment reads:
>> 
>>  * Convert a binary hash to its hex equivalent. The `_r` variant is reentrant,
>>  * and writes the NUL-terminated output to the buffer `out`, which must be at
>>  * least `GIT_MAX_HEXSZ + 1` bytes, and returns a pointer to out for
>>  * convenience.
>> 
>> so I think the intent of the example that used to use sha1_to_hex()
>> has been the raw bytestring that is the object name, not its form
>> that is encapsulated in the "struct object_id()".
>
> I guess you're keying on the phrase "binary hash" there (the
> "GIT_MAX_HEXZ" bits only apply to the "_r" variants anyway). I'd read it
> as encompassing all of the functions below, including oid_to_hex(). But
> I'm OK with it either way.

Yes.  "binary hash" is about "unsigned char[]".  I think that's
historical accident---we added "struct object_id *" variants without
updating the comment.

Here is another try.  The "everybody uses oid_to_hex" in the log
message has also been updated.

1:  8a030f1796 ! 1:  b19f3fe9dd hex: drop sha1_to_hex()
    @@ Metadata
      ## Commit message ##
         hex: drop sha1_to_hex()
     
    -    There's only a single caller left of sha1_to_hex(), since everybody now
    -    uses oid_to_hex() instead. This case is in the sha1dc wrapper, where we
    -    print a hex sha1 when we find a collision. This one will always be sha1,
    -    regardless of the current hash algorithm, so we can't use oid_to_hex()
    -    here. In practice we'd probably not be running sha1 at all if it isn't
    -    the current algorithm, but it's possible we might still occasionally
    +    There's only a single caller left of sha1_to_hex(), since everybody
    +    that has an object name in "unsigned char[]" now uses hash_to_hex()
    +    instead.
    +
    +    This case is in the sha1dc wrapper, where we print a hex sha1 when
    +    we find a collision. This one will always be sha1, regardless of the
    +    current hash algorithm, so we can't use hash_to_hex() here. In
    +    practice we'd probably not be running sha1 at all if it isn't the
    +    current algorithm, but it's possible we might still occasionally
         need to compute a sha1 in a post-sha256 world.
     
         Since sha1_to_hex() is just a wrapper for hash_to_hex_algop(), let's
    @@ Commit message
         it (and as with sha1_to_hex_r() in the previous patch, we'll drop the
         coccinelle transformations, too).
     
    -    The sha1_to_hex() function is mentioned in a comment; we can easily swap
    -    that out for oid_to_hex() to give a better example. It's also mentioned
    -    in some test vectors in t4100, but that's not runnable code, so there's
    -    no point in trying to clean it up.
    +    The sha1_to_hex() function is mentioned in a comment; we can easily
    +    swap that out for oid_to_hex() to give a better example.  Also
    +    update the comment that was left stale when we added "struct
    +    object_id *" as a way to name an object and added functions to
    +    convert it to hex.
    +
    +    The function is also mentioned in some test vectors in t4100, but
    +    that's not runnable code, so there's no point in trying to clean it
    +    up.
     
         Signed-off-by: Jeff King <peff@peff.net>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## cache.h ##
    +@@ cache.h: int get_oid_hex(const char *hex, struct object_id *sha1);
    + int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
    + 
    + /*
    +- * Convert a binary hash to its hex equivalent. The `_r` variant is reentrant,
    ++ * Convert a binary hash in "unsigned char []" or an object name in
    ++ * "struct object_id *" to its hex equivalent. The `_r` variant is reentrant,
    +  * and writes the NUL-terminated output to the buffer `out`, which must be at
    +  * least `GIT_MAX_HEXSZ + 1` bytes, and returns a pointer to out for
    +  * convenience.
     @@ cache.h: int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
       * The non-`_r` variant returns a static buffer, but uses a ring of 4
       * buffers, making it safe to make multiple calls for a single statement, like:
       *
     - *   printf("%s -> %s", sha1_to_hex(one), sha1_to_hex(two));
    ++ *   printf("%s -> %s", hash_to_hex(one), hash_to_hex(two));
     + *   printf("%s -> %s", oid_to_hex(one), oid_to_hex(two));
       */
      char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash, const struct git_hash_algo *);
