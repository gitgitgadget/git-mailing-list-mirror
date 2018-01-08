Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D599E1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 18:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755915AbeAHSpT (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 13:45:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50753 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755867AbeAHSpR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 13:45:17 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 25942D6C6E;
        Mon,  8 Jan 2018 13:45:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pZQVFN7Nzn+p
        d+UFx1H0RVcGmys=; b=STGuv6hM4rQ8AAtdkR6h9ES0bm/UaOegKWaC3JqyQNar
        b2xzlwJN/OEmKSR/4RxVlzybj8DE3wKHuAGy3L2S23PIiYHPQwTyb2pB3ewwJVsx
        zdjbx5+PR5UHSu/6B34h8sw/gF+JebOCwnmYmm2l/unlLkXevhuRVILNXthyZ5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EpWwb+
        k5wqWw5pynAD42g0eNROzX/n7IP43cU4ZhnKbN9irWdVjPaUpkwq9/R1kYbrVf99
        GnJuPfnvq5mMssCP6ML1W61lg5gEraa1Webz19z8j6p3kHCdUXbIVn2Qndhk/H22
        A4lSPGoqQ5TIPKvqZ8iUS9N/N3gdwcjJfTzLM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D013D6C6D;
        Mon,  8 Jan 2018 13:45:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 694EBD6C6C;
        Mon,  8 Jan 2018 13:45:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Thomas Adam <thomas@xteddy.org>
Subject: Re: [PATCH v3 3/3] send-email: add test for Linux's get_maintainer.pl
References: <1515177413-12526-1-git-send-email-git@matthieu-moy.fr>
        <1515407674-5233-1-git-send-email-git@matthieu-moy.fr>
        <1515407674-5233-3-git-send-email-git@matthieu-moy.fr>
Date:   Mon, 08 Jan 2018 10:45:13 -0800
In-Reply-To: <1515407674-5233-3-git-send-email-git@matthieu-moy.fr> (Matthieu
        Moy's message of "Mon, 8 Jan 2018 11:34:34 +0100")
Message-ID: <xmqqzi5o8a12.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 10677FB8-F4A4-11E7-8873-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <git@matthieu-moy.fr> writes:

> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> We had a regression that broke Linux's get_maintainer.pl. Using
> Mail::Address to parse email addresses fixed it, but let's protect
> against future regressions.
>
> Note that we need --cc-cmd to be relative because this option doesn't
> accept spaces in script names (probably to allow --cc-cmd=3D"executable
> --option"), while --smtp-server needs to be absolute.
>
> Patch-edited-by: Matthieu Moy <git@matthieu-moy.fr>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Matthieu Moy <git@matthieu-moy.fr>
> ---
> Change since v2:
>
> * Mention relative Vs absolute path in commit message.
>
> * Remove useless "chmod +x"
>
> * Remove useless double quotes
>
>  t/t9001-send-email.sh | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Thanks, both. =20

"while --smtp-server needs to be ..." gave a "Huh?" for somebody who
weren't familiar with the discussion that led to the addition of
that note (i.e. "unlike a near-by test that passes a full-path
$(pwd)/fake.endmail to --smtp-server" would have helped); it is not
a big deal, though.

Let's merge this to 'next' and try to merge in the first batch post
the release.

Thanks.



> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 4d261c2..a06e5d7 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -172,6 +172,25 @@ test_expect_success $PREREQ 'cc trailer with vario=
us syntax' '
>  	test_cmp expected-cc commandline1
>  '
> =20
> +test_expect_success $PREREQ 'setup fake get_maintainer.pl script for c=
c trailer' "
> +	write_script expected-cc-script.sh <<-EOF
> +	echo 'One Person <one@example.com> (supporter:THIS (FOO/bar))'
> +	echo 'Two Person <two@example.com> (maintainer:THIS THING)'
> +	echo 'Third List <three@example.com> (moderated list:THIS THING (FOO/=
bar))'
> +	echo '<four@example.com> (moderated list:FOR THING)'
> +	echo 'five@example.com (open list:FOR THING (FOO/bar))'
> +	echo 'six@example.com (open list)'
> +	EOF
> +"
> +
> +test_expect_success $PREREQ 'cc trailer with get_maintainer.pl output'=
 '
> +	clean_fake_sendmail &&
> +	git send-email -1 --to=3Drecipient@example.com \
> +		--cc-cmd=3D./expected-cc-script.sh \
> +		--smtp-server=3D"$(pwd)/fake.sendmail" &&
> +	test_cmp expected-cc commandline1
> +'
> +
>  test_expect_success $PREREQ 'setup expect' "
>  cat >expected-show-all-headers <<\EOF
>  0001-Second.patch
