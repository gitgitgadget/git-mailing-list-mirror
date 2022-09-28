Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93C2C6FA82
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 17:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbiI1R7J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 13:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbiI1R7F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 13:59:05 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF45FFA55
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 10:58:54 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 12A4D1A678E;
        Wed, 28 Sep 2022 13:58:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tMDiIVoj0eQAYBH1Roy6oGFwY4I9QgnN31wmyW
        B7ZY8=; b=Iv0aUe/2IY7goHJ16HQCeWSuC6jteMEwgQQw5LCljK7Su5j0EndQV6
        LheWStWLZt7SCRkXknypRpa3nTSIf55eK8x4pTPmyfyyFpIkpP0YiEZCPIvE2SSQ
        WcbU0X9PbR0ijSRYfsg91z42BWL5XkCX8kr8M8/FLuTIg5Ztk+FUs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0BDD61A678D;
        Wed, 28 Sep 2022 13:58:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B031D1A678C;
        Wed, 28 Sep 2022 13:58:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Skrab Sah <skrab.sah@gmail.com>
Cc:     skrab-sah via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] abspath.h is created.
References: <pull.1345.git.git.1664294909011.gitgitgadget@gmail.com>
        <xmqq8rm41gbp.fsf@gitster.g>
        <CA+J78MXbXG4M1w50EAM8t0VkYP_saCt9O90jFKad3+cB+RCZ-Q@mail.gmail.com>
Date:   Wed, 28 Sep 2022 10:58:49 -0700
In-Reply-To: <CA+J78MXbXG4M1w50EAM8t0VkYP_saCt9O90jFKad3+cB+RCZ-Q@mail.gmail.com>
        (Skrab Sah's message of "Wed, 28 Sep 2022 13:02:22 +0530")
Message-ID: <xmqqpmfftm7a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 354E23C4-3F57-11ED-99EA-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Skrab Sah <skrab.sah@gmail.com> writes:

> What is wrong here and what should i do to make it correct.

Almost everything in what the patch is wrong.

 * It creates <abspath.h> as a tracked file, but has a funny comment
   with control-G in it that says "do not edit"

 * It is entirely unclear how the contents of <abspath.h> is meant
   to evolve, if the contributors are forbidden to edit it, and
   without any instruction how to update it.

 * The new <abspath.h> lost all function comments, grouping by
   category, etc. that were in the original <cache.h>.

 * There is an "#undef INTERFACE" that has no use to us, those who
   develop Git, for no clearly explained reason.

 * The proposed log message says what it did, but it does not even
   try to justify why it is a good idea to do so.

 * There is no need to create a new <abspath.h> in the first place.
   If we were in an alternate world where we did not have
   <abspath.c>, it may be reasonable to add <abspath.h> along with
   it, instead of adding declarations for new functions and types in
   <cache.h>.  But the difference falls into "once it is in, it is
   not worth the patch churn to change it" category.

The easiest way to make it correct is to drop it, I guess.

Thanks.

