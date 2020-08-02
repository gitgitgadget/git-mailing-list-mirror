Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7752C433E0
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 19:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC3220722
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 19:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mVVe1b/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgHBT5X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 15:57:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63061 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgHBT5W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 15:57:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 57FB4EAD99;
        Sun,  2 Aug 2020 15:57:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BmoWd6xadKunZXpUYzsH0HGAhSI=; b=mVVe1b
        /VwNZsFKG14yh3qgmNnOBuESZHGJ+rETtM5bHikxaJjd2mVzPAzDd/RdDYmK29Yf
        sbsSMkVZIiXY3OVyqFC6aHmlzo/zi9xb3b6sVYDrYEcnkjEnxu3jCPuvXxfaP+YJ
        p0gTMmhpsXuoZvl63WTGlTZbMZ6/IPwA+pfU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R/Hd0Y0vUmDr3KkDTDTZa8tDtbWm1i4N
        PhAg3KbGc5babdwvMHo+bxtUEoTadTjXSgRoE6DXU+n07flTdXXTgu67e529WjM/
        CLIvaUASFxMTy03UA5MAW1irwKo+rDr31hUJVOULpXXroozpdpxNS4H3yrNgSVtZ
        jPGmx6NQacU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 51888EAD98;
        Sun,  2 Aug 2020 15:57:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 943B5EAD97;
        Sun,  2 Aug 2020 15:57:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/4] t6038: fix test with obviously incorrect expectations
References: <pull.825.git.git.1596349986.gitgitgadget@gmail.com>
        <83a50f7e0bbfd19cffc5cffb9f17484e86443d0a.1596349986.git.gitgitgadget@gmail.com>
Date:   Sun, 02 Aug 2020 12:57:15 -0700
In-Reply-To: <83a50f7e0bbfd19cffc5cffb9f17484e86443d0a.1596349986.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sun, 02 Aug 2020
        06:33:04 +0000")
Message-ID: <xmqq4kpkstwk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E3D1426-D4FA-11EA-9B43-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> t6038.11, 'cherry-pick patch from after text=auto' was set up so that on
> a branch with no .gitattributes file, you cherry-picked a patch from a
> branch that had a .gitattributes file (containing '* text=auto').
> Further, the two branches had a file which differed only in line
> endings.  In this situation, correct behavior is not well defined:
> should the .gitattributes file affect the merge or not?

I'd say that it is probably more intuitive to expect whatever
attributes set on the currently checked out and receiving the
cherry-picked change would take effect, but I do agree with you that
this is not well defined.  I think "changing attributes in the
middle may produce unexpected/undefined results---validate it when
you cross such a boundary" is a prudent advice we should give to the
users.

Would it make more sense not to test ill defined behaviour at all
instead, I wonder?

Thanks.
