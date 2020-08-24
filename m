Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A98AC433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA96C2074D
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wJv9bD0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHXTC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:02:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64271 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgHXTC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 15:02:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 190C6D3D2E;
        Mon, 24 Aug 2020 15:02:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XuShV3LSPDwi7nGBYTe0kestcG4=; b=wJv9bD
        0HtH+sLipYjVzGq7HghSLtL/dkWA3+stFytWLiBQ4eH7bzzq3tk+/1wVyzRIoL8d
        mRYSZnUQlEbQy1SzfSzerQXk8zmJ4m9wL+C1C58d+o4ztz+3XCAhle3/FDruOa8S
        3RMwE4E0ARbUpWHU2gIydfjAnbEqVy1GFzSac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GMpWOtU5jK3dkpvIM1xFSGd7pzOa9pdo
        08ePe6DZVNA3HqnxHBympw6HKxxQfDit/WdZE7ZF5I6sgYVXvGrFG3quz3upkguI
        HFNZCm/aFIKIFnSP09D0Ho3HaBLyvEVsn3P6yECYuuJCvwipQk+JQnePGrYLvamJ
        6mvLWu2VzVo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 11F30D3D2D;
        Mon, 24 Aug 2020 15:02:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 333BFD3D2C;
        Mon, 24 Aug 2020 15:02:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/3] Optionally skip linking/copying the built-ins
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
        <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
        <166bd0d8fb699132569aff855de59c7607581adf.1598283480.git.gitgitgadget@gmail.com>
Date:   Mon, 24 Aug 2020 12:02:51 -0700
In-Reply-To: <166bd0d8fb699132569aff855de59c7607581adf.1598283480.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 24 Aug 2020
        15:37:59 +0000")
Message-ID: <xmqqmu2j50kk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69983780-E63C-11EA-8A15-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> While Git still supports the dashed form (by hard-linking the `git`
> executable to the dashed name in `libexec/git-core/`), in practice, it
> is probably almost irrelevant.

It is irrelevant when you have to say "probably" without facts, and
this paragraph is not necessary to justify this option.  I'd omit it.

We do care about keeping people's scripts working (even if they were
written before Windows folks started using Git---those people who
started using Git before that still exist ;-).

> In fact, some platforms (such as Windows) only started gaining
> meaningful Git support _after_ the dashed form was deprecated, and
> therefore one would expect that all this hard-linking is unnecessary on
> those platforms.
> 
> In addition to that, some programs that are regularly used to assess
> disk usage fail to realize that those are hard-links, and heavily
> overcount disk usage. Most notably, this was the case with Windows
> Explorer up until the last couple of Windows 10 versions.

However, the above two paragraphs I would suggest to keep, as they
do matter---it is a good justification to have this configurable.
Windows folks won't be able to copy and use POSIX shell scripts
written by folks before the Windows port of Git was started to
become widely used anyway.

