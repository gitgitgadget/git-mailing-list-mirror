Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFBBC433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 19:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ADCC20C09
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 19:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yhafVbKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbgFWTjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:39:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52541 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733248AbgFWTjo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 15:39:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58656650A1;
        Tue, 23 Jun 2020 15:39:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RZqirrYSkPPrAyYhk5G1NOhvPFA=; b=yhafVb
        KkZBrSggMZoKvjerZb8z8EHZ4iFojHgd9vBwe0CiK/T3/dGF3KEwqpXfWYk79E2e
        oa9DXTftgAo7VZOPYg7IGxzAM8nYucoT7eiJx/T++8c29UsnlU1C8atgWf6wooyD
        bgEM50JH+5w3ZucKOb88nbbxulp0fzsvfo2qo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PE50VzDUtjsrn70KR9/cQmUWhtnH/F+I
        u0CXTfHu8vlcGZFBwKme19SzOjTB7sgzkV0O+eybVfjYIVs3LvqJ2H1zestuAzep
        xoIBgLK2ULgv31GQCBLhYoCv1WeJ4tbjW2i8s0dFacng7E2n8qHe1adbCZFD1tY2
        y0q3e/0ffe4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 506DC650A0;
        Tue, 23 Jun 2020 15:39:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D37406509F;
        Tue, 23 Jun 2020 15:39:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Chris Torek <chris.torek@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH v3 1/3] remote-curl: use strlen() instead of magic numbers
References: <cover.1592119902.git.liu.denton@gmail.com>
        <cover.1592934880.git.liu.denton@gmail.com>
        <cb8683837c9f583274780057621255a65a1c4c9f.1592934880.git.liu.denton@gmail.com>
        <20200623185458.GD1444619@coredump.intra.peff.net>
Date:   Tue, 23 Jun 2020 12:39:40 -0700
In-Reply-To: <20200623185458.GD1444619@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 23 Jun 2020 14:54:58 -0400")
Message-ID: <xmqqtuz1bmgz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47D9B9EA-B589-11EA-976E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jun 23, 2020 at 01:55:32PM -0400, Denton Liu wrote:
>
>> When we are dealing with a packet-line length header, we use the magic
>> literal `4`, representing the length of "0000" and "0001", the packet
>> line length headers. Use `strlen("000x")` so that we do not have to use
>> the magic literal.
>
> I'm not a huge fan of using strlen() for this, because it's _still_
> magical (you cannot change "0000" in one place without changing it in
> another"). And while it helps with understanding that "4" matches the
> length of that string, IMHO it's harder to read because now I have to
> make sure that those much longer strings all match up.

Yup.  There are two instances of recurring pattern with two memcpy,
where three copies of the same string must appear.  Unless the whole
thing is abstracted away so that these two instances are calls to
a macro/function that takes a single "0000" (and "0001"), I do not
think it is an improvement.

> This refactoring also implies to me that if you changed all of "0000" on
> one line you'd be fine, but that's emphatically not true. The magic
> number "4" is used to size the buffer earlier in the function, and would
> have to match (and of course since this is a network protocol, it's not
> like you could even change those in isolation).

Thanks.  That's even more important point.

> So I dunno. I kind of think the raw "4" is the most readable. It's quite
> obvious to me in the context of a memcpy() what's going on. I don't mind
> memcpy_literal() or similar that hides the repetition, but I think it's
> hard to do here because of the arithmetic on the destination.
>
> -Peff
