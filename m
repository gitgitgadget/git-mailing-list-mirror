Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2890C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 20:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiI1U1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 16:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiI1U1j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 16:27:39 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C78A9C36
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 13:27:38 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A0A201B77BB;
        Wed, 28 Sep 2022 16:27:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9MWl8NETEb42
        kVvqbPs0KUnKwbHDBmm6OJT0jmnbdck=; b=WT4Byvk8HfMCw8hcBRcmIRX5h218
        dv8wvXfpfagPG4AyGASiCvCiFmJsyaHvW7gOSkseTZQCABPzScVGzNY1Qc3iw3I2
        chN8oLegtyVC6CgfS5p1OIQY7tEmle+Ncws341w463MSDOb0b3dzVgUOxj580JAi
        VOYCqxixbWUArUk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9850B1B77BA;
        Wed, 28 Sep 2022 16:27:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 485A71B77B3;
        Wed, 28 Sep 2022 16:27:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 34/35] tests: start asserting that *.txt SYNOPSIS
 matches -h output
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
        <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <patch-v2-34.35-aef2b7356dc-20220928T082458Z-avarab@gmail.com>
Date:   Wed, 28 Sep 2022 13:27:33 -0700
In-Reply-To: <patch-v2-34.35-aef2b7356dc-20220928T082458Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 28 Sep
 2022 10:39:29
        +0200")
Message-ID: <xmqq7d1ns0qy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FC2BB466-3F6B-11ED-98AE-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> There's been a lot of incremental effort to make the SYNOPSIS output
> in our documentation consistent with the -h output,
> e.g. cbe485298bf (git reflog [expire|delete]: make -h output
> consistent with SYNOPSIS, 2022-03-17) is one recent example, but that
> effort has been an uphill battle due to the lack of regression
> testing.
>
> This adds such regression testing, we can parse out the SYNOPSIS
> output with "sed", and is turns out it's relatively easy to normalize
> it and the "-h" output to match on another.
>
> We now ensure that we won't have regressions when it comes to the list
> of commands in "expect_help_to_match_txt" below, and in subsequent
> commits we'll make more of them consistent.

Call that file as such, not a plain "list".  It might be useful to
have it in Documentation/ or somewhere outside the test script so
that people who work on making the match know where to look, as you
are updating CodingGuidelines for this change anyway.

> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -634,7 +634,8 @@ Writing Documentation:
> =20
>   A few commented examples follow to provide reference when writing or
>   modifying command usage strings and synopsis sections in the manual
> - pages:
> + pages. The two should match, see t/t0450-txt-doc-vs-help.sh for
> + (partial) regression testing.

> +test_expect_success 'setup: list of txt v.s. help is sorted' '
> +	sort -u list >list.sorted &&
> +	if ! test_cmp list list.sorted
> +	then
> +		BUG "please keep the command list sorted"
> +	fi
> +'

If the list becomes an external file, we probably could add a
"recommended pre-commit hook" for developers to reduce mistakes,
protecting us even from developers who forgets to run tests.

Or even a "clean" filter that automatically sorts, specified via the
attribute for that file, but that wouldn't protect us from careless
developers who are unlikely to enable the filter X-<.

> +while read builtin
> +do
> +...
> +done <builtins

Fun!


