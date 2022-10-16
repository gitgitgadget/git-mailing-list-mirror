Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E38C4332F
	for <git@archiver.kernel.org>; Sun, 16 Oct 2022 16:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJPQ6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 12:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiJPQ6B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 12:58:01 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613AF32069
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 09:57:59 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 553711C81C5;
        Sun, 16 Oct 2022 12:57:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+7k4zr8YQEGHlYnckWXxIUU4Oh80QJemxsN8ls
        xp3mw=; b=Gg/CQ+UYuXkn2jPTvra3kxZx0VuSma89CUmkZ4r5m+P01NNRvYk8/s
        vTYz6TrJhrK01OMcBdu1MDzh62OwJsTUynE502BXTTBPf5eT2SrO3ly4deiBA6Ul
        rEfWxqyuJPJq37PgG3BoWlGlIwEezg6NM3m9BkaPWPzC02NHJcHSA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F5B41C81C4;
        Sun, 16 Oct 2022 12:57:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 137541C81C2;
        Sun, 16 Oct 2022 12:57:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Rupinderjeet Singh <rupinderjeet47@gmail.com>, git@vger.kernel.org
Subject: Re: [suggestion] Fail cherry-pick if it overwrites untracked files
 with the matching file names
References: <CAAheMRzYX6PdWMtcB=px_kD=-gnGGHvDgvR6Jxy94JH2DpYpJw@mail.gmail.com>
        <xmqq7d11540b.fsf@gitster.g>
        <CABPp-BG=pm8gfRZNW8Rk1V77s40Do1FZy0mxH6epubHbzF8U5w@mail.gmail.com>
Date:   Sun, 16 Oct 2022 09:57:54 -0700
In-Reply-To: <CABPp-BG=pm8gfRZNW8Rk1V77s40Do1FZy0mxH6epubHbzF8U5w@mail.gmail.com>
        (Elijah Newren's message of "Sat, 15 Oct 2022 19:07:45 -0700")
Message-ID: <xmqqo7ub4sfh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ADCEE8D6-4D73-11ED-B9FF-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> There is a command line option meant to allow tweaking this behavior:
> --[no-]overwrite-ignore.

Ah, I totally forgot that relatively recent invention.  Thanks for
bringing it up.

I personally consider it a bit too blunt an instrument, and in the
longer term, it would probably be a better direction to introduce a
new class of paths that are not tracked, and call the class
"precious", which (1) is similar to "ignored" in that the paths in
the class do not get added with "git add ." but (2) unlike "ignored"
but like "untracked", they are not considered to be expendable.

Until that happens, though, treating all "ignored" paths as if they
are "precious" may be a usable workaround.
