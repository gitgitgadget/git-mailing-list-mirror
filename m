Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEB4C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 08:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23EB56113D
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 08:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhD2IdC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 04:33:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53329 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhD2IdC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 04:33:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 97AF912E55E;
        Thu, 29 Apr 2021 04:31:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2CBCjH5tpLediVoIhbWQKtaw79FcgjQntLIuj5
        yX+/A=; b=bCqcHaKt7R4I0fTWm2X1te99MV1YP6Djv7UmUl5gzbm+nsK20wgXFs
        KJWOc09UFzoc9zc+HeHr07G686u9+4h9cNhlYBfq4zhQ6EHkEbGIzLfZWGICYPvT
        Htg6w1GwK/AuKDI/Rv6ktkDHvFY72mpjRu2amjMTBcsk2XDgsmWi0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9086412E55D;
        Thu, 29 Apr 2021 04:31:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CC9FB12E55C;
        Thu, 29 Apr 2021 04:31:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Joachim Kuebart <joachim.kuebart@gmail.com>,
        Joachim Kuebart via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-p4: speed up search for branch parent
References: <pull.1013.git.git.1619640416533.gitgitgadget@gmail.com>
        <xmqq5z05akyf.fsf@gitster.g>
        <CAJGkkrQJFaLPfCBTVn6k1v9cCwF4wEUxr+ZyzebUBQJB8qLaWg@mail.gmail.com>
        <b0befcf3-8d8a-f99f-d4f0-78b2cfe22505@diamand.org>
Date:   Thu, 29 Apr 2021 17:31:54 +0900
In-Reply-To: <b0befcf3-8d8a-f99f-d4f0-78b2cfe22505@diamand.org> (Luke
        Diamand's message of "Thu, 29 Apr 2021 08:22:52 +0000")
Message-ID: <xmqqwnslfq4l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B4A1D5A-A8C5-11EB-9A85-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

>>>>       def searchParent(self, parent, branch, target):
>>>> +        for tree in read_pipe_lines(["git", "rev-parse",
>>>> +                                     "{}^{{tree}}".format(target)]):
>>>> +            targetTree = tree.strip()
>>>
>>> It looks very strange to run a commit that you expect a single line
>>> of output, and read the result in a loop.  Doesn't git-p4.py supply
>>> a more suitable helper to read a single line output from a command?
>> You're absolutely right that this isn't very readable. I had a quick
>> look around for a function that reads a single-line response, but I'll
>> look again and come up with a clearer solution.
>
> I don't think there is one - git-p4 has lots of functions for calling
> `p4', but for calling git, it just uses Python's Popen() API.

OK.  It just felt "strange", not "wrong", so I am OK with the
construct at least for now.

> There are existing tests for importing branches which should cover
> this. I don't know if they need to be extended or not, you might want
> to check.
>
> Looks good otherwise.

Thanks for a prompt review.


