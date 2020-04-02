Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A295C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 16:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094B62074D
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 16:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GZfEncLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389072AbgDBQgU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:36:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54624 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732404AbgDBQgT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 12:36:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E4054FB0F;
        Thu,  2 Apr 2020 12:36:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=FunfQ0WG4Niz+FdW37hZB8t+n+o=; b=GZfEncLdDl9WWjENuS+s
        nB1gPL1yx+0PV8i9dV1DuTAtd+q/cWIJbrcoC3mHVR7qNY6t2wKtTVOxZor3QLyz
        dZp0kKcrzZlmLOheXwgWkfPfLZhMpt3A0TEj56UHAB+3ExfXuzImw1m3VnFf+mYz
        Dx0R0qrH2tye1WxgYGTZ8sE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=j3JnmCzPT/T13iTRSrT4uWKrL3cpypJ2qB3IA6eFMPPa0j
        9jCCTIqR9BKmbObfebvbIEgKTKbZM17WuyhFZ1ztfBDr00PL8WLtgt/5OUR5gDhw
        gSFthcunPbwaBwEV6u5crI47FMvfiAXvSND7wP/0fcLZbsyp6TCGp/4B91Sw8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7425E4FB0D;
        Thu,  2 Apr 2020 12:36:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 001314FB0C;
        Thu,  2 Apr 2020 12:36:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/2] t5319: replace 'touch -m' with 'test-tool chmtime'
References: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
        <pull.596.v2.git.1585774844.gitgitgadget@gmail.com>
        <24e26ecda632421e4c1a61ebabf6ea78301685b1.1585774844.git.gitgitgadget@gmail.com>
        <xmqq369m6g9u.fsf@gitster.c.googlers.com>
        <8e6b1f75-534a-ad79-544b-126ea61b2058@gmail.com>
        <20200402125113.GA3091800@coredump.intra.peff.net>
Date:   Thu, 02 Apr 2020 09:36:16 -0700
Message-ID: <xmqqo8s94zgf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1329B48A-7500-11EA-B988-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Apr 01, 2020 at 08:06:47PM -0400, Derrick Stolee wrote:
>
> I wonder if that would run afoul of the same "mtime and system clock are
> not quite the same" issue we saw recently in [1].

I had the exact thing in mind, which was why I suggested "chmtime"
in the first place (the second reason was that it was easy to do
relative time using the tool than "date + touch"), but I missed that
the tool has a mode that uses timestamp relative to system clock.

> I think it might not because we're only comparing mtimes set
> through the same mechanism (find the system time, subtract from
> it, and assign to mtime). If system time is monotonically
> increasing at any rate, that would produce the desired effect.

But in this particular case, I think, even though setting the
filesystem timestamp based on something that was obtained from the
system clock feels as if we are asking for trouble, the values we
later read back from the filesystem for executing the codepath being
tested (namely, expiration logic) get compared with another value
that is derived from from the system clock (i.e. expiration cutoff),
so in that sense you might be able to argue that it is even more
correct ;-)

