Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACC1C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 15:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353182AbiFUPpN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 11:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353052AbiFUPpL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 11:45:11 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEBC2CDCB
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 08:45:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C174130898;
        Tue, 21 Jun 2022 11:45:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/I+2TGWcV8Kl
        0ysUwQ8JfctX+S+VwTDxGCER4bu/g20=; b=X3bZDJNYzH++iyMFF3rTRMBo8Y9y
        ajQi8TvNvvS7V/Le0FRWo+OacLF9QB+I72luKCc4xR5QGdM5bIpZYVcE/V+qh3HW
        WUUjPNetUO9Ejotvk6P3ceMI/C7uiUPGUvUY89r6Df/vxzWwDqQRB6EH/VzlswjL
        FY5nYVbtHiIUjCE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B7BF130896;
        Tue, 21 Jun 2022 11:45:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E4A84130895;
        Tue, 21 Jun 2022 11:45:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t3701: two subtests are fixed
References: <cf6aee9acadfb666de6b24b9ed63e1a65bfc009e.1655220242.git.git@grubix.eu>
        <nycvar.QRO.7.76.6.2206151649030.349@tvgsbejvaqbjf.bet>
        <165537087609.19905.821171947957640468.git@grubix.eu>
        <nycvar.QRO.7.76.6.2206181342200.349@tvgsbejvaqbjf.bet>
Date:   Tue, 21 Jun 2022 08:45:04 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2206181342200.349@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sat, 18 Jun 2022 13:55:24 +0200 (CEST)")
Message-ID: <xmqq8rpqja0v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1FDEAECC-F179-11EC-8517-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> in config.mak. Nothing else strikes me as potentially relevant.
>>
>> =C3=86var noticed this and has a better version of my patch, I think.
>
> So you did not find it utterly rude and presumptuous that somebody sent=
 a
> new iteration of your patch without even so much as consulting with you
> whether you're okay with this? I salute your forbearance, then.

I had an impression that these (wasn't there another one) were
independent discoveries and patching that happened at the same time.

> Besides, it is not really a better version of your patch. That would ha=
ve
> been:
>
> -- snip --
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 94537a6b40a..6d1032fe8ae 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -538,7 +538,9 @@ test_expect_success 'split hunk "add -p (edit)"' '
>  	! grep "^+15" actual
>  '
>
> -test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
> +test_lazy_prereq BUILTIN_ADD_I 'test_bool_env GIT_TEST_ADD_I_USE_BUILT=
IN true'
> +
> +test_expect_success BUILTIN_ADD_I 'split hunk "add -p (no, yes, edit)"=
' '
>  	test_write_lines 5 10 20 21 30 31 40 50 60 >test &&
>  	git reset &&
>  	# test sequence is s(plit), n(o), y(es), e(dit)

Prerequisite lets you skip. =20

This stops saying that "with scripted version 'add -p' does not
behave in the way we want to see, and we want to leave us a mental
note about it".  I do not know if that is what we want.

Once scripted version gets fully retired, it of course stops
mattering ;-)

> @@ -562,7 +564,7 @@ test_expect_success 'split hunk with incomplete lin=
e at end' '
>  	test_must_fail git grep --cached before
>  '
>
> -test_expect_failure 'edit, adding lines to the first hunk' '
> +test_expect_failure BUILTIN_ADD_I 'edit, adding lines to the first hun=
k' '

I am not sure if this is a good change, quite honestly.  With
s/failure/success/, perhaps, but not in the posted form.
