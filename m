Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB5491F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 12:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfKLMPj (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 07:15:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:45238 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725944AbfKLMPi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 07:15:38 -0500
Received: (qmail 32001 invoked by uid 109); 12 Nov 2019 12:15:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Nov 2019 12:15:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14267 invoked by uid 111); 12 Nov 2019 12:19:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Nov 2019 07:19:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Nov 2019 07:15:37 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] hex: drop sha1_to_hex()
Message-ID: <20191112121537.GB12074@sigill.intra.peff.net>
References: <20191111090332.GA2275@sigill.intra.peff.net>
 <20191111090418.GB12545@sigill.intra.peff.net>
 <20191111141805.GK4348@szeder.dev>
 <20191111142904.GB1934@sigill.intra.peff.net>
 <xmqqa791hgu1.fsf@gitster-ct.c.googlers.com>
 <20191112105759.GA9714@sigill.intra.peff.net>
 <xmqqimnpe2lj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqimnpe2lj.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 12, 2019 at 08:49:44PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >>     @@ cache.h: int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
> >>        * buffers, making it safe to make multiple calls for a single statement, like:
> >>        *
> >>      - *   printf("%s -> %s", sha1_to_hex(one), sha1_to_hex(two));
> >>     -+ *   printf("%s -> %s", oid_to_hex(one), oid_to_hex(two));
> >>     ++ *   printf("%s -> %s", hash_to_hex(one), hash_to_hex(two));
> >>        */
> >>       char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash, const struct git_hash_algo *);
> >>       char *oid_to_hex_r(char *out, const struct object_id *oid);
> >
> > This one-liner leaves the types of "one" and "two" unspecified. :) So
> > it's not wrong to use hash_to_hex(), but maybe it's better to be pushing
> > people towards oid_to_hex() as their first choice? It probably doesn't
> > matter too much either way.
> 
> The pre-context of that comment reads:
> 
>  * Convert a binary hash to its hex equivalent. The `_r` variant is reentrant,
>  * and writes the NUL-terminated output to the buffer `out`, which must be at
>  * least `GIT_MAX_HEXSZ + 1` bytes, and returns a pointer to out for
>  * convenience.
> 
> so I think the intent of the example that used to use sha1_to_hex()
> has been the raw bytestring that is the object name, not its form
> that is encapsulated in the "struct object_id()".

I guess you're keying on the phrase "binary hash" there (the
"GIT_MAX_HEXZ" bits only apply to the "_r" variants anyway). I'd read it
as encompassing all of the functions below, including oid_to_hex(). But
I'm OK with it either way.

-Peff
