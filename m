Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8183DC388F7
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 01:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2428A20719
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 01:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RXyT4RVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbgKFB64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 20:58:56 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55686 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbgKFB6z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 20:58:55 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D342F103C9A;
        Thu,  5 Nov 2020 20:58:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FW+wtnLUth9b+/hBD04lUg9oueE=; b=RXyT4R
        VqcQqeMgQPGtvILr2Nb4xCBsnMXVs+u0aPjch77lh43AV8YPcqGts4Jq/K8u09N3
        kSvP0adyiZ6e5dfp+CMuwpMezbVcfLqKOGnH3CppkfW7omU7OD5fqeqlwltW05LM
        aPWi4U4sd0K+ysSAYivJjD3ID+7LD/tqQ6TPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rFn5PY1FJCYezIr9AOKCN/fUqGT5451I
        j05WWsHApevTJqEB8onvRdQvmWE5AKLlre58FhTgWHDjvVMTNT86bUv2mvbLWDGq
        IagnF++R/QwD0JuosmTyMcFt9/iq2N3q7C1ZdUZVeoSCBgDdwjSRHAIsThkjRec/
        x1lrcClYf7M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CC92F103C99;
        Thu,  5 Nov 2020 20:58:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 21124103C98;
        Thu,  5 Nov 2020 20:58:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 7/8] Makefile: don't delete dist tarballs directly by name
References: <48fdd198-93ad-7282-27e6-9a0c6de93067@ramsayjones.plus.com>
        <xmqqr1p7h38t.fsf@gitster.c.googlers.com>
        <xmqqeel7h0aj.fsf@gitster.c.googlers.com>
        <0cbe821b-092d-a5f9-e2ab-13a3c01e9a02@ramsayjones.plus.com>
Date:   Thu, 05 Nov 2020 17:58:49 -0800
In-Reply-To: <0cbe821b-092d-a5f9-e2ab-13a3c01e9a02@ramsayjones.plus.com>
        (Ramsay Jones's message of "Fri, 6 Nov 2020 01:44:18 +0000")
Message-ID: <xmqqa6vvgs9y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DD4B354-1FD3-11EB-A7FD-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> I did have a patch #9 that moved the removal of the tarballs from
> the 'clean' target to the 'distclean' target (that is move the new
> 'iterate over the dist-tars file' code). However, I wasn't convinced
> that it was a better place for it.

I am not either, other than "things created by 'make distX' cleaned
by 'make distclean'---that sounds consistent" ;-).

> Also, just moving the new removal code would not alter the concerns
> about it that you express above. So, we need to address that either
> way.

"make distclean" can still depend on GIT-VERSION-FILE and your daily
cleaning needs can use "make clean" that cleans only the files that
can be cleaned without knowing what GIT_VERSION is, no?  That way,
we do not have to use dist-tars file at all, no?

