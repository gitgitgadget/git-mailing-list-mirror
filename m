Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DBA1DE2B4
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743533811; cv=none; b=Wdc0tPyNW64p5Q50fwZWSmik5BiextuU+/7CX7WBTitCyKL4XR6gtQGEDN5sTQgEr0brqe2cQ48/mXT1wdlIlZdoGjrzXiml+OHILbkNizRW3KcPx2XddCDlSvgwS5+EsnVbaU22BaGAIwlKOqpeAA7wb1U64qtNO0deA+Wh4SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743533811; c=relaxed/simple;
	bh=0yZcYe8pmVw/nnOwzJEDk3tdyBLzfyxQmiIrek5AYcs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FO8W5OOKtz7YuQC3Og2uS4ruvHVMOeFg8sjkBIgcZVhUCjgBu+9m/T2FWb3hhF7Oky77p9fcz8IML9RUfNwOqCrpyMuNqij2CZRy/H4ZbWsl58BJYNQiGq67FU9ig5M6iSvK25Nu3M+9FqWV10lApXYIxITchcAc0Jwf2SM8hzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ASi7WO9A; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ASi7WO9A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743533802; x=1744138602;
	i=johannes.schindelin@gmx.de;
	bh=/MOjZPQLBHdND7bQ3c3p9KeiCP/GYOGKXjw/KAkJJkE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ASi7WO9AomOd4qQUjzhqmWZEGG1votknk6BtuI9cgv8IpgR1OFLP8rXZxUK+res2
	 nWpwW2oX7y09yRIig0F3CbjqW5hEi3rNsQKv1IqN5opSNqWHG8DAHIP11Y0dBGcsF
	 wVYpZiyvQGYbn77nGi7rM9Olv4rsVmgBcq+EsUfLAs8hwDAuiRKp3qP6pHlGQ/tko
	 c7OjA1kzXss5UBLwq/TI7YabvZ2Lda51bBYklKnaLTravkuRm5xXclB+jNlJt216L
	 x+1SDvm9PnCuaJaZ1rdIcMihwuEUsVh7c2mNNozoV5F63aAngpz/4MNx+eS4xJhfJ
	 CWO6fWV1Aotza39Kaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8ykW-1u3W0t44k2-00321h; Tue, 01
 Apr 2025 20:56:42 +0200
Date: Tue, 1 Apr 2025 20:56:41 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
    Karthik Nayak <karthik.188@gmail.com>, 
    Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 14/20] t/lib-gpg: refactor `sanitize_pgp()` to not
 depend on Perl
In-Reply-To: <20250327-b4-pks-t-perlless-v3-14-b436de9da1b8@pks.im>
Message-ID: <c909b89f-7432-2d35-cfdb-0de9f94a7281@gmx.de>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im> <20250327-b4-pks-t-perlless-v3-14-b436de9da1b8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dhLFloEEiQSv4fz6WmpeCrCdTi5GdHfDwnTvrUjkLDfx7gQEfRJ
 nz0GzKdwd5JU0+OPJqyFD4lSGO/dle0fnISUpNHFT1tfsaPbvpA77BtZ7Lwh9qMgLNUQ+Fk
 kKunqRaS4REyOQFX9bbe+HIgI6w/gmSb/C//TZiYvWBh0BWfHJ+hEozKejdOvCCmeA/vViB
 Y9h8ikymzvpiLqzofovkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dHfeZnAHnbY=;mKT4aHT2knovic1aKEZwM2WajqF
 SZmuHXoRaTfC7OL6ICi6GOGpZb6NMnXOtVg2chxVdSlFXmHebloUMc7FKe39NvlqKPQhrtuHL
 2/CpWKNrd5q9Yu4ZGphs7IUah8wWQmHlWtg1nzjfwJEBDS28N3cAOm1sgPgEreOc95yvVnNla
 MPMviMV6ys7zEC/g57D6tAZ6MniX3ShyZHg5WbvBh/TJHWZkTsRAKYWF0hmYLdgj6+Aaer5PQ
 h+lG8rMJviVjOo1Lyh6Z74+IUWoqSQPGUkr29A8AWC80wosSqOZThezRzblkaj/ZXekVuNKvw
 28UuB7JkwdYpVKxK1ciR9sj7/cZxR4ybzGs8IMqJCVvF8lEJKB22gufDmtJFsZp8eFF7+IJx1
 v9lpz8+vYmVPW22hyMVTpv7vytVfhLfdCER4C2I6HGibAE4hmJm6sIhMm/0ZST8iKWnJK0x4e
 UUv4INAqOVzBLOTJmNE/9/TE/FYJNE0AgNVKSgxQzy06arDcEZNS6JlPRz1+IhN6BjpdLleFE
 s2OOPnBbx6hOizptTQMxUxExtyWOsp2NXn4KiajhP2+z5OM0YXr1a+tiVBH8/M0WsrrJJ7En/
 2B4b7ot5Yq3ae/CefBjyqnWc+JAnz8fUXRybKYgmFPYzalWxJk7e/Uf/EMDD22Sbmo65Zy4IB
 ZmK9LzQG9nHkaHzd5RrWQEeTDHJ64P74T2BFdgfH6mTTBXessUV1y047/IHYPZYQVJ8xt6tVv
 zJO17EyXshNOcQh1rH4ZbKGq1rwiH/jwD+Mhht+zU2kW7eTIZ8x1JqSqe6+zoY8OoOsqwasGf
 jJgoG6SwwDJ5WZFVTFw0DCfnRXSB/c4HiGPwS7c0iNyEnOzfKYLEaKY8tbBbsOCt/qmCp5/YJ
 ny4Uf3bkpvMw+b/4utHmeT2xTOpdzggL9dUlrZvmgALy/NUso05hvaOK20OFhvtQzAXgaZ5DI
 ZKkK/weB8JBgDVqjC+L8NEypxfRaswhAFT6iN6C34gJn1ei1Qnfq4gHUVdJxsRcEouRyj4bn7
 nO1GY93GNXGCvvsFQgefmwdW+noeCHtGpaRfTtLtfHJ5BW8dkogIFtoaClA07z3fSSLo6KMpM
 CjQQBdcGSXfsaHmZgbEgiqJDQqjKqii2KHdjCOI+WkomX2UFk6LWuk1p+iVbRlkBSAe/9e8sB
 C36Forn++YsbcaJQVGl6YZKfV2wyh4CpA7uiJeqzmTnlml8MHV/gpYMznKOyKVPjWdQNgx0UX
 cmRQIb2fk8BCvDhtYZPEHfRsbE8+BO7unvZCPuQz+pT311C+YgYU7VfgwNUUOG+S8siQQAPJO
 QnOjVaw4pz+dzkfIZBg+FJRNLGLvnGZnHWjwi9VPAa0ixY1vRKqiNoEQVPwPFcAIAXbphXr+3
 I9iMw85yB42VFIL/ZTYbBWOVvbb1wZ+x46r+WezZU7VwykxhCExNfRXiF377fhq780ewh6NB7
 7q9/glIjUKbN8hQjuQk0971Zfa16gdPCUHylG9hUjl9vz9x26
Content-Transfer-Encoding: quoted-printable


Hi Patrick,

On Thu, 27 Mar 2025, Patrick Steinhardt wrote:

> The `sanitize_pgp()` test helper uses Perl to strip PGP signatures from
> stdin. Refactor it to instead use awk(1) so that we drop the
> PERL_TEST_HELPERS prerequisite in users of this library.

It's my fault that this commit message is no longer correct because I
talked you into using `sed` instead...

Sorry,
Johannes

>
> Note that we have to add PERL_TEST_HELPERS to a subset of tests in t6300
> now that the test suite doesn't bail out early anymore in case the
> prerequisite isn't set.
>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/lib-gpg.sh            |  6 +-----
>  t/t6300-for-each-ref.sh | 21 ++++++++++-----------
>  2 files changed, 11 insertions(+), 16 deletions(-)
>
> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index 3845b6ac449..937b876bd05 100644
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -192,9 +192,5 @@ test_lazy_prereq GPGSSH_VERIFYTIME '
>  '
>
>  sanitize_pgp() {
> -	perl -ne '
> -		/^-----END PGP/ and $in_pgp =3D 0;
> -		print unless $in_pgp;
> -		/^-----BEGIN PGP/ and $in_pgp =3D 1;
> -	'
> +	sed "/^-----BEGIN PGP/,/^-----END PGP/{/^-/p;d;}"
>  }
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 732a4d3171e..5db7038c417 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -10,12 +10,6 @@ GNUPGHOME_NOT_USED=3D$GNUPGHOME
>  . "$TEST_DIRECTORY"/lib-gpg.sh
>  . "$TEST_DIRECTORY"/lib-terminal.sh
>
> -if ! test_have_prereq PERL_TEST_HELPERS
> -then
> -	skip_all=3D'skipping for-each-ref tests; Perl not available'
> -	test_done
> -fi
> -
>  # Mon Jul 3 23:18:43 2006 +0000
>  datestamp=3D1151968723
>  setdate_and_increment () {
> @@ -1215,7 +1209,7 @@ test_expect_success '%(raw) with --tcl must fail' =
'
>  	test_must_fail git for-each-ref --format=3D"%(raw)" --tcl
>  '
>
> -test_expect_success '%(raw) with --perl' '
> +test_expect_success PERL_TEST_HELPERS '%(raw) with --perl' '
>  	git for-each-ref --format=3D"\$name=3D %(raw);
>  print \"\$name\"" refs/myblobs/blob1 --perl | perl >actual &&
>  	cmp blob1 actual &&
> @@ -1442,9 +1436,14 @@ test_expect_success 'set up trailers for next tes=
t' '
>  '
>
>  test_trailer_option () {
> +	if test "$#" -eq 3
> +	then
> +		prereq=3D"$1"
> +		shift
> +	fi &&
>  	title=3D$1 option=3D$2
>  	cat >expect
> -	test_expect_success "$title" '
> +	test_expect_success $prereq "$title" '
>  		git for-each-ref --format=3D"%($option)" refs/heads/main >actual &&
>  		test_cmp expect actual &&
>  		git for-each-ref --format=3D"%(contents:$option)" refs/heads/main >ac=
tual &&
> @@ -1452,7 +1451,7 @@ test_trailer_option () {
>  	'
>  }
>
> -test_trailer_option '%(trailers:unfold) unfolds trailers' \
> +test_trailer_option PERL_TEST_HELPERS '%(trailers:unfold) unfolds trail=
ers' \
>  	'trailers:unfold' <<-EOF
>  	$(unfold <trailers)
>
> @@ -1482,13 +1481,13 @@ test_trailer_option '%(trailers:only=3Dno) shows=
 all trailers' \
>
>  	EOF
>
> -test_trailer_option '%(trailers:only) and %(trailers:unfold) work toget=
her' \
> +test_trailer_option PERL_TEST_HELPERS '%(trailers:only) and %(trailers:=
unfold) work together' \
>  	'trailers:only,unfold' <<-EOF
>  	$(grep -v patch.description <trailers | unfold)
>
>  	EOF
>
> -test_trailer_option '%(trailers:unfold) and %(trailers:only) work toget=
her' \
> +test_trailer_option PERL_TEST_HELPERS '%(trailers:unfold) and %(trailer=
s:only) work together' \
>  	'trailers:unfold,only' <<-EOF
>  	$(grep -v patch.description <trailers | unfold)
>
>
> --
> 2.49.0.472.ge94155a9ec.dirty
>
>
