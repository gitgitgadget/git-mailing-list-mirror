Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2261C0015E
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 22:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjHIWuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 18:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjHIWuL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 18:50:11 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64792138
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 15:50:10 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0463123E2E;
        Wed,  9 Aug 2023 18:50:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9OZuuvPGYI9UJeQ1LpMOLnDG+OfAX0brR2JkLD
        pBkdc=; b=ly+YcCvQW9r0sLv9V6p2zvITXAULzl5XoDA6Hkz0bUkaYDIpgSJG1f
        x7lF0rllMOE5dKVZwOjmb0lmKWstMhyj0CgjQS+GSKe0aUuqgy3LK8EztvMNOhKR
        +beCUo6yWAfJ85fql4CwXRyZYlSav1/4kVq6mrILwW+TgnNoD4e/Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F121C23E2D;
        Wed,  9 Aug 2023 18:50:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6806E23E2C;
        Wed,  9 Aug 2023 18:50:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 5/8] repack: add `--filter=<filter-spec>` option
References: <20230614192541.1599256-1-christian.couder@gmail.com>
        <20230705060812.2865188-1-christian.couder@gmail.com>
        <20230705060812.2865188-6-christian.couder@gmail.com>
        <xmqqh6qi1byn.fsf@gitster.g>
        <CAP8UFD0aa+EZQ2Q=C2WjWrNL9desg-KLLjOKS8BUBR4DS1ytsQ@mail.gmail.com>
        <xmqqila9p3j8.fsf@gitster.g>
        <CAP8UFD3b6gCog5P7WKzTuPQV2Lhf51=xO7ys+W7o0pGewJMcFg@mail.gmail.com>
        <xmqqcz0fnbs8.fsf@gitster.g> <xmqqo7jzh9mh.fsf@gitster.g>
        <CAP8UFD1eX8JMd91Say_sC7h_V08oRq32Wu9RM+SFtAQnhRPO2w@mail.gmail.com>
Date:   Wed, 09 Aug 2023 15:50:05 -0700
In-Reply-To: <CAP8UFD1eX8JMd91Say_sC7h_V08oRq32Wu9RM+SFtAQnhRPO2w@mail.gmail.com>
        (Christian Couder's message of "Tue, 8 Aug 2023 10:45:48 +0200")
Message-ID: <xmqqy1ijkezm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15C2E1E0-3707-11EE-AA4E-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> but I haven't been able to check that this works on CI as all the job
> seems to fail these days before they even start:

This remark made me worried, but (luckily) it does not seem to be
the case for other topics cooking in 'next' or queued in 'seen'.

It does seem that this topic directly queued on 'master' by itself
without any other topics do break the CI quite badly.  Almost
nothing passes:

  https://github.com/git/git/actions/runs/5812873987

but it may be something as silly as failing test lint.  I didn't
check very closely.

Thanks.
