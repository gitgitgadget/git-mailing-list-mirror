From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Interested in helping open source friends on HP-UX?
Date: Thu, 19 Feb 2015 14:21:11 +0100
Message-ID: <54E5E347.4070401@drmicha.warpmail.net>
References: <xmqq4mt2fx2m.fsf@gitster.dls.corp.google.com> <20150218170007.784be6aa@pc09.procura.nl> <54E4CFDC.40401@drmicha.warpmail.net> <20150218182547.GA6346@peff.net> <xmqqpp972h1n.fsf@gitster.dls.corp.google.com> <20150218185734.GB7257@peff.net> <54E5BBDD.7040100@drmicha.warpmail.net> <20150219121438.59050ce8@pc09.procura.nl> <54E5C6E2.9040101@drmicha.warpmail.net> <20150219125433.GA1591@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 19 14:21:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOR2l-00035K-Cu
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 14:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbbBSNVO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Feb 2015 08:21:14 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59572 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752775AbbBSNVO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2015 08:21:14 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 92C3920CFD
	for <git@vger.kernel.org>; Thu, 19 Feb 2015 08:21:13 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 19 Feb 2015 08:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=92cGYzzMsme2KALHswWAO9
	WooTQ=; b=knwlhDMkAeY610LArXPnyEIM4i06xyv3Ho/67wSXUlKdwdmapcpIPh
	ji3HV9bF4lQO4m1FPVoIZCRAm+sl84MYUar1Ky0DoeIPcRHh7J4pXzgRVZdSMJDR
	F07IrtkXcpI/wR171xxDlgWQ6J81MiqfYJYa2WF1hPPrynwbNUySQ=
X-Sasl-enc: Rvdfa9NVeWTKvEkVjh3MSb2YVsr5A8JLDLve22L3hkmK 1424352073
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id CF335680142;
	Thu, 19 Feb 2015 08:21:12 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <20150219125433.GA1591@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264097>

Jeff King venit, vidit, dixit 19.02.2015 13:54:
> On Thu, Feb 19, 2015 at 12:20:02PM +0100, Michael J Gruber wrote:
>=20
>> OK, so we should use NO_ICONV on HP_UX then.
>>
>>>> Failing so many tests with NO_ICONV is certainly not ideal, but I'=
m not
>>>> sure we should care to protect so many tests with a prerequisite.
>>>
>>> How feasible is it to isolate those tests into separate test files =
that
>>> people that know to not use e.g. Asian can safely ignore them?
>>
>> We have the prerequisite mechanism for that, and most probably, the
>> tests are "isolated" already, in the sense that with NO_ICONV, only
>> trivial setup tests succeed for those test files but all "proper" te=
sts
>> fail. But I'll check. Need a good test to set the prerequisite, thou=
gh.
>=20
> I took a first pass at this. The results are below (and I am hoping o=
ne
> of you can use it as a base to build on, as I do not want to commit t=
o
> doing the second half, as you will see :) ).
>=20
> It passes NO_ICONV through to the test suite, sets up a prerequisite,
> disables some test scripts which are purely about i18n (e.g.,
> t3900-i18n-commit), and marks some of the scripts with one-off tests
> using the ICONV prereq.

Hmm. I know we pass other stuff down, but is this really a good idea? I=
t
relies on the fact that the git that we test was built with the options
from there. This assumptions breaks (with) GIT_TEST_INSTALLED, if not m=
ore.

Basically, it may break as soon as we run the tests by other means than
"make", which is quite customary if you run single tests.

(And we do pass config.mak down, me thinks, but NO_ICONV may come from
the command line.)

> Note that it also has some code changes around reencode_string_len.
> These aren't strictly necessary, but they silence gcc warnings when
> compiled with NO_ICONV. In that case we do:
>=20
>   #define reencode_string_len(a,b,c,d,e) NULL
>=20
> but "e" is an out-parameter. We don't promise it is valid if the
> function returns NULL (which it does here). I'm kind of surprised the
> compiler doesn't realize that:
>=20
>   foo =3D reencode_string_len(...);
>   if (foo)
> 	bar();
>=20
> is dead code, since the first line becomes "foo =3D NULL". So that's
> optional.
>=20
> So, on to the tricky parts. Here are the failures that remain:
>=20
>   1. The script builds up a commit history through the script, and la=
ter
>      tests depend on this for things like commit timestamps or the ex=
act
>      shape of history. t9350 is an example of this (it has one failin=
g
>      test which can be marked, but then other tests later fail in
>      confusing ways).
>=20
>   2. The script creates commits with encoded commit messages, then us=
es
>      those both for cases that care about the encoding, and those tha=
t
>      do not. t4041 is an example here. I think it would be best to us=
e
>      vanilla commit mesages for the main body of tests, and then
>      explicitly test the encoding-related features separately. I thin=
k
>      t4205 and t6006 are in this boat, too.
>=20
> I also tested this on a system with a working "iconv". If we are
> building with NO_ICONV, I am tempted to say that there should be no n=
eed
> to run the "iconv" command-line program at all. But t6006, for exampl=
e,
> does it a lot outside of any test_expect_*. Probably it should be:
>=20
>   test_lazy_prereq ICONV '
> 	test -z "$NO_ICONV" &&
> 	utf8_o=3D$(printf "\303\263") &&
> 	latin1_o=3D$(printf "\363") &&
> 	test "$(echo $utf8_o | iconv -f UTF-8 -t ISO-8559-1)" =3D "$latin1_o=
"
>   '
>=20
> or something, and all of that setup should be wrapped in a
> "test_expect_success ICONV ...". Of course that is the easy part. The
> hard part is splitting the ICONV setup from the vanilla commit setup =
so
> that the other tests can run.

Jeff, you got it wrong. You should do the hard part and leave the easy
part to us!

Thanks anyways, I'll add this to my HP_UX branch.

> ---
> diff --git a/Makefile b/Makefile
> index e8ce649..c460ce8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2112,6 +2112,7 @@ endif
>  ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
>  	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=3DYesPlease >>$@
>  endif
> +	@echo NO_ICONV=3D\''$(subst ','\'',$(subst ','\'',$(NO_ICONV)))'\' =
>>$@
>  	@echo NO_GETTEXT=3D\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)))=
'\' >>$@
>  	@echo GETTEXT_POISON=3D\''$(subst ','\'',$(subst ','\'',$(GETTEXT_P=
OISON)))'\' >>$@
>  ifdef GIT_PERF_REPEAT_COUNT
> diff --git a/pretty.c b/pretty.c
> index 9d34d02..74fe5fb 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1497,7 +1497,7 @@ void format_commit_message(const struct commit =
*commit,
>  	}
> =20
>  	if (output_enc) {
> -		int outsz;
> +		int outsz =3D 0;
>  		char *out =3D reencode_string_len(sb->buf, sb->len,
>  						output_enc, utf8, &outsz);
>  		if (out)
> diff --git a/strbuf.c b/strbuf.c
> index 88cafd4..6d8ad4b 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -94,7 +94,7 @@ void strbuf_ltrim(struct strbuf *sb)
>  int strbuf_reencode(struct strbuf *sb, const char *from, const char =
*to)
>  {
>  	char *out;
> -	int len;
> +	int len =3D 0;
> =20
>  	if (same_encoding(from, to))
>  		return 0;
> diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
> index 4bf1dbe..d522677 100755
> --- a/t/t3900-i18n-commit.sh
> +++ b/t/t3900-i18n-commit.sh
> @@ -7,6 +7,11 @@ test_description=3D'commit and log output encodings'
> =20
>  . ./test-lib.sh
> =20
> +if ! test_have_prereq ICONV; then
> +	skip_all=3D'skipping i18n tests, iconv not available'
> +	test_done
> +fi
> +
>  compare_with () {
>  	git show -s $1 | sed -e '1,/^$/d' -e 's/^    //' >current &&
>  	case "$3" in
> diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
> index a392f3d..c4f9d06 100755
> --- a/t/t3901-i18n-patch.sh
> +++ b/t/t3901-i18n-patch.sh
> @@ -7,6 +7,11 @@ test_description=3D'i18n settings and format-patch |=
 am pipe'
> =20
>  . ./test-lib.sh
> =20
> +if ! test_have_prereq ICONV; then
> +	skip_all=3D'skipping i18n tests, iconv not available'
> +	test_done
> +fi
> +
>  check_encoding () {
>  	# Make sure characters are not corrupted
>  	cnt=3D"$1" header=3D"$2" i=3D1 j=3D0 bad=3D0
> diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
> index 7600a3e..6ac7150 100755
> --- a/t/t4201-shortlog.sh
> +++ b/t/t4201-shortlog.sh
> @@ -159,7 +159,7 @@ $DSCHO (2):
> =20
>  EOF
> =20
> -test_expect_success !MINGW 'shortlog encoding' '
> +test_expect_success !MINGW,ICONV 'shortlog encoding' '
>  	git reset --hard "$commit" &&
>  	git config --unset i18n.commitencoding &&
>  	echo 2 > a1 &&
> diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
> index e585fe6..12b82f9 100755
> --- a/t/t4210-log-i18n.sh
> +++ b/t/t4210-log-i18n.sh
> @@ -3,6 +3,11 @@
>  test_description=3D'test log with i18n features'
>  . ./test-lib.sh
> =20
> +if ! test_have_prereq ICONV; then
> +	skip_all=3D'skipping i18n tests, iconv not available'
> +	test_done
> +fi
> +
>  # two forms of =C3=A9
>  utf8_e=3D$(printf '\303\251')
>  latin1_e=3D$(printf '\351')
> diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
> index 60df10f..d904696 100755
> --- a/t/t5100-mailinfo.sh
> +++ b/t/t5100-mailinfo.sh
> @@ -53,7 +53,7 @@ test_expect_success 'split box with rfc2047 samples=
' \
> =20
>  for mail in `echo rfc2047/00*`
>  do
> -	test_expect_success "mailinfo $mail" '
> +	test_expect_success ICONV "mailinfo $mail" '
>  		git mailinfo -u $mail-msg $mail-patch <$mail >$mail-info &&
>  		echo msg &&
>  		test_cmp "$TEST_DIRECTORY"/t5100/empty $mail-msg &&
> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> index 6da9422..fde4fbb 100755
> --- a/t/t5550-http-fetch-dumb.sh
> +++ b/t/t5550-http-fetch-dumb.sh
> @@ -204,12 +204,12 @@ test_expect_success 'git client shows text/plai=
n with a charset' '
>  	grep "this is the error message" stderr
>  '
> =20
> -test_expect_success 'http error messages are reencoded' '
> +test_expect_success ICONV 'http error messages are reencoded' '
>  	test_must_fail git clone "$HTTPD_URL/error/utf16" 2>stderr &&
>  	grep "this is the error message" stderr
>  '
> =20
> -test_expect_success 'reencoding is robust to whitespace oddities' '
> +test_expect_success ICONV 'reencoding is robust to whitespace odditi=
es' '
>  	test_must_fail git clone "$HTTPD_URL/error/odd-spacing" 2>stderr &&
>  	grep "this is the error message" stderr
>  '
> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> index 98bcfe2..a7168d3 100755
> --- a/t/t7102-reset.sh
> +++ b/t/t7102-reset.sh
> @@ -62,14 +62,14 @@ check_changes () {
>  	done | test_cmp .cat_expect -
>  }
> =20
> -test_expect_success 'reset --hard message' '
> +test_expect_success ICONV 'reset --hard message' '
>  	hex=3D$(git log -1 --format=3D"%h") &&
>  	git reset --hard > .actual &&
>  	echo HEAD is now at $hex $(commit_msg) > .expected &&
>  	test_cmp .expected .actual
>  '
> =20
> -test_expect_success 'reset --hard message (ISO8859-1 logoutputencodi=
ng)' '
> +test_expect_success ICONV 'reset --hard message (ISO8859-1 logoutput=
encoding)' '
>  	hex=3D$(git log -1 --format=3D"%h") &&
>  	git -c "i18n.logOutputEncoding=3D$test_encoding" reset --hard > .ac=
tual &&
>  	echo HEAD is now at $hex $(commit_msg $test_encoding) > .expected &=
&
> diff --git a/t/t8005-blame-i18n.sh b/t/t8005-blame-i18n.sh
> index 847d098..8c3ab28 100755
> --- a/t/t8005-blame-i18n.sh
> +++ b/t/t8005-blame-i18n.sh
> @@ -3,6 +3,11 @@
>  test_description=3D'git blame encoding conversion'
>  . ./test-lib.sh
> =20
> +if ! test_have_prereq ICONV; then
> +	skip_all=3D'skipping i18n tests, iconv not available'
> +	test_done
> +fi
> +
>  . "$TEST_DIRECTORY"/t8005/utf8.txt
>  . "$TEST_DIRECTORY"/t8005/euc-japan.txt
>  . "$TEST_DIRECTORY"/t8005/sjis.txt
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index bb1402d..cef41a8 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -940,6 +940,7 @@ test -z "$NO_PERL" && test_set_prereq PERL
>  test -z "$NO_PYTHON" && test_set_prereq PYTHON
>  test -n "$USE_LIBPCRE" && test_set_prereq LIBPCRE
>  test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
> +test -z "$NO_ICONV" && test_set_prereq ICONV
> =20
>  # Can we rely on git's output in the C locale?
>  if test -n "$GETTEXT_POISON"
>=20
