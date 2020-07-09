Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FADC433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 16:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C7D207DD
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 16:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZXHmzIvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgGIQ0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:26:21 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53230 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgGIQ0U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 12:26:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D4C9E5C6B;
        Thu,  9 Jul 2020 12:26:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6R8JZ/WoBe4qeJEHUEgT3U/xHWg=; b=ZXHmzI
        vCUB2DEMj0lfRTb8eDjafi/zDfQ3W2+qcuZf399dMJiiAoGW1S1Bz6jMHCUryAlF
        e38LSnm5s/xvji1lf4jlLxOlQphkc1qtWh+C4hODYn7UF1O2N0bXTSlJqStAK6Lk
        FwOQA66VvJ10BElx7fpAyqUG7N2ScNPvMWyoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DWOyeC1kTNlAktqImrPaRT1CQ4dvd6fP
        a2kPefnaeD2EHyjnmrEqwjIibvyPOR9COaXqq3odLiYzw8Fq9DX55lRwtsH5A8CO
        pYBjct1Vdq5StbyX6ePfBOOzq6bUlpc0Fe4mTNp8U/YPV6hWp38r2rz7mAkxT7bL
        ZSD/lrFhyBg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 557C8E5C6A;
        Thu,  9 Jul 2020 12:26:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 95ECDE5C69;
        Thu,  9 Jul 2020 12:26:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 00/21] Maintenance builtin, allowing 'gc --auto' customization
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <20200708235719.GA3189386@google.com>
        <ef6e2704-b122-f620-a952-75f3f9efab78@gmail.com>
        <xmqqv9iwyeac.fsf@gitster.c.googlers.com>
        <52715fe8-a545-5c42-2f3a-e59bcbc43497@gmail.com>
Date:   Thu, 09 Jul 2020 09:26:11 -0700
In-Reply-To: <52715fe8-a545-5c42-2f3a-e59bcbc43497@gmail.com> (Derrick
        Stolee's message of "Thu, 9 Jul 2020 11:54:20 -0400")
Message-ID: <xmqqmu48y7rw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E898A19C-C200-11EA-969F-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 7/9/2020 10:05 AM, Junio C Hamano wrote:
>> For existing callers, "git gc --auto" may want to be left alive,
>> merely as a thin wrapper around "git maintenance --auto", and as
>> long as the latter is done in the same spirit of the former, i.e.
>> perform a lightweight check to see if the repository is so out of
>> shape and then do a minimum cleaning, it would be welcomed by users
>> if it does a lot more than the current "git gc --auto".
>
> It's entirely possible that (after the 'maintenance' builtin
> stabilizes) that we make 'git gc --auto' become an alias of something
> like 'git maintenance run --task=gc --auto' (or itemize all of the
> sub-tasks) so that 'git gc --auto' doesn't change behavior.

Yes, it is possible, but I doubt it is desirable.

The current users of "gc --auto" do not (and should not) care the
details of what tasks are performed.  We surely have added more
stuff that need maintenance since "gc --auto" was originally
written, and after people have started using "gc --auto" in their
workflows.  For example, I think "gc --auto" predates "rerere gc"
and those who had "gc --auto" in their script had a moment when
suddenly it started to clean stale entries in the rerere database.

Were they got upset when it happened?  Will they get upset when it
starts cleaning up stale commit-graph leftover files?

As long as "gc --auto" kept the same spirit of doing a lightweight
check to see if the repository is so out of shape to require
cleaning and performing a minimum maintenance when it started
calling "rerere gc", and as long as "maintenance --auto" does the
same, I would think the users would be delighted without complaints.

So, I wouldn't worry too much about what exactly happens with the
future versions of "gc --auto".  The world has changed, and we have
more items in the repository that needs maintenance/cruft removal.
The command in the new world should deal with these new stuff, too.

Thanks.
