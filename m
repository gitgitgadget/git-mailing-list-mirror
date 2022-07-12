Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D50C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 14:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiGLOX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 10:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiGLOX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 10:23:57 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F39525E8A
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 07:23:56 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E364131D89;
        Tue, 12 Jul 2022 10:23:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B16tJ0Inw9Nic18DwbrxyY0ITMLxoBiMoRQCAk
        xLOO4=; b=MisoxXIkLq0Q2tz28ZT0LRE0O0vuydNTIMJoVBc/crKxamBTUCTPXN
        xuh/qWdY88Of3S24bNrq7UA9wqqYKjwYD2ij1/t2sQkIlrhu0YXe9LARnMGlkR9s
        tnvh5O1hDzJNrLHh88UHHRuNFHyeR8Bw8QXjAm94z0gpz24fcY5OQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95F95131D88;
        Tue, 12 Jul 2022 10:23:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 03422131D87;
        Tue, 12 Jul 2022 10:23:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Guyot <tguyot@gmail.com>
Cc:     Jeff King <peff@peff.net>, Gerriko io <gerriko.iot@gmail.com>,
        git@vger.kernel.org
Subject: Re: Why is reflog so obscure?
References: <CALF=2ANoq1eL-RqK_dLaVThoxbvfhzgPJXFHyD1kX8CFCPx3XA@mail.gmail.com>
        <f0bb8ee8-9b38-45a7-a54b-24cf245bb3c8@gmail.com>
        <Ys0e9MxIWQj/pVXx@coredump.intra.peff.net>
        <a8d2a61d-b86f-9b89-6391-36c58c390a12@gmail.com>
Date:   Tue, 12 Jul 2022 07:23:53 -0700
In-Reply-To: <a8d2a61d-b86f-9b89-6391-36c58c390a12@gmail.com> (Thomas Guyot's
        message of "Tue, 12 Jul 2022 05:22:24 -0400")
Message-ID: <xmqqo7xuif46.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42A54A08-01EE-11ED-8897-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Guyot <tguyot@gmail.com> writes:

> Thanks for clarifying that - I suspected it since we can do
> <branch>@{<date>} although I didn't find any reference branch reflogs
> in the documentation. I could've missed it... Is there a way to read a 
> branch reflog?

    $ git reflog ;# lists entries of reflog of HEAD, starting at HEAD@{0}
    $ git reflog HEAD ;# same
    $ git reflog HEAD@{4} ;# same, starting at HEAD@{4}
    $ git reflog master ;# entries of reflog of "master"
    $ git reflog master@{0} ;# same
    $ git reflog master@{now} ;# same, show with timestamps
    $ git reflog master@{4.minutes} ;# same, starting at master@{4.minutes}

For the branch that is currently checked out, you can omit the name
when you use any of the @{...} notation, so 

    $ git reflog @{0}
    $ git reflog @{now}

are often the easiest ways to view what you did on the current
branch.
