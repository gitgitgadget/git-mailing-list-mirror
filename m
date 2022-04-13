Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1FAC433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 17:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiDMRHd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 13:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbiDMRH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 13:07:27 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF09D2FE46
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 10:05:05 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15DC7125B3E;
        Wed, 13 Apr 2022 13:05:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/xwIYp87PcssBcnDh2OO2guqa7Z9gx913F8avn
        OJphM=; b=WVe/YJXanf+nw7zqj/y1qHNP+loVoYWp8CpYT7n2mNaQtvrqR6pcmj
        3wWCuPd6fnCNsAlGb+37c4i7KMBwRDXQKnV/g1bcEJ+HJVb7h62JcoYFGbi6D8pT
        Kn78508Oubes9L8LCzy3vdfnhx/Bf0Zt3to0rZXOZ+eHu5UtCux4k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 06DDD125B3C;
        Wed, 13 Apr 2022 13:05:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 48FBC125B3A;
        Wed, 13 Apr 2022 13:05:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] introducing git replay
References: <20220413164336.101390-1-eantoranz@gmail.com>
Date:   Wed, 13 Apr 2022 10:05:03 -0700
In-Reply-To: <20220413164336.101390-1-eantoranz@gmail.com> (Edmundo Carmona
        Antoranz's message of "Wed, 13 Apr 2022 18:43:35 +0200")
Message-ID: <xmqq4k2wap8g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DCCFB6C0-BB4B-11EC-B547-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> This is a RFC because:
> - Perhaps it is already possible to do it with git rebase
>   to achieve the same? But I haven't seen a recipe that
>   gets it done in stackoverflow, at least.

Without thinking about it too much, out of gut reaction, it looks
like a better target for fast-export piped to fast-import than
rebase or amend, if all it can do is to replay on _identical_ state
and nothing else.

> Let me know what you think.
> Interesting? Not?

If this _were_ to allow some slight deviations of the base and carry
the differences forward, then it definitely belongs to rebase, and
perhaps "rebase --replay-merges" should be taught to behave better
without introducing a new option.  But otherwise, I do not think it
is all that useful.  

Also, if this _were_ to allow recreating the shape of the history,
using updated tips of branches that were merged in the original
history, perhaps taking hints from "Merge branch X into Y" in the
original merge commit's log messages, that would be quite useful
addition to the rebase mechanism, but this is not that.

So, not really, to me at least.
