Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7BEC433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 20:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5296064F17
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 20:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhBYUFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 15:05:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50718 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbhBYUE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 15:04:59 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7ED19FFEF;
        Thu, 25 Feb 2021 15:03:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FpKWYJLv4zkX
        XtWgMmyom7cL28A=; b=lGxfCQMHJ3zNEbTIyxIruMhmvMMysaz7sjCbba1iI25M
        wxX3Xv8P+cEdaCGY9mdw+WGgsgSQ0YJoyd6XuZHl7bIfiT8QCgUyuo9h8viR9uf1
        nbpjDNi2oxvmAA0pqIipgdbQysQq/lZ2M+gSL1hhOdqncWoWM1uGpwDzJNHw/9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=OzhsF6
        NvNnxDgifRuNnti/GgOkZuqlKfHeJQz5zbkNhppB2J3PmHXLVEwQ73repLwBKQD1
        F0JbwgCHET6u3yRXVWtUfEWzCGqGAn9A+6dSxR9uwFg7abLVfZFnb71WUv8x8qXm
        cL9UGFQB9/TRl2hlobGrtSM+Is9PGrynPm9S4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF2979FFEE;
        Thu, 25 Feb 2021 15:03:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5CD079FFED;
        Thu, 25 Feb 2021 15:03:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Getting an actuallt useful merge base?
References: <20210224175834.GT6564@kitsune.suse.cz>
        <YDcOOwBOR4rO3sGr@camp.crustytoothpaste.net>
        <20210225182924.GY6564@kitsune.suse.cz>
        <CABPp-BGdFX6V+GNQ6JVnoY3S9cvA0mL+cKSnAhUhArQbGaD6vw@mail.gmail.com>
Date:   Thu, 25 Feb 2021 12:03:58 -0800
In-Reply-To: <CABPp-BGdFX6V+GNQ6JVnoY3S9cvA0mL+cKSnAhUhArQbGaD6vw@mail.gmail.com>
        (Elijah Newren's message of "Thu, 25 Feb 2021 11:52:06 -0800")
Message-ID: <xmqqv9afud75.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9939BDDE-77A4-11EB-9CFE-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> It's like this
>>
>> T
>> ----o----o----o----o----o----o----o----o----o----o----o----o---(t)---o=
----o----
>>      \             \     \                                      \\\
>>       \             \     \                                      \\\
>>        \             \     \                                      \\\
>>         \        o----o----o\=CC=B6---o---(s)---o----o----o----o----o-=
---o\=CC=B6\=CC=B6-(a)
>>          \      /            \      /                                \=
\
>> S+T  o----o----o----o----o----o----o----o----o----o----o----o----o----=
o\=CC=B6--(b)
>>     /                                       /                         =
  \
>> ---o----o----o----o----o----o----o----o----o----o----o----o----o----o-=
---o---(m)
>>
>> So (t) is common ancestor for (a) and (b) that merge-base reports but =
it is
>> only ancestor for files in set T, and does not have files from set S a=
t all.
>> The common ancestor I am insterested in is (s) which is merge base for=
 both
>> sets of files.
>
> From git-merge-base(1):
>
> "When the history involves criss-cross merges, there can be more than
> one best common ancestor for two commits...When the --all option is
> not given, it is unspecified which best one is output."
>
> Perhaps you want to specify --all to git merge-base, and then perform
> additional checks on the output to select one yourself?

Ignore me, as it is likely I am just confused, but if we are merging
(a) and (b), I do not think (s) could be usable as a merge base; it
may be an ancestor of (a) but is not an ancestor of (b), no?

