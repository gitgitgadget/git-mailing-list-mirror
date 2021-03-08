Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911A6C43381
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68183652B1
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhCHSlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:41:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60000 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhCHSlH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 13:41:07 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9C4EB972C;
        Mon,  8 Mar 2021 13:41:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KPwHpAEcuGV40LEnbln0GFmtz8U=; b=FWN217
        FZ4LgJoJDIktJRN2X9QG180iUM054wegQPPev/FU//eHNDhcU8oEPphCxH6tW3Le
        z9IbQuF//kBfieOWUiWcRi2SWjjlIZGdgMYSbIgzHPXgj0AxigAWDjIv7auR2Ifr
        jLq5btgf1UxJe96C9JoZSeaigydJWDSfEB/JM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G3AN1aN7S3vdzzESzXJ30qtrJfDKpVnr
        2wTEJYouRj/DGLKria8U/00kM4FctaeOKkAM4hrDL1Sq/aiM2mMwPkUrRJWaaIha
        eujmLtXj/khKfGJIA3/bXCKHKd55q+AYuRHyIcDjA4PAc5v+2+yP35btKO0V1EB9
        R+ud/jFL+aQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB918B972B;
        Mon,  8 Mar 2021 13:41:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C53FFB972A;
        Mon,  8 Mar 2021 13:41:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <ttaylorr@github.com>
Cc:     HG King via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, HG King <hgmaxwellking@gmail.com>
Subject: Re: [PATCH] fix: added new BANNED_EXPL macro for better error
 messages, new parameter
References: <pull.896.git.1614991897210.gitgitgadget@gmail.com>
        <xmqq7dmi8zym.fsf@gitster.c.googlers.com>
        <YEZnaeJVt8Rk6duv@nand.local>
Date:   Mon, 08 Mar 2021 10:41:04 -0800
In-Reply-To: <YEZnaeJVt8Rk6duv@nand.local> (Taylor Blau's message of "Mon, 8
        Mar 2021 13:05:46 -0500")
Message-ID: <xmqqo8ft5vzz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7732DAA-803D-11EB-9DFB-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <ttaylorr@github.com> writes:

>> Adding a comment around each of these definition may be OK.  Upon
>> seeing foo_is_a_banned_function, somebody new to the codebase would
>> look for where it is banned, and find the above, so that is a good
>> place to give guidance.
>
> Perhaps, but all of this information is already covered accurately in
> the patches that introduced each banned function. So I'm not sure that I
> even agree that this information is difficult to discover to begin with,
> but I may be biased.

To help those who are not yet familiar with this codebase but are
willing to learn, I tend to agree with you that it is a good idea
not to miss opportunities to encourage them to run "git blame" to
find out about the project history in the parts of the system that
pique their interest.  They will make more motivated contributors
who are invested in the project, if they stick around.

It would discourage and filter out "drive-by" contributors, though.

Somebody may not yet be interested enough to "git clone" us, but
happens to have an extract of distro source tarball and enough
motivation to try peeking and tweaking around.  To such a curious
developer, the "blame" information and log messages with the change
are not readily available, so there probably is some balance to be
struck.
