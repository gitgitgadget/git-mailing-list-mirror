From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] Prefix shell test output messages with test id
Date: Thu, 6 Sep 2012 14:34:00 +0200
Message-ID: <20120906123400.GA25467@tommy-fedora.scientificnet.net>
References: <1346931921-5901-1-git-send-email-glogow@fbihome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jan-Marek Glogowski <glogow@fbihome.de>
X-From: git-owner@vger.kernel.org Thu Sep 06 14:34:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9bHi-00053c-U3
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 14:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178Ab2IFMeH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Sep 2012 08:34:07 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:64137 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab2IFMeF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 08:34:05 -0400
Received: by weyx8 with SMTP id x8so1070711wey.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 05:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ySueTad83nAvmaw1RnyXOfP/wid7Hit57nAjNxptcIs=;
        b=q0aN5fuFI2rcR38G7j8I+EwO2Lu0hHzl8cUVCRe7OVk4/R6ZyOpSmLQZsPqDhgjG8d
         Ir4Md++FnvAgp4smXsYyjWniV46/vGtdTS8SvIJw6y7aBWZioViIwtXv8PbuY2cuILb7
         uKHzyDI4MbO0bKVKG5ouyxd/axbFLi2uMJGImCGWrjEBM2DNk9pZOuHx0+0oTh1NlvzG
         yVrT1uidrl129BRrKVpJ86RzXJBoo+exECtX5Hl1kF0P7YwfXMOWouh9nos2OwcHvtpY
         gZ77n6SWUXrfUhKb/jtImSofLhrqVgwDWZHNGPZNfQWAMAJ0Q5jzPQRC+6Sy0P5psbEE
         bL4A==
Received: by 10.216.181.67 with SMTP id k45mr1111283wem.17.1346934843253;
        Thu, 06 Sep 2012 05:34:03 -0700 (PDT)
Received: from localhost ([46.18.27.15])
        by mx.google.com with ESMTPS id o2sm5518056wiz.11.2012.09.06.05.34.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Sep 2012 05:34:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1346931921-5901-1-git-send-email-glogow@fbihome.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204880>

On 09/06, Jan-Marek Glogowski wrote:
> This adds the test ID (tXXXX) prefix to the test result message of
> all shell tests.  This is especially useful when doing a parallel
> check run, where it's currently quite hard to identify the actual
> failing test case.
>=20
> Signed-off-by: Jan-Marek Glogowski <glogow@fbihome.de>

This breaks the TAP output format of the tests, which is needed to run
them with prove.  To identify the failing tests more easily when runnin=
g
the tests in parallel, you may want to add GIT_TEST_TARGET =3D prove to
your config.mak.

If this change is really needed, I think you should add the test-id aft=
er
the message.
> ---
>  t/t0000-basic.sh        | 28 ++++++++++++++--------------
>  t/test-lib-functions.sh | 11 +++++++----
>  t/test-lib.sh           | 10 ++++++----
>  3 Dateien ge=E4ndert, 27 Zeilen hinzugef=FCgt(+), 22 Zeilen entfernt=
(-)
>=20
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index ccb5435..1bbf5b8 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -58,7 +58,7 @@ test_expect_failure 'pretend we have a known breaka=
ge' '
>  test_expect_success 'pretend we have fixed a known breakage (run in =
sub test-lib)' "
>  	mkdir passing-todo &&
>  	(cd passing-todo &&
> -	cat >passing-todo.sh <<-EOF &&
> +	cat >0000t05-passing-todo.sh <<-EOF &&
>  	#!$SHELL_PATH
> =20
>  	test_description=3D'A passing TODO test
> @@ -77,14 +77,14 @@ test_expect_success 'pretend we have fixed a know=
n breakage (run in sub test-lib
> =20
>  	test_done
>  	EOF
> -	chmod +x passing-todo.sh &&
> -	./passing-todo.sh >out 2>err &&
> +	chmod +x 0000t05-passing-todo.sh &&
> +	./0000t05-passing-todo.sh >out 2>err &&
>  	! test -s err &&
>  	sed -e 's/^> //' >expect <<-\\EOF &&
> -	> ok 1 - pretend we have fixed a known breakage # TODO known breaka=
ge
> -	> # fixed 1 known breakage(s)
> -	> # passed all 1 test(s)
> -	> 1..1
> +	> 0000t05: ok 1 - pretend we have fixed a known breakage # TODO kno=
wn breakage
> +	> 0000t05: # fixed 1 known breakage(s)
> +	> 0000t05: # passed all 1 test(s)
> +	> 0000t05: 1..1
>  	EOF
>  	test_cmp expect out)
>  "
> @@ -141,7 +141,7 @@ test_expect_success 'tests clean up even on failu=
res' "
>  	(
>  	cd failing-cleanup &&
> =20
> -	cat >failing-cleanup.sh <<-EOF &&
> +	cat >0000t12-failing-cleanup.sh <<-EOF &&
>  	#!$SHELL_PATH
> =20
>  	test_description=3D'Failing tests with cleanup commands'
> @@ -162,23 +162,23 @@ test_expect_success 'tests clean up even on fai=
lures' "
> =20
>  	EOF
> =20
> -	chmod +x failing-cleanup.sh &&
> -	test_must_fail ./failing-cleanup.sh >out 2>err &&
> +	chmod +x 0000t12-failing-cleanup.sh &&
> +	test_must_fail ./0000t12-failing-cleanup.sh >out 2>err &&
>  	! test -s err &&
>  	! test -f \"trash directory.failing-cleanup/clean-after-failure\" &=
&
>  	sed -e 's/Z$//' -e 's/^> //' >expect <<-\\EOF &&
> -	> not ok - 1 tests clean up even after a failure
> +	> 0000t12: not ok 1 - tests clean up even after a failure
>  	> #	Z
>  	> #	touch clean-after-failure &&
>  	> #	test_when_finished rm clean-after-failure &&
>  	> #	(exit 1)
>  	> #	Z
> -	> not ok - 2 failure to clean up causes the test to fail
> +	> 0000t12: not ok 2 - failure to clean up causes the test to fail
>  	> #	Z
>  	> #	test_when_finished \"(exit 2)\"
>  	> #	Z
> -	> # failed 2 among 2 test(s)
> -	> 1..2
> +	> 0000t12: # failed 2 among 2 test(s)
> +	> 0000t12: 1..2
>  	EOF
>  	test_cmp expect out
>  	)
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 9bc57d2..c81ad7f 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -24,6 +24,9 @@
>  #
>  # In particular, quoting isn't enough, as the path may contain the s=
ame quote
>  # that we're using.
> +
> +TID=3D$(basename ${0%%-*})
> +
>  test_set_editor () {
>  	FAKE_EDITOR=3D"$1"
>  	export FAKE_EDITOR
> @@ -434,7 +437,7 @@ test_external_without_stderr () {
>  test_path_is_file () {
>  	if ! [ -f "$1" ]
>  	then
> -		echo "File $1 doesn't exist. $*"
> +		echo "$TID: File $1 doesn't exist. $*"
>  		false
>  	fi
>  }
> @@ -442,7 +445,7 @@ test_path_is_file () {
>  test_path_is_dir () {
>  	if ! [ -d "$1" ]
>  	then
> -		echo "Directory $1 doesn't exist. $*"
> +		echo "$TID: Directory $1 doesn't exist. $*"
>  		false
>  	fi
>  }
> @@ -450,7 +453,7 @@ test_path_is_dir () {
>  test_path_is_missing () {
>  	if [ -e "$1" ]
>  	then
> -		echo "Path exists:"
> +		echo "$TID: Path exists:"
>  		ls -ld "$1"
>  		if [ $# -ge 1 ]; then
>  			echo "$*"
> @@ -476,7 +479,7 @@ test_line_count () {
>  		error "bug in the test script: not 3 parameters to test_line_count=
"
>  	elif ! test $(wc -l <"$3") "$1" "$2"
>  	then
> -		echo "test_line_count: line count for $3 !$1 $2"
> +		echo "$TID: test_line_count: line count for $3 !$1 $2"
>  		cat "$3"
>  		return 1
>  	fi
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 78c4286..6fccbe9 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -31,6 +31,8 @@ done,*)
>  	;;
>  esac
> =20
> +TID=3D$(basename ${0%%-*})
> +
>  # Keep the original TERM for say_color
>  ORIGINAL_TERM=3D$TERM
> =20
> @@ -185,7 +187,7 @@ if test -n "$color"; then
>  			*) test -n "$quiet" && return;;
>  		esac
>  		shift
> -		printf "%s" "$*"
> +		printf "$TID: %s" "$*"
>  		tput sgr0
>  		echo
>  		)
> @@ -194,12 +196,12 @@ else
>  	say_color() {
>  		test -z "$1" && test -n "$quiet" && return
>  		shift
> -		echo "$*"
> +		echo "$TID: $*"
>  	}
>  fi
> =20
>  error () {
> -	say_color error "error: $*"
> +	say_color error "$TID: error: $*"
>  	GIT_EXIT_OK=3Dt
>  	exit 1
>  }
> @@ -262,7 +264,7 @@ test_ok_ () {
> =20
>  test_failure_ () {
>  	test_failure=3D$(($test_failure + 1))
> -	say_color error "not ok - $test_count $1"
> +	say_color error "not ok $test_count - $1"
>  	shift
>  	echo "$@" | sed -e 's/^/#	/'
>  	test "$immediate" =3D "" || { GIT_EXIT_OK=3Dt; exit 1; }
> --=20
> 1.7.11.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
