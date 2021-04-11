Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043E5C433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 06:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE30F60C3E
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 06:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhDKGDR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 02:03:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51712 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhDKGDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 02:03:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 895C8122BE3;
        Sun, 11 Apr 2021 02:03:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+EjlcewR2nKQpPDDmthAoJyOPsk=; b=IfXYFq
        oqzdd35Zn59mPJnHe5OHPA25QaIGbKYr7bPiIKjBsABQbqpoI129hs8d6fPsAkYR
        KRelWS1NKpQpUBmpdA2hU/sccjyUpnHTBFWJplera2EtlFz4PyybC6vY0jvMbvU0
        XnZpRtX10Z7uykKybz9/gEU5aNCg2b2IsST3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vsfGHJ3ge7SmUZDws1rwtqJZDLPOcGL5
        uIg5aViVnIQCFfbcyqpqxyVO50P23MZv+/HaoThk5xUGvJ/Klq7/o67aQjAS/M4X
        wsqmYVPrsG/wENBvr/MQ4dhhYHpkG9tFNd1+haBWX031kwrGuBiwVzAyO7Q2uWXM
        heaJcMVy2+s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8276A122BE2;
        Sun, 11 Apr 2021 02:03:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C9D48122BE1;
        Sun, 11 Apr 2021 02:02:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/8] rev-parse: implement object type filter
References: <cover.1615813673.git.ps@pks.im> <cover.1617967252.git.ps@pks.im>
Date:   Sat, 10 Apr 2021 23:02:55 -0700
In-Reply-To: <cover.1617967252.git.ps@pks.im> (Patrick Steinhardt's message of
        "Fri, 9 Apr 2021 13:27:47 +0200")
Message-ID: <xmqqpmz1icj4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90625C98-9A8B-11EB-85A2-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Subject: Re: [PATCH v3 0/8] rev-parse: implement object type filter
>
> this is the third version of my patch series which implements a new
> `object:type` filter for git-rev-parse(1) and git-upload-pack(1) and
> extends support for bitmap indices to work with combined filters.

Do you truly mean rev-parse, or is it just a typo for rev-list?

> This mostly addresses Peff's comments. Thanks for your feedback!
>
>     - Removed the `base` parameter from `process_tag()`.
>
>     - The object type filter doesn't assume ordering for the object type
>       enum anymore.
>
>     - Combined filters in the bitmap path now verify that
>       `filter_bitmap` does not return any errors.
>
>     - Renamed "--filter-provided" to "--filter-provided-revisions" and
>       added documentation for it.
>
>     - Refactored the code to not munge the `filter_provided` field in
>       the filter options struct, but instead carry it in rev-list.c.
>
> Please see the attached range-diff for more details.
>
> Patrick
