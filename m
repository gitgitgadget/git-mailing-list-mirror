Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E9EC2BB1D
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 19:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7AA206E9
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 19:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LH0n6QTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgCLTy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:54:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61387 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLTy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 15:54:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 24366C5938;
        Thu, 12 Mar 2020 15:54:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZDhZ41RdXtbqQNNbXTAAe01uXJw=; b=LH0n6Q
        TyCi5niWr/YVtwNM51TyFn6PSoZGx4NI6Y+KE1JBGoDR3jVQ//fyCM+3UW9XKrgM
        Jnn2jZZ5OM+4KtqoYrjmGi7yu3uNLymOjuLV25DurSE40d854D7RuASh6nzv9QuU
        KbZjU+NCNaejKaBl954CP0K6wHWG0AyCM3Jfs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Byj3/E09uZQRWfdX3gCH0NXpeVxmcUR3
        WfR1hUKlABc29Za+6PCmxlWnb3RRLUcKJpCqzqPuKFGFibuS0mYDkwiZKbeFkBjO
        rQSn2naMnO/cgMpfa1mYcQH8X4Up+54k7h99SQqnnXc43JLXGMpsrfCk0nzWna46
        P2gA4kZRhrY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1B3D8C5937;
        Thu, 12 Mar 2020 15:54:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 62F2CC5936;
        Thu, 12 Mar 2020 15:54:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 20/20] rebase: rename the two primary rebase backends
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
        <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
        <ad8339aebf28ec84c22ed59cef06614d204adb55.1581802602.git.gitgitgadget@gmail.com>
        <20200312151318.GM212281@google.com>
        <CABPp-BHyNvxQZ5q=9WXXESTPmxFe4fAiE5roGeV2H+XJ_cpDmg@mail.gmail.com>
        <20200312175548.GC120942@google.com>
        <CABPp-BFLwpa019Prd3nf7s4BY2jWp8utOvJD9pzHcbg66b8fWw@mail.gmail.com>
        <20200312184621.GD120942@google.com>
Date:   Thu, 12 Mar 2020 12:54:54 -0700
In-Reply-To: <20200312184621.GD120942@google.com> (Jonathan Nieder's message
        of "Thu, 12 Mar 2020 11:46:21 -0700")
Message-ID: <xmqq4kutfiwh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5901A10E-649B-11EA-9692-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Sorry for the lack of clarity.  I mean allowing
>
> 	[rebase]
> 		backend = am
> 		backend = apply
> 		backend = futuristic
>
> with behavior
>
> - on "git" that understands am but not apply or futuristic, use the am
>   backend
> - on "git" that understands apply but not am or futuristic, use the
>   apply backend
> - on "git" that understands apply and futuristic, use the futuristic
>   backend
>
> That way, a single config file is usable on all three versions of Git.

IOW, make rebase.backend a multi-valued one and use it when one and
only one value is a recognised one?  What would an error message say
when none is recognised, and when would that be issued?

I like the general direction it takes, but I think it would be
simpler to (1) die when we see what we do not recognise and (2)
teach the latest one that "am" is a synonym for "apply", without
even advertising "am".

