Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D533C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 16:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244043AbiHHQiR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 12:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbiHHQiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 12:38:16 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A80B8B
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 09:38:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BAE91B5EB4;
        Mon,  8 Aug 2022 12:38:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kYzraSbmKuu8vGanYJHZbrpnvh0YkDwDzqkLux
        B7oPg=; b=A8p7N2wqb5gdvpHpKmbkdVqcGWB9PJdsnXPM7GPmanTthqBP06tpoI
        vNoru4ypHndHlaWnTgf31mo9bCC5wCjQzH7ZHI9DMOuGbChz3gadKHrU508miiji
        9MIONXj1lqhu0p1QBlLCIoBG6B1Rwmd80z4xYf5KA7XGFCO0Hqgoo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 945171B5EB3;
        Mon,  8 Aug 2022 12:38:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 42ACA1B5EB2;
        Mon,  8 Aug 2022 12:38:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/5] Some improvements to safe.directory on Windows
References: <pull.1286.git.1657700238.gitgitgadget@gmail.com>
        <pull.1286.v2.git.1659965270.gitgitgadget@gmail.com>
Date:   Mon, 08 Aug 2022 09:38:10 -0700
In-Reply-To: <pull.1286.v2.git.1659965270.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 08 Aug 2022 13:27:45
        +0000")
Message-ID: <xmqqzggesnbh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DB2E290-1738-11ED-873A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Due to the semantics being substantially different from Unix, the
> safe.directory feature presents its own set of problems on Windows. One
> particular issue would have prevented it from working in GitHub Actions'
> build agents, which we definitely rely on in the Git project itself. This
> was addressed via the fifth patch, which had made it (in a slightly
> different form) already into Git for Windows v2.35.2, and they are ready to
> be applied to core Git, too.
>
> The FAT32 patch came in later, and was released as part of Git for Windows
> v2.37.0, so I also have confidence that it is stable and ready to be
> integrated into core Git, too.
>
> Changes since v1:
>
>  * Restructured the patch series.
>  * Instead of an environment variable to turn on debugging, we now always
>    show the platform-dependent information together with the error message
>    about the dubious ownership (iff it is shown, that is), based on an idea
>    by Junio.
>  * Rebased onto gc/bare-repo-discovery to avoid a merge conflict.

I actually had to rebase it back so that we could merge it to
'maint' for further 2.37.x releases.  I'll refer to the original
patches in this thread when I merge the result to 'seen', of course,
to make sure the results do match.  It would have been slightly less
convenient if you did not do this rebase, but it would have allowed
me to have much better confidence in the result that may eventually
go to 'maint'.  After all, mistakes in resolving merge conflicts on
'seen' can be corrected before the topic hits 'next'.

Thanks.  I do not know about the API calls mingw.c part of these
patches make, but the overall structure looks sensible to me.

