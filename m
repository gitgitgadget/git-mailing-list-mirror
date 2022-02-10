Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A728C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 18:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiBJSEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 13:04:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbiBJSEn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 13:04:43 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83732100A
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 10:04:44 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABAA81080BF;
        Thu, 10 Feb 2022 13:04:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eEcneBcYXRadzsA43JV6U6KrCJ3YFxfxvVAyGk
        ih1To=; b=cafokg5sRUbQDHZBr4V6ZSuvqqttN4Yk2QaboTVI9/+k7nsoqdc2uh
        IIKMzWDfY5ytZoklKCnAp9hM4kex953R/Pf43t2vqJ54vgcZe95qe5AmCHb8FzvO
        L2YKjQhcbxZX72jWACpWrudw8NTyfHpbFTLdTe44pYhD2RDe6ZUeU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2DE31080BE;
        Thu, 10 Feb 2022 13:04:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 08CED1080BD;
        Thu, 10 Feb 2022 13:04:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 0/2] fetch: speed up mirror-fetches with many refs
References: <cover.1643806143.git.ps@pks.im> <cover.1644495978.git.ps@pks.im>
Date:   Thu, 10 Feb 2022 10:04:41 -0800
In-Reply-To: <cover.1644495978.git.ps@pks.im> (Patrick Steinhardt's message of
        "Thu, 10 Feb 2022 13:28:01 +0100")
Message-ID: <xmqqfsoqvbra.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC4BBC06-8A9B-11EC-94D6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1Patrick Steinhardt <ps@pks.im> writes:

> this is the third version of my patch series which aimn to speed up
> mirror-fetches in repos with huge amounts of refs. Again, the only
> change compared to v2 is a change in commit messages: Chris has rightly
> pointed out that the benchmarks were a bit confusing, so I've updated
> them to hopefully be less so.
>
> Thanks for your feedback!

> Patrick
>
> Patrick Steinhardt (2):
>   fetch-pack: use commit-graph when computing cutoff
>   fetch: skip computing output width when not printing anything

Both changes are based on quite sensible idea.  If we have
precomputed dates for each commit, it makes sense to look it up
before parsing the commit.  If we are not preparing output, there is
no point in computing the output width.

Very simple and potentially effective.

Will queue.  Thanks.

