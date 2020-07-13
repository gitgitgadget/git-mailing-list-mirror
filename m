Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DD1C43462
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 14:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A90520738
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 14:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d188ZNm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgGMOvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:51:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55899 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730064AbgGMOvR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 10:51:17 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B386CB40F;
        Mon, 13 Jul 2020 10:51:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Flt+5Z0GDW6mixNYDUmyAfcSQYU=; b=d188ZN
        m5TlCLejuQDJqPuvu6yPHnqzVkTi5MBr315k6UEq8oVu24TGCZ5/R3Xf645A1MrB
        R61IJSJaYSh6ZLEPGVl1y7PBPWWLAtYzVhMimrwW3BN9i2q3n1tlcas/8ALMwQgT
        0LGltpft1+d43w3fB+oUyke2vc01gEotT5BAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O7nDQvzRGoxEfA8o71P4XCg7iQs5WM42
        tLPkzN5JnXKFHHiJvA8f+GzzFB8Zg+SsoHd3eMyqO3Mz90OYnIaTyZNosajOjRZK
        8fV9c9T8NcpNE9zQ1Hg6ipaevsOT4xa1gsZ05ElgUxluAOvl2MutbL5runstuJhc
        H1jOSSETo6s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 03F9CCB40E;
        Mon, 13 Jul 2020 10:51:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4F962CB40C;
        Mon, 13 Jul 2020 10:51:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jason Xu <jasonx98@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Force git diff to create a binary patch?
References: <CAGPh-qNrjQ5xwbPcfJdBqrqOJQsVpa2hy-XHwN-8rhPPZe4Vpg@mail.gmail.com>
Date:   Mon, 13 Jul 2020 07:51:12 -0700
In-Reply-To: <CAGPh-qNrjQ5xwbPcfJdBqrqOJQsVpa2hy-XHwN-8rhPPZe4Vpg@mail.gmail.com>
        (Jason Xu's message of "Mon, 13 Jul 2020 00:58:23 -0400")
Message-ID: <xmqqwo37o4db.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C9C1A56-C518-11EA-AF56-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jason Xu <jasonx98@gmail.com> writes:

> Here are two small files with non-ASCII data, yet git diff considers
> them text instead of binary.

Because it is based on heuristics, without a NUL in that short file,
the file may not be judged to be binary.

    echo '* -diff' >.git/info/attributes

would tell Git that they need to be treated as binary junk not
suited for textual diff (you'd need to tweak the pattern to your
need).



