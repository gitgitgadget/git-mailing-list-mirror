Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A37FC433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 18:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240776AbiA1SOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 13:14:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53270 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbiA1SOq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 13:14:46 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A6FF5105C48;
        Fri, 28 Jan 2022 13:14:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xoctBgNGULR8xJvPYF2yK96/uaGMBw9ibSUXH0
        0NMOQ=; b=WtmwJdJhfP+O7Ebunw4bvlYPN2nGkBEboiT7wknjbD5kVdSNkQUku2
        eh7X3+/HaxX33X34Hi8Hwvil/gGiqtcnYZvmTwjiBhpdMy0eH/T1BBhaK/bn8bM5
        3GzLmKRQSEhPJMU8B++8yxTrTjxRU06Xf9mthWlOdj3AAgbt1Em4c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E98A105C47;
        Fri, 28 Jan 2022 13:14:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE91B105C44;
        Fri, 28 Jan 2022 13:14:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] fetch --prune: exit with error if pruning fails
References: <20220127153714.1190894-1-t.gummerer@gmail.com>
        <xmqqmtjh0x5f.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2201281110050.347@tvgsbejvaqbjf.bet>
Date:   Fri, 28 Jan 2022 10:14:43 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2201281110050.347@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 28 Jan 2022 11:13:56 +0100 (CET)")
Message-ID: <xmqqpmobwwvg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BB4BCCA-8066-11EC-B854-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I am not so sure. When pruning failed, there may very well be directories
> or files in the way of fetching the refs as desired. And it might be even
> worse if pruning failed _without_ the fetch failing afterwards: the user
> specifically asked for stale refs to be cleaned up, the command succeeded,
> but did not do what the user asked for.
>
> Maybe Thomas has an even stronger argument in favor of erroring out. In
> any case, I don't think that `--prune` should be a "best effort, otherwise
> just shrug" option. If we wanted that, we could introduce
> `--prune-best-effort` or some such...

I am not opposed to reporting an error by exiting with non-zero exit
code.  I never said it should be best effort, and doing the "fetch" part
after a failed prune does not make it best effort.

What I am questioning is if it makes sense to stop the fetching
part.  When we fetch to update multiple refs, we do not stop at the
first ref-update failure, but try to do as much as possible and then
report an error, no?  It is the same thing.

