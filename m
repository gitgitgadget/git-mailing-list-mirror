Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A42C433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD66206FA
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MsKtSucB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHZQUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:20:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61277 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgHZQUL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 12:20:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3439B68482;
        Wed, 26 Aug 2020 12:20:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oVTZLpph9ztOq+9zo50vnMSK6p4=; b=MsKtSu
        cBSJKoo3STTFzq8D9aqBaOBUG+EsK3k/JNaSkDBH4mBRmwOFrdGi2hg6e/Fys5Yk
        /8eiznwzzxy7+Em0Sw0AvMMktL4WP+aIQH1GYDqtopHt8EaEMyOMVhb/HTbI9Pmf
        Dn5QZbmbwwaI+wXa+n140zh/xsoj5sU/pGVEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cRRy5FcpybRTfLiuGCcyt7B2/tzaJIm6
        ITY2HDMOAQ81L44eBGj4tPAgtTBylLSN9zIE8LSGe0TIe4GaMdPrZtWRuOyydhqu
        Iapwzc5DgvzXWk4D9qkppMChIjzTHbW8ffqioHVwfrEILiyd4oVALj2k0IDga45y
        D9r57lXRU2A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1240E68481;
        Wed, 26 Aug 2020 12:20:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6003E68480;
        Wed, 26 Aug 2020 12:20:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/3] Optionally skip linking/copying the built-ins
References: <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
        <pull.411.v3.git.1598443012.gitgitgadget@gmail.com>
        <52deafded50ef99d904d2af39c098028b8714e86.1598443012.git.gitgitgadget@gmail.com>
Date:   Wed, 26 Aug 2020 09:20:07 -0700
In-Reply-To: <52deafded50ef99d904d2af39c098028b8714e86.1598443012.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 26 Aug 2020
        11:56:51 +0000")
Message-ID: <xmqq1rjtxtu0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02239DE2-E7B8-11EA-B2F4-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> For a long time already, the non-dashed form of the built-ins is the
> recommended way to write scripts, i.e. it is better to call `git merge
> [...]` than to call `git-merge [...]`.
>
> While Git still supports the dashed form (by hard-linking the `git`
> executable to the dashed name in `libexec/git-core/`), in practice, it
> is probably almost irrelevant.

Let's drop this paragraph.  We do not have to defend this new opt-in
feature with "probably".  Even if there are folks heavily depend on
the old promise of having all binaries on disk, giving the rest of
the world an option to have Git without that promise is a good thing
as long as there is a good reason why the rest of the world would
want to omit binaries for builtins.  And we do have a good one below.

> However, we *do* care about keeping people's scripts working (even if
> they were written before the non-dashed form started to be recommended).

That misses the point.  They were written in dashed form, and when
we started recommending non-dashed form, they were TOLD to tweak it
by adjusting PATH early in their script, and they did so to keep the
script working.  So it is not "even if".  We do care because we
promised them that we will *NOT* break them if they did such and
such, and they followed that recommendation.

> Keeping this backwards-compatibility is not necessarily cheap, though:
> ...
> introduce a Makefile knob to skip generating them.

I do not have anything add to the good argument above (elided) to
allow those who know they do not rely on the age old promise.  Well
written.

