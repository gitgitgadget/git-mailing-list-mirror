Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 955AD1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 04:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKLEOD (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 23:14:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64208 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfKLEOD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 23:14:03 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB80319646;
        Mon, 11 Nov 2019 23:14:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=C5ifBgKoxJB0
        6rQmUUPu347Bh/0=; b=qHoLn5h04sjDwsSXdlVclBzhN+vlzcq0ZVYXZO9+stWO
        UZHyU2olYQuO/Dw2wqJpDcM8ox8EpVkaWW2js5zu3uIIu4druVx4I5QzW+JsDOjW
        XRwcJVWH9VYygdq27dzp80fO93AD4nMDzeCp88XHThyzv6VKLc1fXz6f5eezsW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=IYcLjK
        paCbLk6XAjL3qJgWvhfmpujoDGHRVdFKfyFCrro+2FcFVzSwzMT+dYpWUsCZggMF
        098q393LLU0qh8KL3YqDBn6+mtdNQ5jH6VuvwuUP6ZOV6omGMkLzoaiMhCM9s3QW
        sUHOxHg4RfhtyrVet00TRK/+lG6KZm1SYTwkM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9C1019645;
        Mon, 11 Nov 2019 23:14:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CF7F019644;
        Mon, 11 Nov 2019 23:13:59 -0500 (EST)
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
Date:   Tue, 12 Nov 2019 13:13:58 +0900
In-Reply-To: <20191111142904.GB1934@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 11 Nov 2019 09:29:04 -0500")
Message-ID: <xmqqa791hgu1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DA4B7382-0502-11EA-9D9B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Nov 11, 2019 at 03:18:05PM +0100, SZEDER G=C3=A1bor wrote:
>
>> On Mon, Nov 11, 2019 at 04:04:18AM -0500, Jeff King wrote:
>> > There's only a single caller left of sha1_to_hex(), since everybody =
now
>> > uses oid_to_hex() instead. This case is in the sha1dc wrapper, where=
 we
>> > print a hex sha1 when we find a collision. This one will always be s=
ha1,
>> > regardless of the current hash algorithm, so we can't use oid_to_hex=
()
>>=20
>> Nit: s/oid_to_hex/hash_to_hex/
>>=20
>> We can't use oid_to_hex() because we don't have a 'struct object_id'
>> in the first place, as sha1dc only ever deals with 20 unsigned chars.
>
> Ah, you're right. I admit I am still getting up to speed on all of the
> new hash-agnostic versions of the various functions.

Thanks.  I've amended this one and the range diff since the pushout
yesterday looks like this.

1:  8a030f1796 ! 1:  02d21d4117 hex: drop sha1_to_hex()
    @@ Commit message
         hex: drop sha1_to_hex()
    =20
         There's only a single caller left of sha1_to_hex(), since everyb=
ody now
    -    uses oid_to_hex() instead. This case is in the sha1dc wrapper, w=
here we
    +    uses hash_to_hex() instead. This case is in the sha1dc wrapper, =
where we
         print a hex sha1 when we find a collision. This one will always =
be sha1,
    -    regardless of the current hash algorithm, so we can't use oid_to=
_hex()
    +    regardless of the current hash algorithm, so we can't use hash_t=
o_hex()
         here. In practice we'd probably not be running sha1 at all if it=
 isn't
         the current algorithm, but it's possible we might still occasion=
ally
         need to compute a sha1 in a post-sha256 world.
    @@ cache.h: int hex_to_bytes(unsigned char *binary, const char *hex, =
size_t len);
       * buffers, making it safe to make multiple calls for a single stat=
ement, like:
       *
     - *   printf("%s -> %s", sha1_to_hex(one), sha1_to_hex(two));
    -+ *   printf("%s -> %s", oid_to_hex(one), oid_to_hex(two));
    ++ *   printf("%s -> %s", hash_to_hex(one), hash_to_hex(two));
       */
      char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash, =
const struct git_hash_algo *);
      char *oid_to_hex_r(char *out, const struct object_id *oid);
