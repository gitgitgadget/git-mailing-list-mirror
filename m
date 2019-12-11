Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08233C2D0C6
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 16:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE6F205C9
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 16:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E3dKKwdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfLKQOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:14:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58758 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729912AbfLKQOh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 11:14:37 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F3C633603E;
        Wed, 11 Dec 2019 11:14:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rMJkMFHx6siVgUxfK01r4mz8mJc=; b=E3dKKw
        dVgOHtXTFDn4W3uQ+PKtW/fRIh/zrWTIkpuSNvCIIrkFWhFYltXDRwgaDiMoTspX
        HVkYj0DybWb75HErxYkeNKulWuxLsarGfPJFbAH+9T/7HA0Dea92I/QJTBP57XrG
        IuE53LYOoLjNCamGzdgFYKwb6hEJGKplEZXQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wy3VYR7mIMwzx/lFy4x6flRXER6T7Cvp
        FZc4s/7NAYcbf6r/YO6m3oI1UnwOjP/ysJgkEmQ4eavIT4n5mksLNKTuaeSuo/Wx
        0IGKf+tEGwm84UN0v6owJFXP0ieSdBcQMoa9P1vCE1mN6z7qCj8mQMSRGSP+WeHB
        j0THIUoZkmg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB7F53603D;
        Wed, 11 Dec 2019 11:14:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5A3E83603B;
        Wed, 11 Dec 2019 11:14:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     phillip.wood@dunelm.org.uk,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 5/5] commit: support the --pathspec-from-file option
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
        <f4847046896848d3f16bc5f3cb7a26271cefd97c.1572895605.git.gitgitgadget@gmail.com>
        <9ca7fa57-c438-7243-6ab1-956d8f132d37@gmail.com>
        <25aaaca1-1c88-d2c6-b502-cd35752ce745@syntevo.com>
        <4401823b-8039-99b4-2436-ed2f1a571d78@gmail.com>
        <2b573436-0ed2-9d24-f375-dfea0825a39e@syntevo.com>
        <b9454df6-7d31-e255-84bd-8a1c548cffd7@gmail.com>
        <9d77a425-da8d-d6e7-f51f-c4ce6ee988d5@syntevo.com>
Date:   Wed, 11 Dec 2019 08:14:33 -0800
In-Reply-To: <9d77a425-da8d-d6e7-f51f-c4ce6ee988d5@syntevo.com> (Alexandr
        Miloslavskiy's message of "Wed, 11 Dec 2019 16:06:57 +0100")
Message-ID: <xmqq5zimrg9i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52A725DE-1C31-11EA-94D3-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com> writes:

> and I can continue to extend it in the same direction, or try to
> refactor to make it better. I actually choose the second path:
> [1][2]. These were two "don't" lessons for me, as both topics now
> gather dust in mail graveyard.

If nobody commented on your patches, that is not a punishment.  It
could have been that reviewers were busy addressing other issues
back then, in which case a gentle ping by resending a polished
version (it could be that the changes were not presented well to
attract reviewers' attention---polishing the proposed log messages
without changing the patch text might be all it takes to make them
realize that the topic is worth looking at) would help.

> [1]
> https://public-inbox.org/git/pull.479.git.1574969538.gitgitgadget@gmail.com/
> [2]
> https://public-inbox.org/git/pull.477.git.1574848137.gitgitgadget@gmail.com/T/#u

I actually was meaning to read and comment on [1], but lack of time
pushed it down in my queue.  Sorry about that.

