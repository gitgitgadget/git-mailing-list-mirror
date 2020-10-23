Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC16C4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 15:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC0BE20E65
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 15:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L+ZWje+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465724AbgJWPXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 11:23:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63219 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S465721AbgJWPXn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 11:23:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80DA68A042;
        Fri, 23 Oct 2020 11:23:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S3k98IOdTBYc8iSy4dJWqR89mLw=; b=L+ZWje
        +gBdHG00F62l+oxKbGEeJHbq6DwCA8Qd+83TJRuTl7e7PNvLJGL+8Qro9muJHw+D
        V0aNgOTMu8qRWKTnTq56dqj6YJMcK12e2k1xMo+hv+tpClq4ZmEC8UWCz+TLpxz6
        Jb03r9HxiYCJDWVf6agKZD4FRvgOO14e+AOfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZVDeRWJesFuNKaOWYOIIRDIOyW6Y4GSp
        KbBukSln5CimVGEED62rNJI259joMSdU58qIF14jIwBegRf+edYPVKKJH3zGgN/N
        VeU230oQ7b7HL1n6bPpo1oI6MU0euTKocVGqlAbGGH6uVk97lZZbiu8x18P2BUJk
        Nq7RCJFyYYI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77C018A041;
        Fri, 23 Oct 2020 11:23:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF71D8A040;
        Fri, 23 Oct 2020 11:23:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     VenomVendor <info@venomvendor.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: committer-date-is-author-date flag removes email in "Commit"
References: <e08df0d5792ab70a9158be32cfa28696@venomvendor.com>
        <20201023070747.GA2198273@coredump.intra.peff.net>
Date:   Fri, 23 Oct 2020 08:23:40 -0700
In-Reply-To: <20201023070747.GA2198273@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 23 Oct 2020 03:07:47 -0400")
Message-ID: <xmqqmu0dhsoz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB0AA46E-1543-11EB-815D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Oct 23, 2020 at 11:18:51AM +0530, VenomVendor wrote:
>
>> What did you do before the bug happened? (Steps to reproduce your issue)
>> * Create empty repo using `git init`
>> * Make few commits, at least two
>> * execute `git log --format=fuller`
>> * Notice the log, with "Author", "AuthorDate", "Commit", "CommitDate"
>> * Note, "Commit"
>> * execute `git rebase --committer-date-is-author-date HEAD~1`
>> * execute `git log --format=fuller`
>> * Note, email from "Commit" is empty <>
>
> Thanks for a clear report. I was able to easily reproduce the problem.
> There are actually two related bugs here, and they're both regressions
> in v2.29.0.
>
>   [1/3]: t3436: check --committer-date-is-author-date result more carefully
>   [2/3]: am: fix broken email with --committer-date-is-author-date
>   [3/3]: rebase: fix broken email with --committer-date-is-author-date

Thanks for taking quick care of this.  It counts as an embarrasing
brown-paper-bag bug; it is a bit surprising that nobody noticed it
while the original change was discussed.

I wonder if we even needed to do the original change to begin with
(stopping to export means not giving information to the hooks), but
that is a separate matter.

Will take a look and queue.  Thanks.

>
>  builtin/am.c                   | 4 ++--
>  sequencer.c                    | 2 +-
>  t/t3436-rebase-more-options.sh | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> -Peff
