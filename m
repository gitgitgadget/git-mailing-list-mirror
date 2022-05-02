Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45A1C433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 18:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386885AbiEBSeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 14:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386881AbiEBSeK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 14:34:10 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EA36141
        for <git@vger.kernel.org>; Mon,  2 May 2022 11:30:40 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB3ED136954;
        Mon,  2 May 2022 14:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HNahn11Z5oCFwNn5k3VSx/4biejNdYCYtdVDk8
        lUlFw=; b=HNNrMI3wRkT/yUoP0CvWfoXOWuYlYrDVCkCvB4VZRYY+Kptmn/fjic
        nQZSIuOcXL2+ZDoTcQY2sGQhoVDmm2DievBOFVKzFV6AjzRoBOAqv/DEGCp9mIkb
        RsREP2wGvPMEIicMQ+MqHeh597p3i6OWJ4nq2z3zTph5Mo+h7gxSs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2E10136953;
        Mon,  2 May 2022 14:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 39797136952;
        Mon,  2 May 2022 14:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Austin Morton <austin.morton@aquatic.com>
Cc:     git@vger.kernel.org
Subject: Re: Able to checkout same branch in multiple worktrees when using
 symbolic-refs
References: <CAAir=1MbwGtONW7yWRWoXKzAiwqwhOAqdhfWYMYLxt1vANuUOA@mail.gmail.com>
        <xmqqsfpvabib.fsf@gitster.g>
        <CAAir=1NY=98Z_cTrEyUn6tcPFR3UGNUmXs=2hg27LMGijGZpUw@mail.gmail.com>
Date:   Mon, 02 May 2022 11:30:38 -0700
In-Reply-To: <CAAir=1NY=98Z_cTrEyUn6tcPFR3UGNUmXs=2hg27LMGijGZpUw@mail.gmail.com>
        (Austin Morton's message of "Mon, 2 May 2022 14:54:33 +0000")
Message-ID: <xmqq7d73zt0x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F751A4BE-CA45-11EC-B953-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Austin Morton <austin.morton@aquatic.com> writes:

[jc: swapped the blocks to chronological order, and trimmed parts
that are not relevant to this reply].

> On Fri, Apr 29, 2022 at 8:19 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Austin Morton <austin.morton@aquatic.com> writes:
>>
>> I also suspect there is no way, other than scanning _all_ the local
>> branches, to see if some other branch aliases the branch we are
>> about to check out.  It may potentially be somewhat expensive.
>
> I don't know why you would need to scan all the local branches, unless
> that is what "git worktree list" ends up doing under the hood?
> ...
> Seems like you would "just" need to resolve the symbolic-ref in the
> same way that the worktree code does when checking against existing
> worktrees in find_shared_symref during checkout.

Yeah, you're right.

You would scan all the worktrees instead of asking all the
local branches "Are you a symlink that points at a branch I am about
to check out?  If so, yell loudly to stop me."

>> But it would be nice if it can get fixed in inexpensively.
>>
>> Thanks for a report.

So, yeah, it may be doable to fix it inexpensively.

Patches welcome ;-)

Thanks.
