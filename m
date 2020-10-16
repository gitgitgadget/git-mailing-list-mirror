Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48E7C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 16:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B60220829
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 16:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rpdQT04A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410378AbgJPQaZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 12:30:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60731 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408429AbgJPQaY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 12:30:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F633FC37F;
        Fri, 16 Oct 2020 12:30:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vsqwsr54KdPzoRyvedmPtM9vc2U=; b=rpdQT0
        4AHRICIjIjMCj8A6zkIKcVpKxx/3gmnMAWkpTxR3e89ogSa+t/9MCdgvB1ClOvhK
        7Sv7gS3Tbgr4qply5xdbKHu/t3fwvHzfIP9Nzy9IWxrLARcmpI/Prl3b05jYWfGW
        v8BFh+ITInOleAMFvZxcNCDo2Eeg1sOahquGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jDscQz02WhxY+4JSMIU98e/e6TP8GWM8
        q5NsnsQmykEGrzoSwfzIyYgFjz2O02Ncc4JcEouk0+BesojAFaiChNwqTfAjpUNT
        dIwgIolnH9yF2zqOdTf9d+//Djn8aZiiPRv5NS7a1NA1iUoDIG3749uXmzcxts/D
        wVO4nSnU0m8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 76A5CFC37E;
        Fri, 16 Oct 2020 12:30:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B9BC5FC37B;
        Fri, 16 Oct 2020 12:30:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/3] test-lib: allow selecting tests by
 substring/regex with --run
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
        <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
        <41e2528e83ba7087c9d21f0b15efed416f1512f8.1602616786.git.gitgitgadget@gmail.com>
        <20201014170413.GB21687@coredump.intra.peff.net>
        <xmqq1rhzihqa.fsf@gitster.c.googlers.com>
        <20201015194648.GB1490964@coredump.intra.peff.net>
        <xmqq7drrfe15.fsf@gitster.c.googlers.com>
        <20201016003847.GB2932796@coredump.intra.peff.net>
        <xmqq7drqdu2u.fsf@gitster.c.googlers.com>
Date:   Fri, 16 Oct 2020 09:30:21 -0700
In-Reply-To: <xmqq7drqdu2u.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 16 Oct 2020 09:16:57 -0700")
Message-ID: <xmqq362edtgi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E36595D0-0FCC-11EB-895E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> My plan is that you'd be able to say:
>>
>>   Meta/make --test=filesystem,update-ref
>>
>> for t0050 and t1400 respectively. Or more interesting things like
>> "git-svn-*" to skip all of the t91xx tests (or "git-svn/*" if we split
>> them by directories).
> ...
> The word "filesystem"?  Unless we have a rule that we can use each
> unique word in test names only once (which of course is impractical)
> I am not sure I can use it in place of 0050 without checking names
> of other tests first.
>
>> I definitely don't want to make anybody's life harder. But if the
>> numbers aren't unique and the text connected to them is, then it seems
>> like we should just use the text primarily.
>
> True in principle, but it is harder to come up with unique substring
> of text, knowing only that the whole string is unique.

I think there was a mismatch in assumptions and expectations.  I
think your "plan" was to use the whole name (what comes after \d+-
in the current naming scheme, except for the .sh at the end), and I
was assuming a glob with implicit * on both ends would be used, i.e.

    $ ls -d t/*update-ref*

would give me 1404 (update-ref-errors) in addition to 1400 (update-ref).

So if the rule is to always spell out the full name if I wanted
uniqueness, then it would work.  In the cited usecase of knowing
which two failed the first time, I should have the full filename
of them available.

Thanks.
