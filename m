Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B22FC433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 21:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F7B61439
	for <git@archiver.kernel.org>; Thu, 13 May 2021 21:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhEMVEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 17:04:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55452 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbhEMVEk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 17:04:40 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1731D1331A2;
        Thu, 13 May 2021 17:03:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gu4fThY9oY4JeCl0S94TNLbGdbGix0/d8LTRwO
        CRjgE=; b=FdRDWB/09R3W9GSFucB5FV3EsvZ0g3wfgf+GcmgCgC8CglwzCZAhum
        Jg6Z5ebbu5qaUB9A7yNKEDGmoGUPIzG7lnMeWqGRdpObt4oxtTvy3dOnpFFM2/8C
        HJJ6YO3VsU5YbfqDsCHQi8cj3+8sKTlSyArzbFBaWMFG3UHPXgJ4Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0F6B11331A0;
        Thu, 13 May 2021 17:03:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2E30A13319F;
        Thu, 13 May 2021 17:03:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     dwh@linuxprogrammer.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: Is the sha256 object format experimental or not?
References: <20210508022225.GH3986@localhost>
        <YJcqqYsOerijsxRQ@camp.crustytoothpaste.net>
        <87lf8mu642.fsf@evledraar.gmail.com>
        <YJm23HESQb1Z6h8y@camp.crustytoothpaste.net>
        <20210513202919.GE11882@localhost>
Date:   Fri, 14 May 2021 06:03:23 +0900
In-Reply-To: <20210513202919.GE11882@localhost> (dwh@linuxprogrammer.org's
        message of "Thu, 13 May 2021 13:29:19 -0700")
Message-ID: <xmqqo8de9wis.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A86BA80A-B42E-11EB-AD37-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

dwh@linuxprogrammer.org writes:

> I think Git should externalize the calculation of object digests just
> like it externalizes the calcualtion of object digital signatures.

The hashing algorithms used to generate object names has
requirements fundamentally different from that of digital
signatures.  I strongly suspect that that fact would change the
equation when you rethink what you said above.

We can "upgrade" digital signature algorithms fairly easily---nobody
would complain if you suddenly choose different signing algorithm
over a blob of data, as long as all project participants are aware
(and self-describing datastream helps here) and are capable of
grokking the new algorithm we are adopting.  But because object
names are used by one object to refer to another, and most
importantly, we do not want a single object to have multiple names,
we cannot afford to introduce a new hashing algorithm every time we
feel like it.  In other words, diversity of object naming algorithms
is to be avoided as much as possible, while diversity of signature
algorithms is naturally expected.
