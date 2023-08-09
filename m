Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F9CC001B0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 20:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjHIU5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHIU5O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 16:57:14 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB357115
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 13:57:13 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 105F7189A36;
        Wed,  9 Aug 2023 16:57:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l29YSyu8rAM2lizYzWuk1hOo4gHohorkmmYQHy
        XQTAE=; b=rFY7hENiVwuWwG5QMB5Ib4j4AVq8aZK1PrdlS0UEmLPdGuhRP2520W
        TzyRYkYGxoSajQ4zuolbSpQVyAjBdKjjyw6tk3ARF0buhDM6Jp3vRwQWXPPHleQH
        dxedUxDi9SV1cZIECIXYHGyvewomX1gTNyigVFR+eVWFa6+2mmqCA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 06BC0189A35;
        Wed,  9 Aug 2023 16:57:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 750D0189A31;
        Wed,  9 Aug 2023 16:57:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     tboegi@web.de, git@vger.kernel.org, friebetill@gmail.com
Subject: Re: [PATCH v1 1/1] git stash needing mkdir deletes untracked file
References: <5260C6A0-C53C-4F6D-B899-6AD8601F8458@gmail.com>
        <20230808172624.14205-1-tboegi@web.de>
        <6e40eb0b-2331-1e39-bee0-c9720c24d1c8@gmail.com>
Date:   Wed, 09 Aug 2023 13:57:11 -0700
In-Reply-To: <6e40eb0b-2331-1e39-bee0-c9720c24d1c8@gmail.com> (Phillip Wood's
        message of "Wed, 9 Aug 2023 14:15:28 +0100")
Message-ID: <xmqqo7jgkk7s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 502B8824-36F7-11EE-B8DE-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Although this change is framed in terms of changes to "git stash push"
> I think the underlying issue and this patch actually affects all users
> of unpack_trees(). For example if "README" is untracked then
>
> 	git checkout <rev> README
>
> will currently fail if <rev>:README is a blob but will succeed and
> remove the untracked file if <rev>:README is a tree.

Very true, and with an .untracked file nobody asked Git to create,
presumably?  I am not sure if the updated behaviour is better than
the current behaviour.  

If "silent and unconditional removal" bothers us, I wonder if it is
a lot better approach to error out and have the user sort out the
mess, which is what we usually do when it gets tempting to "move it
away with an arbitrary rename" like this patch tries to do.  I
dunno.

Thanks.



