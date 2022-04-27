Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEB7C433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 20:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbiD0Uww (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 16:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbiD0Uwr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 16:52:47 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACFF36B48
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 13:49:35 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7EA34134B37;
        Wed, 27 Apr 2022 16:49:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BhH34cWHgYNSyuqYGfAVeyaaAX5kvYy3OJFYO3
        kgzLo=; b=IT/B5SnleDi0CepO2m9824NfojeEKYCQ09MqjXKZ+oWQpVffyxLfbx
        3yOyMi/SA8OjB//iwCZBsRrjVvcKI+5EK5t7/fW4opMf3YGrHvzWpeeYULCf9EHk
        0+fu4YZLBiN+Q43zJbqlnnuf3eJgiKEc9DEu3sXik4IHvOCya5jig=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72520134B36;
        Wed, 27 Apr 2022 16:49:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D7918134B35;
        Wed, 27 Apr 2022 16:49:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/3] safe.directory: document and check that it's
 ignored in the environment
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
        <20220427170649.4949-1-szeder.dev@gmail.com>
        <20220427170649.4949-4-szeder.dev@gmail.com>
        <xmqqlevql0lj.fsf@gitster.g>
Date:   Wed, 27 Apr 2022 13:49:32 -0700
In-Reply-To: <xmqqlevql0lj.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        27 Apr 2022 13:42:32 -0700")
Message-ID: <xmqqee1il09v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B17C0CC-C66B-11EC-92F0-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If we had GIT_SAFE_DIRECTORIES that lists the safe directories (like
> $PATH does), that would have been absolutely necessary to document
> how it works, but GIT_CONFIG_* is merely an implementation detail of
> how "git -c var=val" works and I am not sure if it is even a good
> idea to hardcode how they happen to work like these tests.  The only
> thing the users should know is that GIT_CONFIG_{KEY,VALUE}_* are
> used internally by the implementation and they should not muck with
> it, no?

I misremembered.  GIT_CONFIG_COUNT and stuff are usable by end user
scripts, but then ...

> diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.txt
> index 6d764fe0cc..ae0e2e3bdb 100644
> --- a/Documentation/config/safe.txt
> +++ b/Documentation/config/safe.txt
> @@ -13,8 +13,8 @@ override any such directories specified in the system config), add a
>  `safe.directory` entry with an empty value.
>  +
>  This config setting is only respected when specified in a system or global
> -config, not when it is specified in a repository config or via the command
> -line option `-c safe.directory=<path>`.
> +config, not when it is specified in a repository config, via the command
> +line option `-c safe.directory=<path>`, or in environment variables.

... this part must clarify what environment variables it is talking
about.

    ... via the command line option `-c safe.directory=<path>`, or
    via the GIT_CONFIG_{KEY,VALUE} mechanism.

or something, perhaps.  I actually do think it is a useful addition
to have GIT_SAFE_DIRECTORIES environment variable that should NOT be
ignored.
