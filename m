Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154EDC433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 19:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392122AbiDUT6n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 15:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392109AbiDUT6i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 15:58:38 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3684D608
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:55:47 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CFB67119B1A;
        Thu, 21 Apr 2022 15:55:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3KWavYY1MH6s
        8OvdgrF7epT/9V0h4UEhFaYlRBJy4l8=; b=AcWe2H3yfxeLki48e5DEBMJvBHYp
        EGGK8B/HVoLzBPJGxX/M96/sMAACPzleQ128jfkxLreRTMJQ0VjkPsKkuxa2QTL3
        B1L4H1za/iT2HxvsIOreRDCrd/0n2jV64bNaX95733A5Jz/FKvT36urOZBfiNt/M
        pRiAV2SzmjwPgUw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7BD3119B19;
        Thu, 21 Apr 2022 15:55:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3315E119B18;
        Thu, 21 Apr 2022 15:55:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v2] CI: select CC based on CC_PACKAGE (again)
References: <patch-1.1-d89ad4d5b7c-20220421T130310Z-avarab@gmail.com>
        <patch-v2-1.1-92acf9420a9-20220421T174733Z-avarab@gmail.com>
        <xmqqzgkegspg.fsf@gitster.g>
        <220421.867d7i6ycr.gmgdl@evledraar.gmail.com>
        <xmqqlevygqqc.fsf@gitster.g>
Date:   Thu, 21 Apr 2022 12:55:45 -0700
In-Reply-To: <xmqqlevygqqc.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        21 Apr 2022 12:51:07 -0700")
Message-ID: <xmqqczhagqim.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 08C4B0F2-C1AD-11EC-8B76-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I'm happy to rephrase it however you'd like, but I'm a bit confused by
>> the "saw any mention in the proposed log message". I'm fairly sure
>> paragraph 2 onwards covers this, i.e. how linux-gcc's behavior is
>> changed (as it also regressed).
>
> Yeah, true, """Likewise for the linux-gcc job CC=3Dgcc-8 was changed
> to the implicit CC=3Dgcc, which would select GCC 9.4.0 instead of GCC
> 8.4.0.""" that you wrote is exactly about it.
>
> I was confused because immediately after that you said it was not a
> bug, so I dismissed it as not part or the real issue.  Perhaps
> striking that "not a bug" part may make it less confusing?  I dunno.

Also, the description above merely says we use gcc-9 instead of gcc-8,
without saying if that is a good change or not, which is another thing
that needs to be said.  In the larger context, if we aim to try different
compilers, we should know which other ones we are using, and if linux-gcc
job is meant to test gcc-8 (because we know there is another job
that tests gcc-9), the change was a bug.  But because you said it
was not a bug, it made it unclear if that is merely an observation
or it was pointing out our earlier mistake that should be corrected.
