Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A19AC433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 20:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbhLQUtD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 15:49:03 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57625 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237169AbhLQUtC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 15:49:02 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F71B16A2BC;
        Fri, 17 Dec 2021 15:49:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=23YtD1Kbn6Mnm5dFaHAsbAicZ
        NSa/dCd8jDAE7iMmWk=; b=s8KSjcGVqj3x/FR3co7LRrdi4Xy8pnBb9oRJvmE/x
        /QdArz2cS2fViRcekQNccwsgnuvvesziN4MEZbolD2XVxhxPeQ0Z8GqUzZSbFTU6
        WY+fBDaXUmHHPRIlgyRG4SIpKJJlcFmljbfhZxuCLLyRZtrWoNqhAp5nPUxMmycO
        aY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7835916A2BA;
        Fri, 17 Dec 2021 15:49:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D5D3D16A2B7;
        Fri, 17 Dec 2021 15:48:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t4204 is not sanitizer clean at all
References: <20211213220327.16042-1-jerry@skydio.com>
        <20211213220327.16042-2-jerry@skydio.com> <xmqqee6dz5s9.fsf@gitster.g>
        <xmqqtuf86t7z.fsf_-_@gitster.g>
        <211217.861r2bal75.gmgdl@evledraar.gmail.com>
Date:   Fri, 17 Dec 2021 12:48:57 -0800
Message-ID: <xmqqk0g32c06.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C21C0BDA-5F7A-11EC-89A1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This change looks good to me.
>
> FWIW this is not a mistake on my part, but something I'm perfectly awar=
e
> of. I don't consider it to be "brekage".
>
> We have plenty of place in the test suite where we hide exit codes on
> the LHS of a pipe, or where we call a function that doesn't &&-chain it=
s
> git invocations.
>
> In those cases we can and usually will "succeed" under LSAN, because it
> allows the program to emit its full output, and will abort() at the ver=
y
> end.

But pipes do not hide ONLY deaths by sanitizer.  And by relying on
the presence of pipe hiding deaths of git tools to mark the script
sanitizer-clean, the TEST_PASSES_SANITIZE_LEAK=3Dtrue line adds an
unnecessary road-block for those who are cleaning up the "git whose
crash are hidden by being on the left hand side of the pipe"
pattern.

I do not know what to call it if not "breakage".

