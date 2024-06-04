Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB00D146D6E
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717521129; cv=none; b=mnKYVznz0rDpFnK75fbfejZRriyRUyMdcBoXJ/+IrYXCWCX++k3VpkmHWJfZPepSatYQY/ONfdqodEZ5okB+HyFN5PkQlMWvU6Q0Wq7Y3bgmB/0tMzZ28pEwXMwo5KRJ3dAbP44JHQToKPrFoQjI4X4KjCEh43zj8VgbBt6p43M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717521129; c=relaxed/simple;
	bh=wNfCaL+Udc+29wcaxXBOZU+pBMnaPZkTf2y+nSreV/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mZDe2pyaFkCBDZr08KddulTujDCP/mzgANsRb6PBbN1DRNeUFXANfnIEVhDTch7wPr71ogYyqudZJ4nSsTbBu17tNdo03aLZoj5+e2t95fgo82jmJzMpuy4saqdgobWaVkAR2KD3Nogy4fUrebPpJD9l/kuoY4Zf+dz45x+SlHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=B6M1o2MQ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B6M1o2MQ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CF5141CDAF;
	Tue,  4 Jun 2024 13:12:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wNfCaL+Udc+2
	9wcaxXBOZU+pBMnaPZkTf2y+nSreV/Y=; b=B6M1o2MQ6NoXUXJcuas4HnBsOuiw
	zNFhW9rg8UaWiZOjv5vBYqdx+dGd8Nrw64MqXIcJHobClZ46qPUQcSa63FT2Bl2I
	SgwFPcNNLg4C6ndAoWUKd0fEZoFe+R74McJZD+q0PC5KvLkR8t8BNgtyuF7luquF
	TwiMof7l07f50LI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C762C1CDAE;
	Tue,  4 Jun 2024 13:12:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9BFD81CDA5;
	Tue,  4 Jun 2024 13:12:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Dragan Simic <dsimic@manjaro.org>,
  Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 6/6] add-patch: introduce the command '|'
In-Reply-To: <75a3cc89-4d23-4eae-b0ad-e52e2c8ba550@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Mon, 3 Jun 2024 22:38:41 +0200")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
	<b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
	<1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
	<75a3cc89-4d23-4eae-b0ad-e52e2c8ba550@gmail.com>
Date: Tue, 04 Jun 2024 10:12:03 -0700
Message-ID: <xmqqy17kws2k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 91975506-2295-11EF-943B-B84BEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> @@ -1389,6 +1390,7 @@ N_("j - leave this hunk undecided, see next undec=
ided hunk\n"
>     "s - split the current hunk into smaller hunks\n"
>     "e - manually edit the current hunk\n"
>     "p - print the current hunk\n"
> +   "| - use pager to show the current hunk, or use |<program> to custo=
mize\n"
>     "? - print help\n");

"to customize" strongly hints that the customization will stick, at
least during this session.  Is that what actually happens?

> @@ -1401,6 +1403,7 @@ static int patch_update_file(struct add_p_state *=
s,
>  	struct child_process cp =3D CHILD_PROCESS_INIT;
>  	int colored =3D !!s->colored.len, quit =3D 0;
>  	enum prompt_mode_type prompt_mode_type;
> +	const char* pager =3D NULL;

The asterisk sticks to "pager", not its type.

>  	enum {
>  		ALLOW_GOTO_PREVIOUS_HUNK =3D 1 << 0,
>  		ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK =3D 1 << 1,
> @@ -1449,9 +1452,15 @@ static int patch_update_file(struct add_p_state =
*s,
>  		strbuf_reset(&s->buf);
>  		if (file_diff->hunk_nr) {
>  			if (rendered_hunk_index !=3D hunk_index) {
> +				if (pager)
> +					setup_custom_pager(pager);
>  				render_hunk(s, hunk, 0, colored, &s->buf);
>  				fputs(s->buf.buf, stdout);
>  				rendered_hunk_index =3D hunk_index;
> +				if (pager) {
> +					wait_for_pager();
> +					pager =3D NULL;
> +				}
>  			}
> =20
>  			strbuf_reset(&s->buf);
> @@ -1485,6 +1494,7 @@ static int patch_update_file(struct add_p_state *=
s,
>  				strbuf_addstr(&s->buf, ",e");
>  			}
>  			strbuf_addstr(&s->buf, ",p");
> +			strbuf_addstr(&s->buf, ",|");
>  		}
>  		if (file_diff->deleted)
>  			prompt_mode_type =3D PROMPT_DELETION;
> @@ -1512,8 +1522,8 @@ static int patch_update_file(struct add_p_state *=
s,
>  			continue;
>  		ch =3D tolower(s->answer.buf[0]);
> =20
> -		/* 'g' takes a hunk number and '/' takes a regexp */
> -		if (s->answer.len !=3D 1 && (ch !=3D 'g' && ch !=3D '/')) {
> +		/* 'g' takes a hunk number, '/' takes a regexp and '|' takes a progr=
am */
> +		if (s->answer.len !=3D 1 && (ch !=3D 'g' && ch !=3D '/' && ch !=3D '=
|')) {

Not limited to this instance, but a good discipline is to stop and
think twice before adding the third thing to already existing two.

Perhaps

		/*
		 * 'g' takes a hunk number to go to.
		 * '/' takes a regexp to match.
		 * '|' takes a program to pipe to.
		 */
		if (s->answer.len !=3D 1 && !strchr("g/|", ch))

> @@ -1674,6 +1684,17 @@ static int patch_update_file(struct add_p_state =
*s,
>  			}
>  		} else if (s->answer.buf[0] =3D=3D 'p') {
>  			rendered_hunk_index =3D -1;
> +		} else if (ch =3D=3D '|') {
> +			strbuf_remove(&s->answer, 0, 1);
> +			if (s->s.use_single_key && s->answer.len =3D=3D 0) {

If you check .use_single_key, you do not need to check answer.len,
do you?  Can it ever be anything other than 0 here in the single-key
mode?

> +				printf("%s", _("program? "));
> +				fflush(stdout);
> +				strbuf_getline(&s->answer, stdin);
> +				strbuf_trim_trailing_newline(&s->answer);
> +			}
> +			strbuf_trim(&s->answer);
> +			pager =3D s->answer.buf;

Is it safe to peek into s->answer.buf and expect it to be live until
we have to use the pager like this?

By the way, it should be trivial to make the "custom" pager more sticky.

		} else if (ch =3D=3D '|') {
			if (s->s.use_single_key) {
				... read into s->answer ...
			} else {
				strbuf_remove(&s->answer, 0, 1);
			}
			strbuf_trim_trailing_newline(&s->answer);

			/*
                         * If it is completely empty, use the last
                         * one, if it is semi-empty, reset to the default=
.
                         */
			if (!s->answer.len) {
				;
			} else {
				FREE_AND_NULL(pager);
				strbuf_trim(&s->answer);
                                if (!s->answer.len)
                                	pager =3D xstrdup(s->answer.buf);
			}

Even better, we can lift the scope of "pager" one level up, define
it as an on-stack variable in run_add_p(), add a new parameter of
type "const char **" to patch_update_file(), and use it throughout
patch_update_file(), so that a "custom" pager set here will be
carried across file boundaries.

> +			rendered_hunk_index =3D -1;
>  		} else if (s->answer.buf[0] =3D=3D '?') {
>  			const char *p =3D _(help_patch_remainder), *eol =3D p;
> =20
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 6f6d174687..7b3ebb671d 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -64,8 +64,8 @@ test_expect_success 'unknown command' '
>  	git add -N command &&
>  	git diff command >expect &&
>  	cat >>expect <<-EOF &&
> -	(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command ${SQ}W${SQ} (=
use ${SQ}?${SQ} for help)
> -	(1/1) Stage addition [y,n,q,a,d,e,p,?]?$SP
> +	(1/1) Stage addition [y,n,q,a,d,e,p,|,?]? Unknown command ${SQ}W${SQ}=
 (use ${SQ}?${SQ} for help)
> +	(1/1) Stage addition [y,n,q,a,d,e,p,|,?]?$SP
>  	EOF
>  	git add -p -- command <command >actual 2>&1 &&
>  	test_cmp expect actual
> @@ -348,9 +348,9 @@ test_expect_success 'different prompts for mode cha=
nge/deleted' '
>  	git -c core.filemode=3Dtrue add -p >actual &&
>  	sed -n "s/^\(([0-9/]*) Stage .*?\).*/\1/p" actual >actual.filtered &&
>  	cat >expect <<-\EOF &&
> -	(1/1) Stage deletion [y,n,q,a,d,p,?]?
> -	(1/2) Stage mode change [y,n,q,a,d,j,J,g,/,p,?]?
> -	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]?
> +	(1/1) Stage deletion [y,n,q,a,d,p,|,?]?
> +	(1/2) Stage mode change [y,n,q,a,d,j,J,g,/,p,|,?]?
> +	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,|,?]?
>  	EOF
>  	test_cmp expect actual.filtered
>  '
> @@ -537,13 +537,13 @@ test_expect_success 'split hunk setup' '
>  test_expect_success 'goto hunk 1 with "g 1"' '
>  	test_when_finished "git reset" &&
>  	tr _ " " >expect <<-EOF &&
> -	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? + 1:  -1,2 +1,3       =
   +15
> +	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,|,?]? + 1:  -1,2 +1,3     =
     +15
>  	_ 2:  -2,4 +3,8          +21
>  	go to which hunk? @@ -1,2 +1,3 @@
>  	_10
>  	+15
>  	_20
> -	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
> +	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,|,?]?_
>  	EOF
>  	test_write_lines s y g 1 | git add -p >actual &&
>  	tail -n 7 <actual >actual.trimmed &&
> @@ -556,7 +556,7 @@ test_expect_success 'goto hunk 1 with "g1"' '
>  	_10
>  	+15
>  	_20
> -	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
> +	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,|,?]?_
>  	EOF
>  	test_write_lines s y g1 | git add -p >actual &&
>  	tail -n 4 <actual >actual.trimmed &&
> @@ -566,11 +566,11 @@ test_expect_success 'goto hunk 1 with "g1"' '
>  test_expect_success 'navigate to hunk via regex /pattern' '
>  	test_when_finished "git reset" &&
>  	tr _ " " >expect <<-EOF &&
> -	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? @@ -1,2 +1,3 @@
> +	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,|,?]? @@ -1,2 +1,3 @@
>  	_10
>  	+15
>  	_20
> -	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
> +	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,|,?]?_
>  	EOF
>  	test_write_lines s y /1,2 | git add -p >actual &&
>  	tail -n 5 <actual >actual.trimmed &&
> @@ -583,7 +583,7 @@ test_expect_success 'navigate to hunk via regex / p=
attern' '
>  	_10
>  	+15
>  	_20
> -	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
> +	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,|,?]?_
>  	EOF
>  	test_write_lines s y / 1,2 | git add -p >actual &&
>  	tail -n 4 <actual >actual.trimmed &&
> @@ -595,17 +595,38 @@ test_expect_success 'print again the hunk' '
>  	tr _ " " >expect <<-EOF &&
>  	+15
>  	 20
> -	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? @@ -1,2 +1,3 @@
> +	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,|,?]? @@ -1,2 +1,3 @@
>  	 10
>  	+15
>  	 20
> -	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
> +	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,|,?]?_
>  	EOF
>  	test_write_lines s y g 1 p | git add -p >actual &&
>  	tail -n 7 <actual >actual.trimmed &&
>  	test_cmp expect actual.trimmed
>  '
> =20
> +test_expect_success TTY 'print again the hunk (PAGER)' '
> +	test_when_finished "git reset" &&
> +	cat >expect <<-EOF &&
> +	<GREEN>+<RESET><GREEN>15<RESET>
> +	 20<RESET>
> +	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,|,?]? <RESET>=
PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
> +	PAGER  10<RESET>
> +	PAGER <GREEN>+<RESET><GREEN>15<RESET>
> +	PAGER  20<RESET>
> +	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,|,?]? <RESET>
> +	EOF
> +	test_write_lines s y g 1 \| |
> +	(
> +		GIT_PAGER=3D"sed s/^/PAGER\ /" &&
> +		export GIT_PAGER &&
> +		test_terminal --no-stdin-pty git add -p >actual
> +	) &&
> +	tail -n 7 <actual | test_decode_color >actual.trimmed &&
> +	test_cmp expect actual.trimmed
> +'
> +
>  test_expect_success 'split hunk "add -p (edit)"' '
>  	# Split, say Edit and do nothing.  Then:
>  	#
> @@ -780,21 +801,21 @@ test_expect_success 'colors can be overridden' '
>  	<BLUE>+<RESET><BLUE>new<RESET>
>  	<CYAN> more-context<RESET>
>  	<BLUE>+<RESET><BLUE>another-one<RESET>
> -	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,p,?]? <RESET><BOLD>Split=
 into 2 hunks.<RESET>
> +	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,p,|,?]? <RESET><BOLD>Spl=
it into 2 hunks.<RESET>
>  	<MAGENTA>@@ -1,3 +1,3 @@<RESET>
>  	<CYAN> context<RESET>
>  	<BOLD>-old<RESET>
>  	<BLUE>+<RESET><BLUE>new<RESET>
>  	<CYAN> more-context<RESET>
> -	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET><MAGE=
NTA>@@ -3 +3,2 @@<RESET>
> +	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,|,?]? <RESET><MA=
GENTA>@@ -3 +3,2 @@<RESET>
>  	<CYAN> more-context<RESET>
>  	<BLUE>+<RESET><BLUE>another-one<RESET>
> -	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? <RESET><MAGENT=
A>@@ -1,3 +1,3 @@<RESET>
> +	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,|,?]? <RESET><MAGE=
NTA>@@ -1,3 +1,3 @@<RESET>
>  	<CYAN> context<RESET>
>  	<BOLD>-old<RESET>
>  	<BLUE>+new<RESET>
>  	<CYAN> more-context<RESET>
> -	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET>
> +	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,|,?]? <RESET>
>  	EOF
>  	test_cmp expect actual
>  '
