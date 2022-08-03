Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D635C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 06:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbiHCGgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 02:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiHCGgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 02:36:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E1F28E1D
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 23:36:08 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C0F3C1B354C;
        Wed,  3 Aug 2022 02:36:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RUuU9AoYoLPESZ7oN3bcLGIwj+Isssa4NpiW/D
        phq0Y=; b=NgdUEYNGpzSok0rUi3AvCGoZQHs0ry5lmrphV4TKhtrsexiOmRxmF4
        ZkL35SWTWrYSzXK7p/yGhvkJLEfPop/JV4lv2xhBGQjOPd7cKCVmrJ6gm/9t8GAt
        l2FHXXicc6aU1mhVBWN9ca7C27swUKMgZ5L0hZ9IGG/z825lb3qXo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AB7D81B354B;
        Wed,  3 Aug 2022 02:36:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5078C1B354A;
        Wed,  3 Aug 2022 02:36:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 09/10] maintenance: stop writing log.excludeDecoration
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
        <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
        <318269dfe27a56d4c85b8723fbd9853159e9d096.1659122979.git.gitgitgadget@gmail.com>
Date:   Tue, 02 Aug 2022 23:36:03 -0700
In-Reply-To: <318269dfe27a56d4c85b8723fbd9853159e9d096.1659122979.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 29 Jul 2022
        19:29:38 +0000")
Message-ID: <xmqqr11xdeb0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C4C7E6A-12F6-11ED-99C1-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> This reverts commit 96eaffebbf3d0 (maintenance: set
> log.excludeDecoration durin prefetch, 2021-01-19).
>
> The previous change created a default decoration filter that does not
> include refs/prefetch/, so this modification of the config is no longer
> needed.
>
> One issue that can happen from this point on is that users who ran the
> prefetch task on previous versions of Git will still have a
> log.excludeDecoration value and that will prevent the new default
> decoration filter from being active. Thus, when we add the refs/bundle/
> namespace as part of the bundle URI feature, those users will see
> refs/bundle/ decorations.

Yup, and if they find it disturbing, they can fix it, but it is
unlikely to be a problem, I would think, since decoration works only
for exact point in history.  If this topic were to choose what refs
the "describe" abbreviation uses, it would have been much more
annoying to see some unwanted refs used.
