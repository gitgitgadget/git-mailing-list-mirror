Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D77C433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 16:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356436AbiELQWj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 12:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356435AbiELQWd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 12:22:33 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2366C231090
        for <git@vger.kernel.org>; Thu, 12 May 2022 09:22:31 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A948C199901;
        Thu, 12 May 2022 12:22:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jVYqXI5g8D5xkx1+7G34vZFrsyB/mKvivekD/O
        Y9png=; b=A2b7MXnp9zBCdv/4Ks0KOBLXHIuevadoF+Sg8lQmuxQJnNd1MvtpfS
        Kz4LReFKA+8gHj+7Ig+Yi2O91hC3fUPMEBrBsEJBguLz9XagwwACgqfbEzUOhtmh
        QanalNeMuWJ3EyhSigFDb5sZJ5AwAfmHYrTxeHBHgscyJMZKqbCy8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A144E1998FF;
        Thu, 12 May 2022 12:22:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4B9741998FE;
        Thu, 12 May 2022 12:22:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] http: add custom hostname to IP address resolutions
References: <20220502083639.610279-1-chriscool@tuxfamily.org>
        <20220504104601.136403-1-chriscool@tuxfamily.org>
        <20220505112114.ktki3dgjbyukzhlm@carlos-mbp.lan>
        <CAP8UFD3UvjJzEQApiCKSknDWaTjbEMKkr17j1QN-8gwz7eWV3Q@mail.gmail.com>
Date:   Thu, 12 May 2022 09:22:26 -0700
In-Reply-To: <CAP8UFD3UvjJzEQApiCKSknDWaTjbEMKkr17j1QN-8gwz7eWV3Q@mail.gmail.com>
        (Christian Couder's message of "Thu, 12 May 2022 10:52:59 +0200")
Message-ID: <xmqqzgjmg1q5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6B449D0-D20F-11EC-AAE7-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> "Perhaps invent a totally bogus domain name, map that to
> localhost ::1, run a test server locally, and try to clone from that
> bogus domain?"
>
> (See: https://lore.kernel.org/git/xmqqfslrycvp.fsf@gitster.g/)
>
> I think "a totally bogus domain name" refers to something other than
> "example.com".

I meant a domain that should not be used for purposes other than
being examples in the real world, including "example.com".

But RFC6761, which is an update to RFC2606, describes a set of
properties that make .invalid nice domain to use, including:

 1.  Users are free to use "invalid" names as they would any other
     domain names.  Users MAY assume that queries for "invalid"
     names will always return NXDOMAIN responses.

 3.  Name resolution APIs and libraries SHOULD recognize "invalid"
     names as special and SHOULD always return immediate negative
     responses.  Name resolution APIs SHOULD NOT send queries for
     "invalid" names to their configured caching DNS server(s).
       
Another possibility is ".test" but it is more for testing DNS, not
application, i.e.

 1.  Users are free to use these test names as they would any other
     domain names.  However, since there is no central authority
     responsible for use of test names, users SHOULD be aware that
     these names are likely to yield different results on different
     networks.

 3.  Name resolution APIs and libraries SHOULD NOT recognize test
     names as special and SHOULD NOT treat them differently.  Name
     resolution APIs SHOULD send queries for test names to their
     configured caching DNS server(s).

so for a code like what we are discussing, which would not want the
names to be shown to DNS and yield any IP address, ".test" makes a
poorer "bogus domain name" than ".invalid", I think.

By the way, we seem to have references to .xz top-level domain,
which appeared only in earlier drafts of what became RFC2606 (which
was updated by RFC6761) in both documentation pages and tests.  At
some point we may want to update the former to ".example" and the
latter to ".invalid" as a clean-up.

> Also "example.com" does seem to resolve to an IP address and even has
> an HTTP(S) server on it, while I think the purpose of the test would
> be to check that there is not even a valid DNS resolution when the new
> option is not used.

Yup, that makes ".invalid" a better candidate, I think.

Thanks.

