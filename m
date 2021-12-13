Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BE3C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 18:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbhLMSvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 13:51:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57679 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhLMSvR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 13:51:17 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A7BA811032F;
        Mon, 13 Dec 2021 13:51:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=94N2a6RcP6JR
        8Nb10DLr/eESajQB/zMcO1UXZ08XzPk=; b=c75bq/tshtZIIXp9DpZC8VWSdHBF
        VjDkoGz6EE6fu25iqkpV+LWtT/PGqPmJxHJM6c3J/HrohQzMZUMbBWc1q3Sd6kcj
        yh8UkVWqiNgcvtUaG/dHfIsxbk8sLuFqV3wdAE09bAn6UVmOZplXiWrjYdIPDCok
        j/w5acMJ4m+9koc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F56511032E;
        Mon, 13 Dec 2021 13:51:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 119D711032D;
        Mon, 13 Dec 2021 13:51:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/2] test-lib.sh: remove the now-unused
 "test_untraceable" facility
References: <cover-v2-0.2-00000000000-20211201T200801Z-avarab@gmail.com>
        <cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com>
        <patch-v3-2.2-a7fc794e20d-20211210T100512Z-avarab@gmail.com>
        <20211212163207.GA3400@szeder.dev>
        <211212.865yrtbvl1.gmgdl@evledraar.gmail.com>
        <20211212201441.GB3400@szeder.dev>
Date:   Mon, 13 Dec 2021 10:51:14 -0800
In-Reply-To: <20211212201441.GB3400@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Sun, 12 Dec 2021 21:14:41 +0100")
Message-ID: <xmqqo85kcp99.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A6B2DD3E-5C45-11EC-8F83-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> > Please do not remove BASH_XTRACEFD.  And especially not like this,
>> > without even mentioning it in the commit message.
>>=20
>> I can re-roll with an amended commit message that explicitly mentions
>> it
>
> It should rather be a separate patch...
>
>>, but that doesn't address your "please do not remove",
>>=20
>> Do you see reason to keep it at the end-state fo this series? E.g. a
>> counter-argument to
>> https://lore.kernel.org/git/211210.86pmq4daxm.gmgdl@evledraar.gmail.co=
m/?
>
> I don't see any argument pertinent to BASH_XTRACEFD in general in that
> email, of in favor of its removal in particular, and there are no
> valid arguments for its removal in earlier emails in this thread
> either.

If I am reading =C3=86var right, the argument is "dash would not be fixed
with BASH_XTRACEFD, so there needs another way that would work there,
and if the approach happens to work also for bash, then there is no
reason to use BASH_XTRACEFD", I think.

Now, if the way =C3=86var came up with to help shells with "-x" not to
contaminate their standard error stream that our test scripts want
to inspect is worse to write, understand, and maintain, compared to
the way we have been writing our tests that inspect their standard
errors, without having to worry about "-x" output thanks to the use
of BASH_XTRACEFD, it may make a regression to developer
productivity, but I am not sure if that is the case.

I think [1/2] of this same series can serve an example of how tests
must be tweaked to live under the world order without BASH_XTRACEFD?
Having to set and use a temporary file to capture the standard error
output and append to it upfront looks uglier than each individual
test locally capturing the standard error output from a single
invocation of a helper function, but it does not look _too_ bad to
me.  Can we find another example to argue for BASH_XTRACEFD, how
much it makes it easier to write tests that work even under "-x"?



