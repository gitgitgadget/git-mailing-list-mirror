Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23624C2D0BF
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 21:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B7D21D7D
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 21:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hEQjS61t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfLRV50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:57:26 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60191 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfLRV5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 16:57:24 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D515A9285;
        Wed, 18 Dec 2019 16:57:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4KM35uyCsaoLoDda1sLzM8ilx5o=; b=hEQjS6
        1tlTh6FZfQEXAvY0E0qktpneRpONm9Pj8HA1+Cmc+2GKJdI5NB9Xnzy6XhX3AakE
        wwOUFYaJ/bFY0sMSi6G05thF364R5qnJJ2pn9Mukz8BExZwzVtxyxTSRHolY5Bvb
        J4adV0UEYUll8GkImUzi26VOw4LSkv8FizOW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fw1oMDpKK6aT8gP6NaOEN79yO2WeKCfV
        LYF2rZx10mNBHHidfO0eqCJWJzZ31eu0ouWltD7rQ5dehC0yrjUKj3M0UF8Th4Pv
        hCQGldJBvVsljzWAh62dZd6q/AJqkIeWi7e+itzwAxBY+Om20LzVuG8nZjw6ZiMP
        bN+HOlxHPuo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 64EAFA9284;
        Wed, 18 Dec 2019 16:57:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 86FB3A9283;
        Wed, 18 Dec 2019 16:57:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH v2 01/18] t7107, t7526: directly test parse_pathspec_file()
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
        <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
        <8d5fb9f40b8fc766ef022f910529e6308d9c2d80.1576511287.git.gitgitgadget@gmail.com>
Date:   Wed, 18 Dec 2019 13:57:17 -0800
In-Reply-To: <8d5fb9f40b8fc766ef022f910529e6308d9c2d80.1576511287.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Mon, 16 Dec 2019
        15:47:49 +0000")
Message-ID: <xmqqwoatcn5u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CC07B64-21E1-11EA-9BE8-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
>
> In my previous patches, `parse_pathspec_file()` was tested indirectly by
> invoking `git reset` and `git commit` with properly crafted inputs. This
> has some disadvantages:
> 1) A number of tests are copy&pasted for every command where
>    `--pathspec-from-file` is supported. With just two commands, it
>    wasn't too bad, but I'm going to extend support to many more
>    commands, which would make a handful of low-value tests.
> 2) Tests are located in suboptimal test packages
> 3) Tests are indirect

That cuts both ways.  For a developer who is too narrowly focused
(because s/he spent enough time staring at the code), testing the
underlying machinery in a more direct way does feel attractive, but
at the same time, what matters to the end users is how well the
feature, when integrated into the commands they use (not the test
scaffolding like the "test-parse-pathspec-file" command), works.

So "indirect" is not necessarily a bad thing.

