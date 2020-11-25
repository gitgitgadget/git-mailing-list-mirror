Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C865C56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 19:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C13820857
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 19:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u5Xf4nIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgKYTu2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 14:50:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64959 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbgKYTu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 14:50:28 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC0AC8CC0E;
        Wed, 25 Nov 2020 14:50:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GqEFQJo1MbMW
        Nq5wtZ8x0B1Rviw=; b=u5Xf4nIkjrQY6kctlLMkF85BkGHDFWUv2cYJvc+JZdEJ
        F493SI7YOFrKSVFGeDwimiuVBxQOwArYLcd2YzH/r8rsNW5rHOX1q0YgC6oZv8NI
        BvQg5rZYnqNe0d+LdIieBsdCsn2yKCB/zOLbYw/pBcN+a6tB1nSIT2rk0FRZLUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WzXhc9
        p7yscwKaCkD1TUc5bR4BwQi+1zloXUxa+20FHshKECuoCV9nmy6CW4Uz/IkhYHIe
        bjpSRfmebzt05I8n0jqWVDTlMmNPGRjCoVq4Ffm5MkBLuu+LLSOFcOl2+IrvIWy+
        BytfPq9iEJqY/eSOLsNrBo5tTGJoYCBnwwxug=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D14968CC0D;
        Wed, 25 Nov 2020 14:50:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 50E1E8CC0C;
        Wed, 25 Nov 2020 14:50:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 2/2] config: allow specifying config entries via
 envvar pairs
References: <cover.1606214397.git.ps@pks.im>
        <97740ada840a1e2f151003e695de9f2efa5a7e62.1606214397.git.ps@pks.im>
        <87360xq08k.fsf@evledraar.gmail.com>
Date:   Wed, 25 Nov 2020 11:50:24 -0800
In-Reply-To: <87360xq08k.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 25 Nov 2020 10:00:59 +0100")
Message-ID: <xmqqzh35dxmn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7603692C-2F57-11EB-ABDA-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Nov 24 2020, Patrick Steinhardt wrote:
>
> ...some more feedback.
>
>> +GIT_CONFIG_COUNT,GIT_CONFIG_KEY_<n>,GIT_CONFIG_VALUE_<n>::
>> +	If GIT_CONFIG_COUNT is set to a positive number, all environment pai=
rs
>> +	GIT_CONFIG_KEY_<n> and GIT_CONFIG_VALUE_<n> up to that number will b=
e
>> +	added to the process's runtime configuration. The config pairs are
>> +	zero-indexed. Any missing key or value is treated as an error. An em=
pty
>> +	GIT_CONFIG_COUNT is treated the same as GIT_CONFIG_COUNT=3D0, namely=
 no
>> +	pairs are processed. Config entries set this way have command scope,
>> +	but will be overridden by any explicit options passed via `git -c`.
>
> Perhaps work in some/all of some version of these:
>
>  - There's also a GIT_CONFIG_PARAMETERS variable, which is considered
>    internal to Git itself. Users are expected to set these.

"are", or "are not"?  I think it is the latter, and if so I agree
that it is a good thing to say here or somewhere nearby.

>    --> I.e. even if we're not going to support some format for
>    --> GIT_CONFIG_PARAMETERS document what it is.

My preference is to keep it an implementation detail, especially if
we were to be adding this new thing as a documented feature, so
documenting it beyond its existence and nature is counterproductive.

>  - This is analogous to the pre-receive `GIT_PUSH_OPTION_*` variables
>    (see linkgit:githooks[5]), but unlike those the `-c` option to
>    linkgit:git(1) does not set `GIT_CONFIG_*`.

I am slightly negative about this.  It would be an irrelevant noise
to readers who are interested in environment variables that affect
how "git config" works (which is what this section is about).  Also
for those who want to learn about GIT_PUSH_OPTION variable, I do not
think they would look for it in "git config" documentation and check
its ENVIRONMENT section.  It would be much more likely for them to
look for them in the documentation for receive-pack or push (and then
redirected to githooks doc).

>  - Saying "command scope" here I think is wrong/misleading. If I didn't
>    know how this worked I'd expect the first git process to see it to
>    delete it from the env, so e.g. the "fetch" command would see it, bu=
t
>    not the "gc" it spawned (different commands). Maybe just say "the
>    scope of these is as with other GIT_* environment variables, they'll
>    be inherited by subprocesses".

OK.

> Re the indent question to make the diff more readable question Junio
> had: could set some "do we have this or that" variables here to not
> reindent the existing code, but maybe not worth the effort...

I was leaving a clue for those who want to futz with "diff"
algorithm that this change can be a good test case for their
improvement.

I didn't mean that as a suggestion to help "diff" produce a better
result by twisting code.  We should not tweak our code to please
"git show" output.  Tweaking code to please "cat/less $file" output
is very much welcome, though.

Thanks.
