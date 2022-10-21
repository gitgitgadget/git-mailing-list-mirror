Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AF4C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 17:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiJURyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 13:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiJURyu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 13:54:50 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A8242ACD
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 10:54:44 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 70A001B21A2;
        Fri, 21 Oct 2022 13:54:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aLsQ7js7R0k76PZIVw4DKojvrRmstJvhrwFXhh
        ikOlk=; b=my3FT02pzgvJF7uJtvsT6uEc1zxFwRwYfv+i+CCYdsbk74NsRJJ81e
        yvTpLi2RS0gAmuFtXI6/wWnPf3oTJvr3fUaZ1FELwEpEG4eD3/uv/dXo9PpMvc4y
        VgifC+dFmS0+wqFUJeepbo9EAbyVmM+J/pRdyeuR0rvA0MUghiGhA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 67D2B1B21A1;
        Fri, 21 Oct 2022 13:54:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 966F11B21A0;
        Fri, 21 Oct 2022 13:54:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 8/8] rebase: cleanup action handling
References: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
        <pull.1150.v4.git.1666344108.gitgitgadget@gmail.com>
        <ed800844ba13d143bdbc5fd0b033af96df131529.1666344108.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 10:54:40 -0700
In-Reply-To: <ed800844ba13d143bdbc5fd0b033af96df131529.1666344108.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 21 Oct 2022 09:21:48
        +0000")
Message-ID: <xmqqo7u5kqov.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70540D84-5169-11ED-9143-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Treating the action as a string is a hang over from the scripted
> rebase. The last commit removed the only remaining use of the action
> that required a string so lets convert the other action users to use
> the existing action enum instead. If we ever need the action name as a
> string in the future the action_names array exists exactly for that
> purpose.

Nice.


#leftoverbit

Perhaps a clean-up worth making after the dust settles from this
series would be to use designated initialisers to avoid names and
their string values going out of sync, perhaps like

	static const char *action_names[] = {
		[ACTION_NONE] = "undefined",
		[ACTION_CONTINUE] = "continue",
		...
		[ACTION_SHOW_CURRENT_PATCH] = "show_current_patch",
	};

Unless the final element is something that must stay at the end even
when adding new member to a collection, it is a good idea to keep a
(seemingly unnecessary) comma at the end.  That would make it easier
to add a new member without unnecessary patch noise.

