Return-Path: <SRS0=BObu=DK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28843C41604
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 19:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF45C206DD
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 19:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f9L9vZGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgJCTe7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Oct 2020 15:34:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57375 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgJCTe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Oct 2020 15:34:59 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5176883336;
        Sat,  3 Oct 2020 15:34:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p+clQrYssmIqvCQbopdYE+IguD0=; b=f9L9vZ
        GGSC+jqYW2MJpHjibjxaTVexcLuLqSa62ggYmUHPacDPzNBWKgBZ4MDE2fvQF6Xf
        HIeEAdIll8AGAnYtcza+n/xl0vS0qFNzWgh5oWrRBA2kyiUT28KLACNpn6sHWDgw
        ilfxRd7A7JDf3aK8Y9GxIyOC5RsHN2y41vX2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XrSN2GUomubejW5GqdxuiSfDANrgKDYu
        Ho5m0NmpljVzoiRATPuEsxs2eoLPXsM8rwgoQZhYhQmS7Aho/Dd5ZJqpfkM6AeKB
        hlvhwmMbNXNMgO/cLXURqJRCkkPx8hgILHwuNE/pQ4nSJ+lZGEo1rGSEqUV/3U1Y
        CxdkRVwMHKk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 485C483335;
        Sat,  3 Oct 2020 15:34:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C2D5A83333;
        Sat,  3 Oct 2020 15:34:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Nico Weber via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Nico Weber <thakis@chromium.org>
Subject: Re: [PATCH] bisect: add a --verify flag to `bisect run`
References: <pull.741.git.1601750003858.gitgitgadget@gmail.com>
        <xmqqeemf8633.fsf@gitster.c.googlers.com>
Date:   Sat, 03 Oct 2020 12:34:56 -0700
In-Reply-To: <xmqqeemf8633.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 03 Oct 2020 12:25:36 -0700")
Message-ID: <xmqqa6x385nj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84AB1A50-05AF-11EB-81BB-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> For this change, it might look like this:
>
>   The script given to the `git bisect run script` may broken in some
>   way.  [Explain why it is bad that 'script' is not run on the known
>   bad or good revisions here in the current code.  The script is run
>   to test on the midway commit anyway and the lack of +x bit would
>   be noticed just as quickly as you retest a known good or bad
>   revision, so this 'feature' appears as a pure overhead to cause
>   extra checkouts and builds for no great additional benefit, at
>   least to me, and I tried but cannot make a good case for you
>   here].

After thinking about this a bit, I think the reason why you want is
because once "bisect run" starts to run, you cannot tell between the
script that failed because it itself is buggy and the script that
noticed a breakage in the revision being tested.  So you may waste a
whole night if you start a long bisection session and then leave
work after seeing a few first failures.

But I still am skeptical if it is worth the overhead of checking out
a large working tree to a different revision (like Chromium), only
to sanity check the script.  If I were in such a situation, what I
would do would be to first manually run 'script' outside "git bisect
run" on the revision that happens to be checked out (i.e. the one
that "git bisect" asked me to test) before throwing the script at
"git bisect run".  Sure, I won't know if the revision yet to be
tested is good or bad, so there is no yardstick to tell if the
script is producing an expected result, but didn't I have the same
issue when declaring the "current" bad commit was bad and the
"current" good commit was good?  
