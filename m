Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4212AC00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 16:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiHOQ6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 12:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbiHOQ6I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 12:58:08 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA651275EF
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 09:58:06 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 462D91B83A7;
        Mon, 15 Aug 2022 12:58:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=brY/MqdZalOwKKM+hmrvq0slPAvNjGnEA2P3k7
        SjICo=; b=tAWvp7mVwTGfQex8NkwS/R0N6+5B6/bJCFMItTLAt6hJv3zzDEFs8r
        1lx6k2ERPYa1PH1uHo4o1pXFjYCtphDsF4/H1tA1mZsih/YmTHhmAd9I2zsjO0+5
        2EL145CVOl9ra/9oI1ul9JXcDfnHODNKSK4Yir/opzIl122QxkYbs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3DE251B83A6;
        Mon, 15 Aug 2022 12:58:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B6DFE1B83A5;
        Mon, 15 Aug 2022 12:58:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/5] rebase: store orig_head as a commit
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
        <cced4a48360b4e4a8ce791e9404ac6b37bae4eba.1660576283.git.gitgitgadget@gmail.com>
Date:   Mon, 15 Aug 2022 09:58:01 -0700
In-Reply-To: <cced4a48360b4e4a8ce791e9404ac6b37bae4eba.1660576283.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Mon, 15 Aug 2022 15:11:20
        +0000")
Message-ID: <xmqqilmt30me.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6CC477B8-1CBB-11ED-9FA2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Using a struct commit rather than a struct oid to hold orig_head means
> that we error out straight away if branch being rebased does not point
> to a commit. It also simplifies the code than handles finding the
> merge base and fork point as it not longer has to convert from an oid
> to a commit.

As lookup_commit_reference_by_name() eventually calls into deref_tag(),
a command like

    git rebase -i maint $(git rev-parse v2.37.2)

would presumably still work, which is good.

