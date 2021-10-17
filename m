Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D018C433EF
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 05:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2ACA61050
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 05:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244974AbhJQFxC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Oct 2021 01:53:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63650 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbhJQFxA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Oct 2021 01:53:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F831E414B;
        Sun, 17 Oct 2021 01:50:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T5cOwb+wqNHPhhJAALm9ctFLdgQSwNoeLtvzbH
        dM4e8=; b=ZG98ho69lGrrQJx8X5Ue2gH5NfJRx9/iL2ZgZfTCSG447pXZQJaA+F
        1P402FS8WY7l46A8rHc1slO7/ZSF/pL0upJmurRQmQbgMALOlxRbF3GCpjIv7fof
        647FajvD+2KlUFltL5GfAj0ivPcVNw7HO+BSYawU0r4gu1f+L4hic=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 57847E414A;
        Sun, 17 Oct 2021 01:50:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C19E9E4149;
        Sun, 17 Oct 2021 01:50:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] branch: add "inherit" option for branch.autoSetupMerge
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
        <0346f447548cfd11307173aaa3284d86a2ef689c.1631319742.git.steadmon@google.com>
        <xmqqwnnondba.fsf@gitster.g> <YWun9j7L5uNlVHkW@google.com>
Date:   Sat, 16 Oct 2021 22:50:44 -0700
In-Reply-To: <YWun9j7L5uNlVHkW@google.com> (Josh Steadmon's message of "Sat,
        16 Oct 2021 21:35:02 -0700")
Message-ID: <xmqqee8k19or.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C2166BC-2F0E-11EC-82EF-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Thanks for the feedback. I've added "--track=direct" and
> "--track=inherit" flags in V3, which I'll send out shortly. I am a bit
> skeptical of the value of having "--track=direct" when just "--track"
> still works, but I'll leave it up to the list to decide.

Ah, I assumed that with the configuration variable set to inherit,
you'd make a command line --track to use the upstream of the fork
point branch as the upstream of the new branch, but if your
intention is that (1) without --track or --no-track on the command
line, if configuration is set to inherit, the new branch will track
the upstream of the original, and (2) with --track on the command
line, the new branch will track the original without any "inherit"
magic, then I agree that there is no need for a way to explicitly
choose between --track={direct,inherit} from the command line.  The
choice would be, for those with remote.autosetupmerge=inherit, to
use --no-track (to not track anything), --track (to track directly
the original branch), or say nothing (to inherit tracking), and for
those without that, --no-track (to not track) and --track (to track
directly) are the same but there is no way (other than "git -c
var=val") to do "inherited tracking".

One advantage of allowing to be explicit is that you do not have to
remember (or know --- if you are visiting somebody else's repository
to help them out) how remote.autosetupmerge is configured (or
unconfigured).  From the command line, without having to worry about
configured values to interfere, you can control which tracking mode
is used.


