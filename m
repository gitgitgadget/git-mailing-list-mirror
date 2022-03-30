Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E02AC433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 22:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbiC3WJC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 18:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbiC3WI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 18:08:59 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC293FBDB
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 15:07:13 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 66FFA11A91D;
        Wed, 30 Mar 2022 18:07:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kUJ3PAr7kIWI
        E7t9HwaZfZ2z8AzcY+2BaRgYxO4uI0g=; b=Z6zPAZnnXT+6gLsZ+28KIgyi90fm
        O5kKUiNqsVWP0vUGpv8Zjt0wI5DO/Nu82TDPXVjjs6x5NtIY8hWZWy+2ZwwJvRtM
        7uggx5QvNPEx+BDSqVlc2WoTEfB9o7UIdReK1nOf6M/iNwL2VX0+OusSMY1L9I4S
        UVgdqsIjAW4gSqU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E84D11A91A;
        Wed, 30 Mar 2022 18:07:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BF88D11A918;
        Wed, 30 Mar 2022 18:07:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v5] tracking branches: add advice to ambiguous refspec
 error
References: <pull.1183.v4.git.1648553209157.gitgitgadget@gmail.com>
        <pull.1183.v5.git.1648624810866.gitgitgadget@gmail.com>
        <220330.864k3fpo32.gmgdl@evledraar.gmail.com>
        <xmqqmth76use.fsf@gitster.g>
        <220330.86o81nta6k.gmgdl@evledraar.gmail.com>
Date:   Wed, 30 Mar 2022 15:07:10 -0700
In-Reply-To: <220330.86o81nta6k.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 30 Mar 2022 23:09:49 +0200")
Message-ID: <xmqqzgl75c35.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BFDA12C6-B075-11EC-BD98-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>>> +				 "To support setting up tracking branches, ensure that\n"
>>>> +				 "different remotes' fetch refspecs map into different\n"
>>>> +				 "tracking namespaces."),
>>>> +			       orig_ref,
>>>> +			       remotes_advice.buf
>>>> +			       );
>>>
>>> Nit: The usual style for multi-line arguments is to "fill" lines unti=
l
>>> you're at 79 characters, so these last three lines (including the ");=
")
>>> can all go on the "tracking namespaces" line (until they're at 79, th=
en
>>> wrap)>
>>
>> I didn't know about the magic "79" number.  It makes the resulting
>> source code extremely hard to read, though, while making it easier
>> to grep for specific messages.
>
> I'm referring to the "80 characters per line", but omitted the \n, but
> yeah, I should have just said 80.

No, what I meant was that you do not want the rule to be to cut *AT*
exactly the column whatever random rule specifies, which would
result in funny wrapping in the middle of the word, e.g.

        "To support setting up tracking branches, ensure that diff"
        "erent remotes' fetch refspecs map into different tracking"
        " namespaces."

and "at 79, then wrap" somehow sounded to me like that.  I do not
think you meant to imply that (instead, I think you meant to suggest
"wrap the line so that the string constant is not longer than 79
columns"), but it risks to be mistaken by new contributors.

FWIW, I'd actually prefer to see both the sources to be readable by
wrapping to keep the source code line length under certain limit
(the current guideline being 70-something), counting the leading
indentation, and at the same time keep it possible and easy to grep
messages in the source.

That requires us to notice when our code has too deeply nested,
resulting in overly indented lines, and maintain the readability
(refatoring the code may be a way to help in such cases).
