Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808F2C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 19:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455E92072C
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 19:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="umCrHAra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390079AbgAXT1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:27:44 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63506 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389270AbgAXT1o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 14:27:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1A57FBC264;
        Fri, 24 Jan 2020 14:27:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+Rtm/JdNhhdfImJiiSfzO4gk8eY=; b=umCrHA
        raV5a3IJVqPd0FAPsTEym781SWgkTmkJVeBcTpH4WhraqAZMGoX79CDJDhA9zirp
        Gakwc72Rd6g1iAmuu4gtYx4hT8yBZtUu+lJgRJkVqfnlb3HIEkRRNjl2DMIzjPYt
        6JxG645stncIbcQxcWM8PxSGCRMl8IihVDqFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GXIQmLLpSwKz/vgrXkGi95oQwe78PoXu
        jrRgy1QAqIoKo458e1VysPL1fvA5rzSPXwLd9D0JYTjLin/qFY5DuGRCoJRLMGkc
        8dWwz8SrEmyxz05RmpJPE3tu73A9Zj1PCtw1ZzWONy0Whe7Kyy5f7kHKiXs2Ps3Y
        mawevEWmWHI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 118FFBC263;
        Fri, 24 Jan 2020 14:27:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DBB9CBC262;
        Fri, 24 Jan 2020 14:27:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     David =?utf-8?Q?Burstr=C3=B6m?= <davidburstrom@spotify.com>,
        git@vger.kernel.org
Subject: Re: Bug or unexpected behaviour in git show <rev>:a\b
References: <CAA-mk2_jB2X1J-NCXQ92spa-fmEct9G9f1iQo7t8=rvD5coFDA@mail.gmail.com>
        <20200124190119.GB1672342@coredump.intra.peff.net>
Date:   Fri, 24 Jan 2020 11:27:35 -0800
In-Reply-To: <20200124190119.GB1672342@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 24 Jan 2020 14:01:19 -0500")
Message-ID: <xmqqk15gzmc8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 948CC55A-3EDF-11EA-94F3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So everything is working as designed, or at least explainable. But I
> think there is some room for improvement. A backslash that isn't
> followed by a glob meta-character _is_ still a meta character (your
> "a\b" would be globbing for "ab"). But it's useless enough that I think
> it shouldn't be enough to trigger the "oh, you probably meant this as a
> pathspec" DWIM rule.

This sounds sensible.

> We _could_ also say "even though this could technically be a pathspec
> because of its metacharacter, it looks vaguely enough like a
> path-in-tree revision that we shouldn't guess". That I'm less
> comfortable with, just because it makes the heuristics even more
> magical.

Not just it becomes more magical, I am afraid that the code to
implement such a heuristics would be fragile and become a source of
unnecessary bugs.  Let's not go there.

I should learn to use "working as designed or at least explainable"
more often in my responses, by the way.  That's quite a useful and
good phrase ;-)

