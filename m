Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264DCC433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E142020756
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DDitqOOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgEOSA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 14:00:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51559 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgEOSA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 14:00:56 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A2844E192;
        Fri, 15 May 2020 14:00:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Cdi5qb3zpo8T
        /lsmEO2BRTlvfy0=; b=DDitqOOZz8Ku90Ub4xMp/d6wrbRyfTVJbia2FA14S/k6
        yaxXuSWKHEv93HvqI/z+MpH62PK67c5xmbl8xy9JTjkjAJgyQIIjuowX13aOHsey
        Enov0s1rhaJVtgjmdNgDaOdNGNvDdZA2haBooy9WnCvaEOJUxm2u1mE/PpeS4Dk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wnturk
        28S/Hx57MII5Oo/q1BpD43bNsevX6EAskgZziEE50BJd7Al5qf6EjV8dfG/t0uOw
        v1Bckckpo8O6UMIga79L73yJOy3eJNvBBjV7OIadfAlR2SoIWRziBWaeSkZ7/OWi
        AThd9MyO3UYVXH1if64JamiQUP39cy35NBGCA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 416C04E191;
        Fri, 15 May 2020 14:00:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE6554E18F;
        Fri, 15 May 2020 14:00:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, emaste@freebsd.org, sunshine@sunshineco.com
Subject: Re: [RFC PATCH v2] t4210: detect REG_ILLSEQ dynamically
References: <20200513111636.30818-1-carenas@gmail.com>
        <20200513180213.45866-1-carenas@gmail.com>
Date:   Fri, 15 May 2020 11:00:50 -0700
In-Reply-To: <20200513180213.45866-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 13 May 2020 11:02:13 -0700")
Message-ID: <xmqqy2ptkrhp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 032235F6-96D6-11EA-B104-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is https://github.com/git/git/runs/678964255 related to this change?

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> 7187c7bbb8 (t4210: skip i18n tests that don't work on FreeBSD, 2019-11-=
27)
> adds a REG_ILLSEQ prerequisite to avoid failures from the tests added w=
ith
> 4e2443b181 (log tests: test regex backends in "--encode=3D<enc>" tests,
> 2019-06-28), but hardcodes it to be only enabled for FreeBSD.
>
> Instead of hardcoding the affected platform, add a test using test-tool=
 to
> make sure it can be dynamically detected in other affected systems (lik=
e
> DragonFlyBSD or macOS), and while at it, enhance the tool so it can rep=
ort
> better on the cause of failure and be silent when needed.
>
> To minimize changes, it is assumed the regcomp error is of the right ty=
pe
> since we control the only caller, and is also assumed to affect both ba=
sic
> and extended syntax (only extended is tested, but both behave the same =
in
> all three affected platforms).
>
> The description of the first test which wasn't accurate has been correc=
ted,
> and unlike the original fix from 7187c7bbb8, all added entries to test-=
lib
> are no longer needed and only the 2 affected engines will have their te=
sts
> suppressed.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
> v2:
> - nicer variable names and hopefully easier to understand logic



>
>  t/helper/test-regex.c | 20 +++++++++++++++----
>  t/t4210-log-i18n.sh   | 45 ++++++++++++++++++++++++++++---------------
>  t/test-lib.sh         |  6 ------
>  3 files changed, 45 insertions(+), 26 deletions(-)
>
> diff --git a/t/helper/test-regex.c b/t/helper/test-regex.c
> index 10284cc56f..a4bd1f3a36 100644
> --- a/t/helper/test-regex.c
> +++ b/t/helper/test-regex.c
> @@ -41,16 +41,21 @@ int cmd__regex(int argc, const char **argv)
>  {
>  	const char *pat;
>  	const char *str;
> -	int flags =3D 0;
> +	int ret, silent =3D 0, flags =3D 0;
>  	regex_t r;
>  	regmatch_t m[1];
> +	char errbuf[64];
> =20
>  	if (argc =3D=3D 2 && !strcmp(argv[1], "--bug"))
>  		return test_regex_bug();
>  	else if (argc < 3)
>  		usage("test-tool regex --bug\n"
> -		      "test-tool regex <pattern> <string> [<options>]");
> +		      "test-tool regex [--silent] <pattern> <string> [<options>]");
> =20
> +	if (!strcmp(argv[1], "--silent")) {
> +		silent =3D 1;
> +		argv++;
> +	}
>  	argv++;
>  	pat =3D *argv++;
>  	str =3D *argv++;
> @@ -67,8 +72,15 @@ int cmd__regex(int argc, const char **argv)
>  	}
>  	git_setup_gettext();
> =20
> -	if (regcomp(&r, pat, flags))
> -		die("failed regcomp() for pattern '%s'", pat);
> +	ret =3D regcomp(&r, pat, flags);
> +	if (ret) {
> +		if (!silent) {
> +			regerror(ret, &r, errbuf, sizeof(errbuf));
> +			die("failed regcomp() for pattern '%s' (%s)",
> +				pat, errbuf);
> +		} else
> +			return 1;
> +	}
>  	if (regexec(&r, str, 1, m, 0))
>  		return 1;
> =20
> diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
> index c3792081e6..8fccb83020 100755
> --- a/t/t4210-log-i18n.sh
> +++ b/t/t4210-log-i18n.sh
> @@ -10,6 +10,12 @@ latin1_e=3D$(printf '\351')
>  # invalid UTF-8
>  invalid_e=3D$(printf '\303\50)') # ")" at end to close opening "("
> =20
> +if test_have_prereq GETTEXT_LOCALE &&
> +	! LC_ALL=3D$is_IS_locale test-tool regex --silent $latin1_e $latin1_e=
 EXTENDED
> +then
> +	have_reg_illseq=3D1
> +fi
> +
>  test_expect_success 'create commits in different encodings' '
>  	test_tick &&
>  	cat >msg <<-EOF &&
> @@ -61,33 +67,40 @@ do
>  	prereq=3D
>  	if test $engine =3D "perl"
>  	then
> -		prereq=3D"PCRE"
> -	else
> -		prereq=3D""
> +		prereq=3DPCRE
>  	fi
>  	force_regex=3D
>  	if test $engine !=3D "fixed"
>  	then
> -	    force_regex=3D.*
> +		force_regex=3D.*
> +	fi
> +
> +	if test -z "$have_reg_illseq" ||
> +		test $engine =3D "fixed" || test $engine =3D "perl"
> +	then
> +		test_expect_success !MINGW,GETTEXT_LOCALE,$prereq "-c grep.patternTy=
pe=3D$engine log --grep searches in log output encoding (latin1 + locale)=
" "
> +			cat >expect <<-\EOF &&
> +			latin1
> +			utf8
> +			EOF
> +			LC_ALL=3D$is_IS_locale git -c grep.patternType=3D$engine log --enco=
ding=3DISO-8859-1 --format=3D%s --grep=3D\"$force_regex$latin1_e\" >actua=
l &&
> +			test_cmp expect actual
> +		"
>  	fi
> -	test_expect_success !MINGW,!REGEX_ILLSEQ,GETTEXT_LOCALE,$prereq "-c g=
rep.patternType=3D$engine log --grep does not find non-reencoded values (=
latin1 + locale)" "
> -		cat >expect <<-\EOF &&
> -		latin1
> -		utf8
> -		EOF
> -		LC_ALL=3D\"$is_IS_locale\" git -c grep.patternType=3D$engine log --e=
ncoding=3DISO-8859-1 --format=3D%s --grep=3D\"$force_regex$latin1_e\" >ac=
tual &&
> -		test_cmp expect actual
> -	"
> =20
>  	test_expect_success !MINGW,GETTEXT_LOCALE,$prereq "-c grep.patternTyp=
e=3D$engine log --grep does not find non-reencoded values (latin1 + local=
e)" "
>  		LC_ALL=3D\"$is_IS_locale\" git -c grep.patternType=3D$engine log --e=
ncoding=3DISO-8859-1 --format=3D%s --grep=3D\"$force_regex$utf8_e\" >actu=
al &&
>  		test_must_be_empty actual
>  	"
> =20
> -	test_expect_success !MINGW,!REGEX_ILLSEQ,GETTEXT_LOCALE,$prereq "-c g=
rep.patternType=3D$engine log --grep does not die on invalid UTF-8 value =
(latin1 + locale + invalid needle)" "
> -		LC_ALL=3D\"$is_IS_locale\" git -c grep.patternType=3D$engine log --e=
ncoding=3DISO-8859-1 --format=3D%s --grep=3D\"$force_regex$invalid_e\" >a=
ctual &&
> -		test_must_be_empty actual
> -	"
> +	if test -z "$have_reg_illseq" ||
> +		test $engine =3D "fixed" || test $engine =3D "perl"
> +	then
> +		test_expect_success !MINGW,GETTEXT_LOCALE,$prereq "-c grep.patternTy=
pe=3D$engine log --grep does not die on invalid UTF-8 value (latin1 + loc=
ale + invalid needle)" "
> +			LC_ALL=3D$is_IS_locale git -c grep.patternType=3D$engine log --enco=
ding=3DISO-8859-1 --format=3D%s --grep=3D\"$force_regex$invalid_e\" >actu=
al &&
> +			test_must_be_empty actual
> +		"
> +	fi
>  done
> =20
>  test_done
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 0ea1e5a05e..81473fea1d 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1454,12 +1454,6 @@ case $uname_s in
>  	test_set_prereq SED_STRIPS_CR
>  	test_set_prereq GREP_STRIPS_CR
>  	;;
> -FreeBSD)
> -	test_set_prereq REGEX_ILLSEQ
> -	test_set_prereq POSIXPERM
> -	test_set_prereq BSLASHPSPEC
> -	test_set_prereq EXECKEEPSPID
> -	;;
>  *)
>  	test_set_prereq POSIXPERM
>  	test_set_prereq BSLASHPSPEC
