Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B0EC71155
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 20:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF1682151B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 20:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Oi21PJr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgLAUCC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 15:02:02 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56360 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLAUCB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 15:02:01 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A7F9E114846;
        Tue,  1 Dec 2020 15:01:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kNbWqeQEQz9k
        vP07omSPHt/YXOs=; b=Oi21PJr5LB7cu3ZbXVUQqk01YaoOBIVfuWrpm/OjeJrX
        FLtNKue/pvQl668MxL2/2t5IrnZstunfnyyy8UO4ShuMGuD4HVpHcbmpkCrjq0UF
        qNqv0fYF8j+/VYpSyQyA/JZ1U4gFDfNpU9ba8p0EO+GxP+OClg3bNhtTq92lrMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Y8mId4
        jJV1OW0uuYdzzEy9AptCvXyTvo7bvOTEdqAc01Av2BWf9VNN7fhYUw2BEdFh0oQo
        S6zU9JPzPo8uQKJKrmMhjmYehwiFebEzMhpnHLw/Jt9ziZgZksmUDMxJ1WkFvxaS
        3+NF02nnpVOFE+CmXUVHnpbmkYBmH5byz3A18=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A14D2114845;
        Tue,  1 Dec 2020 15:01:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E1419114844;
        Tue,  1 Dec 2020 15:01:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 00/10] make "mktag" use fsck_tag()
References: <20201126012854.399-1-avarab@gmail.com>
        <20201126222257.5629-1-avarab@gmail.com>
        <87zh2xvny6.fsf@evledraar.gmail.com>
Date:   Tue, 01 Dec 2020 12:01:14 -0800
In-Reply-To: <87zh2xvny6.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 01 Dec 2020 11:08:01 +0100")
Message-ID: <xmqqlfehpa7p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F8DDA4B8-340F-11EB-9FC7-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Nov 26 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Now a non-RFC. I went for the approach I suggested in
>> <87r1ognv4b.fsf@evledraar.gmail.com> of just having fsck_tag() able to
>> optionally tell us about its parsed tag/type, thus avoiding any need
>> for a custom parser in mktag.c. Hopefully I've addressed the rest of
>> the feedback, range-diff below.
>
> Ping @ Jeff & brian: you said you wanted this in one shape or another,
> so mind seeing if the v2 looks good to you?:)
>
> Junio didn't pick it up for the "What's Cooking" sent out recently,
> hopefully some reviewer ACK/NACK will help move it forward. Thanks!

True.  I don't want to queue too many topics on 'seen', only to end
up with a pile of patches that haven't been reviewed adequately and
cannot move forward.
