Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76BDB20286
	for <e@80x24.org>; Wed, 13 Sep 2017 21:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751427AbdIMVwM (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 17:52:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65529 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751148AbdIMVwL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 17:52:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C0FFBADE94;
        Wed, 13 Sep 2017 17:52:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qByeN7ZppzS0/h+RGKo3+1Sn9L8=; b=FAkQ5S
        bQbU1i9cOMj0T0KMNujqTj7qiHbc5DHZxEWXRKJjo448mcThVZeInq/YYsNZGUVp
        YDZGp3ijQq5mJOLdBUaeEd99TjsYbeLGZcGlZv1p3iVvsVwjrDM3utpfbgS0vWUr
        qBOoqeNFQ8tr5ieZxQxpX3orfPjjNI/OtiFCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kL+oi7Nf3pfoYsu3LnS1dhJQtzrOt97g
        xF/7ZqEL4wmu+c9YeEwtvXzKf/dv2KdFS+IoprPDR+vfT2ndsZMIBSCgB9FgCsru
        BMVs7J1Ly8SY73S8sievR8pRnU150JF13aizORFcOWe6zvWfS4fOPws8PkqUncFj
        tJ8+QmTTPOw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B79B8ADE93;
        Wed, 13 Sep 2017 17:52:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C55EADE92;
        Wed, 13 Sep 2017 17:52:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
        <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
        <20170307001709.GC26789@aiede.mtv.corp.google.com>
        <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
        <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
        <20170911185913.GA5869@google.com>
        <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
        <20170913163052.GA27425@aiede.mtv.corp.google.com>
Date:   Thu, 14 Sep 2017 06:52:08 +0900
In-Reply-To: <20170913163052.GA27425@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 13 Sep 2017 09:30:52 -0700")
Message-ID: <xmqq7ex21d2v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB1A9BB6-98CD-11E7-8B67-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Treating generation numbers as derived data (as in Jeff King's
> preferred design, if I have understood his replies correctly) would
> also be possible but it does not interact well with shallow clone or
> narrow clone.

Just like we have skewed committer timestamps, there is no reason to
believe that generation numbers embedded in objects are trustable,
and there is no way for narrow clients to even verify their correctness.

So I agree with Peff that having generation numbers in object is
pointless; I agree any other derivables like corresponding sha-1
name is also pointless to have.

This is a tangent, but it may be fine for a shallow clone to treat
the cut-off points in the history as if they are root commits and
compute generation numbers locally, just like everybody else does.
As generation numbers won't have to be global (because we will not
be embedding them in objects), nobody gets hurt if they do not match
across repositories---just like often-mentioned rename detection
cache, it can be kept as a mere local performance aid and does not
have to participate in the object model.

> All that said, for simplicity I still lean against including
> generation numbers as part of a hash function transition.

Good.

> This is unrelated to Brandon's message, except for his use of SHA3 as
> a placeholder for "the next hash function".
>
> My assumption based on previous conversations (and other external
> conversations like [1]) is that we are going to use SHA2-256 and have
> a pretty strong consensus for that.  Don't worry!

Hmph, I actually re-read the thread recently, and my impression was
that we didn't quite have a consensus but were leaning towards
SHA3-256.

I do not personally have a strong preference myself and I would say
that anything will do as long as it is with good longevity and
availability.  SHA2 family would be a fine choice due to its age on
both counts, being scrutinized longer and having a chance to be
implemented in many places, even though its age itself may have to
be subtracted from the longevity factor.

Thanks.
