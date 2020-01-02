Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9013DC2D0C2
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 18:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5265C21655
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 18:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UDS6dcoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgABSfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 13:35:13 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54575 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgABSfN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 13:35:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C5260ACA78;
        Thu,  2 Jan 2020 13:35:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cAeFATOKBhUz8Yy/kU1hQuia6C0=; b=UDS6dc
        ooalfTrJuMYhTQs94Qqt26DktO7Yq3wCpxxyadpIC7yn4bF+y+NpRoQ/w8c3GHZo
        x3j15auowdQ6p/5V1iyGTuVRSrFcAsQvVB+u2+EYD7ScaFJY44D5jMtJwb1dkepd
        2zXfUdqYAwbfC14UxsVW4U1iHEpdQ1rrL2hBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KrCMgkswh0iF7b27fF+N4o3M+Cqxnmcp
        Jqzqn68Uy+BU/9Ds7vxFqSi3xzzXoaXPqEQCOpvz4RxS2NXNyKHD1TbKvomGd4fv
        KU8nL9BlaFyjSWAFDUhyfIDGcrqyKiFs6csKiLBU8zjgYoWsmcr9E3tC6bj/SOwe
        Pyl2z4KdoHw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BCB6AACA77;
        Thu,  2 Jan 2020 13:35:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E0579ACA76;
        Thu,  2 Jan 2020 13:35:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/1] merge-recursive: remove unnecessary oid_eq function
References: <pull.685.git.git.1577856057.gitgitgadget@gmail.com>
        <c653a9b8d3863b3484eff224bbfbde65c250eaf0.1577856057.git.gitgitgadget@gmail.com>
Date:   Thu, 02 Jan 2020 10:35:07 -0800
In-Reply-To: <c653a9b8d3863b3484eff224bbfbde65c250eaf0.1577856057.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 01 Jan 2020
        05:20:57 +0000")
Message-ID: <xmqqtv5demg4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B1F43AA-2D8E-11EA-894C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Back when merge-recursive was first introduced in commit 6d297f8137
> (Status update on merge-recursive in C, 2006-07-08), it created a
> sha_eq() function.  This function pre-dated the introduction of
> hashcmp() to cache.h by about a month, but was switched over to using
> hashcmp() as part of commit 9047ebbc22 (Split out merge_recursive() to
> merge-recursive.c, 2008-08-12).  In commit b4da9d62f9 (merge-recursive:
> convert leaf functions to use struct object_id, 2016-06-24), sha_eq() was
> renamed to oid_eq() and its hashcmp() call was switched to oideq().
>
> oid_eq() is basically just a wrapper around oideq() that has some extra
> checks to protect against NULL arguments or to allow short-circuiting if
> one of the arguments is NULL.  I don't know if any caller ever tried to
> call with NULL arguments, but certainly none do now which means the
> extra checks serve no purpose.  (Also, if these checks were genuinely
> useful, then they probably should be added to the main oideq() so all
> callers could benefit from them.)

Just for some historical yuck values ^W^W entertainment,
6d297f81373:merge-recursive.c shows how the function was called and
needed to prepare for NULL inputs.

I agree that today's code won't need the "two NULLs are equal, and NULL
is never equal to anything" hack.  We've come a long way ;-)

