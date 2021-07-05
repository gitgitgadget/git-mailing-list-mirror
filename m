Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFDDC07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 19:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93E56141C
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 19:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhGETZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 15:25:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53486 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhGETZo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 15:25:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 56CF613ECC8;
        Mon,  5 Jul 2021 15:23:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qr6dyNYqp4mVsWzf64jdA847NpRteJf3oqKCC6
        QhDMc=; b=jePP4gG3SNiNtYhES0k9ogqad1afH1/OskM/0Zk2sTLooMS9uwje7W
        S14WmI1m124dMsU5CulE0Z33GcnaR6FHzOgi9Reb0cwadOlWiY+NfcV/AmDTCCjs
        arEWiOhPVl6pf7rq/W0jh5sdJZ2tUk5s0wJYiF8e95Tl5/ygtXV5o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F06913ECC6;
        Mon,  5 Jul 2021 15:23:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C73ED13ECC5;
        Mon,  5 Jul 2021 15:23:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        newren@gmail.com
Subject: Re: [PATCH RFC] rebase: respect --ff-only option
References: <20210705044505.666977-1-alexhenrie24@gmail.com>
        <349748b4-3c48-7ca7-eb0f-e859a15cab0f@gmail.com>
        <7ee36923-0806-4316-729c-8418df5b6555@gmail.com>
        <xmqqpmvwn1qp.fsf@gitster.g>
Date:   Mon, 05 Jul 2021 12:23:03 -0700
In-Reply-To: <xmqqpmvwn1qp.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        05 Jul 2021 09:50:54 -0700")
Message-ID: <xmqqlf6kmup4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6BE3E4EE-DDC6-11EB-973D-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> Looking at origin/seen:builtin/pull.c we already check if we can
>> fast-forward and unconditionally merge in that case irrespective of
>> any '--rebase' option or pull.rebase config. It should be simple for
>> pull to error out if '--ff-only' is given and we cannot fast-forward.
>
> Excellent.
>
> Even though teaching even more special case on the "git pull" side
> makes me feel somewhat dirty, but I think it would be a small price
> to pay, and the end result would save an useless fork whose sole
> purpose is to make the integration step after fetch fail when "pull"
> can easily tell, as you said, that it ought to fail, so overall it
> would probably be a net win.

A tangent after thinking a bit more.

I do not think "pull.rebase=interactive" affects the "ff logic" at
all.  Rebasing integration rebuilds _your_ commits on the current
branch on top of the tip of _their_ history, and if their history is
a descendant of your history (i.e. the history fast-forwards), by
definition, you do not have anything you need to rebuild on top of
theirs, whether with the opportunity to make tweaks via "rebase -i"
or without.

This observation does not change the conclusion at all, but I should
have spoken after thinking X-<.

Thanks.
