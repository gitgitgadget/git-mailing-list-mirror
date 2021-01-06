Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89232C43331
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 21:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66DFA2313C
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 21:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbhAFVH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 16:07:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62915 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbhAFVHz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 16:07:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC417A2515;
        Wed,  6 Jan 2021 16:07:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=48OgqPVRjyVa3nqrFm0spGm8ehc=; b=sr2KPX
        IpDJmv3mwY1Jyl8p04TW8YL1B9O09nl+8jRmrjeYWGt6y4W/g/dOmqNqN/0+QJfn
        ndUgGUaa9np8Bx/WE6kA/decjEylHLtvKzjD29cK90URlEUL38yMCbd5/oLAByGl
        t/EC+hzpqsUXp8tV57qUqcX3//GsBAsClDGCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wY+EGHraMiwtiJwcDO63cmgEurPVBaRl
        MkMFWak5XJuA10O+s6L4ce2W788/WaZXL+mC7m9ly5b2876iwPP9KPaSuUf5jm7j
        DwwXcqwBxa1Xq6CZidp96+5bpJqnm/Z9b5yjUFRPUtEbJLSK65bL3rPxbaW5HNL2
        BMb4pl89Hn0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3E5DA2514;
        Wed,  6 Jan 2021 16:07:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 041D8A2511;
        Wed,  6 Jan 2021 16:07:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v5 8/8] config: allow specifying config entries via
 envvar pairs
References: <cover.1606214397.git.ps@pks.im> <cover.1608104755.git.ps@pks.im>
        <dfceffd8d4fbc3c99cfa7c5d838e4c3a2db6598a.1608104755.git.ps@pks.im>
        <xmqqczz06x83.fsf@gitster.c.googlers.com>
        <xmqq1rfg6vcz.fsf@gitster.c.googlers.com> <X/WQsO47uhgvrcaS@ncase>
Date:   Wed, 06 Jan 2021 13:07:11 -0800
In-Reply-To: <X/WQsO47uhgvrcaS@ncase> (Patrick Steinhardt's message of "Wed, 6
        Jan 2021 11:28:00 +0100")
Message-ID: <xmqqble1rczk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2528E43C-5063-11EB-9EE0-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Dec 23, 2020 at 01:55:08PM -0800, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > The same problem may exist in new paragraphs in git.txt that
>> > describes the "--config-env" stuff.
>> 
>> Here is what I tentatively queued on top of these 8 patches as a fixup.
>> 
>> Thanks.
>
> Your changes look good to me, thanks!

You're welcome.  Looking forward to seeing a new round with these
minor fixes squashed in, so that we do not have a series with known
breakages in early parts that are fixed in later steps.

Thanks.
