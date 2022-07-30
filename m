Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4977C3F6B0
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 20:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiG3Uiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 16:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiG3Uip (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 16:38:45 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEB15FEA
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 13:38:43 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 569C51AFE2F;
        Sat, 30 Jul 2022 16:38:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xvdN9Jhp0WUNO8FQs9AC1Jlx13DaJeCgz99JDQ
        bi/7k=; b=fDbdlKdcubNdDDcGR1LhgoRUld/Z552WgSfyBOH8EgRshKn6UUbvW4
        VJtr9yFymg5Mmqn8VJlovzBBaV7k4ajY1r7mmCs0vh3YUIkcZHzdqLIfI4RoXvVG
        hJ9gIREI5Aog85UVI9A38qesNRVUZJDD+i8YbDO18hluNqPcXDzNg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F0191AFE2D;
        Sat, 30 Jul 2022 16:38:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D087B1AFE2B;
        Sat, 30 Jul 2022 16:38:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git List Mailing <git@vger.kernel.org>
Subject: Re: "git symbolic-ref" doesn't do a very good job
References: <CAHk-=wh9f0EmsNFgoxUa8BzVej06+7MbLr-MLBjDjtj_=Pf90A@mail.gmail.com>
        <CAHk-=wg9LaHeg0UmZ90gLOaBpO-5fhoaH22iNNm=1eror95pFg@mail.gmail.com>
Date:   Sat, 30 Jul 2022 13:38:37 -0700
In-Reply-To: <CAHk-=wg9LaHeg0UmZ90gLOaBpO-5fhoaH22iNNm=1eror95pFg@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 30 Jul 2022 13:21:50 -0700")
Message-ID: <xmqqtu6y1gky.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 977E3CF8-1047-11ED-96FF-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> t3200-branch.sh does
>
>       git symbolic-ref refs/heads/dangling-symref nowhere
>
> which really depends on that whole "git symbolic-ref does no sanity
> checking at all".

Yeah, once in the past, I thought

    git symbolic-ref refs/heads/main master

might be a way to adjust to the new world order without having me to
change my workflow.  I can always update master, and main follows it
without me being aware of it even being there. 

But it did not work.  Even worse, after doing so, running

    git update-ref refs/heads/main master

created ".git/master", which was a disaster.  Of course

    git symbolic-ref refs/heads/main refs/heads/master

would have worked.

I am not sure what workflow the "nowhere" thing is supposed to help.
Of course, with s/nowhere/HEAD/, it is a perfectly sane repository
immediately after "git init -b nowhere", so whatever tightening we
do, we should make sure that

    git symbolic-ref refs/heads/main HEAD

keeps working.
