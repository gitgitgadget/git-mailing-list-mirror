Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3A7C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 16:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347960AbiC3Qky (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 12:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346850AbiC3Qkx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 12:40:53 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C57341FBF
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 09:39:08 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01462117357;
        Wed, 30 Mar 2022 12:39:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vwhluFxVxfiFK+PiHXvBHhSS/Q4FIQ3DdMLHTX
        p12Ec=; b=BtQ5wWb2q/tZ5EWOh8YQTQkcYiW/gdb9cKEFAajKEofE+lJtAva9M3
        dtHM7q45h5eapnv3xNFmH4JxTGYxbvtZVmshSKdy9/VP5mnKHes6U2ZtpUobsmiU
        Mh+5HxSe1pK+zSuUF6ufeFcjfsLV0hbFAR7Y0WkALDolVixmPLvXM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EBEDC117356;
        Wed, 30 Mar 2022 12:39:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2B0CD117355;
        Wed, 30 Mar 2022 12:39:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 1/2] untracked-cache: test untracked-cache-bypassing
 behavior with -uall
References: <pull.985.v4.git.1645974782256.gitgitgadget@gmail.com>
        <pull.985.v5.git.1648553134.gitgitgadget@gmail.com>
        <98a4d8f35c5abfcda5590f7e511f7b576000fd5a.1648553134.git.gitgitgadget@gmail.com>
        <xmqq5ynwwvli.fsf@gitster.g>
        <CAPMMpoigpEi9mTET1r9sbSdw92kUXw9cRQPdUv-O179j3+_wAQ@mail.gmail.com>
Date:   Wed, 30 Mar 2022 09:39:02 -0700
In-Reply-To: <CAPMMpoigpEi9mTET1r9sbSdw92kUXw9cRQPdUv-O179j3+_wAQ@mail.gmail.com>
        (Tao Klerks's message of "Wed, 30 Mar 2022 06:46:52 +0200")
Message-ID: <xmqqwngb9yzd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E91F24E2-B047-11EC-A437-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> Sorry, I'm not completely sure whether my comment was misleading, or
> whether I'm misunderstanding your feedback.
>
> The test added here does not test "desirable" behavior from an
> end-user functional perspective, but it does test behavior that is
> working "as-designed" as of many years ago.

Is it "as-designed", or just "left buggy"?

I somehow had an impression that you meant the latter, and it would
be our aspirational goal to eventually fix it.  And for such case,
it would be better to write the test body to show what the command 
should do, which would make the test fail with today's Git, and mark
it as test_expect_failure (which is not an ideal mechanism to prepare
for a future fix, but that is what we have now and should use, until
a better alternative being worked on is finished).

But if it is "as-designed, some users may find it suboptimal or
confusing or with any other negative adjectives, but it is too late
to change now and more importantly it is unthinkable to change it
because existing tools and users do depend on the current behaviour",
then what you did is perfectly fine.

> The intent in adding this test is to ensure that if/when someone
> changes this behavior down the line, they be forced to understand the
> implications.

That, too.

Thanks.
