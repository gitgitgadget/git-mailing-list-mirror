Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62363C433E1
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 15:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C63D206F6
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 15:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FIIhpdGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbgGGP22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:28:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50456 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730146AbgGGP21 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 11:28:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 68C7CDD407;
        Tue,  7 Jul 2020 11:28:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5VIwaTOKhYAyMMDYVx9y5KH6EzM=; b=FIIhpd
        GlkUQ3tw57/93JSfqRK6IUmE3pJC9Aw8u5nWI7VyexPSJoSBWKJIeQCa8rchHcma
        GK9+7zQ5TGP7uUsDvGJE4jke4zsvnRGOeM4XL2YP3nsqD7mFxhk49u6LB6h+RLcC
        MZpxFUhcDTdwg8ucZfuu+s9Dv6DbuXKWm/Y0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fgYnYGMLAq0Emb08caU0WcPa0uHACkQO
        dHebZZkvjQDBGix2OlDPPjUvjz0YtMBi/09DSRzy9loPoo/fpYiDj7/YS3O9hDEZ
        4y10yM0gX7e5ByXV9zxJnF63WniI3HvfrC1idpIMVfgDEeRLPjB9jWubceGxzJ8B
        +YSY6qyHc6Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61E44DD406;
        Tue,  7 Jul 2020 11:28:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A9E8DDD405;
        Tue,  7 Jul 2020 11:28:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/2] ref-filter: add support for %(contents:size)
References: <20200702140845.24945-1-chriscool@tuxfamily.org>
        <20200702140845.24945-3-chriscool@tuxfamily.org>
        <xmqq5zb09v4e.fsf@gitster.c.googlers.com>
        <CAP8UFD1JiBOhpXeADObFBgoGm292dxQ933TENrZNPnmSv+SbUg@mail.gmail.com>
Date:   Tue, 07 Jul 2020 08:28:21 -0700
In-Reply-To: <CAP8UFD1JiBOhpXeADObFBgoGm292dxQ933TENrZNPnmSv+SbUg@mail.gmail.com>
        (Christian Couder's message of "Tue, 7 Jul 2020 10:40:10 +0200")
Message-ID: <xmqqr1tn5oq2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E57FF8A-C066-11EA-8A1D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> I am fine if it just is silently ignored (which is consistent with
>> already existing behaviour of other requests that do not make sense
>> for the given type) if the thing is a blob or a tree, but we'd need
>> to cover the case with a test or two.  It seems you only expect this
>> with a tag object and do not have any test that checks for other
>> types of objects?
>
> My patch already adds 1 test with a commit:

But that is not an interesting case, no?  Unless I missed that there
were new tests to see what happens with a blob and a tree, that is.

> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -125,6 +125,7 @@ test_atom head contents:body ''
>  test_atom head contents:signature ''
>  test_atom head contents 'Initial
>  '
> +test_atom head contents:size '8'
>  test_atom head HEAD '*'
>
> There is only one test with a commit, because that's already the case
> for %(contents) too.
>
> I am ok with adding another preparatory patch to the series that would
> add a few more test cases with commits, trees and blobs though.

I am OK either way, because I know fairly well how these formatting atom
system works (I had heavy involvement in the initial one) and I know
it would be hard to make it do nonsensical things when given an
object of an unexpected type.

But I was hoping some among us experienced contributors would lead
beginners by example of making sure we test both positive ("see, my
shiny new toy does work") and negative ("and it won't do nonsensical
things when given an input it is not designed to work with") cases.

Thanks.
