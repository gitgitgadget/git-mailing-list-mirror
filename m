Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D16C433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 04:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01873610A8
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 04:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhKEEwD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 00:52:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54339 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhKEEwC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 00:52:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F68CF170A;
        Fri,  5 Nov 2021 00:49:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GnIKH+iLIKqmiR4+IWHCkKfkqNVLR2do5MP/G1
        AuWpI=; b=VC+ZZcLJ275zvcjbMHd3ip/1lHINqBelSvYXeVr+NDGFsf558WEiKu
        5rln4rIdyZG+cs31zRVzQ3zwOGdq0PEoj46ABO6uigYfdQq0IjxeNdvx1aWisZrd
        ACWt4u2RBZdsKlFKQsgC0paIX3vVfAX4SKw4L09QicFooFEUN+pX8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 878E7F1707;
        Fri,  5 Nov 2021 00:49:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EC5D6F1706;
        Fri,  5 Nov 2021 00:49:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 4/4] submodule: record superproject gitdir during
 'update'
References: <20211104234942.3473650-1-emilyshaffer@google.com>
        <20211104234942.3473650-5-emilyshaffer@google.com>
Date:   Thu, 04 Nov 2021 21:49:21 -0700
In-Reply-To: <20211104234942.3473650-5-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 4 Nov 2021 16:49:42 -0700")
Message-ID: <xmqqzgqjxl4e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BED85ED6-3DF3-11EC-BB27-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> A recorded hint path to the superproject's gitdir might be added during
> 'git submodule add', but in some cases - like submodules which were
> created before 'git submodule add' learned to record that info - it might
> be useful to update the hint. Let's do it during 'git submodule
> update', when we already have a handle to the superproject while calling
> operations on the submodules.

We are hearing repeated mention of "cache" and "hint".  Do we ever
invalidate it, or if we have such a record, do we blindly trust it
and use it without verifying if it is still fresh?

Also, this step and the previous step both say we record gitdir on
their title, but we instead record common dir.  Whichever is the
right choice to record, let's be consistent.

Thanks.
