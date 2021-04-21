Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63EBC433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 19:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7390E61457
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 19:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245468AbhDUTFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 15:05:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52793 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245360AbhDUTFk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 15:05:40 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 03190134722;
        Wed, 21 Apr 2021 15:05:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q5AAx8NIuvbqrM22gPisyW4s8tQ=; b=drWZBy
        VWInzb0PlN13T9gDlfTmLfrD3h07Pkgx5Q1Ot8pKJi9gdrXbPK4cNDbsO2MSmy2C
        OrYb1mMoht2mEC44c07lERrvJ47+Zn5sVsf0I/OTLW787A79sYaMhIyTsEBdmfgx
        Xnn7KOlKijryHvf0ZxQMJPjGvdrXivVAwFNVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D6/qIsFBWTZ9swq9lUVD9lTZRB4zGJto
        hjwDL6jaVoQx3TcyBCvHNJaYdNVmz1R0nYodVPjsUP8+M5BbWPHoiEA8c1bCC4Cw
        E5d3gsYTthB2GMGKCCo/eUzaVOJWyOPhSEbRMVgxJsZGKReB1hZJ77vD7SLuHsXG
        DTvE9wrLlsM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EFF20134721;
        Wed, 21 Apr 2021 15:05:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 34D5D134720;
        Wed, 21 Apr 2021 15:05:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     git <git@vger.kernel.org>
Subject: Re: Track changes across multiple branches, c.f. "p4 interchanges" ?
References: <d9022ce8-2752-db75-f4b7-d5188c41bd90@diamand.org>
Date:   Wed, 21 Apr 2021 12:05:02 -0700
In-Reply-To: <d9022ce8-2752-db75-f4b7-d5188c41bd90@diamand.org> (Luke
        Diamand's message of "Wed, 21 Apr 2021 09:54:04 +0000")
Message-ID: <xmqqpmynxxup.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7AD26BEC-A2D4-11EB-A0F7-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> 2. Merge
> ...
> If I do "git merge bugfix" onto relbranch, then as well as getting X,
> I also get B and C, which I don't want.

This won't work exactly for the reason why you want to do #3 below.

> 3. Always start from a merge base
>
> I could tell people that if they are making a bugfix that will need to
> go onto multiple branches, that they need to start from some common 
> merge base, and then merge to the final target branches.
> ...
> And invariably people will start out thinking their change is not a
> bugfix, but a new feature, and then find that actually we need the new 
> feature on the release branch.
>
> 4. Use gerrit change-ids
>
> We could adopt gerrit change-ids. It feels like this is kind of a
> kludge, but perhaps it's the only thing that really works?
>
> Is there something better?

Just to throw another in for completeness (not claiming which one is
better and which one is worse):

5. Primarily use #3 to merge, but use "cherry-pick -x" when
   replaying a fix that was built on a wrong base, and tweak the
   procedure to find out "is this fix already on branch X?" to also
   pay attention to it.

It is no worse than #4, I would think, as both approaches would need
to scan the commit log messages to find the commits that are not in
the ancestry chain that participated to the branch.

