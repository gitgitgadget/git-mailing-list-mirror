Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA356C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 19:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89376610CF
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 19:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhHST6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 15:58:47 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52037 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbhHST6l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 15:58:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8DD88157C56;
        Thu, 19 Aug 2021 15:58:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Mntp82oxYkzOwLeUjz+VhgUm6xhNZgF6w027fo
        ulA+E=; b=sPI46fOHBNRFXW0VfaaQdg809FbhEE0lJPzcrrHUIWsHa5MK6ZwA9b
        ePFOnJXAAjTBSrS0d13CPONDri3rwngE0cn2xSkbrKfmamRsf7aZOKVu0jb/kttQ
        p54N15SIgsvl2pov3ZAbBGv1Z7JWfBNDZViZpmrRwn1jywsy0XA0k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 85F39157C55;
        Thu, 19 Aug 2021 15:58:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 50C58157C51;
        Thu, 19 Aug 2021 15:58:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 0/2] test-lib-functions.sh: keep user's HOME, TERM and
 SHELL for 'test_pause' and 'debug'
References: <pull.1022.git.1629393395.gitgitgadget@gmail.com>
        <CAPig+cT2FfaYBbsRMy7vxXkvsxn4BcFTn4bGJjgvJKznXg1OYg@mail.gmail.com>
Date:   Thu, 19 Aug 2021 12:57:58 -0700
In-Reply-To: <CAPig+cT2FfaYBbsRMy7vxXkvsxn4BcFTn4bGJjgvJKznXg1OYg@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 19 Aug 2021 14:10:05 -0400")
Message-ID: <xmqqsfz5yzp5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C18144A8-0127-11EC-9534-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> I also find the test_pause() user-experience suboptimal and appreciate
> the idea of improving it. However, this approach seems fatally flawed.
> In particular, setting HOME to the user's real home directory could
> lead to undesirable results. When I'm using test_pause() to debug a
> problem with a test, I'm not just inspecting the test state, but I
> quite often interact with the state using the same Git commands as the
> test itself would use.

Yes, I do agree with you that it is a valid concern.

I wonder if the developers can configure tools used during debugging
session with XDG so that HOME can be kept for the "fake user that
ran the test suite, with the fake user's configuration"?
