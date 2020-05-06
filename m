Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A224FC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E732206B8
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EfkyzMrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgEFRdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 13:33:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63832 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgEFRdX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 13:33:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 18AD7C5B72;
        Wed,  6 May 2020 13:33:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=INrvWwbieke3jcspE36bu8yA2jw=; b=EfkyzM
        rU39Qm1X7Va/N8jkdUb3GIu+b7kgiAd8nr3I0cF1DcGA+JLdlTqPiEwFJbDrU5ER
        wPzk7YnJkkoIhD1v7uT4QlYDhW11ekGKu3yqYj/3WxLg09N2yJzXJKC8mu/T401b
        KcHPL9n4Ac2Be1YXArMHKBAElCtPzMWLz24Yk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CYV8gEWJ4YQZDRutIeT6/A/WNxKnEFYD
        l0RWbiby6053S2wMiZZ0f/y1hQFFlnTaSOm/Lnckpadv2jmHtRx8Iom1DH/n1tzc
        tdlitrdFNUaCRVB5nJsWBdwvQFHVV7kpvTZvHUPAvVdvHeZ1aNuFlm0qLJiIYh9+
        v7JsWgkO2HQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 10CDFC5B71;
        Wed,  6 May 2020 13:33:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5DD41C5B70;
        Wed,  6 May 2020 13:33:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Git List <git@vger.kernel.org>,
        Pierrick Gaudry <pierrick.gaudry@loria.fr>
Subject: Re: [PATCH] commit: silence git-gc if --quiet is given
References: <20200506140138.650455-1-abhishekkumar8222@gmail.com>
        <CAPig+cSi5xe_FSzr7Z3D6+f1WxsbPthQnWcE1FrLyhrmi4TCGg@mail.gmail.com>
Date:   Wed, 06 May 2020 10:33:16 -0700
In-Reply-To: <CAPig+cSi5xe_FSzr7Z3D6+f1WxsbPthQnWcE1FrLyhrmi4TCGg@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 6 May 2020 12:09:06 -0400")
Message-ID: <xmqq8si56k9v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC82340C-8FBF-11EA-8A43-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, May 6, 2020 at 10:03 AM Abhishek Kumar
> <abhishekkumar8222@gmail.com> wrote:
>> As reported by Perrick [1], commit does not propagate quiet behavior to
>> gc if present. While we are at it, convert argv_gc_auto to struct argv_array.
>>
>> [1]: https://lore.kernel.org/git/20200506094327.GC31637@rillettes/
>
> According to the source you cite, this sort of issue has come up
> before in a different context (git-fetch). Do we know if there are
> other commands which invoke git-gc which might also suffer the same
> issue?

I just wrote my analysis to the original thread.  It looks to me a
fairly low-hanging fruit.

