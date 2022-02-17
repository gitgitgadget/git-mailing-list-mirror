Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F9BC433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 22:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiBQWvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 17:51:48 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiBQWvr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 17:51:47 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666097806A
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 14:51:29 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 355E911150C;
        Thu, 17 Feb 2022 17:51:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sJN49i/ONWrRqmL+MORbKg/UKTYY1s9ox75LDj
        WsfG4=; b=B7Rpg/KbZpm2XXFRJ3ZCWEzo9CnV5m588AjqqTkeRnaQbwqmcZJEPd
        C6zZ1US/7thxFnjZRuOamWfYxM3JxkXTsAHg/MvJ+Fdth1rjRymOXQu8tc3YGFlk
        3xbpYxz1glyNbz774B/wvw9oIRxcx2lcruZxoFT73y7XsGOfDonQA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BA0411150B;
        Thu, 17 Feb 2022 17:51:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8DFAB11150A;
        Thu, 17 Feb 2022 17:51:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] dir: force untracked cache with core.untrackedCache
References: <pull.1058.git.1644860224151.gitgitgadget@gmail.com>
        <pull.1058.v2.git.1645131630140.gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 14:51:27 -0800
In-Reply-To: <pull.1058.v2.git.1645131630140.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Thu, 17 Feb 2022 21:00:29
        +0000")
Message-ID: <xmqq5ypd6r9s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 247D0942-9044-11EC-AA7B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The GIT_FORCE_UNTRACKED_CACHE environment variable writes the untracked
> cache more frequently than the core.untrackedCache config variable. This
> is due to how read_directory() handles the creation of an untracked
> cache.
>
> Before this change, Git would not create the untracked cache extension
> for an index that did not already have one. Users would need to run a
> command such as 'git update-index --untracked-cache' before the index
> would actually contain an untracked cache.
>
> In particular, users noticed that the untracked cache would not appear
> even with core.untrackedCache=true. Some users reported setting
> GIT_FORCE_UNTRACKED_CACHE=1 in their engineering system environment to
> ensure the untracked cache would be created.
>
> The decision to not write the untracked cache without an environment
> variable tracks back to fc9ecbeb9 (dir.c: don't flag the index as dirty
> for changes to the untracked cache, 2018-02-05). The motivation of that
> change is that writing the index is expensive, and if the untracked
> cache is the only thing that needs to be written, then it is more
> expensive than the benefit of the cache. However, this also means that
> the untracked cache never gets populated, so the user who enabled it via
> config does not actually get the extension until running 'git
> update-index --untracked-cache' manually or using the environment
> variable.
>
> We have had a version of this change in the microsoft/git fork for a few
> major releases now. It has been working well to get users into a good
> state. Yes, that first index write is slow, but the remaining index
> writes are much faster than they would be without this change.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---

Will queue.

Thanks.
