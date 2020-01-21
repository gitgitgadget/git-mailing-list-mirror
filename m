Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F339EC2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 18:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42712087E
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 18:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rAGYmJ0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgAUSWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:22:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59346 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgAUSWn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 13:22:43 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B48035C24;
        Tue, 21 Jan 2020 13:22:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mGxvJ5icGNmjBzYM56AIWsRYPoM=; b=rAGYmJ
        0DVa53MKwwO7TIw4HWHI1QWfk08XyWOV7t7/rsiZTzRFgFHvlE0X6EFnwgLLUZsr
        mpaQO4wMacxLh4StuPc3SjjmnPXd9DlvqINulwqDIevw9/4YeJL1FSFsz+0i5BcW
        SiU8vbCFznXlCG0rWsn1gIfvOtu0kRKqaYcNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ItpQLXVNnZbew3mj2RaeGn0PE4/I0Nss
        fEbIbKKnHLEc/BsntSgFs4DhzFa4GrmDSvHMi0L4c7F36Jy2fxkr6QinytrTwT+w
        7DrqtLsfYxm4uX3Lz6K8b0KZkjnJgg8W+r7hh31tnGOMrgXebIW/93ajwxeWQyd6
        Z9zE9mXAwDk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 636A935C23;
        Tue, 21 Jan 2020 13:22:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C8AE935C22;
        Tue, 21 Jan 2020 13:22:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2] fetch: document and test --refmap=""
References: <pull.532.git.1579274939431.gitgitgadget@gmail.com>
        <pull.532.v2.git.1579570692766.gitgitgadget@gmail.com>
        <20200121162433.GA6215@coredump.intra.peff.net>
Date:   Tue, 21 Jan 2020 10:22:39 -0800
In-Reply-To: <20200121162433.GA6215@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 21 Jan 2020 11:24:33 -0500")
Message-ID: <xmqq5zh4brf4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 027A3244-3C7B-11EA-BAEC-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jan 21, 2020 at 01:38:12AM +0000, Derrick Stolee via GitGitGadget wrote:
>
>> Update the documentation to clarify how '--refmap=""' works and
>> create tests to guarantee this behavior remains in the future.
>
> Yeah, this looks like a good solution to me.
>
>> This can be accomplished by overriding the configured refspec using
>> '--refmap=' along with a custom refspec:
>> 
>>   git fetch <remote> --refmap= +refs/heads/*:refs/hidden/<remote>/*
>
> This isn't strictly related to your patch, but since the rationale here
> describes the concept of a background job and people might end up using
> it as a reference, do you want to add in --no-tags to help them out?

Also, is the order of the arguments correct?  I would have expected
to see <remote> after all dashed options and before refspecs.

> If it makes you feel better, I only found --refmap because I was the one
> who implemented the original "update based on refspecs" logic, and while
> looking for that commit with "git log --grep=opportunistic" I stumbled
> onto Junio's commit adding --refmap, which referenced mine. Maybe this
> also works as a good case study in why we should write good commit
> messages and refer to related work. :)

;-)

> Anyway, I wasn't at all sure that a blank --refmap= would do what you
> want until I tried it. But it was always intended to work that way. From
> c5558f80c3 (fetch: allow explicit --refmap to override configuration,
> 2014-05-29):
>
>   +static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
>   +{
>   +       ALLOC_GROW(refmap_array, refmap_nr + 1, refmap_alloc);
>   +
>   +       /*
>   +        * "git fetch --refmap='' origin foo"
>   +        * can be used to tell the command not to store anywhere
>   +        */
>   +       if (*arg)
>   +               refmap_array[refmap_nr++] = arg;
>   +       return 0;
>   +}

Good analysis, and also the answer to my previous question is also
there ;-)

