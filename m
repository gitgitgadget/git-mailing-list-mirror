Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BD0C2D0F7
	for <git@archiver.kernel.org>; Tue, 12 May 2020 21:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 484D120769
	for <git@archiver.kernel.org>; Tue, 12 May 2020 21:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wFCr7UzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbgELVDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 17:03:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59332 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELVDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 17:03:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B199D3E9C;
        Tue, 12 May 2020 17:03:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G1fWOlajSVvxWDA0J/DZD8QwxSw=; b=wFCr7U
        zLZ0kUtkPQa0LKPjkfJX5MhELmaA9gL2bgKD+wrPditU1l7/DjQAD9ESJOXExKgf
        jsRAAf0UyuP/Yz+BVJJjwZ3nmLdqgs8WqcfmaQ20sy1QNMDNmc6hris3ewC/34G8
        T3RUvpR84CqrWTzyVnC0/os33xo7nxKQYetPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CjJHnlQNd0oB7e4ah33SaC65Cq13q+Vi
        2IHIUOzEwBE8Kx9FGLSSO/jy2UNcBNtNffL4CITjuLxluZjvvNPmXEz7HNU2idJ3
        THE+0nUjlstSFe3bCuBmq8pI8DHipj+BKDShSprC4kXUZ93wGid8wzgTtQqByKH5
        QMM+J0zegyM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 54931D3E9B;
        Tue, 12 May 2020 17:03:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.99.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 90603D3E9A;
        Tue, 12 May 2020 17:03:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v2 10/11] cmake: parse the makefile for the sources.
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
        <b0a321a714a766962456e2a9e8dd7d2be349e34d.1589302255.git.gitgitgadget@gmail.com>
Date:   Tue, 12 May 2020 14:03:18 -0700
In-Reply-To: <b0a321a714a766962456e2a9e8dd7d2be349e34d.1589302255.git.gitgitgadget@gmail.com>
        (Sibi Siddharthan via GitGitGadget's message of "Tue, 12 May 2020
        16:50:53 +0000")
Message-ID: <xmqqk11gc1d5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 027D7924-9494-11EA-A296-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
>
> The CMake script parses the Makefile for:
> SCRIPT_SH
> SCRIPT_PERL
> TEST_BUILTINS_OBJS
> LIB_OBJS
> BUILTIN_OBJS
> XDIFF_OBJS
> VCSSVN_OBJS
>
> By doing this we avoid duplication of text between the Makefile and
> the CMake script.

Thanks, this makes perfect sense, but it probably should have been
done from the very beginning, without copying the huge list manually
in the step [01/11].

How robust is the "parser"?  Do we need to leave an instruction to
Makefile writers to conform to certain style to help CMake users as
an additional comment in the Makefile, or is any reasonable textual
drift still accepted?

