Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2ECC6FA82
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 18:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiIZSJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 14:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiIZSJH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 14:09:07 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611931EEC1
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 10:55:05 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F7091C60BB;
        Mon, 26 Sep 2022 13:55:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZBHUzf+1hk+hsD0il+ajufCxkqw7iTk0+hRINJ
        gl4BU=; b=hxgmcE/2hQJRnXmD+PoMMdBfkz9lFbapEQk7cu7pTo21s7shyaNUyF
        njWQbAupNHcXCYH6t9/7JXqrPWGUZixqyRSxS8xE9qRogSe55ISz24aqzrSE9jCI
        S2QrH7+RAi8PknFTNvnp18lTJOYT2fgGJrjOzqNOtgBSuJHrVCByM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 58ACF1C60BA;
        Mon, 26 Sep 2022 13:55:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D573C1C60B6;
        Mon, 26 Sep 2022 13:55:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, derrickstolee@github.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] read-cache: avoid misaligned reads in index v4
References: <pull.1366.git.1663962236069.gitgitgadget@gmail.com>
        <bb3a2470-7ff5-e4a6-040a-96e0e3833978@gmail.com>
Date:   Mon, 26 Sep 2022 10:54:59 -0700
In-Reply-To: <bb3a2470-7ff5-e4a6-040a-96e0e3833978@gmail.com> (Phillip Wood's
        message of "Sun, 25 Sep 2022 09:25:08 +0100")
Message-ID: <xmqqpmfiowb0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 577AC34C-3DC4-11ED-A105-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I was confused as to why this was safe as it means we're still reading
> the individual fields from unaligned addresses. The reason it is safe
> is that we use get_bexx() to read the fields and those functions
> handle unaligned access. I wonder if it is worth adding a note to
> clarify that if you re-roll.

I've got so used to ours that gives unaligned accesses, but I guess
in some other circles, get_XeYY() means reading YY bit-wide integer
in X byte-order from a preperly aligned address, and if that is the
case, I do not mind such a comment somewhere.  It would help those
coming from such a background very much.

Thanks.


