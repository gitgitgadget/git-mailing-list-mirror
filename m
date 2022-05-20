Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052F9C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 22:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbiETWMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 18:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiETWMi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 18:12:38 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEC8197F47
        for <git@vger.kernel.org>; Fri, 20 May 2022 15:12:37 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BF2B519D2D4;
        Fri, 20 May 2022 18:12:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jrtpNQWFLt0B54cjyYsoBEFVyTNnH09vbV9XZt
        OCMiE=; b=ppDCow+OCltzsa5lp2G4sDGhq+MfQeqbPpxDE2Olmenrvajabe5P6L
        +LslqzVo879l0Z2iltFgIfu10DD+Cyt2M3ySDm8Awiq953sFwW9nxwxC0IJuUvJt
        qGJxW7ZhXNRzWbJ2S0esGeU655ktUBK7sUQw3uq0qLMcQgTiZq7mk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B733F19D2D3;
        Fri, 20 May 2022 18:12:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.111.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 63D9919D2D2;
        Fri, 20 May 2022 18:12:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] repack: respect --keep-pack with geometric repack
References: <pull.1235.git.1653064572170.gitgitgadget@gmail.com>
        <YofJLv8+x5J7yPmf@nand.local> <xmqqr14oey2a.fsf@gitster.g>
Date:   Fri, 20 May 2022 15:12:32 -0700
In-Reply-To: <xmqqr14oey2a.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        20 May 2022 13:41:49 -0700")
Message-ID: <xmqqee0ng8fj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F29E75A8-D889-11EC-91A8-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>> +			/*
>>> +			 * The pack may be kept via the --keep-pack option;
>>> +			 * check 'existing_kept_packs' to determine whether to
>>> +			 * ignore it.
>>> +			 */
>
> OK.  So there are two classes of packs we want to exclude from the
> geometry repacking.  Those that already have .pack_keep bit set, and
> those that are _are_ newly making into kept packs that do not yet
> have .pack_keep bit set.  Makes sense.

And with another topic in-flight combined, we have the third class
that we would want to exclude here, i.e. the ones that are "cruft".

(Noticed while rebuilding 'seen').

