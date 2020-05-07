Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E50C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 18:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C8D9208DB
	for <git@archiver.kernel.org>; Thu,  7 May 2020 18:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KjEJ9HUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgEGS3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 14:29:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60265 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgEGS3S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 14:29:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 38CA3D8DF1;
        Thu,  7 May 2020 14:29:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jsk0DUcfIlTYMj73XZ9Q8U8SQEc=; b=KjEJ9H
        UX2NVSCZQnay4lkqyiAaeSOkPRmmIUgIXl8luXlI8YcyBuFHwsvS31kFNYERPIp+
        TnIitIwhtBOAumGGXGCOfq18UHcOVKEUz0wVdoRatmd4/pf1LeZAnjvbTcCRILBD
        ohOk38VE/oAPwzSuXtnodtVjbDGki9hOwBAvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FuCYJwMgyYB6iYBRWMhUVsORi1adVSPA
        Q2qQHGLieHHxSjDxDYNQO27jT5AeH8YcPJXBfPWfnSXJdMhEfUv0hiuza0VFm5Dd
        1uCwfZfKMyzDyoYdPjkNkJ3We9JYD/1dOcPOpq1SWlLMUtAuz9prT+HJL5l5D53G
        xYaQNkO0Yeo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3032CD8DF0;
        Thu,  7 May 2020 14:29:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7A865D8DEF;
        Thu,  7 May 2020 14:29:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
References: <20200504233634.GB39798@coredump.intra.peff.net>
        <20200505002055.GC64230@syl.local>
        <20200505164326.GA64077@coredump.intra.peff.net>
        <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
        <20200505182418.GA66702@coredump.intra.peff.net>
        <20200505210451.GA645290@coredump.intra.peff.net>
        <20200506004612.GE927@danh.dev>
        <xmqqr1vx90mt.fsf@gitster.c.googlers.com>
        <20200506142500.GA2429@danh.dev>
        <xmqqa72l81pe.fsf@gitster.c.googlers.com>
        <20200507122549.GB3057274@coredump.intra.peff.net>
Date:   Thu, 07 May 2020 11:29:09 -0700
In-Reply-To: <20200507122549.GB3057274@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 7 May 2020 08:25:49 -0400")
Message-ID: <xmqqeerv4n0q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A58993C6-9090-11EA-8F8A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, I agree that all of the mechanisms for dealing with the unrelated
> history are somewhat awkward. Another issue is that you can't just:
>
>   git clone --single-branch -b refs/ci/config my-config
>
> to work on it, because "-b" wants only heads or tags (we could address
> that by putting it in refs/heads/ci-config or similar).

I somehow don't think that it is such a huge issue, because I expect
anybody who has legitimate interest in refs/ci/config to have a full
clone of git.git anyway.  So it is more like defining another
remote.origin.fetch like this:

	 [remote "origin"]
	 	url = https://git.kernel.org/pub/scm/git/git.git/
	 	fetch = +refs/heads/*:refs/remotes/origin/*
	+	fetch = +refs/ci/config:refs/remotes/origin/ci-config

         [remote "publish"]
		url = https://github.com/user/git/


and then do something like:
    
	$ git worktree add -b ci-config ../git-ci-config origin/ci-config
	$ cd ../git-ci-config
	... hack hack hack ...
	$ git push publish ci-config:refs/ci/config

> If we do go the javascript route, perhaps it would make sense for
> refs/ci/config to be a single blob containing a snippet of javascript
> with several functions. And then we could just eval() that and call the
> appropriate functions (if defined).

Yup.

> Then a sample can live in the main repo with something like:
>
>   # This file contains functions which will be run by the GitHub
>   # Actions CI script.
>   #
>   # You may customize it for your own fork by modifying it on any branch
>   # you like, and installing with:
>   #
>   #  git push <remote> $(git rev-parse HEAD:ci/config):refs/ci/config
>   #
>   # [allow_ref() sample definition and documentation....]
>
> That sidesteps most of those issues.

Perhaps.
