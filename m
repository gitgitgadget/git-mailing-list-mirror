Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49B8C001B0
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 16:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjHGQ0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 12:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjHGQ0F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 12:26:05 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB3C1730
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 09:26:03 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF0B02298A;
        Mon,  7 Aug 2023 12:26:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a44pJFyZVr+/e73ee7GAqOjmLWN6KbJHJcTOqw
        J+WRw=; b=gAlrLLYYDx+7v5ispp9m+YGvZMY3FPyzD8iMd86ZdAUIi32Tt/YasI
        upSDsphunKEGXG/H5aDIpa5XBs4UtmLtLGev1D6AbjA6gmXT8Mr2tbtnMKn2w+ag
        /RQpy9KkJvuuVytZ2lGY/e5u9A++wSVRlp7LiWzdeejm8UtBvIekk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B839122989;
        Mon,  7 Aug 2023 12:26:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3CE6E22986;
        Mon,  7 Aug 2023 12:25:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ryan Williams via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ryan Williams <ryan@runsascoded.com>
Subject: Re: [PATCH] ls-tree: default <tree-ish> to HEAD
References: <pull.1566.git.1691412557518.gitgitgadget@gmail.com>
Date:   Mon, 07 Aug 2023 09:25:57 -0700
In-Reply-To: <pull.1566.git.1691412557518.gitgitgadget@gmail.com> (Ryan
        Williams via GitGitGadget's message of "Mon, 07 Aug 2023 12:49:17
        +0000")
Message-ID: <xmqqmsz2hl9m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17BEB682-353F-11EE-9B02-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ryan Williams via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ryan Williams <ryan@runsascoded.com>
>
> When no positional arguments are passed to `git ls-tree`, it currently
> prints "usage" info to stderr and exits with code 129. A more intuitive
> default would be to operate on the `HEAD` commit's tree (similarly to
> `git show`, `git log`, and possibly others).

As 'ls-tree' is a plumbing command meant for script writers, it was
designed to require the users to be more explicit.  So, similarity
to "show" and other Porcelain commands do not weigh much here.  Same
for "rev-list" that does not fall back to HEAD.

This was a very deliberate design decision to help use of the
plumbing commands.  A buggy script may say

    TREE=$(some command to find a tree object)
    git ls-tree $TREE

without making sure something sensible is in $TREE (and not even
quoting it like "$TREE"), and if ls-tree defaulted to something, the
script will silently produce a wrong result, instead of failing,
robbing the script writer a chance to notice a bug in their code to
come up with the TREE object name.

So, I dunno.

Thanks.
