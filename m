Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEFBC433E0
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 23:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 634EB64EC4
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 23:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhCMXXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 18:23:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51432 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbhCMXXc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 18:23:32 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2405AB80DD;
        Sat, 13 Mar 2021 18:23:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tcF3wSkwAz67
        AVggatwH0s69W7s=; b=v3JINTSRGi2UyCbtXwz6Em25KPLqz1BlnSexXoltqg/y
        gxMVkrkYeYWtXXEsjKhy1J2lo+rfIi/3s+RznBvydHy6/P1HuNydHQpIxftwzPFJ
        FeQgI6jM7UsAocUudlmnPtRlveMSKr6D+ZwRd4c1cnIZW3lP0adFaJ9IeksDiaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tMKYsu
        7IbsiJhe6M/paCdpVgFGGjyXA63r5xSCD2GP3EUHxA9mddSilK0y9MbYu/5wJgco
        ACI74mCOD5ygl/w5Hi5/jQfJ2aKynsUiHqxqSziiQbbM7yUa9cBXSEa8zswFwHw1
        iNi/zP+MXW0aVjPLNXhAc1GqZGoBgtgO16yP4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1ADACB80DC;
        Sat, 13 Mar 2021 18:23:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D223B80DB;
        Sat, 13 Mar 2021 18:23:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Taylor Blau <ttaylorr@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] [GSOC][RFC] format-patch: pass --left-only to
 range-diff
References: <pull.898.v2.git.1615278830804.gitgitgadget@gmail.com>
        <pull.898.v3.git.1615285726482.gitgitgadget@gmail.com>
        <xmqqpn0456lr.fsf@gitster.g>
        <CAOLTT8QhgeGim6ujqqyXwQ=bmQtJ43T5i3CPmNMPmBr0amR-HQ@mail.gmail.com>
Date:   Sat, 13 Mar 2021 15:23:29 -0800
In-Reply-To: <CAOLTT8QhgeGim6ujqqyXwQ=bmQtJ43T5i3CPmNMPmBr0amR-HQ@mail.gmail.com>
        (ZheNing Hu's message of "Sat, 13 Mar 2021 12:01:50 +0800")
Message-ID: <xmqqwnua4ozy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1F39E9DA-8453-11EB-BCF1-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8813=E6=
=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=886:51=E5=86=99=E9=81=93=EF=BC=9A
>>
>> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > From: ZheNing Hu <adlternative@gmail.com>
>> >
>> > In https://lore.kernel.org/git/YBx5rmVsg1LJhSKN@nand.local/,
>> > Taylor Blau proposing `git format-patch --cover-letter
>> > --range-diff` may mistakenly place upstream commit in the
>> > range-diff output. Teach `format-patch` pass `--left-only`
>> > to range-diff,can avoid this kind of mistake.
>>
>> The above is a bit too dense for average readers to grok.  Even if
>> the readers refer to the external reference, it is unclear where the
>> "may mistakenly" can come from and why "--left-only" would be
>> useful (and our log message should not depend on external material
>> so heavily to begin with).
>>
>
> You are right, commit information with the original thread link may mak=
e
> it difficult for readers to read. I will pay attention.
>
>> So let's think aloud to see what use case this may be helpful, and
>> how the proposed solution makes the world a better place.
>>
>> If I understand correctly, the use case this tries to help is this:
>>
>>  * You had sent the v1 iteration of topic.  It was in the range
>>    B1..T1 where B1 is the tip of the integration branch (like
>>    'master') from the upstream.
>>
>>  * To prepare for the v2 iteration, not only you updated individual
>>    commits, you rebased the series on a new upstream.  Now the topic
>>    is in the range B2..T2, where B2 is the tip of the integration
>>    branch from the upstream, and it is very likely that B2 is a
>>    descendant of B1.
>>
>> And you want to find out how your commits in T2 (new iteration)
>> compares with those in T1 (old iteration).  Normally,
>>
>>     $ git range-diff T1...T2
>>
>> would be the shortest-to-type and correct version but that is
>> invalidated because you rebased.
>>
>>     ---o---B1--b---b---b---B2
>>             \               \
>>              t---t---T1      s---s---s---T2
>>
>> You'd have commits B1..T1 on the left hand side of the range-diff,
>> while the right hand side has not just B2..T2 but also commits in
>> the range B1..B2, too.
>>
>> By using --left-only (i.e. show only those pair that maps from
>> commits in the left range), you can exclude the commits in the
>> B1..B2.
>>
>>     $ git range-diff --left-only T1...T2
>>
>> I however wonder what --left-only (Suppress commits that are missing
>> from the first range) would do to commits in range B2..T2 (they are
>> all yours) that are (1) added since the v1 iteration, or (2)
>> modified so drastically that no matching commit is found.  With the
>> right invocation, of course,
>>
>>     $ git range-diff B1..T1 B2..T2
>>
>> you would not have such a problem.  If 2 't's in B1..T1 correspond
>> to 2 of the 3 's's in B2..T2, at least the presense of the third 's'
>> that did not match would show up in the output, making it clear that
>> you have one more commit relative to the earlier iteration.  If use
>> of --left-only filters it out, the output may be misleading to the
>> readers, no?
>>
>> I started writing (or "thinking aloud") hoping that I can help
>> coming up with a better log message to describe the problem being
>> solved, but I ended up with "does this make the system better?"
>
> Junio, thank you for elaborating this issue in detail and clearly.
> I probably understand what you mean by "git range-diff B1..T1 B2..T2"
>  to correctly output the commits on my two version topic branch, withou=
t
> including the upstream commits of B1..B2.So we don=E2=80=99t even need =
to specify
> the `--left-only` to avoid the output of B1...B2, right?
>
> The only thing I can think of now is that if users tend to use T1...T2
> to compare
>  the differences between the two topics, will the upstream commit in
> B1...B2 appear
> more abrupt?

Yes, it would be, but that is why you need to educate users what
causes it, and what the right way to avoid unrelated commits from
appearing, and how this --left-only fits in the solution.

If some of the time, "--left-only T1...T2" would give you the same
result as the more strict "B1..T1 B2..T2", that may be why users may
want to use the "--left-only" instead as an easy/lazy alternative.

But I suspect that it would give an incorrect result some of the
time---for example, in the above example, wouldn't one of the
commits labeled as 's' be completely hidden?  And if that is the
case, the end-user documentation would need to warn about it, and
explain that it is a easy/lazy alternative that can produce
incorrect result in the log message.
