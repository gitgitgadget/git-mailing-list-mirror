Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A05C433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 17:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiGTRLQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 13:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiGTRLO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 13:11:14 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45AA4E863
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 10:11:12 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 15F541A425B;
        Wed, 20 Jul 2022 13:11:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+rg4Nw8P0Q9W
        hSiiMXr1NiGHUfQKUp1BtohqbiZ+rVc=; b=sw8XY7RfLCWeJdOZ4pc4dgp5ujwt
        9svXpswioWWkseYaaSwQ0Hcq3pAAePc8QNrHZO05T31jaEXsmr+/bIXu6Xj5fAJ8
        CEkjB0wvBeE9l15W7JTZd0Q3TGEB1/bQtH76oxjrhHc/IkMsMGlQQycgi1a6dMdp
        ZrtI01QNR70pF6c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0CD291A425A;
        Wed, 20 Jul 2022 13:11:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8D4031A4255;
        Wed, 20 Jul 2022 13:11:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 10/10] log tests: don't use "exit 1" outside a sub-shell
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
        <patch-10.10-9cedf0cb0e2-20220719T205710Z-avarab@gmail.com>
Date:   Wed, 20 Jul 2022 10:11:06 -0700
In-Reply-To: <patch-10.10-9cedf0cb0e2-20220719T205710Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 19 Jul
 2022 23:05:24
        +0200")
Message-ID: <xmqqmtd33e1h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F1D29420-084E-11ED-A795-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change an "exit 1" added in ac52d9410e5 (t4205: cover `git log
> --reflog -z` blindspot, 2019-11-19) to use "return 1" instead, which
> curiously was done in an adjacent test case added in the same commit.
>
> Using "exit 1" outside a sub-shell will cause the test framework
> itself to exit on failure, which isn't what we want to do here.
>
> This issue was spotted with the new
> "GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck" mode, i.e. that "git show"
> command leaks memory, and we'd thus "exit 1". Another implementation
> of "GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck" or "--invert-exit-code"
> might have intercepted the "exit 1", and thus hidden the underlying
> issue here, but we correctly distinguish the two.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t4205-log-pretty-formats.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Let's not bury this, which does not have to depend on the rest of
the patches in this series, at the end.  Instead have this a
separate topic, on which this topic may depend on.


>
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
.sh
> index e448ef2928a..0404491d6ee 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -156,7 +156,7 @@ test_expect_success 'NUL termination with --reflog =
--pretty=3Doneline' '
>  	for r in $revs
>  	do
>  		git show -s --pretty=3Doneline "$r" >raw &&
> -		cat raw | lf_to_nul || exit 1
> +		cat raw | lf_to_nul || return 1
>  	done >expect &&
>  	# the trailing NUL is already produced so we do not need to
>  	# output another one
