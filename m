Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED58C54EE9
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 16:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbiI1QA2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 12:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbiI1QAI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 12:00:08 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF82979EA
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 09:00:00 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1873D1A58EA;
        Wed, 28 Sep 2022 12:00:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aoFvfziOTzS67XdR2P9RtH4zBZJ8/uT7QTPuXu
        plg14=; b=LKP0Wv1pImXgZWZa9NGR5xnK/Kl8UVpVMAz/YzGhiiS+JME+wpwBGm
        Wgr8Rlp4htlMr+NUtbHBb59Ig3aJ/VCaEhA0B0iEjxOzzCYV315TqjqDFRyq5XZ2
        zhObU5z9p+ItUIC3ZKTKJkolYQ2pXG+NXeve+D4OsT0uIugDR5A8g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0FCAA1A58DC;
        Wed, 28 Sep 2022 12:00:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 99D8B1A58D3;
        Wed, 28 Sep 2022 11:59:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Christophe Poucet <christophe.poucet@gmail.com>
Subject: Re: [PATCH 05/10] evolve: add the change-table structure
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
        <2b3a00a6702eb8fb12e45b833ca74155939588ef.1663959325.git.gitgitgadget@gmail.com>
        <3c61e0b3-5526-f42e-48a7-c4465d06ccb3@dunelm.org.uk>
        <220927.865yh8zzux.gmgdl@evledraar.gmail.com>
        <ae031714-ba51-fe39-6351-ebd638840c32@dunelm.org.uk>
        <220927.861qrwzvhe.gmgdl@evledraar.gmail.com>
        <72c4e8c9-62bb-96aa-7b42-d7103b7873eb@dunelm.org.uk>
Date:   Wed, 28 Sep 2022 08:59:54 -0700
In-Reply-To: <72c4e8c9-62bb-96aa-7b42-d7103b7873eb@dunelm.org.uk> (Phillip
        Wood's message of "Wed, 28 Sep 2022 15:33:02 +0100")
Message-ID: <xmqqh70rzdz9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9875B2DE-3F46-11ED-990A-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Chris if you want to use '/**' style comments for the API docs then
> please do so consistently and do not use them elsewhere.

Thanks.

> I've come across them in projects that use gtk-doc or other
> documentation generators where it is necessary to distinguish
> 'documentation' from 'code comments'. I don't think they add much
> value if one is not generating documentation from the source, it is
> just one more thing for contributors to remember.

Yes, I personally find them annoying, but has tolerated them so far,
hoping that something good (read: automated documentation out of
comments) emerge someday, simply because the first ones were added
by folks who were interested in that direction, which unfortunately
has never materialized.

Maybe it would eventually happen, but I think there are a lot of
clean-up to do before it happens.  I somehow suspect that the sooner
the mechanism to create the documentation set, however incomplete
and messy the result is with the current material, the more incentive
the contributors have to apply /** vs /* distinction properly, but
of course on the other hand, until the existing material gets
cleaned up, the care they need to take to make the distinction does
feel like a makework.  So, I dunno.

Thanks.

