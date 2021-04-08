Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E74C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 17:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C99D6610F8
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 17:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhDHRjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 13:39:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54817 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhDHRjC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 13:39:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 44DD112E326;
        Thu,  8 Apr 2021 13:38:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HvDDLXj4aIOa
        NvR47QG45VEmMUw=; b=Ir+EEn3iiDHUhFmgVotTrMiGSUrDmLt5v8bVkIH5FS41
        pJF8SAZtzjDzZQupVbYEErNAYvnsnSLU8H59R7ICMf5F39fhWz2ii76MPsvBgpIQ
        w1f+TOlFEmTmIUD9Ba4OWtJAQu/IXR1S9uJeifGKj1wTolMCYNorSX0NTGGGUDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Dk2u42
        Lt0diCX5LffJpTSVeT378WJ+vFFhdxAE6DDpb2boW+d9AOxVNBXdPogDOQyBfj1n
        vwlFIVQp5RYUfmzgZtGFMoDFPmX8CPk8LG7Ie1gkp5wjAX/w57BLS6PjMAtc0ww7
        QS516f9g85F8hiKfhwml0gjgLiGUnprpQvu9g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C56112E325;
        Thu,  8 Apr 2021 13:38:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1A03912E324;
        Thu,  8 Apr 2021 13:38:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Miriam Rubio <mirucam@gmail.com>, git@vger.kernel.org,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v2 1/4] run-command: make `exists_in_PATH()` non-static
References: <20210407173334.68222-1-mirucam@gmail.com>
        <20210407173334.68222-2-mirucam@gmail.com> <YG7naB1xepTSoeVk@danh.dev>
Date:   Thu, 08 Apr 2021 10:38:46 -0700
In-Reply-To: <YG7naB1xepTSoeVk@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Thu, 8 Apr 2021 18:22:39 +0700")
Message-ID: <xmqq4kggvfq1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 46401FF2-9891-11EB-8E89-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> On 2021-04-07 19:33:30+0200, Miriam Rubio <mirucam@gmail.com> wrote:
>> From: Pranit Bauva <pranit.bauva@gmail.com>
>>=20
>> Removes the `static` keyword from `exists_in_PATH()` function
>> and declares the function in `run-command.h` file.
>> The function will be used in bisect_visualize() in a later
>> commit.
>>=20
>> `exists_in_PATH()` and `locate_in_PATH()` functions don't
>> depend on file-local variables.
>
> Isn't this implementation detail? I think we shouldn't include them in
> the commit message.

I also was scratching my head about the statement.  What the
sentence says is not incorrect per-se, but it was not clear what the
relevance is to mention it.  I suspect that it may have wanted to
say "because they do not depend on any file scope statics to keep
state or base their computation on, it is safe to expose them as a
generally reusable public helper functions", and if so, "that's an
irrelevant implementation detail" would not be a valid objection
against mentioning it, but as written in the original, the sentence
as a mere statement of the fact does not seem to help readers.

>> +/**
>> + * Returns if a $PATH given by parameter is found or not (it is NULL)=
. This
>> + * function uses locate_in_PATH() function that emulates the path sea=
rch that
>> + * execvp would perform. Memory used to store the resultant path is f=
reed by
>> + * the function.
>
> I think this documentation focused too much in implementation detail,
> locate_in_PATH is still an internal linkage symbol at this stage.
> I think its mention here doesn't improve anything.

I totally agree with this.  What it does is more important.

If you have to describe how it does it, it is often because you need
to warn callers due to a curious implementation glitch (e.g. "this
uses 4-slot rotating internal buffer, so do not expect its return
value to stay stable after many calls").  In such a case, of course
describing how it does it is important to help callers avoid pitfalls,
but for this function, I do not see a need for that.
