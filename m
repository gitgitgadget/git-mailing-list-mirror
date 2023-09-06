Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7479EEE14C3
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 21:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244659AbjIFVBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 17:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjIFVBh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 17:01:37 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB8419AF
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 14:01:32 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B397128E3C;
        Wed,  6 Sep 2023 17:01:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=BQzUAfYnOZ1EFQ9L0yCiWZCrc4kByoN5Xh8Aqy
        4SzHE=; b=Bro4gfpVcLzYDtuHqfuZahj4jyyLCr1Ypwu89oaEYLd9RN3uo55m+x
        ByDpErpgPRaWy70tqT6s0YSt4jwng7I/KKqC0k0nwr81D71juzyWiRtGlNSklkfH
        rieyzeF2mxFoTnzvkibq4ER+M5eH93Pz/m/RZ8XUxJj0al5P+mx1A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9867628E3B;
        Wed,  6 Sep 2023 17:01:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 18DC728E39;
        Wed,  6 Sep 2023 17:01:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 0/7] rebase -i: impove handling of failed commands
In-Reply-To: <pull.1492.v4.git.1694013771.gitgitgadget@gmail.com> (Phillip
        Wood via GitGitGadget's message of "Wed, 06 Sep 2023 15:22:44 +0000")
References: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
        <pull.1492.v4.git.1694013771.gitgitgadget@gmail.com>
Date:   Wed, 06 Sep 2023 14:01:26 -0700
Message-ID: <xmqqedjbm2xl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C1A33C8-4CF8-11EE-A86F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series fixes several bugs in the way we handle a commit cannot be
> picked because it would overwrite an untracked file.
>
>  * after a failed pick "git rebase --continue" will happily commit any
>    staged changes even though no commit was picked.
>
>  * the commit of the failed pick is recorded as rewritten even though no
>    commit was picked.
>
>  * the "done" file used by "git status" to show the recently executed
>    commands contains an incorrect entry.
>
> Thanks to Eric, Glen and Junio for their comments on v2. Here are the
> changes since v2:
>
> Patch 1 - Reworded the commit message.
>
> Patch 2 - Reworded the commit message, added a test and fixed error message
> pointed out by Glen.
>
> Patch 3 - New cleanup.
>
> Patch 4 - Reworded the commit message, now only increments
> todo_list->current if there is no error.
>
> Patch 5 - Swapped with next patch. Reworded the commit message, stopped
> testing implementation (suggested by Glen). Expanded post-rewrite hook test.
>
> Patch 6 - Reworded the commit message, now uses the message file rather than
> the author script to check if "rebase --continue" should commit staged
> changes. Junio suggested using a separate file for this but I think that
> would end up being more involved as we'd need to be careful about creating
> and removing it.
>
> Patch 7 - Reworded the commit message.

Thanks.  This version looks good to me (although I am not as
familiar with this part of the codebase as others on the Cc: line).

