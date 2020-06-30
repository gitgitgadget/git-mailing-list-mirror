Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C87C433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 22:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A6C20724
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 22:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ecjUptki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgF3WG0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 18:06:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52263 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgF3WG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 18:06:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D4BB9E76AD;
        Tue, 30 Jun 2020 18:06:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vgqIUcSykyv+vOqirHH3WnI6tvU=; b=ecjUpt
        kiUOq/MBZy2fi84cz2anv5Lz6ccfGHs9mUu/21Cl8JDwUV3Eo9ru+46gyUiU6qei
        Q5E39OoppYhcXjgCEzFa4NBRdLrf1QBxzoHLwtV1dQ/oLsjGhz3VyUnX6vyLIqBr
        gc+pgBAtFi7rmAXajOI7eA93gMiYs2uxm4zsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ELrvTDAoZYVVfHfcAOVmu3+xmLzgFTYu
        oBEekpxBNZDeJgqJ7fC0dWfzcfOb5Q0/HcJHpda/1fWKDgc8QwcRq+XFEdINo62Y
        ekJdIr2UxK2yP0naeBIlZKh/oy7gfb8bHpl+nQJyOlJSeq2jtsQGDflYDaZu6Lh7
        hcHmDxD1nkM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CB63FE76AC;
        Tue, 30 Jun 2020 18:06:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 20696E76A9;
        Tue, 30 Jun 2020 18:06:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/5] t3701: stop using `env` in force_color()
References: <cover.1593529394.git.liu.denton@gmail.com>
        <67d5b93fdaab7f73f352293372ee3d71fb7c1409.1593529394.git.liu.denton@gmail.com>
        <CAPig+cTYJwDL_uGfSR0OmU4fYANbqQ5jLkyN29WXDvq6gWG_Zg@mail.gmail.com>
Date:   Tue, 30 Jun 2020 15:06:18 -0700
In-Reply-To: <CAPig+cTYJwDL_uGfSR0OmU4fYANbqQ5jLkyN29WXDvq6gWG_Zg@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 30 Jun 2020 17:48:44 -0400")
Message-ID: <xmqqlfk4dx9h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED836FA0-BB1D-11EA-97A5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Jun 30, 2020 at 11:03 AM Denton Liu <liu.denton@gmail.com> wrote:
>> In a future patch, we plan on making the test_must_fail()-family of
>> functions accept only git commands. Even though force_color() wraps an
>> invocation of `env git`, test_must_fail() will not be able to figure
>> this out since it will assume that force_color() is just some random
>> function which is disallowed.
>>
>> Instead of using `env` in force_color() (which does not support shell
>> functions), export the environment variables in a subshell. Write the
>> invocation as `force_color test_must_fail git ...` since shell functions
>> are now supported.
>>
>> Signed-off-by: Denton Liu <liu.denton@gmail.com>
>> ---
>> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
>> @@ -31,7 +31,13 @@ diff_cmp () {
>>  force_color () {
>> -       env GIT_PAGER_IN_USE=true TERM=vt100 "$@"
>> +       (
>> +               GIT_PAGER_IN_USE=true &&
>> +               export GIT_PAGER_IN_USE &&
>> +               TERM=vt100 &&
>> +               export TERM &&
>> +               "$@"
>> +       )
>>  }
>
> I'm having trouble understanding why this function was transformed the
> way it was. I presume the subshell is to ensure that the variable
> assignments don't escape the function context since you're dropping
> 'env', however, it seems the following would be simpler:
>
>     force_color ()  {
>         (GIT_PAGER_IN_USE=true TERM=vt100 "$@")
>     }
>
> Or, is there something non-obvious going on that I'm missing?

Denton wants to be able to write

	force_color test_must_fail git foo blah

The only known kind of POSIX breaking behaviour by some shells makes
the assignment persist after the "$@" returns, and the subshell
would be a good way to protect the caller of force_color from the
effect of the assignment leaking, so if we only care about that
known breakage, both Denton's and your simplification should work
OK, but it is probably clearer to see that we are *not* relying on
any one-shot environment assignment at all in Denton's version.

I'd list two variables on a single export command, though ;-)

> By the way, I'm wondering if the subshell deserves an in-code comment.
> Whereas, we have somewhat settled upon the idiom 'test_must_fail env
> FOO=bar ...' when we need to make sure variable assignments don't
> escape the local context -- since 'FOO=bar test_must_fail ...' doesn't
> make that guarantee under all shells -- the use of a subshell here to
> achieve the same (if I'm understanding correctly) is not nearly so
> obvious. The non-obviousness is due to "$@" being abstract -- someone
> reading the code won't necessarily realize that the first element of
> "$@" might be a shell function, thus would not necessarily understand
> the use of a subshell.

Probably.
