Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0248C433E0
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 05:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F94264E37
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 05:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBGFT5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 00:19:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58272 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGFT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 00:19:56 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26C04A1FF4;
        Sun,  7 Feb 2021 00:19:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ll+sp2uwzWno9fAPNLGYRqwk8pE=; b=KMvBQp
        qivvlDg8axcmnG2SvZyaCjDVsjeMSep4N4lAsHMbqPFObn6LbQlI5trYzM4d8uhj
        KNNu4xaxmKXzUM/sdgh/VoeI0MPu7wd0pGzxr29gpX2S/Z/rD/OlthTEOkzWnfU1
        VlV8Lp4nx2rJiGeLFYGQ31I6iRancKy8XZTE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nmQG3XeF/bxrIUMw1ATbCSO87uWqZ3Ml
        TamONvpXDkekOD9Et6hiSvV99b50RtGx9AAZXYc/HnbIFS/KD20JsBXGP5POBeXp
        O0KvDlfKDwQ0bsz7hYx60Ggx/Q8ugUq1kotyHKp7FYK6luUEMvKHhjJla4hA9SXb
        yFhW2LlzZTk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BC80A1FF3;
        Sun,  7 Feb 2021 00:19:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 75CE3A1FF2;
        Sun,  7 Feb 2021 00:19:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/3] Optimization batch 7: use file basenames to guide
 rename detection
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
Date:   Sat, 06 Feb 2021 21:19:12 -0800
In-Reply-To: <pull.843.git.1612651937.gitgitgadget@gmail.com> (Elijah Newren
        via GitGitGadget's message of "Sat, 06 Feb 2021 22:52:14 +0000")
Message-ID: <xmqqtuqo8nfz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0421FC56-6904-11EB-AF2A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series depends on ort-perf-batch-6[1], which has not yet appeared in
> seen despite being reviewed by both Junio and Stolee.

It is because that one depends on something not in, but soon about
to go in, 'master' and I didn't want to add to "this topic depends
on top of that other topic" mess.
