Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE7FC433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 23:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18852074B
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 23:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SsXiLz1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgFKXOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:14:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62928 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgFKXOw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 19:14:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 00FA6C9A93;
        Thu, 11 Jun 2020 19:14:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iLUkUJZeRpgj5gxx5y2yO+y5LJw=; b=SsXiLz
        1rHysxgOisbXCR6j75ImwvBWX4md/6BuDtchjxTDUKbwNznz0afnFbA4CQfjg5QN
        CrNhfQ+Vo94akLja7b+j7ma2RfEBLFnZABpFLrMVNRSqieNMq4USnFYAJHRJ6QwB
        SQBZDguEu3DUagAs7jFcht42uY39cyFqYchig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SP8Pf7AUmjZA93FT7m6onucrbGRjvAgs
        cByEkOV+13ql63Ee1a3FgiBpuR9je+4qsf+BzCeM42kiBdZQ9FkWLftEH6rfnAr6
        kBpRTnrr5SbnINwfUULE0nGl6vdTjupmMf+4O4DFUsQifEW+VbhOzkP0jNcU3LM1
        2mlO1VUqe7I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ED1D9C9A92;
        Thu, 11 Jun 2020 19:14:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3BC31C9A91;
        Thu, 11 Jun 2020 19:14:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/9] init: allow overriding the default branch name for new repositories
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com>
        <08e46af3-ff52-8bce-b75a-db8c390c9641@gmail.com>
Date:   Thu, 11 Jun 2020 16:14:46 -0700
In-Reply-To: <08e46af3-ff52-8bce-b75a-db8c390c9641@gmail.com> (Alban Gruin's
        message of "Thu, 11 Jun 2020 12:23:51 +0200")
Message-ID: <xmqqwo4di49l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 584AF91E-AC39-11EA-83BE-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> Why adding yet another environment variable instead of relying only on a
> config option?  I understand it's for the tests, but can't we add a
> shell function in test-lib.sh (and friends) that tries to read
> `GIT_TEST_DEFAULT_BRANCH_NAME', and, if it exists, sets
> `core.defaultBranchName'?

Can you produce such a patch that does it cleanly?  My knee jerk
reaction is that I would suspect that you end up having to touch
many places in the t/ scripts, but if you prove otherwise, that
would certainly be appreciated.

And no, 

    git () { command git -c core.defaultBranchName=master "$@" }

is not an acceptable solution.

