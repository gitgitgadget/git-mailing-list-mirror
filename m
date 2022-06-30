Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EF8C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 16:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbiF3Qtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 12:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiF3Qtc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 12:49:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AF624F19
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 09:49:32 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B310E1A6F6C;
        Thu, 30 Jun 2022 12:49:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C6S7qE5jzKrCzEN5xFlYbDhZWdWcRhh5HwIMcA
        ftc2g=; b=AtWbHw51Wm59U38aW2rD3ZejQ/D/5m92Uu0KO7DXtUAIr/YDMxwnxi
        JPv6WStbj83MhNkp1sVFQcNQLqMEHhaTKFkshXzVV5SD2PG7H8Fy1Of969z2xP8e
        2OCkm7BYxoH8uPxvw97/uA5pxTB9I2gTjZrVYoAbjV6tZAdTVFORg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AAECD1A6F6B;
        Thu, 30 Jun 2022 12:49:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2478E1A6F6A;
        Thu, 30 Jun 2022 12:49:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 2/8] branch: consider refs under 'update-refs'
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <2bc647b6fcd6032a1e97e67739ced31117bfbfce.1656422759.git.gitgitgadget@gmail.com>
        <xmqqpmisikex.fsf@gitster.g>
        <9d188e11-7bb4-cae7-b38a-f9f38c8c2fe1@github.com>
Date:   Thu, 30 Jun 2022 09:49:26 -0700
In-Reply-To: <9d188e11-7bb4-cae7-b38a-f9f38c8c2fe1@github.com> (Derrick
        Stolee's message of "Wed, 29 Jun 2022 08:58:48 -0400")
Message-ID: <xmqqr136f65l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B0ACADC-F894-11EC-AC4D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> I wonder how important such a situation is, though. But I'm willing
> to add the extra lookups in 'git gc' and 'git fsck' to make this a
> non-issue.

What I was hinting at was if some of this can be done by using a
ref, so that we do not have to touch "gc" or "fsck" at all.

As to the importance, I would say it is about the same importance as
being able to prevent the branches involved in the rebase from
touched in other worktrees.  We expect it to take sufficiently large
wallclock time from the beginning of a rebase and its finish to make
such a protection necessary, so an auto-gc may even be started from
other worktrees without our knowledge.

Thanks.

