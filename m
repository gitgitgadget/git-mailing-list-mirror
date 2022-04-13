Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D36C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 16:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbiDMQST (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiDMQSR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 12:18:17 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F400167F7
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 09:15:55 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C513212547F;
        Wed, 13 Apr 2022 12:15:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ejTol09Pa8VC03jF/7tcgsYMYSeP4itM14QXom
        691PQ=; b=mk/6UUKcV7FKrtYeaS68OQ3tjMP8q7BqE2VTdHZvEdD0XRrnsA4Zd8
        iN/00NRXNaQYwQc7xan/68Ig/JXivgEKZHKAj/I7HvGuosYtx/YGgzfMz6t1nZMc
        PWx3f/b+og9St9j5UOlJrIf77NGw6CvjSTMrAQiyXQpUQ9ki/MTH0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BCD8012547E;
        Wed, 13 Apr 2022 12:15:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3220A12547D;
        Wed, 13 Apr 2022 12:15:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/3] Updates to the safe.directory config option
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
Date:   Wed, 13 Apr 2022 09:15:51 -0700
In-Reply-To: <pull.1215.git.1649863951.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Wed, 13 Apr 2022 15:32:28 +0000")
Message-ID: <xmqq35iharig.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD3A1B96-BB44-11EC-83F9-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Here is a very fast response to the security release yesterday.

Wow.  While I were down the whole day yesterday after sending the
release announcement, it seems a lot have happened X-<.  Does your
"a very fast" expect only "wow, thanks for a fast reponse", or does
it also expect "ok, we'll take a deep look with a spoonful of salt
as it was prepared in haste"?

> The second patch here is an adaptation from a contributor who created a pull
> request against git/git [1]. I augmented the patch with a test (the test
> infrastructure is added in patch 1).
>
> The third patch is a change to the safe.directory config option to include a
> possible "*" value to completely opt-out of the check. This will be
> particularly helpful for cases where users run Git commands within a
> container. This container workflow always runs as a different user than the
> host, but also the container does not have access to the host's system or
> global config files. It's also helpful for users who don't want to set the
> config for a large number of shared repositories [2].

Let me take a look how well these integrate into the maintenance
tracks.

I would appreciate something that is targetted and narrow that can
be applied to the oldest maintenance track (2.30.3) and then merged
upwards, plus niceties on top that does not necessarily have to
apply to the oldest ones if the surrounding code or tests were
changed more recently.

Thanks.

> Thanks, -Stolee
>
> [1] https://github.com/git/git/pull/1235 [2]
> https://github.com/git-for-windows/git/issues/3787 [3]
> https://github.com/desktop/desktop/issues/14336
>
> Derrick Stolee (2):
>   t0033: add tests for safe.directory
>   setup: opt-out of check with safe.directory=*
>
> Matheus Valadares (1):
>   setup: fix safe.directory key not being checked
>
>  Documentation/config/safe.txt |  7 +++++
>  setup.c                       | 12 ++++++---
>  t/t0033-safe-directory.sh     | 49 +++++++++++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+), 3 deletions(-)
>  create mode 100755 t/t0033-safe-directory.sh
>
>
> base-commit: 11cfe552610386954886543f5de87dcc49ad5735
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1215%2Fderrickstolee%2Fsafe-directories-star-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1215/derrickstolee/safe-directories-star-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1215
