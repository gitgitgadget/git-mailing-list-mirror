Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAE7C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 17:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3962072C
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 17:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="X7lbI1NO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbgAXRQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 12:16:58 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55109 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730514AbgAXRQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 12:16:58 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B9875BB585;
        Fri, 24 Jan 2020 12:16:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=21Q8h4Nefe7+
        5Vkwww61eUIxgS4=; b=X7lbI1NOXrDxivl4xNePvfG8Q41dn0ifNmb9jyUoK65m
        GK/KqsFVB4nsKt89uXqJC7wjFFbzXjVw6Q998AJcH4xh3Kd4IbHu1NIJMnQ6xrsN
        k5vjw0JTz74mvVlo1sbyAzYhe/qg3bGFD+kA3AaHYQL4itSgDfXg28qLXleKNfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JwsppZ
        HFYZ9BWGU62c4PSbiERS1WX5/4+KTzfTHVMje7ScogUHZCGim9Hi2+xAnul3ZNP1
        /iCH4HBJ0luZDbqxVFuRfxOeJEQWO5Lok1sJtVc2+L4HYPZHeLoWfQQQu5snKtAL
        G13ld0gti01Z0bmoG18pA1E3YzHPGRCwdXzhE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B1512BB584;
        Fri, 24 Jan 2020 12:16:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DA8EEBB582;
        Fri, 24 Jan 2020 12:16:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Peter =?utf-8?Q?K=C3=A4stle?= <peter.kaestle@nokia.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, pc44800@gmail.com
Subject: Re: [PATCH v2] Fix status of initialized but not cloned submodules
References: <23e3d410-5271-a919-aa03-9e776cf72f7c@nokia.com>
        <1579601532-10694-1-git-send-email-peter.kaestle@nokia.com>
        <xmqq4kwl512y.fsf@gitster-ct.c.googlers.com>
        <9192695a-0b3f-d166-7efa-84f57e091c2c@nokia.com>
Date:   Fri, 24 Jan 2020 09:16:52 -0800
In-Reply-To: <9192695a-0b3f-d166-7efa-84f57e091c2c@nokia.com> ("Peter
        =?utf-8?Q?K=C3=A4stle=22's?= message of "Fri, 24 Jan 2020 12:55:25 +0100")
Message-ID: <xmqqblqs3hbv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 51C1658A-3ECD-11EA-AD9A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter K=C3=A4stle <peter.kaestle@nokia.com> writes:

> Originally, without applying the v3 series, I can see those testcases:
>
> 1) not-init, not-cloned: 'status should initially be "missing"'
> 2) init, not-cloned: MISSING
> 3) not-init, cloned: MISSING
> 4) init, cloned: 'status should be "up-to-date" after update'
> 4.1) + modified: 'status should be "modified" after submodule commit'
> 4.2) + modified, committed: 'status should be "up-to-date" after update=
'
>
> My patch v3 series adds a testcase for 2).

That's good.

> Is 3) even a possible use-case?

That would be somebody who is about to add a submodule to an
existing project, right?  You have a top-level project, you need
somebody else's project as its submodule or you need to use a
library in your top-level project and you develop the library
yourself, but want to keep that library part separate from its first
user which is your top-level project.  So in the working tree of a
top-level project you either "git init lib/" and start the submodule
project right there, or "git clone $URL_of_upstream_of_lib lib/",
and then plan to do "git submodule add lib", but haven't done so
yet.  .gitmodules does not know about it, but the directory is
already populated and is a valid repository.

> Besides that, I think testcases for man git-submodule's description of
> status on merge conflicts are missing (...[prefix] U if the submodule
> has merge conflicts).

Nice to know.  Thanks.
