Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1348C433DF
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 20:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DD7C2070B
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 20:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cMaG31B1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgGXUa7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:30:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51771 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgGXUa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 16:30:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E6C60E5990;
        Fri, 24 Jul 2020 16:30:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5iPJmKtP7M1rgK6uPosbKH2kyPY=; b=cMaG31
        B1v8WBlWLFbplhE8WWStDv4KVxByyIbopspWOL/LHEsMCVph7Sm4Tr/dffPlXCt1
        tEYPpnG0490YrelmFjI78Z21mxJn4Lc37W13KpcMf1WNVvzOMGgUDlpkXuN9iJu8
        /gCvHpli7rNAU6qaIDr++G9KuWP/r7zqCin9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G1BgzgpQQdpM0F/xJwo78bCKQHj0Jejg
        CbSbl3npxxzXP2dUdRtwflpK1n1WWpJcNGXCfDG6+Mn8Dix8DYwMcTiJVg0Z6u9Z
        rzpnH/H3Whu6r8yUiPwOHq1UWyi702yuWc0PyUfueFm9HnQ16mrlgzqAwl3sBL9Z
        5HctlnUJOQ8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DF7EDE598E;
        Fri, 24 Jul 2020 16:30:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 339CEE598B;
        Fri, 24 Jul 2020 16:30:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        "B. Stebler" <bono.stebler@gmail.com>, git@vger.kernel.org
Subject: Re: Improving merge of tricky conflicts
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
        <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
        <874kpzmhis.fsf@osv.gnss.ru> <xmqqwo2v45hq.fsf@gitster.c.googlers.com>
        <87tuxzl00h.fsf@osv.gnss.ru>
        <20200723182648.GC3975154@coredump.intra.peff.net>
        <87blk6yrlc.fsf@osv.gnss.ru> <xmqqimedq5c8.fsf@gitster.c.googlers.com>
        <874kpxwghu.fsf@osv.gnss.ru>
Date:   Fri, 24 Jul 2020 13:30:51 -0700
In-Reply-To: <874kpxwghu.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
        24 Jul 2020 09:53:49 +0300")
Message-ID: <xmqq7duslkp0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91EAEB46-CDEC-11EA-B486-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> If your merge used the merge (as opposed to diff3) style, and seeing
>> that the resulting conflict is not easy to review and you wish you
>> used diff3 style instead, it is way too late for any option to "git
>> merge" to help you.
>
>   $ git merge --abort
>   $ git merge --conflict=diff3 side-branch
>
> or, say, entirely imaginary:
>
>   $ git merge --redo --conflict=diff3 side-branch -- my-file
>
> if merge had --redo option and path limiting support, that could be
> handy for other reasons as well, as I have already pointed elsewhere and
> you disagreed, but still.

You are ignoring the case where you may have successfully resolved
conflicts in some paths before you noticed conflicts in some
particular files are hard to see in one style and wish if you used
the other style, I think.

Surely, you can reset everything away and redo it from scratch,
which is what all of the above is, but then you would need a way to
stash away the successful half resolution so far before discarding
them.  Compared to that, "ouch, I screwed up and want a freshly
conflicted state back for these paths" would allow you revert only
the botched paths without discarding the work you have already done.

> Actually, "git checkout" is not the place where I'd expect to find this
> feature in the first place, so to me it's rather already 99%
> illogical.

One half of the "checkout" (which now exists as a synonym "restore")
is to update the working tree files out of various sources, and
"conflicted stages in the index" is one of them, so it entirely is
natural and logical home for the feature.

The documentation needs updating to help you and others feel it
natural, I would think.  This seems to be mostly the matter of
better education.

