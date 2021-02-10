Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A8AC433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 20:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F7564EDA
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 20:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhBJUPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 15:15:15 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63760 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhBJUPM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 15:15:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C46F3105C1F;
        Wed, 10 Feb 2021 15:14:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8Ia/smQU/Pvr3OgP1nI0Z/rv1js=; b=iOcTJ8
        jdwyUwwfPCqaYovM2pV+S0jwRpR7KkMyY0Ts7mBU1ewSQ+AgzsmqBEmZezhGGzDy
        fgSNbLhgzH30lCdq56PmxvvkvCH0odsRUs2WHStvuTeS6vFKKQG/SOHBHhtsNT56
        fe6pvo1LkEn6OeAlG1izaQe1quDN7wANSn2rU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xrMZWNU5AmQX7E9oYNQYS5DNSgG6r5oF
        rbJ+0IUh7ZtC5kwdUfmD7GVQ4HnYNEj5xXGkZgKJB7BiH7L2jQtfBIH8+AAj+YfR
        j0RxuNwWUIt0dVhei1UiJWOPT0A1zz4BIAtiKoOl6QT8U+wLfCbtgADS+kRaA6Rn
        RD7umrnOd4U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BDA37105C1E;
        Wed, 10 Feb 2021 15:14:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3ECAA105C1B;
        Wed, 10 Feb 2021 15:14:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Filippo Valsorda <valsorda@google.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: BUG: commit-reach.c:66: bad generation skip
References: <CA+2K_KotVrV=rjE6fcd_FfxxS0sewkywvO0EMVZdoHbSiqJTQw@mail.gmail.com>
        <CA+2K_KqH=Gn=Yx-UYzMBO+gZje3G3PJ_3-5HeO81wyZKvVwOSA@mail.gmail.com>
        <c19b6e23-96cd-fd0a-163d-826b46b51da0@gmail.com>
        <CA+2K_KqEzH7XmrHXd0Vniu+tBQpFwFnYPyzoj-kMhyN2NnoZFQ@mail.gmail.com>
        <962a2abc-6352-4d19-c39f-29f3c744f861@gmail.com>
Date:   Wed, 10 Feb 2021 12:14:24 -0800
In-Reply-To: <962a2abc-6352-4d19-c39f-29f3c744f861@gmail.com> (Derrick
        Stolee's message of "Wed, 10 Feb 2021 07:24:45 -0500")
Message-ID: <xmqq7dnf3ckf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92AD11E2-6BDC-11EB-B0BF-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 2/10/2021 7:18 AM, Filippo Valsorda wrote:
>> On Mon, Feb 8, 2021 at 3:26 AM Derrick Stolee <stolee@gmail.com> wrote:
>>> _This_ is interesting. I haven't heard of this problem happening
>>> in a released version of Git.
>>>
>>> I'm CC'ing Jonathan Nieder who recently saw this happening, but that
>>> was on a newer version than 2.30.0 with a topic that is not part
>>> of 2.30.0. But maybe the version shipped internally is versioned
>>> without extra information on top of the latest tag? (I see your
>>> @google.com email, which makes me think you have an internal version.)
>> 
>> Ah, the issue indeed first showed up as I was using the internal
>> version. I then installed mainline 2.30.0 to check that it reproduced
>> on the same local repository before reporting a bug.
>
> The mainline does have the BUG() statement, but it's really reflecting
> bad data in the commit-graph file. That data was written by the internal
> version and was not reset until you rewrote the file.

Thanks for digging, you two.  The above clearly explains the
symptom.

> Thanks, but let me know if it reproduces again. The bug should be fixed
> in ds/commit-graph-genno-fix [1], and I think the Google internal release
> has been rolled back until that branch is included.

The topic has been cooking in 'next' since Feb 3rd, so jrnieder's
team would probably have already picked it up.  It would be in
'master', together with the ak/corrected-commit-date topic it builds
on, not in a very distant future (typically a topic cooks in 'next'
for a week, unless it is a trivial typofix, doc updates, that sort
of low-impact change).

Thanks.
