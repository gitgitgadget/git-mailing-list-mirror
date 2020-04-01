Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D59C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 21:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C4D2071A
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 21:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nGVeFXSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbgDAVf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:35:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62331 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgDAVf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 17:35:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F9CF5831C;
        Wed,  1 Apr 2020 17:35:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0ZWPcf74tlOizmOLMPv/xZGRfpY=; b=nGVeFX
        SMtANttJDj7v9NreK2VA9tyk3JiZkg3J3pfEIfQha8wH8chRWkuOfAy1807Og+Xz
        Ikg6Qqb1DVbrWHfrAehy6pskvEneQraHrxdCQ41jqDID1v96t2klEQr5RrjSeY8b
        2RNZMHsnQ8VqRhSQ83FFdFglsi1APMBkdbVg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WkojoL64f5bYTSXiK5RxQGTKIiLYh+tf
        QVr5EUE6fDtU+Dc4CS2aMRs5CFKxUNHgtjNXUhxpDsGxrbv5MLxV3mFgC6CIks/g
        S7PzFf/BZwM+BOnDOO9yRUrbuoUUr23gmhov3/1CuDDENWHeJ9Kok1eq6jnNtBQ6
        X0vblpbxDgA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85ED95831A;
        Wed,  1 Apr 2020 17:35:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E97D058319;
        Wed,  1 Apr 2020 17:35:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/2] t5319: replace 'touch -m' with 'test-tool chmtime'
References: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
        <pull.596.v2.git.1585774844.gitgitgadget@gmail.com>
        <24e26ecda632421e4c1a61ebabf6ea78301685b1.1585774844.git.gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 14:35:25 -0700
In-Reply-To: <24e26ecda632421e4c1a61ebabf6ea78301685b1.1585774844.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 01 Apr 2020
        21:00:43 +0000")
Message-ID: <xmqq369m6g9u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B329B5B6-7460-11EA-B290-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The use of 'touch -m' to modify a file's mtime is slightly less
> portable than using our own 'test-tool chmtime'.

Portability aside, the relative form would also be resistant against
skews between filesystem time and wallclock time and is preferrable
when we can use it.

> The important
> thing is that these pack-files are ordered in a special way to
> ensure the multi-pack-index selects some as the "newer" pack-files
> when resolving duplicate objects.

This note is very much appreciated.

>  		rm -rf .git/objects/pack &&
>  		mv .git/objects/pack-backup .git/objects/pack &&
> -		touch -m -t 201901010000 .git/objects/pack/pack-D* &&
> -		touch -m -t 201901010001 .git/objects/pack/pack-C* &&
> -		touch -m -t 201901010002 .git/objects/pack/pack-B* &&
> -		touch -m -t 201901010003 .git/objects/pack/pack-A* &&
> +		test-tool chmtime =-5 .git/objects/pack/pack-D* &&
> +		test-tool chmtime =-4 .git/objects/pack/pack-C* &&
> +		test-tool chmtime =-3 .git/objects/pack/pack-B* &&
> +		test-tool chmtime =-2 .git/objects/pack/pack-A* &&

The original wants D to be the oldest and A to be the newest, and
the updated would want the same ordering.

When created, we know A gets created before B which gets created
before C and so on, in the "setup expire tests" part.  If each step
takes too much time (e.g. the VM is heavily loaded), wouldn't the
adjustment above become insufficient?

In other words, would we want to flip the order these packs get
created in the "setup" part, in addition to the use of chmtime
(which reads the existing file timestamp using stat(2) and then
updates the file timestamp relative to the original timestamp)
we see here?

Also, in the best case (i.e. original timestamp of A/B/C/D are the
same), the above seems to assume that the filesystem has at least 1
second file timestamp granularity.  Do we want to make them at least
2 seconds apart, or am I worried too much about ancient filesystems
that no longer metter?

Thanks.

>  		ls .git/objects/pack >expect &&
>  		MINSIZE=$(test-tool path-utils file-size .git/objects/pack/*pack | sort -n | head -n 1) &&
>  		git multi-pack-index repack --batch-size=$MINSIZE &&
