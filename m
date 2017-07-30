Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BAF920899
	for <e@80x24.org>; Sun, 30 Jul 2017 21:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754546AbdG3VWA (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 17:22:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57485 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754236AbdG3VV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 17:21:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED6438A4D9;
        Sun, 30 Jul 2017 17:21:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WOZCSfSzn9/Oa/EtGN+6luMnvCY=; b=NCXm01
        OU55yS2lzLdK8kgwqURSWGLSAdhw9L5iHcVwFag4EFPmbRtyb8GZ+l5inqe+meLM
        ZdiInxW5V6yDPug5qoK2wYRQA3VviPGFOQdz8tD0SCQjpdfEqoMNiQlasNh3hk83
        +QT7c6+96uPnkl676m2sdVjSNDBdokN+CkYXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MWBRFO7MLO7kEcOt+8Ut8BpWAOFr5a8H
        FWuVDH/bVP0hbdjDeEBjfj8OwKMvqHhJKemFIY1+4d6YIpn/5g0NM5aeUIu3r7x8
        jGoaGf2GI9eB3qpSOLxWvCXcqP6j3GawXYKykBIJMiFownQBkq7HMG891oUm1NQF
        Biq4XnUKAIY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5C1B8A4D6;
        Sun, 30 Jul 2017 17:21:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5F6128A4D3;
        Sun, 30 Jul 2017 17:21:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] t6500: mark tests as SHA1 reliant
References: <20170728171817.21458-1-sbeller@google.com>
        <20170728171817.21458-3-sbeller@google.com>
        <xmqq379gmco6.fsf@gitster.mtv.corp.google.com>
        <20170729175833.4idan3befldn5vgp@genre.crustytoothpaste.net>
Date:   Sun, 30 Jul 2017 14:21:50 -0700
In-Reply-To: <20170729175833.4idan3befldn5vgp@genre.crustytoothpaste.net>
        (brian m. carlson's message of "Sat, 29 Jul 2017 17:58:33 +0000")
Message-ID: <xmqqini9k4cx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A7833C8-756D-11E7-92B2-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> One approach I had considered taking is having a helper of some sort
> that wrapped a simple key/value store.  We could pass the wrapper the
> SHA-1 value (or, if necessary, an arbitrary key) and have it return the
> proper value based on the given hash function.
>
> That does have the downsides that the values may not present in the
> tests themselves, and that people adding new tests will of course need
> to run the test suite twice.  But it does make the tests easier to read.
>
> Opinions on the desirability of this approach are of course welcome.

I am not quite sure if I follow.  There was a proposal to tweak the
commit format that uses the new hash in such a way that we can tell
what SHA-1 would have been used if everything were SHA-1 (I think it
was from Jonathan, but I may be mistaken), and I recall that
generally the list were receptive to the idea.  But I have a feeling
that your "helper of some sort" is something else.

If your <key,value> is about letting us store something like

 - If you hash "hello\n" the resulting blob in SHA-1 world has this
   object name, and with that, you can find out the equivalent
   object name in SHA-256 world.

 - If you have a tree with the above blob at path P and nothing
   else, then the object name of that tree in the SHA-1 world and
   SHA-256 world are different and we can map between them.

 - Likewise for a commit that points at the above tree with fixed
   date, author and message.

I am not sure how much it would help.  Are you aiming to make it
easier and more structured to create a patch like what Stefan did
recently for t8008 in 0ba9c9a0 ("t8008: rely on rev-parse'd HEAD
instead of sha1 value", 2017-07-26)?

I also suspect that tests like t1512 and t6500 would not benefit
that much from such a mapping.  In these tests, the object names by
themselves are not interesting.  These tests are about what Git does
when the names of the objects involved in them happen to share a
certain prefix.  We are not interested in using the same payload in
these tests using different hash, which is likely to destroy the
aspect of the object names that these tests are interested in,
namely, they share the same prefix.  When updating these tests to
adjust for the SHA-256 world, we want to preserve that the resulting
object names happen to share the same prefix by tweaking the payload
strings (i.e. "263 and 410" in t6500 are chosen to cause the
resulting objects to share "17/" prefix and fall inside a same
fan-out directory as loose objects.  We want to choose different
strings so that the names of the resulting objects share the same
prefix, not necessarily "17/" but preferrably so, in the SHA-256
world.  Similarly, Random-looking strings like "a2onsxbvj" in t1512
are chosen to cause blobs, trees, commits and tags that are involved
in the test to all share the same prefix "000000..."; we want to
choose different set of such random-looking strings that cause all
objects involved to hash to the same prefix, not necessarily but
preferrably "000000...").


