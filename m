Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F021AC433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 22:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98DFC23381
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 22:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbhAUWu6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 17:50:58 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52386 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbhAUWu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 17:50:57 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B405E106D86;
        Thu, 21 Jan 2021 17:50:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1AI6KJJWNE4ny8TGR6JEw+eB0uM=; b=Y5u1AB
        G9vrH0Rvb75WjeQ0heyAcanS/Mj96M280KHQ/tVCsrh1vZArmuqa8/ml4QAD0mPp
        Pd1TbkwYyHUUulPLVKgal1FDiM4VN3ViSfR4aZoMPDkr1Kpz8gJSGbnJsgOvphkI
        mBjU0704LZd+CVtghOkrzQk3XWOQtaBHrtuYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F2L6R4aFPZG7krcoDbn5xv/06dwAN8/F
        9tqa5uAQ04lybx9V2Im6KWGzmkRkH1t1oS09sWwWJKM4M2JUCvTfVFMsAQdwYb6b
        RxcNp7n3OL1wMphtxeH1LwYN6l/LpuU+7eucjXQr81eJvpoGv6otLenUuRJQngjt
        gJWiNeCPFD8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A1072106D85;
        Thu, 21 Jan 2021 17:50:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DA071106D84;
        Thu, 21 Jan 2021 17:50:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: automerge implementation ideas for Windows
References: <X/onP6vFAHH8SUBo@camp.crustytoothpaste.net>
        <20210109224236.50363-1-davvid@gmail.com>
        <20210109225400.GA156779@ellen>
        <xmqqmtxhd1zx.fsf@gitster.c.googlers.com>
        <xmqqa6thcn1n.fsf_-_@gitster.c.googlers.com>
        <20210110072902.GA247325@ellen>
        <xmqqh7np9gqn.fsf@gitster.c.googlers.com>
        <20210116042454.GA4913@ellen> <20210120232447.GA35105@ellen>
Date:   Thu, 21 Jan 2021 14:50:12 -0800
In-Reply-To: <20210120232447.GA35105@ellen> (Seth House's message of "Wed, 20
        Jan 2021 16:24:47 -0700")
Message-ID: <xmqqk0s5c3bv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0609F256-5C3B-11EB-A19D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> One other point of discussion: I would like to change the name of this
> feature. "Automerge" is a bit of an overloaded term and, IMO, doesn't
> describe this feature very well. Several of the GUI diff programs have
> a feature that they call "automerge" or "auto merge", and there's a flag
> for Meld already in Git called "mergetool.meld.useAutoMerge" which could
> cause confusion.
>
> Instead, I'd like to propose "mergetool.hideResolved" or the more
> verbose "mergetool.hideResolvedConflicts" as the name. We're not really
> merging anything (Git aleady did that before the mergetool is invoked),
> but rather we're just not showing any conflicts that Git was already
> able to resolve.

I have no objetion.  I didn't think 'automerge' was bad, but it
probably is too broad a word as you discuss in the above.

"hide resolved" sounds like the name that describes what it does
quite well.

> #1: Use POSIX read and a while loop to emulate an awk-like approach:

I'd rather not to see us do "text processing" in shell, especially
with "read -r".  I just do not trust it (even with the "-r" option).

Having said that, I am not familiar enough to the Windows
environment to know what is trustworthy and what is not (apparently,
things like "sed" that I would intuitively place as much trust as
anything else is giving us so much trouble out of box), so I'll
shut up and listen to others.
