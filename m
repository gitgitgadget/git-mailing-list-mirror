Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9500DC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BFDC60231
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbhHSU1M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 16:27:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58576 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbhHSU1L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 16:27:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D7C78E00C7;
        Thu, 19 Aug 2021 16:26:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4NoMlp2fVHZN
        gamcDdzNLITQWXeZv6hF0yJ2tUqabmw=; b=dhYqGaYKrwW06aIxtneEklXvwwAR
        1U6QyPGe365iUkeeHG5EyfYLxFCar0eUgOeaQSEfPic9GL3LlETWSZUUYL9/i/3a
        /pB49LwartS94EMzfmvq2NIG4bF1UODXXRfn6wbF+NGt7+TZ89dGU6UHf2GfTFu1
        2Wsl/gGPXzjbdZE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D00C4E00C6;
        Thu, 19 Aug 2021 16:26:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 60287E00C5;
        Thu, 19 Aug 2021 16:26:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, hanwen@google.com, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] t3200: refactor symlink test from hn/refs-errno-cleanup
In-Reply-To: <20210819075244.36776-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 19 Aug 2021 00:52:44 -0700")
References: <20210819050103.25995-1-carenas@gmail.com>
        <20210819075244.36776-1-carenas@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Thu, 19 Aug 2021 13:26:33 -0700
Message-ID: <xmqqczq9yydi.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BF2A6DE8-012B-11EC-A90E-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> d1931bcf0d (refs: make errno output explicit for refs_resolve_ref_unsaf=
e,
> 2021-07-20) add a test for a crash when refs is a symlink, but it fails
> on windows.
>
> add the missing SYMLINKS dependency and while at it, refactor it slight=
ly
> to comply better with the CodingGuidelines.
>
> Reported-by: Jeff King <peff@peff.net>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
> v2:
> * update subject for clarity; might be worth squashing instead into 3d6=
3ce75e
>   (refs: explicitly return failure_errno from parse_loose_ref_contents,
>   2021-07-20)
> * change from --git-dir to -C for clarity
> * add reporting for errors to the for loop as suggested by Eric

Thanks for a fix-up.

Let's eject hn/refs-errno-cleanup and possibly ab/refs-files-cleanup
topics out of 'next' and give these 18 patches a chance for a fresh
start, as I've already failed a short-cut attempt to squash in the
"fix" yesterday that forgot the SYMLINKS prerequisite and even
today's attempts to fix it seem to be going back and forth X-<.
Even worse, there is a t0031 breakage that seems to have come from
the latter topic.

IOW, I won't be picking this up but asking Han-Wen and =C3=86var to come
up with a clean reroll of the two series, using this as an input
(perhaps Helped-by: etc. would be needed).

Thanks.
