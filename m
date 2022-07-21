Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586D8C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 20:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiGUUsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 16:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiGUUsk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 16:48:40 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C3D8FD46
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 13:48:39 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1FBAB1AE37A;
        Thu, 21 Jul 2022 16:48:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lyEHJj3aKysaLcybIkZVxjtyX+dwsUSLQTHlt/
        bhF3w=; b=djADljK+R4mKk/bc15l3eHZGAcf6BQQCpmV/oGSVR0syim8QNUUNUv
        hs/DbwAu6kaBLdYhwTg5lhA0ySSL5e0gMMLKuuyYguqGIgVhsKX+RoKDehkV1PD/
        AS3nq3sHllJ9f7HOB/5BHRwCN25UHC8VxuOxY0QNlOVE08Q8G+S7o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 043421AE379;
        Thu, 21 Jul 2022 16:48:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7BF8E1AE378;
        Thu, 21 Jul 2022 16:48:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: On-branch topic description support?
References: <xmqqilnr1hff.fsf@gitster.g>
        <220721.86mtd2tqct.gmgdl@evledraar.gmail.com>
        <xmqqwnc6idxr.fsf@gitster.g>
        <220721.86a692tkva.gmgdl@evledraar.gmail.com>
        <xmqqy1wmgx8t.fsf@gitster.g>
        <20220721182645.45xrwf2buohibcaw@meerkat.local>
        <20220721191349.kf3zx4tpwrjhzudt@nitro.local>
        <xmqqa692grqr.fsf@gitster.g>
        <20220721201918.xvunkyehxnjbwhjv@meerkat.local>
Date:   Thu, 21 Jul 2022 13:48:33 -0700
In-Reply-To: <20220721201918.xvunkyehxnjbwhjv@meerkat.local> (Konstantin
        Ryabitsev's message of "Thu, 21 Jul 2022 16:19:18 -0400")
Message-ID: <xmqqsfmufazi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CCF9478-0936-11ED-AD1F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> One thought that comes to mind -- perhaps it would be easier not to track the
> special commit, but designate the branch as a special "proposed changes"
> branch that could even "hide" the cover-letter merge commit (CLM) from most
> operations. It's still a simple two-parent merge commit, so it can be
> pushed/pulled with any existing remotes without requiring any changes on the
> server side, but operations like adding a regular new commit to the tip of
> the "proposed changes" branch would automatically move the merge commit so
> it's back at the tip. This way "not sure what you're trying to do" situations
> like this would be avoided:
>
>   A--B--C--CLM--D--E
>  /          /
> Y-----------

Sorry, you lost me.  It is quite clear what the user is trying to do
in this case.  After preparing the initial cut of the topic that has
three commits, A, B, and C, and writing about them in CLM, there
were fix-ups and enhancements needed, which were implemented in D
and E.  The branch is waiting to be rebased into

   A--B--C--D--E--CLM'
  /               / 
 Y----------------

which gives you a chance to talk also about D and E in the updated
iteration of CLM.

Whether the "cover letter material in an empty commit at the tip" is
a single-parent commit or a needless merge, there will be fallouts,
such as "git branch --[no-]merged" becoming much less useful.  I am
sure there will be many others once we start seriously exploring
these approaches.

