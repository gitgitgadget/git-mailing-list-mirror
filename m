Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0446CC433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 02:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C362964ED1
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 02:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhBYCfS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 21:35:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57596 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbhBYCfP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 21:35:15 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EF06AA7AC;
        Wed, 24 Feb 2021 21:34:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ggdyl96n2b7q
        a0N5eW3rLGMMh10=; b=t2HliHU9KIeGGzgTyyeLVYtSgudcF/nvy6phsZM9RIwH
        HXXswnIZhSa1yaysFZSfIBqU8hR+CMV8f0yFFrgv/7/cJMNtEojIUOkjVC7l539f
        WwR0cjQ0rWmxHd6fhfHwzWW4X3iVjfYNKq1rsVoZXwdWWPWwrc2EHvq/OzHNEWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tCBxcC
        avA7AcavG5pAbp6Yn5fM0KWqvUS25jF1tTXbUV+dBU+9MfVwrBw2Af8DfD9st6HH
        BN/s1jXL47j5JZ0ML3vWyIwRNN+NRdKjsOLBgK1k7eFfktw+tRKx5TP5ImwSU0eN
        c1f00dbYqBL0kRZzXskyrj0khuH55C6aVusmg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66700AA7AB;
        Wed, 24 Feb 2021 21:34:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B0DBFAA7AA;
        Wed, 24 Feb 2021 21:34:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 04/10] diffcore-rename: extend cleanup_dir_rename_info()
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
        <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
        <f7bdad78219de6819d0403f8957e9a0c8b4218bc.1614123848.git.gitgitgadget@gmail.com>
        <87v9ag7uyx.fsf@evledraar.gmail.com>
Date:   Wed, 24 Feb 2021 18:34:30 -0800
In-Reply-To: <87v9ag7uyx.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 25 Feb 2021 03:16:22 +0100")
Message-ID: <xmqqim6gyix5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FD93F030-7711-11EB-93D4-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But in this case where we've gone through stages of changing code that'=
s
> never been used I think we're making it harder to read than not. I'd
> prefer just to see this cleanup_dir_rename_info() function pop into
> existence in 05.

I had a similar impression on parts of the earlier series where a
new helper without users were given as a standalone patch.  I found
it a bit disorienting.

> Style nit/preference: I think code like this is easier to read as:
>
>     if (simple-case) {
>         blah
>         blah;
>         return;
>     }
>     complex_case;
>
> Than not having the "return" and having most of the interesting logic i=
n
> an indented "else" block. Or maybe just this on top of the whole thing
> (a -w diff, hopefully more readable, but still understandable):

Yes, that is also a good tip for a more readable patch, but that
applies only for if/else at the end of the function.

In general, formulating the condition so that the smaller body comes
first for "if" and the larger one goes to the body of "else" would
make the if/else easier to understand, as you can often hold the
condition and smaller body just before "else" in your head, and
after clearly understanding that part, it becomes easier to
concentrate on the other side, i.e. "now we know what happens if the
condition is true, what about the other case?  Let's read on ...".

Thanks.
