Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03FBC20286
	for <e@80x24.org>; Wed, 13 Sep 2017 22:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751311AbdIMWPP (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 18:15:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60695 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751128AbdIMWPO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 18:15:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D95A9FDEE;
        Wed, 13 Sep 2017 18:15:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aJmrgWD/AD4vmDGngLFBJ1OEpio=; b=jWrc4f
        xFXCpcPwOfHRpJgKmtp4o/iZqze5ZBKR2hTfzu07OBXaW+jVGsQk2zfrCt7tmHwP
        EEg2JGLNabE5ght3ZLANQe0Tyi/lvldrUzqEhkRzFP0Z8qfr3B9n4NkOT4+mJ4uL
        1rz251+TGHw0Idx4aqEYCQLHwwFopxX/OFcak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MrSdymj2b0/RqmQGdPxjbPe4Ed7V4E6p
        0I2iTzvITos9M4AqmuZItDbzMLIdsS4O+yAK7VZiYNDK7bS4a+jpJDVu2u4ZgzV/
        wXkctL/uMru6oKFc0RJqietCvLOLomywNmJMl6GzDfCw83mVmSZyqgsmqaEYcjFm
        shYd9FCkD9Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 744D69FDEC;
        Wed, 13 Sep 2017 18:15:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B2DDD9FDEB;
        Wed, 13 Sep 2017 18:15:12 -0400 (EDT)
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
        <xmqq7ex21d2v.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 14 Sep 2017 07:15:11 +0900
In-Reply-To: <xmqq7ex21d2v.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 14 Sep 2017 06:52:08 +0900")
Message-ID: <xmqq377q1c0g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 033EE56C-98D1-11E7-A398-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Treating generation numbers as derived data (as in Jeff King's
>> preferred design, if I have understood his replies correctly) would
>> also be possible but it does not interact well with shallow clone or
>> narrow clone.
>
> Just like we have skewed committer timestamps, there is no reason to
> believe that generation numbers embedded in objects are trustable,
> and there is no way for narrow clients to even verify their correctness.
>
> So I agree with Peff that having generation numbers in object is
> pointless; I agree any other derivables like corresponding sha-1
> name is also pointless to have.
>
> This is a tangent, but it may be fine for a shallow clone to treat
> the cut-off points in the history as if they are root commits and
> compute generation numbers locally, just like everybody else does.
> As generation numbers won't have to be global (because we will not
> be embedding them in objects), nobody gets hurt if they do not match
> across repositories---just like often-mentioned rename detection
> cache, it can be kept as a mere local performance aid and does not
> have to participate in the object model.
>
>> All that said, for simplicity I still lean against including
>> generation numbers as part of a hash function transition.
>
> Good.

In the proposed transition plan, the treatment of various signatures
(deliberately) makes the conversion not quite roundtrip.

When existing SHA-1 history in individual clones are converted to
NewHash, we obviously cannot re-sign the corresponding NewHash
contents with the same PGP key, so these converted objects will
carry only signature on SHA-1 contents.  They can still be validated
when they are exported back to SHA-1 world via the fetch/push
protocol, and can be validated locally by converting them back to
SHA-1 contents and then passing the result to gpgv.

The plan also states, if I remember what I read correctly, that
newly created and signed objects (this includes signed commits and
signed tags; mergetags merely carry over what the tag object that
was merged was signed with, so we do not have to worry about them
unless the resulting commit that has mergetag is signed itself, but
that is already covered by how we handle signed commits) would be
signed both for NewHash contents and its corresponding SHA-1
contents (after internally convering it to SHA-1 contents).  That
would allow us to strip the signature over NewHash contents and
derive the SHA-1 contents to be shown to the outside world while
migration is going on and I'd imagine it would be a good practice;
it would allow us to sign something that allows everybody to verify,
when some participants of the project are not yet NewHash capable.

But the signing over SHA-1 contents has to stop at some point, when
everybody's Git becomes completely unaware of SHA-1.  We may want to
have a guideline in the transition plan to (1) encourage signing for
both for quite some time, and (2) the criteria for us to decide when
to stop.

Thanks.
