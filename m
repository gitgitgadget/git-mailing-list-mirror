Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F9CC433E1
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 05:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3451B207F9
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 05:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YwbdmGOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgFIFHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 01:07:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59510 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgFIFHn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 01:07:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 40E65D3049;
        Tue,  9 Jun 2020 01:07:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dw6Ra0AXNJxKPN26ZwwjsEehytQ=; b=YwbdmG
        OwLwGySGiEaYaKRucsRxUSfELoWuBhNHB/KeU3sRWsVSyokuk8SY2ZzFJtjglrBr
        QOejp0peUOleb3hK4hi8lymLOMOpgCtThbJErWaP7/2Ge8nBHOzDVNFSbDQlciIX
        en9C+E/jjnez/8MIfx/HTu7w/ZGfhYriddtbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r8Gw/D84GBw+P1vKpMHX261+Oq/niPeB
        Ari+gbKBH/X9owVkniY+bQuSasq2G5qxh3Ym1NbVvYrtwZ9QJz/AJkCIcs54uGX3
        pXv4rR+ixbEULIOJ4PfAfzjYc1tDEnIgnTOlIheFI2zgLXgsNEFdbi5gY/8LWfBM
        lPJdJkunLCU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 264CFD3048;
        Tue,  9 Jun 2020 01:07:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5A87AD3047;
        Tue,  9 Jun 2020 01:07:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Lin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Lin <johnlinp@gmail.com>
Subject: Re: [PATCH v2] gc: recommend `git gc --prune=now` instead of `git prune`
References: <pull.652.git.1591581739031.gitgitgadget@gmail.com>
        <pull.652.v2.git.1591662224566.gitgitgadget@gmail.com>
Date:   Mon, 08 Jun 2020 22:07:36 -0700
In-Reply-To: <pull.652.v2.git.1591662224566.gitgitgadget@gmail.com> (John Lin
        via GitGitGadget's message of "Tue, 09 Jun 2020 00:23:44 +0000")
Message-ID: <xmqqv9k0j087.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 236DECC8-AA0F-11EA-B660-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Lin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Lin <johnlinp@gmail.com>
>
> `git prune` is a plumbing command and should not be run directly by
> users. The corresponding porcelain command is `git gc`, which is
> mentioned in the man page of `git prune`.

Much better than v1 that came without any justification ;-)

I however wouldn't say "should not"---that feels a bit too strong (I
personally use "prune" from the command line once or twice every
week and do not see why I should be forbidden from doing so [*1*]),
but the users who see this message would not need such a precise
control afforded by use of "git prune", so "gc --prune=now" is a
better recommendation.

Thanks.

[Footnote]

*1* The command does not even produce a machine readable output.
    The reason it is not recommended (but that is different from
    "should not") to casual users over "git gc" is because it is a
    very focused tool (it is only about removing loose objects and
    does not touch other things) and applicable to a very specific
    condition.  Those who can recognize that they are in that
    situation should not be forbidden from using it with a dogmatic
    "should not".

