From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] Add C_LOCALE_OUTPUT prereq to test cases that
 require English text matching
Date: Sun, 24 Jun 2012 11:28:07 -0500
Message-ID: <20120624162807.GB18791@burratino>
References: <1340541692-10834-1-git-send-email-pclouds@gmail.com>
 <1340541692-10834-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 18:28:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sipfd-0001ms-LQ
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 18:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772Ab2FXQ2N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jun 2012 12:28:13 -0400
Received: from mail-yw0-f51.google.com ([209.85.213.51]:33098 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab2FXQ2M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jun 2012 12:28:12 -0400
Received: by yhnn12 with SMTP id n12so2774429yhn.10
        for <git@vger.kernel.org>; Sun, 24 Jun 2012 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5pkVq1CfEsouPE0qmXi3wqz34TAL3ao1cPNbAJTyuDQ=;
        b=AcPFxoq/9qS8BMGS31XTQKZcdUOIMJJuQvtoLftLuJLAJ/aHX+8PPzcvayHIWZyzy5
         NXDTRXWAzUqNuGoDcXqelb19RR1ft59nIIebbrxyv+tmg2AAsTSXTu3FQ90Rvxfntgf/
         5bgRUoOUUpIJy9O2CsX4IEJr0kloKkyeXFmjS10UI4rMVpYLW93hLuONbE0KK5T0C2iY
         WVWr+CI1/IUVa+Owv6XBOBnQkhhlPO6WJBAwv2stujWs4NNtkY/ubRHjLZ93RIhcM0o3
         Jo6G5mfvyTieH22WbSk2w5Z88RuVtwWt9XWcYn2lHuWvau43m74QinJsvgj/fvB6/VlU
         0QiA==
Received: by 10.50.46.201 with SMTP id x9mr6101215igm.34.1340555291451;
        Sun, 24 Jun 2012 09:28:11 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id dw5sm4389023igc.6.2012.06.24.09.28.10
        (version=SSLv3 cipher=OTHER);
        Sun, 24 Jun 2012 09:28:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1340541692-10834-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200537>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> This fixes all GETTEXT_POISON breakages caused by recent i18n changes=
=2E

=46irst, thanks much for this.

Lots of these could be fixed in a more targetted way by using
test_i18ngrep, but the C_LOCALE_OUTPUT prereq works just as well as a
way to double-check that the newly translated strings are hopefully
not disrupting any functionality people rely on.

[...]
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -9,7 +9,7 @@ TEST_DATE_NOW=3D1251660000; export TEST_DATE_NOW
>  check_show() {
>  	t=3D$(($TEST_DATE_NOW - $1))
>  	echo "$t -> $2" >expect
> -	test_expect_${3:-success} "relative date ($2)" "
> +	test_expect_${3:-success} C_LOCALE_OUTPUT "relative date ($2)" "
>  	test-date show $t >actual &&
>  	test_cmp expect actual
>  	"

Could use test_i18ncmp so we catch if test-date crashes, but anyway,
yeah, we can't expect to be able to meaningfully test date formatting
in another language.


> @@ -29,7 +29,7 @@ check_show 62985600 '2 years ago'
> =20
>  check_parse() {
>  	echo "$1 -> $2" >expect
> -	test_expect_${4:-success} "parse date ($1${3:+ TZ=3D$3})" "
> +	test_expect_${4:-success} C_LOCALE_OUTPUT "parse date ($1${3:+ TZ=3D=
$3})" "
>  	TZ=3D${3:-$TZ} test-date parse '$1' >actual &&
>  	test_cmp expect actual
>  	"

This one is less pleasant.  Could test-date be convinced to produce
machine-readable output (e.g., seconds since the epoque)?  I'd be
especially concerned to check that the parser still accepts the
same input strings in other locales.

> @@ -50,7 +50,7 @@ check_parse '2008-02-14 20:30:45' '2008-02-14 20:30=
:45 -0500' EST5
> =20
>  check_approxidate() {
>  	echo "$1 -> $2 +0000" >expect
> -	test_expect_${3:-success} "parse approxidate ($1)" "
> +	test_expect_${3:-success} C_LOCALE_OUTPUT "parse approxidate ($1)" =
"
>  	test-date approxidate '$1' >actual &&
>  	test_cmp expect actual
>  	"

Likewise.

[...]
> --- a/t/t0040-parse-options.sh
> +++ b/t/t0040-parse-options.sh
> @@ -48,7 +48,7 @@ Standard options
> =20
>  EOF
> =20
> -test_expect_success 'test help' '
> +test_expect_success C_LOCALE_OUTPUT 'test help' '
>  	test_must_fail test-parse-options -h > output 2> output.err &&
>  	test ! -s output.err &&
>  	test_cmp expect output

Sensible.

> @@ -104,8 +104,8 @@ test_expect_success 'OPT_BOOL() is idempotent #2'=
 'check boolean: 1 -DB'
>  test_expect_success 'OPT_BOOL() negation #1' 'check boolean: 0 -D --=
no-yes'
>  test_expect_success 'OPT_BOOL() negation #2' 'check boolean: 0 -D --=
no-no-doubt'
> =20
> -test_expect_success 'OPT_BOOL() no negation #1' 'check_unknown --fea=
r'
> -test_expect_success 'OPT_BOOL() no negation #2' 'check_unknown --no-=
no-fear'
> +test_expect_success C_LOCALE_OUTPUT 'OPT_BOOL() no negation #1' 'che=
ck_unknown --fear'
> +test_expect_success C_LOCALE_OUTPUT 'OPT_BOOL() no negation #2' 'che=
ck_unknown --no-no-fear'

Simpler to do

      --- i/t/t0040-parse-options.sh
      +++ w/t/t0040-parse-options.sh
      @@ -89,7 +89,7 @@ check_unknown() {
	      cat expect.err >>expect &&
	      test_must_fail test-parse-options $* >output 2>output.err &&
	      test ! -s output &&
      -	test_cmp expect output.err
      +	test_i18ncmp expect output.err
       }
      =20
       test_expect_success 'OPT_BOOL() #1' 'check boolean: 1 --yes'

[...]
> @@ -308,7 +308,7 @@ cat > expect <<EOF
>  Callback: "not set", 1
>  EOF
> =20
> -test_expect_success 'OPT_CALLBACK() and callback errors work' '
> +test_expect_success C_LOCALE_OUTPUT 'OPT_CALLBACK() and callback err=
ors work' '
>  	test_must_fail test-parse-options --no-length > output 2> output.er=
r &&
>  	test_cmp expect output &&
>  	test_cmp expect.err output.err

Using test_i18ncmp on stderr would allow us to keep checking stdout.

[...]
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -389,7 +389,7 @@ test_expect_success 'get bool variable with empty=
 value' \
>  	'git config --bool emptyvalue.variable > output &&
>  	 cmp output expect'
> =20
> -test_expect_success 'no arguments, but no crash' '
> +test_expect_success C_LOCALE_OUTPUT 'no arguments, but no crash' '
>  	test_must_fail git config >output 2>&1 &&
>  	grep usage output
>  '

It's mostly about "no crash", so test_i18ngrep would be more
comforting.

[...]
> --- a/t/t1502-rev-parse-parseopt.sh
> +++ b/t/t1502-rev-parse-parseopt.sh
> @@ -39,7 +39,7 @@ Extras
>  extra1    line above used to cause a segfault but no longer does
>  EOF
> =20
> -test_expect_success 'test --parseopt help output' '
> +test_expect_success C_LOCALE_OUTPUT 'test --parseopt help output' '
>  	test_expect_code 129 git rev-parse --parseopt -- -h > output < opti=
onspec &&
>  	test_cmp expect output
>  '

Seems fine (though test_i18ncmp is more targetted).

> --- a/t/t2006-checkout-index-basic.sh
> +++ b/t/t2006-checkout-index-basic.sh
> @@ -5,12 +5,12 @@ test_description=3D'basic checkout-index tests
> =20
>  . ./test-lib.sh
> =20
> -test_expect_success 'checkout-index --gobbledegook' '
> +test_expect_success C_LOCALE_OUTPUT 'checkout-index --gobbledegook' =
'
[...]
> -test_expect_success 'checkout-index -h in broken repository' '
> +test_expect_success C_LOCALE_OUTPUT 'checkout-index -h in broken rep=
ository' '
[...]
> +++ b/t/t2107-update-index-basic.sh
[...]
> -test_expect_success 'update-index --nonsense dumps usage' '
> +test_expect_success C_LOCALE_OUTPUT 'update-index --nonsense dumps u=
sage' '
[...]
> -test_expect_success 'update-index -h with corrupt index' '
> +test_expect_success C_LOCALE_OUTPUT 'update-index -h with corrupt in=
dex' '
[...]
> +++ b/t/t3004-ls-files-basic.sh
[...]
> -test_expect_success 'ls-files with nonsense option' '
> +test_expect_success C_LOCALE_OUTPUT 'ls-files with nonsense option' =
'
[...]
> -test_expect_success 'ls-files -h in corrupt repository' '
> +test_expect_success C_LOCALE_OUTPUT 'ls-files -h in corrupt reposito=
ry' '
[...]
> +++ b/t/t3200-branch.sh
[...]
> -test_expect_success 'branch -h in broken repository' '
> +test_expect_success C_LOCALE_OUTPUT 'branch -h in broken repository'=
 '
[...]
> -test_expect_success \
> +test_expect_success C_LOCALE_OUTPUT \
>      'git branch -m dumps usage' \
[...]
> +++ b/t/t3501-revert-cherry-pick.sh
[...]
> -test_expect_success 'cherry-pick --nonsense' '
> +test_expect_success C_LOCALE_OUTPUT 'cherry-pick --nonsense' '
[...]
> -test_expect_success 'revert --nonsense' '
> +test_expect_success C_LOCALE_OUTPUT 'revert --nonsense' '

Likewise.

> --- a/t/t4006-diff-mode.sh
> +++ b/t/t4006-diff-mode.sh
> @@ -32,26 +32,26 @@ test_expect_success 'prepare binary file' '
>  	git commit -m binbin
>  '
> =20
> -test_expect_success '--stat output after text chmod' '
> +test_expect_success C_LOCALE_OUTPUT '--stat output after text chmod'=
 '
>  	test_chmod -x rezrov &&
>  	echo " 0 files changed" >expect &&
>  	git diff HEAD --stat >actual &&
>  	test_cmp expect actual
>  '

Yeah, sensible enough.

It would be possible to recover some of the test by adding another
that does --numstat.

[...]
> --- a/t/t4012-diff-binary.sh
> +++ b/t/t4012-diff-binary.sh
> @@ -62,7 +62,7 @@ test_expect_success 'apply --numstat understands di=
ff --binary format' '
> =20
>  # apply needs to be able to skip the binary material correctly
>  # in order to report the line number of a corrupt patch.
> -test_expect_success 'apply detecting corrupt patch correctly' \
> +test_expect_success C_LOCALE_OUTPUT 'apply detecting corrupt patch c=
orrectly' \
>  	'git diff | sed -e 's/-CIT/xCIT/' >broken &&
>  	 if git apply --stat --summary broken 2>detected
>  	 then

This is an old one and uses a weird style.  I guess I'd go for

	git diff >patch &&
	sed -e "s/-CIT/xCIT/" <patch >broken &&
	test_must_fail git apply --stat --summary broken 2>detected &&

	if test_have_prereq C_LOCALE_OUTPUT
	then
		l=3D$(sed -n "s/.*fatal.*at line \([0-9]*\).*/\1/p" <detected) &&
		echo xCIT >expect &&
		sed -n "$l p" <broken >actual &&
		test_cmp expect actual
	fi

A translator is free to use %Id for the line number, so it's hard to
parse this in an arbitrary locale.

[...]
> -test_expect_success 'apply detecting corrupt patch correctly' \
> +test_expect_success C_LOCALE_OUTPUT 'apply detecting corrupt patch c=
orrectly' \

Likewise.

[...]
> --- a/t/t4120-apply-popt.sh
> +++ b/t/t4120-apply-popt.sh
[...]
> -test_expect_success 'apply with too large -p' '
> +test_expect_success C_LOCALE_OUTPUT 'apply with too large -p' '
>  	cp file1.saved file1 &&
>  	test_must_fail git apply --stat -p3 patch.file 2>err &&
>  	grep "removing 3 leading" err

It's mostly about making sure "git apply" fails gracefully and the
functionality involves parsing (which can get screwed up by locale
settings), so keeping the test running in other locales using
test_i18ngrep would be a comfort. =20

[...]
> -test_expect_success 'apply with too large -p and fancy filename' '
> +test_expect_success C_LOCALE_OUTPUT 'apply with too large -p and fan=
cy filename' '

Likewise.

> --- a/t/t4133-apply-filenames.sh
> +++ b/t/t4133-apply-filenames.sh
> @@ -28,7 +28,7 @@ index d00491f..0000000
[...]
> -test_expect_success 'apply diff with inconsistent filenames in heade=
rs' '
> +test_expect_success C_LOCALE_OUTPUT 'apply diff with inconsistent fi=
lenames in headers' '
>  	test_must_fail git apply bad1.patch 2>err &&
>  	grep "inconsistent new filename" err &&
>  	test_must_fail git apply bad2.patch 2>err &&
[...]
> +++ b/t/t4200-rerere.sh
[...]
> +test_expect_success C_LOCALE_OUTPUT 'rerere --no-no-rerere-autoupdat=
e' '
[...]
> +test_expect_success C_LOCALE_OUTPUT 'rerere -h' '
[...]
> +++ b/t/t4202-log.sh
[...]
> +test_expect_success C_LOCALE_OUTPUT 'log --graph with diff and stats=
' '

Seems fine.

> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -413,7 +413,7 @@ test_expect_success \
[...]
> -test_expect_success \
> +test_expect_success C_LOCALE_OUTPUT \
>      'make sure index-pack detects the SHA1 collision' \
>      'test_must_fail git index-pack -o bad.idx test-3.pack 2>msg &&
>       grep "SHA1 COLLISION FOUND" msg'

I'd drop the grep, personally.

[...]
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -24,7 +24,7 @@ setup_repository () {
>  tokens_match () {
>  	echo "$1" | tr ' ' '\012' | sort | sed -e '/^$/d' >expect &&
>  	echo "$2" | tr ' ' '\012' | sort | sed -e '/^$/d' >actual &&
> -	test_cmp expect actual
> +	test_i18ncmp expect actual

Sensible.

[...]
> @@ -694,7 +694,7 @@ test_expect_success 'migrate a remote from named =
file in $GIT_DIR/branches' '
>  	 test "$(git config remote.origin.fetch)" =3D "refs/heads/master:re=
fs/heads/origin")
>  '
> =20
> -test_expect_success 'remote prune to cause a dangling symref' '
> +test_expect_success C_LOCALE_OUTPUT 'remote prune to cause a danglin=
g symref' '
>  	git clone one seven &&

test_i18ngrep message

and

test_i18ngrep ! message

work well for this kind of thing.

[...]
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
[...]
> +test_expect_success C_LOCALE_OUTPUT 'gc --gobbledegook' '
[...]
> +test_expect_success C_LOCALE_OUTPUT 'gc -h with invalid configuratio=
n' '
[...]
> +++ b/t/t7508-status.sh
[...]
> +test_expect_success C_LOCALE_OUTPUT 'status --column' '
[...]
> +test_expect_success C_LOCALE_OUTPUT 'merge -h with invalid index' '

Sane.

Hope that helps,
Jonathan
