Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A409F1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 16:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfFZQOt (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 12:14:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59045 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfFZQOt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 12:14:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0263516A884;
        Wed, 26 Jun 2019 12:14:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TtS84m3H1Vgp
        xBevrtReiSok34Y=; b=e+hg6dzeCkqd4KqSeyxEVkCbRvMopYG9qIZxP8MWVyvn
        WPAngzMHDJmN3Q+aW88SvymLnnSr8Kg++LV4F7LgrKudmcryCmS0eWkKbvq5jeoN
        8DkODH4kZ59Jtcn2WlY46WnSIXGwzAmP385fhvIeAlfHhiQpfaKR40/P4vFV/jI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=A6obYE
        obe0C45D7AHcr5cfTHCKM8GWobZ6lMsXNGjJQ7QVmOiu3X+v9ejS3jBTdvGtWb5O
        IQevUxNIpJ1rFEzwdaUZ2pARsM05/KJZ2L/oTEQoTizDSOLp7TOX1WJ5nJEpwi8T
        mYRILbZ5AeYC/dfQ7uH4d33f1Uemzk/M54SxY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EDB8D16A883;
        Wed, 26 Jun 2019 12:14:46 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 522E116A882;
        Wed, 26 Jun 2019 12:14:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        gitgitgadget@gmail.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [RFC/PATCH 5/7] grep: drop support for \0 in --fixed-strings <pattern>
References: <87r27u8pie.fsf@evledraar.gmail.com>
        <20190626000329.32475-6-avarab@gmail.com>
Date:   Wed, 26 Jun 2019 09:14:45 -0700
In-Reply-To: <20190626000329.32475-6-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 26 Jun 2019 02:03:27 +0200")
Message-ID: <xmqqftnwe32i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 83CAB672-982D-11E9-99CA-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change "-f <file>" to not support patterns with "\0" in them under
> --fixed-strings, we'll now only support these under --perl-regexp with
> PCRE v2.
>
> A previous change to Documentation/git-grep.txt changed the
> description of "-f <file>" to be vague enough as to not promise that
> this would work, and by dropping support for this we make it a whole
> lot easier to move away from the kwset backend, which a subsequent
> change will try to do.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---

This step, together with all others, looks sensibly justified to me
only when I wear tinted glasses that make me pretend that the final
goal is to promote pcre backend, which is much more important than
serving the current users.  When I remove the glasses, it smells
more like making excuses.

But as we saw discussed in the previous thread, I too think it is OK
to make 'Nobody would notice the updated behaviour of NUL in the
patterns' our working assumption and see if anybody screams---after
all we have to start somewhere to make progress.

A very good thing about this series is that it does *not* add a new
feature that people would miss, even if it went straight to 'master'
and to the next release.  All it does is to optimize differently and
changing the behaviour we assume nobody depends on. =20

It is easy enough to revert the whole thing if it turns out to be
problematic even in the worst case, and nobody would notice ;-)
