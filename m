Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 905651F462
	for <e@80x24.org>; Wed, 31 Jul 2019 01:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfGaB73 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 21:59:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57184 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbfGaB72 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 21:59:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AA9D48CFAF;
        Tue, 30 Jul 2019 21:59:23 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=Y44rR9bDyupDT2JqEmsQ1Z7n/e0=; b=XdV+TX4
        epEz4RnAPTboiuxNMqlcwpNu3WqI12rBHi4SpR8YkLmLWIoVlWMgwMdwjJ50m7rf
        RJfxLWykskk8CIfyKjLXQ07nSzXHibGxVhi3pTaDg7gL2uYsB8o3jsPRrMYz7H7e
        p4j0GrcrVnAIl1Q01bRibJzIK6s4QlbSOjJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=XJ2hwWWIT6R2AppreDkMAIgkKgoL6RGZE
        o+/FE3ksyH9D6MiQ1zCr7Hl5NR4FLul6xymqT9nJxrv9SnC/UXkBT6QFBLt/5t5J
        HZECU2LA6yFoLZ4tFBPeGziR0ZORzhXf3XIF6i0N9Z2oNnnHl4I402TxvoiLQOO8
        xc8ACQtCxw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 94B328CFAE;
        Tue, 30 Jul 2019 21:59:23 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 03A6F8CFAD;
        Tue, 30 Jul 2019 21:59:19 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Tue, 30 Jul 2019 21:59:17 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        git@vger.kernel.org, git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
Message-ID: <20190731015917.GB4545@pobox.com>
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com>
 <20190730194938.GZ4545@pobox.com>
 <20190730200203.GA4882@sigill.intra.peff.net>
 <20190730205624.GR20404@szeder.dev>
 <20190731005933.GA9610@sigill.intra.peff.net>
 <20190731012336.GA13880@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731012336.GA13880@sigill.intra.peff.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: CFB7E63A-B336-11E9-9FE5-B0405B776F7B-09356542!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Tue, Jul 30, 2019 at 08:59:33PM -0400, Jeff King wrote:
> 
>>> OTOH, this is not just any hashmap, but an oidmap, and I could imagine
>>> that there might be use cases where it would be beneficial if the
>>> iteration order were to match the oid order (but don't know whether we
>>> actually have such a use case).
>> 
>> I don't think we can promise anything about iteration order. This test
>> is relying on the order at least being deterministic between runs, but
>> if we added a new entry and had to grow the table, all bets are off.
>> 
>> So regardless of the endian thing above, it probably does make sense for
>> any hashmap iteration output to be sorted before comparing. That goes
>> for t0011, too; it doesn't have this endian thing, but it looks to be
>> relying on hash order that could change if we swapped out hash
>> functions.
> 
> So here's an actual patch.

At the risk of showing my complete lack of knowledge about
these tests, I was wondering if the order mattered for the
other tests in t0011 and t0016.  I had assumed it didn't and
had something like this for testing (and a similar change to
test_oidmap() in t0016):

 diff --git i/t/t0011-hashmap.sh w/t/t0011-hashmap.sh
 index 9c96b3e3b1..9ed1c4f14d 100755
 --- i/t/t0011-hashmap.sh
 +++ w/t/t0011-hashmap.sh
 @@ -4,8 +4,8 @@ test_description='test hashmap and string hash functions'
  . ./test-lib.sh
  
  test_hashmap() {
 -	echo "$1" | test-tool hashmap $3 > actual &&
 -	echo "$2" > expect &&
 +	echo "$1" | test-tool hashmap $3 | sort >actual &&
 +	echo "$2" | sort >expect &&
  	test_cmp expect actual
  }

You've got a more comprehensive patch and a proper commit
message, so this is really just a matter of curiosity.

-- 
Todd
