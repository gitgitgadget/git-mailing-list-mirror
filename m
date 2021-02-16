Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C3BC433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 01:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3CE64DBA
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 01:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhBPB5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 20:57:37 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60580 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhBPB5g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 20:57:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 77D86110E18;
        Mon, 15 Feb 2021 20:56:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=scjHNszrjyFJHKwyKobvLQqhGQ8=; b=XocOFj
        o65+opmX9vWkX/y08abxz+1b69A8Ts99MWaR14BLcI8HsuRQeV28qUVyDzbcrkxq
        d2xdqVcZCE8UpqfXFbO/XxfWD2H7hTkYBM7g+Nmv9UERmcnKfBVEGNehYHWd2IeG
        g7G/GiwA2jXB5KJV3dGsH5e9dKrNDRITTe1Zw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r9E4FHx3QctMWExo3qdLT8akmOVgashK
        tpZygx4gI0xU31/VD5JoeuXdZUxnCkwiALpK6qGn+EXxFHC/T+hjsRllBXG+j+kH
        3G7Kh+gdxAUJ93TdICtmaBly3uQd0wruXbSNQjk3yaubmGLQyqrdS6bAUdJ5WXJl
        H43wimhGe04=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 72526110E16;
        Mon, 15 Feb 2021 20:56:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BB61D110E15;
        Mon, 15 Feb 2021 20:56:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Blake Burkhart <bburky@bburky.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] fsck: make symlinked .gitignore and .gitattributes
 a warning
References: <YCsBA002yv8XpppM@coredump.intra.peff.net>
        <YCsBRUQkrAm8l2gz@coredump.intra.peff.net>
        <87y2foaltl.fsf@evledraar.gmail.com>
        <YCsc0OePtrotjeg5@coredump.intra.peff.net>
Date:   Mon, 15 Feb 2021 17:56:50 -0800
In-Reply-To: <YCsc0OePtrotjeg5@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 15 Feb 2021 20:16:00 -0500")
Message-ID: <xmqqtuqcsrkt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CD1EA8C-6FFA-11EB-BE7F-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That said, they'd probably want to checkout those old commits, too. So
> we probably do need a config override, even if it's a broad one ("trust
> me, this repo is OK, just allow symlinks for these special files").

Is this about the check that is overly strict for some existing
projects that kept the jk/symlinked-dotgitx-files topic in the
'seen' so far?

On the fsck end, we know we can demote the error level per
repository, but I wonder if we should make checkout/clone honor the
same setting?

I think GITMODULES_SYMLINK has been there for quite some time at
"error" level and we do want to discourage it to be a symbolic link,
so I am not quite sure what the demoting of these two achieves.  Why
aren't we having a similar issue on .gitmodules that is a symbolic
link?

Thanks.

