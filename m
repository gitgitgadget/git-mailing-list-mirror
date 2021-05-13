Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D967C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 20:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECAF8613CB
	for <git@archiver.kernel.org>; Thu, 13 May 2021 20:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhEMUUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 16:20:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54704 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhEMUUF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 16:20:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92AEFB5F59;
        Thu, 13 May 2021 16:18:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3ULEjMlKZNLcqPvEXc03KwEBFnwcCLgaopvDS5
        uc9pU=; b=Ff0f680pU7ABOdDVQ3oRK36R1qIjjwJgLsm2Nr6Q6C/C3J94wN5J4A
        BrQ2mRSkB8QDXDvDKUxdDJ83e9X6xuXEyh2wKrcPRelGWrK7z0i7j/c4V/tkc05c
        vkiHSDInrCUtDdG2lewmOkELhoAJfmsSsp2X0LZ/WMc2vAaSk/9Po=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AB61B5F58;
        Thu, 13 May 2021 16:18:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1AB54B5F57;
        Thu, 13 May 2021 16:18:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Rebase options via git pull
References: <87r1iakbyn.fsf@osv.gnss.ru>
Date:   Fri, 14 May 2021 05:18:54 +0900
In-Reply-To: <87r1iakbyn.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
        13 May 2021 16:19:44 +0300")
Message-ID: <xmqq1raabd5d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70ED7FDA-B428-11EB-AA0F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Is there a way to specify additional options for "git rebase" when it's
> invoked via:
>
>   git pull --rebase
>
> ? What if rebase is used implicitly due to "pull.rebase" being set
> accordingly?
>
> In particular, I'd like to be able to:
>
>   git pull --rebase --no-fork-point
>
> but it doesn't work.
>
> From documentation is looks like "git pull --rebase" is still a
> second-class citizen. There is whole section about merge options in the
> manual, and none about rebase options.

Yeah, it does feel like so.

Just like we can pass merge-strategy specific options via -X<opt>=<val>,
e.g.

    $ git pull -Xsubtree=gitk git://ozlabs.org/~paulus/gitk.git

to ask the command to invoke "git merge -Xsubtree=gitk" after
fetching from the remote repository, we should allow rebase specific
options via a similar mechanism, e.g. -Yno-fork-point=yes (or
something along that line---exact syntax does not matter).

But I do not think there currently is anything like that.

