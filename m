Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC772C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 20:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbiBXUfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 15:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiBXUft (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 15:35:49 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F312399D6
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 12:35:18 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3BCAA1750DE;
        Thu, 24 Feb 2022 15:35:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jJNdjC671qS8jwyPsW3IRXJ2CQQGPDJ7h66Mlo
        VJ5CI=; b=CfxflFTO/mDyVwPi6jWblf1mKAO1xFI4UUYRWEj5m3D5gAaoUBmsPZ
        0SDfx2VQnTL3JgghYyTcbBhr3WyFGe2n1j2YeAVHUS9zCzUL+YGcOM7Ob/x5PziV
        Bq7aG+ivkb5m7s8E3qwvuzeL0W/q9xq3OQkmdxQDuUMK+bo2vpCLY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 334C41750DD;
        Thu, 24 Feb 2022 15:35:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 48DF61750DC;
        Thu, 24 Feb 2022 15:35:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] Write index when populating empty untracked cache
References: <pull.986.git.1624559401.gitgitgadget@gmail.com>
        <627f1952fd8d4864b6b87f5539a9d9b802c5796b.1624559402.git.gitgitgadget@gmail.com>
        <xmqq35t11dtu.fsf@gitster.g>
        <CAPMMpogerttWdjGBNxJaqHT4bd3_igDx4_Fxev2eNHqexZ=aLQ@mail.gmail.com>
Date:   Thu, 24 Feb 2022 12:35:13 -0800
In-Reply-To: <CAPMMpogerttWdjGBNxJaqHT4bd3_igDx4_Fxev2eNHqexZ=aLQ@mail.gmail.com>
        (Tao Klerks's message of "Thu, 24 Feb 2022 18:52:27 +0100")
Message-ID: <xmqq5yp4knpa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45204BBA-95B1-11EC-ADF1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

>> The logic sounds fairly straight-forward.
>
> I didn't understand here whether you were confirming that the change
> seems to make sense (yay!), or commenting that the extra comment block
> is redundant, stating something obvious, and should better be removed.
> Could you confirm please?

I meant the former when I wrote it.

But now you made me re-read the patch, I am becoming slightly
sympathetic to the "do we even need to comment?" interpretation, too
;-)

The question is if the comment to these two statements is redundant.

	if (!dir->untracked->root) {
		/*
		 * If we've had to initialize the root, then what we had was an
		 * empty uninitialized untracked cache structure. We will be
		 * populating it now, so we should trigger an index write.
		 */
		FLEX_ALLOC_STR(dir->untracked->root, name, "");
		istate->cache_changed |= UNTRACKED_CHANGED;
	}

I can be pursuaded either way.
