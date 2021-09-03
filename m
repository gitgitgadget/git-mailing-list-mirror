Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3A6C433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D79FF60E77
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbhICRgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:36:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50731 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhICRgz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 13:36:55 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88E50E8979;
        Fri,  3 Sep 2021 13:35:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iVY21YR006ccMX+Vw4PSrmaNKmEXRDVCyiUSmA
        oBhXw=; b=kNDLa/lB57yjig0WPoRkGnx3sDIIGy0FVE/vQNAuFGg1oJWQZVJeB9
        wpBrnB5nlqtTztFNnTtyj9IWXVgrmv48Ze67JbIZ7rWN8jwsL6YUgK0QaghLR4GE
        1VjtgoP8apObu5c+V4cZvvZRWNKKWRHAJY2HWZq7P8nogAQfgUbt0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80615E8978;
        Fri,  3 Sep 2021 13:35:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD442E8977;
        Fri,  3 Sep 2021 13:35:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 04/15] scalar: 'register' sets recommended config and
 starts maintenance
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
        <3786f4c597fffc13f638efd26875dcb257d54ab4.1630359290.git.gitgitgadget@gmail.com>
        <xmqq5yvks22s.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2109031724560.55@tvgsbejvaqbjf.bet>
Date:   Fri, 03 Sep 2021 10:35:53 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2109031724560.55@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 3 Sep 2021 17:41:37 +0200 (CEST)")
Message-ID: <xmqqsfylftom.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 637A6A3A-0CDD-11EC-8089-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> "The design decisions we made are all part of being opinionated" can
>> all explain it away, but at least we should let the users know where
>> the opinionated choices scalar makes want to lead them to, and this
>> "src/" stuff needs a bit of clarification.  Perhaps a documentation
>> will be added in later steps?
>
> I had hoped that the initial blurb of the manual page was sufficient, but
> you're right, the `register` subcommand is particular in that it allows to
> force Scalar to consider the worktree to be identical to the Scalar
> enlistment. I added this:

Sorry, if it weren't clear that I was commenting on each step as I
read along without peeking later steps.  I think I saw it was
written somewhere that this was to encourage use of read-only
directory that keeps the sources with build artifacts and crufts
created outside it (so forests of projects will not have the source
directories, each of which has its own .git/, next to each other---
instead we would have shell directories, each with its own src/ and
src/.git, next to each other).  The additional documentation below
is a good thing to have handy when readers learn how to use
"register" (or more generally, what an "enlistment" is).  As long as
the motivation behind that design is given somewhere (not necessarily
here) for readers to discover, I am OK with the design.

> 	diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
> 	index 1593da45eae..568987064b2 100644
> 	--- a/contrib/scalar/scalar.txt
> 	+++ b/contrib/scalar/scalar.txt
> 	@@ -40,6 +40,10 @@ register [<enlistment>]::
> 		and starts background maintenance. If `<enlistment>` is not provided,
> 		then the enlistment associated with the current working directory is
> 		registered.
> 	++
> 	+Note: when this subcommand is called in a worktree that is called `src/`, its
> 	+parent directory is considered to be the Scalar enlistment. If the worktree is
> 	+_not_ called `src/`, it itself will be considered to be the Scalar enlistment.

Thanks.

