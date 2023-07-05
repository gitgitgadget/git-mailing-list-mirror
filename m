Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73368EB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 19:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjGETxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 15:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjGETxU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 15:53:20 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019141989
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 12:53:16 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7FB7233009;
        Wed,  5 Jul 2023 15:53:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RRLaB6rhPyTG
        EmBCWMw9LWIHrgnE6GNtNZJykPoMQ8g=; b=BC8m5IzQExc1HJkrASxyzlVIwoSJ
        IvWsFD1xuSgcq0VwUh6NHtiDMMF7Mz0EzV3CRlF26wjAjijq2YoHp+D2jYyg6mS7
        rMh9kBG7ae0khNbcer55IrSMTHheyclR7k4myShMZOQbthTUhUgI40rFRdcJVVzu
        x0xlTf/NFkhc6fs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 77B0633008;
        Wed,  5 Jul 2023 15:53:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E9D8433007;
        Wed,  5 Jul 2023 15:53:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3] t0091-bugreport.sh: actually verify some content of
 report
References: <AN0heSrMCnygWUC5Sh1UA9v2JGtjcxYDKPFE0xUPddGEW29c3w@mail.gmail.com>
        <20230705183532.3057433-1-martin.agren@gmail.com>
Date:   Wed, 05 Jul 2023 12:53:11 -0700
In-Reply-To: <20230705183532.3057433-1-martin.agren@gmail.com> ("Martin
        =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 5 Jul 2023 20:35:27 +0200")
Message-ID: <xmqqv8eyyw2g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 932E8D4C-1B6D-11EE-B928-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> +test_expect_success 'create a report' '
> +	git bugreport -s format &&
> +	test_file_not_empty git-bugreport-format.txt
> +'

OK.

> +test_expect_success 'report contains wanted template (before first sec=
tion)' '
> +	sed -ne "/^\[/q;p" git-bugreport-format.txt >actual &&
> +	cat >expect <<-\EOF &&
> +	Thank you for filling out a Git bug report!
> +	Please answer the following questions to help us understand your issu=
e.
> +
> +	What did you do before the bug happened? (Steps to reproduce your iss=
ue)
> +
> +	What did you expect to happen? (Expected behavior)
> +
> +	What happened instead? (Actual behavior)
> +
> +	What'\''s different between what you expected and what actually happe=
ned?
> +
> +	Anything else you want to add:
> +
> +	Please review the rest of the bug report below.
> +	You can delete any lines you don'\''t wish to share.
> +
> +
> +	EOF
> +	test_cmp expect actual
> +'

I am not sure about the value of the bit-for-bit test here, but OK.
It is not like we will be changing this piece of text every week.

> +test_expect_success 'sanity check "System Info" section' '
> +	test_when_finished rm -f git-bugreport-format.txt &&
> +
> +	sed -ne "/^\[System Info\]$/,/^$/p" <git-bugreport-format.txt >system=
 &&
> +
> +	# The beginning should match "git version --build-info" verbatim,
> +	# but rather than checking bit-for-bit equality, just test some basic=
s.
> +	grep "git version [0-9]." system &&
> +	grep "shell-path: ." system &&
> +
> +	# After the version, there should be some more info.

Do you want to assert the "after" part?  "grep" alone does not do
anything of that sort.

> +	# This is bound to differ from environment to environment,
> +	# so we just do some rather high-level checks.
> +	grep "uname: ." system &&
> +	grep "compiler info: ." system
>  '

Don't we at least want to anchor all these patterns with "^" or
something?

Alternatively, since we do not expect the values of the fields are useful
at all, perhaps doing something like this

    sed -n -e '/^\[System Info\]/,/\[Enabled Hooks]/s/^\([^:]*):.*/\1/p' =
>names

to ensure that we have the fields we expect in the output makes more sens=
e?

I notice that "git version:" does not have its value on its line.
Isn't it a bug we would rather fix before writing this "sanity check"
test, I have to wonder.

Thanks.
