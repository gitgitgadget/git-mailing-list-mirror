Return-Path: <SRS0=lsTH=42=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBABC10F27
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 15:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D919C20873
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 15:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fyEjy1A5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgCIPO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:14:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60973 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgCIPO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Mar 2020 11:14:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CEA88C7FCB;
        Mon,  9 Mar 2020 11:14:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HPy2zBQ4/ME6Ezx68F4V5KSF0GI=; b=fyEjy1
        A5TUwzTVrq6PZe10Uoc7d4aM+eUCD75qdwaXEIrBNrSbrkdJNoR0PCt7jkVKzheU
        l7S30159sQCQv2C/3CjGJ7PQz6+oI7D2Wp2hK9kNNinRMekZzLU1yUgE27hlLvco
        mc8bRvK+OaxDQf0SUKhzCWrSLeR2a1WJ9e31o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R+nh4yoiw6viOnzcH/wF1GpmZ/28z2ij
        rDuSQvhlYxF/ABGikpPRb6wBQCNJxe/2vy+tTLExB+thaIz2wwOEJjaQrVl2FxOY
        1e4MCGs8Ram5mwZJwj4vXv9XHWsW4BPj1eWn2xARJgFxiiSkEti/j/wLSMKEQS+7
        t/G6ugsVWno=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C5022C7FCA;
        Mon,  9 Mar 2020 11:14:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E1328C7FC9;
        Mon,  9 Mar 2020 11:14:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 0/3] Teach ref-filter API to correctly handle CRLF in messages
References: <pull.576.git.1583692184.gitgitgadget@gmail.com>
Date:   Mon, 09 Mar 2020 08:14:49 -0700
In-Reply-To: <pull.576.git.1583692184.gitgitgadget@gmail.com> (Philippe Blain
        via GitGitGadget's message of "Sun, 08 Mar 2020 18:29:41 +0000")
Message-ID: <xmqqimjd1rx2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9843C4C-6218-11EA-9BD3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The ref-filter API does not correctly handle commit or tag messages that use
> CRLF as the line terminator. Such messages can be created with the--verbatim 
> option of git commit and git tag, or by using git commit-tree directly.
>
> This impacts the output of git branch -v, and git branch, git tag and git
> for-each-ref when used with a --format argument containing the atoms 
> %(contents:subject) or %(contents:body).

What is missing from the above is the definition of "correct".
Without saying what you consider in the current behaviour is
"incorrect" and why, the first sentence does not give the right
information to readers.

Let me speculate why "such messages" are created by end users using
the --verbatim option.  They probably have unusual message that
needs to have whitespaces and characters that are stripped without
the option at the end of the lines in the message, and they
explicitly ask Git not to lose them with the option.  Perhaps CR may
be among those that they want to retain.

So "git for-each-ref --format='%(contents:body)'" should retain
these CRs and whitespaces at the end of these lines, but you are
reporting an incorrect behaviour, so perhaps somehow we lose them?

That does indeed sound like a bug.  We should keep them in the
output if the user took pains to deliberately place them in the
commit.  Unless the user tells us to clean/hide them with an option,
that is.

But as you did not say what your definition of correctness is in the
above two paragraphs, it is not clear to readers if that is the bug
you are trying to address, or even if such a bug exists in the first
place.

(haven't read the remainder of the cover or the patches yet).
