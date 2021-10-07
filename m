Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ADCC433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 22:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD8F60FC1
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 22:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhJGWDp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 18:03:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59689 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241216AbhJGWDj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 18:03:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB1FCF3883;
        Thu,  7 Oct 2021 18:01:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WF9WkPLhqIRN7HpXRwxW5bVmbJNi0b+8TuepGJ
        RMk5A=; b=JlLWzIAKilVnLf1GTkM1YKE12hsJyFBwwZH50m2JDaCuXfcxinoS6l
        xPiMN+9P54720Q0aGo6PmbjjXK4mwuBFLxqlyDLymzRbwX0G09fT6fQisXccmazn
        mstRG22QHj2YoLz6iIbN2SFwpc09ph2VKYFAaEF8MED+3xUbCpzD0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E21F2F3882;
        Thu,  7 Oct 2021 18:01:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 52539F387C;
        Thu,  7 Oct 2021 18:01:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>,
        Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
References: <xmqq8rzhmsi7.fsf@gitster.g>
        <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
        <87v92lxhh4.fsf@evledraar.gmail.com> <xmqqilykliiz.fsf@gitster.g>
        <20210928210059.vy5isvmcj75vufdu@neerajsi-x1.localdomain>
        <xmqq8rzgi8a7.fsf@gitster.g>
        <CANQDOddZ-KYTB4q0nYNDinis8aKktm6Ek6F+mJouTV-yRtTpUw@mail.gmail.com>
Date:   Thu, 07 Oct 2021 15:01:42 -0700
In-Reply-To: <CANQDOddZ-KYTB4q0nYNDinis8aKktm6Ek6F+mJouTV-yRtTpUw@mail.gmail.com>
        (Neeraj Singh's message of "Tue, 28 Sep 2021 16:53:13 -0700")
Message-ID: <xmqq4k9spk8p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 283426B2-27BA-11EC-84E8-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> Elijah,
>
> Here's a branch of your changes based on the amalgamated tmp-objdir code:
> https://github.com/neerajsi-msft/git/commits/neerajsi/remerge-diff
>
> This commit adapts your code to use the amalgamated API:
> https://github.com/neerajsi-msft/git/commit/725328fe1d8be8326d2ddef78e164ca21450b100

It seems that the discussion petered out at this point.

Right now I have a version of ns/remerge-diff before this adjustment
in 'seen', and Neeraj's latest version is kept out of 'seen' as they
do not play well together without an adjustment like that.

What's the good way forward?  I do not deeply care which one goes
first, but I have a feeling that the need by remerge-diff that wants
to discard temporary objects would involve more work to make it safe
than the need by batched fsync where newly created objects will not
be discarded but merely moved to the primary store before the end of
the operation, so from that point of view, it seems simpler and
safer to queue ns/batched-fsync topic first (especially given that
it is a no-op until the end-user opts into the experiment), and have
a remerge-diff that uses the infrastructure from Neeraj's topic.

What's your take on the rebase Neeraj made, Elijah (at the URL
above)?

Thanks.




