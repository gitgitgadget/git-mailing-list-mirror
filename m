Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D791C433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 01:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62145206FA
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 01:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OfMSsr7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgFKB4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:56:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62494 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgFKB4A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 21:56:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6DEAD647D6;
        Wed, 10 Jun 2020 21:55:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LHT3OH90B2d1A9ZBbopPNRwfheI=; b=OfMSsr
        7SgwckvuNIoVsusCQqphkWwIRpfxz/hThTEza99/hI51NIQP8DtgYZTQsd4jOkD5
        59PbYjhfiEDngcu8LN6CWl/q4MD0jYbQWIEfYTbw3Td8eAFAbVrnlFfOhzvA/m22
        zytKWcZdqgvRC/UauBlXdFKxe1g+rpZxNAWn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BLFBNzQWQ1tkrmWcJ7IMyjdMCq78hs0I
        lTJ0W9R3vWVEEZf6p3a48wMy5YTIb8Uoa2Ksmc17Qv7TZhnI+EJb26JNZTt16RCk
        r2sCCiIpzifknoXs1y3ym1fC8jUgyVGJFQykBxzyNPe5ndliZoO/NpNTvCvEzVm9
        nXhNAjQZsQU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6519B647D5;
        Wed, 10 Jun 2020 21:55:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E8786647D3;
        Wed, 10 Jun 2020 21:55:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 6/9] Documentation: add Packfile URIs design doc
References: <cover.1590789428.git.jonathantanmy@google.com>
        <cover.1591821067.git.jonathantanmy@google.com>
        <6344c225897de1a2d8aa86d610e9eaf1c6ec82b4.1591821067.git.jonathantanmy@google.com>
Date:   Wed, 10 Jun 2020 18:55:58 -0700
In-Reply-To: <6344c225897de1a2d8aa86d610e9eaf1c6ec82b4.1591821067.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Wed, 10 Jun 2020 13:57:20 -0700")
Message-ID: <xmqqftb2cqmp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2114B32-AB86-11EA-B828-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +The server advertises the `packfile-uris` capability.
> +
> +If the client then communicates which protocols (HTTPS, etc.) it supports with
> +a `packfile-uris` argument, the server MAY send a `packfile-uris` section
> +directly before the `packfile` section (right after `wanted-refs` if it is
> +sent) containing URIs of any of the given protocols. The URIs point to
> +packfiles that use only features that the client has declared that it supports
> +(e.g. ofs-delta and thin-pack). See protocol-v2.txt for the documentation of
> +this section.

Even if we have some pre-packaged packfiles, if the requestor lacks
some feature (by the way, shouldn't we consistently use "capability"
instead of "feature" to call things like "ofs-delta"?)  to be able
to understand them, we would already know that fact (i.e. the lack
of capability on the other side) by the time we have to decide if we
can give packfile-uris section.  OK, this makes sense.

> +Clients should then download and index all the given URIs (in addition to
> +downloading and indexing the packfile given in the `packfile` section of the
> +response) before performing the connectivity check.

Looking good.

Is there other requirement on the packfile that can be retrieved
with the URI listed in the packfile-uris section?  It would be clear
that it must, together with the contents in the dynamic 'packfile'
section, give fully connected set of objects to the other side that
has the object it claimed to have.  But are we allowed to include
extra/unasked-for objects in such a packfile?  Or is it better to
leave it unspecified?

Thanks.
