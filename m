Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE82C4BA24
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 19:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D83C24656
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 19:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t9ZcsRdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgBZT7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:59:49 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51969 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgBZT7s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 14:59:48 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ECFA9AC023;
        Wed, 26 Feb 2020 14:59:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KS0Q8drGCXVQzXWsSAxTHod6+io=; b=t9ZcsR
        dpx+z09R02CANMSqpfYayXblLBJGWydjvXX4xdMhb6nBE9zXBpFXYI0w1QO4bTuV
        2l7WfFkL9/RE/L1UTi97Q05JDPykVns4w+8SjzaDzcoPaP6jR/G6E0oEh6pKhykr
        f+B5wiW0vJWTWVY7Ts7m7C5ptG4+pSm0P4KKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HUN64SmA8mEXTimYkPr1NQK/4BuoiDeA
        Iiq28RYLmPXCXfBxwzFFgZMhwLbd+/d1DOmXfxX/9VIhZ2zIqlmRc2DYfkz+S9xI
        ZpxWHIYmXfTpHxAleEuqvLE6yH3iN4CZTZny3JwYU540THYB6n+vqeQMQ4dI5fuX
        +KbUU0W6j5k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E5480AC021;
        Wed, 26 Feb 2020 14:59:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1FA5BAC01E;
        Wed, 26 Feb 2020 14:59:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v7 6/6] Reftable support for git-core
References: <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
        <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
        <a622d8066c7fe27accc5101c3341c30bf706dae1.1582706986.git.gitgitgadget@gmail.com>
        <xmqq8skpjjyz.fsf@gitster-ct.c.googlers.com>
        <CAFQ2z_PikWsjFizg8=e9+YunkiaciD64BDks8=J55185NC5oQg@mail.gmail.com>
Date:   Wed, 26 Feb 2020 11:59:38 -0800
In-Reply-To: <CAFQ2z_PikWsjFizg8=e9+YunkiaciD64BDks8=J55185NC5oQg@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 26 Feb 2020 19:59:02 +0100")
Message-ID: <xmqqv9nti0gl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8684DE40-58D2-11EA-B95B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Wed, Feb 26, 2020 at 7:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>> > diff --git a/t/t0031-reftable.sh b/t/t0031-reftable.sh
>> > new file mode 100755
>> > index 00000000000..d35211c9db2
>> > --- /dev/null
>> > +++ b/t/t0031-reftable.sh
>
> Thanks for your careful review. Should we not start with the C code,
> though? I've written the reftable library to my best ability, but it
> hasn't been peer reviewed yet.

My intention was to let others, especially those from outside
Google, to comment before I do ;-)

>>         test_write_lines HEAD refs/heads/master >expect &&
>>
>> > +        git show-ref | cut -f2 -d" " > got &&
>>
>> Is the order of "show-ref" output guaranteed in some way?  Otherwise
>> we may need to make sure that we sort it to keep it stable.
>
> The ref iteration result is lexicographically ordered.
>
>> Without --show-head, HEAD should not appear in "git show-ref"
>> output, but the expected output has HEAD, which is puzzling.
>
> The HEAD symref is stored in reftable too, and to the reftable code
> it's just another ref. How should we refactor this? Shouldn't the
> files ref backend produce "HEAD" and then it's up to the show-ref
> builtin to filter it out?

After looking at show-ref.c, the answer is obvious, I would think.
for_each_ref() MUST NOT include HEAD in its enumeration, and that is
why the caller of for_each_ref() makes a separate call to head_ref()
when it wants to talk about HEAD.  As a backend-agnostic abstraction
layer, behaviour of functions like for_each_ref() should not change
depending on what ref backend is in use.

> The reflog entries are only removed if someone calls into the ref
> backend to expire them. Does that happen automatically?

"gc auto" may kick in in theory but not likely in these tests, so it
would be safe and sensible to know and check the expected number of
reflog entries in this test, I guess.

Thanks.
