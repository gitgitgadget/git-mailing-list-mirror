Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F56A1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 11:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfKLLtu (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 06:49:50 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59488 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfKLLtu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 06:49:50 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EC5BA9D53B;
        Tue, 12 Nov 2019 06:49:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=izY9PiwoNCuz/mDrBAZzhwMU/RQ=; b=hja+51
        a7w4PLBjV7sWFV98E4ZAA59otYqHS+hG13osD36GQZmLsbVC3dGt9PqiUi8soBn6
        H+AK/bzrMYQe7b93ftAv27XTu7MaW5tORsYepX7/1BoABORjaMds74ZHNm4pPME+
        Kf/jSyZhB/YwbOniwo8w8oCkoD6hLtz+kFZXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lmFFiRQVRmuPhylq+0GMRsFO824Xd/Y8
        h7a8BMh+Le3yVV6zPZPo8K6kvJOJZY7iaMHCN+VWtOkngEdrb1PeS/nARWZMSJVR
        T+Ej9Xevt5WQAkl2b14/Pa7DrwkO0A93dsnWy5Jv1dQ00aTbQT7pzn3tBpeLHyLR
        PAMs9Y5mMnU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E4D459D53A;
        Tue, 12 Nov 2019 06:49:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 18BC89D537;
        Tue, 12 Nov 2019 06:49:46 -0500 (EST)
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
Date:   Tue, 12 Nov 2019 20:49:44 +0900
In-Reply-To: <20191112105759.GA9714@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 12 Nov 2019 05:57:59 -0500")
Message-ID: <xmqqimnpe2lj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8686BB0E-0542-11EA-9B0C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>     @@ cache.h: int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
>>        * buffers, making it safe to make multiple calls for a single statement, like:
>>        *
>>      - *   printf("%s -> %s", sha1_to_hex(one), sha1_to_hex(two));
>>     -+ *   printf("%s -> %s", oid_to_hex(one), oid_to_hex(two));
>>     ++ *   printf("%s -> %s", hash_to_hex(one), hash_to_hex(two));
>>        */
>>       char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash, const struct git_hash_algo *);
>>       char *oid_to_hex_r(char *out, const struct object_id *oid);
>
> This one-liner leaves the types of "one" and "two" unspecified. :) So
> it's not wrong to use hash_to_hex(), but maybe it's better to be pushing
> people towards oid_to_hex() as their first choice? It probably doesn't
> matter too much either way.

The pre-context of that comment reads:

 * Convert a binary hash to its hex equivalent. The `_r` variant is reentrant,
 * and writes the NUL-terminated output to the buffer `out`, which must be at
 * least `GIT_MAX_HEXSZ + 1` bytes, and returns a pointer to out for
 * convenience.

so I think the intent of the example that used to use sha1_to_hex()
has been the raw bytestring that is the object name, not its form
that is encapsulated in the "struct object_id()".

