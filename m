From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 3/3] pretty: add aliases for pretty formats
Date: Sun, 2 May 2010 07:30:39 -0500
Message-ID: <20100502123039.GB13419@progeny.tock>
References: <1272798044-10487-1-git-send-email-wmpalmer@gmail.com>
 <1272798044-10487-4-git-send-email-wmpalmer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 02 14:30:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8YJv-0005Dj-B3
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 14:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301Ab0EBMao convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 May 2010 08:30:44 -0400
Received: from mail-iw0-f182.google.com ([209.85.223.182]:39012 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121Ab0EBMan (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 08:30:43 -0400
Received: by iwn12 with SMTP id 12so2101653iwn.15
        for <git@vger.kernel.org>; Sun, 02 May 2010 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=GsIWp+/nCcaYHI7/onfnM0usQ5mllKBj9diDb2Q1sGw=;
        b=hMgxPxzjbQMbCo6NPs6Evuf4gmtJi627CpKth18ozkkFBNSD6wJ6YG7A/M704DIbgs
         kmN3bYx8SBWYyxYHbcvhEmsH8MnugMxr9ycW+vaNKSX8Q+E0k9PKYFgsUUkwqobLCAJh
         urokH1oYtdG4FVoNWnr3zQlRHbnPlM1gDOIsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Mo9TwzAptSMU5iOXIZttSO7f1GXz7mo9hlLF8WUFF02jU0OhG2NoJtPX+j+C/+Kv6j
         6iFCUy+1L+pRmAbUxZZn9+myNOsIoc/vpqcMqjVsxan619UZkyf6j1xUrPfqwNXFKfJ4
         5i2Sz89zT6/Xlsb4ienqcJUJJG15zhh9y/Z4s=
Received: by 10.231.170.84 with SMTP id c20mr3570968ibz.62.1272803441338;
        Sun, 02 May 2010 05:30:41 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm3415739iwn.6.2010.05.02.05.30.39
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 05:30:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1272798044-10487-4-git-send-email-wmpalmer@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146168>

Will Palmer wrote:

> Signed-off-by: Will Palmer <wmpalmer@gmail.com>
[...]
> +pretty.<name>::
> +	Alias for a --pretty=3D format string, as specified in
> +	linkgit:git-log[1]. Any aliases defined here can be used just
> +	as the built-in pretty formats could. For example, defining
> +	"pretty.hash =3D format:%H" would cause the invocation
> +	"git log --pretty=3Dhash" to be equivalent to running
> +	"git log --pretty=3Dformat:%H".

This =E2=80=9Csection.key =3D value=E2=80=9D syntax neither matches the=
 =E2=80=98git config=E2=80=99
command line nor .gitconfig file syntax.  I know alias.<name> uses the
same wording, but maybe we can be clearer this time.  E.g., since this
is the git-config(1) manual page,

	For example, running `git config pretty.changelog "format:* %H %s"`
	would cause the invocation `git log --pretty=3Dchangelog` to be
	equivalent to running `git log '--pretty=3Dformat:* %H %s'`.

> +static int git_pretty_formats_config(const char *var, const char *va=
lue, void *cb)
> +{
> +	struct cmt_fmt_map *commit_format =3D NULL;
> +	const char *name;
> +	const char *fmt;
> +	int i;
> +
> +	if (prefixcmp(var, "pretty."))
> +		return 0;
> +
> +	name =3D &var[7];

Can this magic number be avoided?  Maybe

	name =3D &var[strlen("pretty.")];

> +++ b/t/t4205-log-pretty-formats.sh
[...]
> +test_expect_code 128 'alias non-existant format' '
> +	git config pretty.test-alias format-that-will-never-exist &&
> +	git log --pretty=3Dtest-alias'

This will succeed if the =E2=80=98git config=E2=80=99 fails.  Why not u=
se

	test_expect_success 'alias non-existent format' '
		git config ... &&
		test_must_fail git log --pretty=3Dtest-alias
	'

or something like

	test_exit_status() {
		test "${2+set}" || return 1
		code=3D$1
		shift
		eval "$*"
		test $code -eq $?
	}

	test_expect_success 'alias non-existent format' '
		git config ... &&
		test_exit_status 128 git log --pretty=3Dtest-alias
	'

?

[...]
> +test_expect_code 128 'alias loop' '
> +	git config pretty.test-foo test-bar &&
> +	git config pretty.test-bar test-foo &&
> +	git log --pretty=3Dtest-foo'

Likewise.

With whatever subset of the above changes you deem suitable,

  Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks again.

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 85d5b90..03f2a29 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1469,11 +1469,12 @@ pager.<cmd>::
 pretty.<name>::
 	Alias for a --pretty=3D format string, as specified in
 	linkgit:git-log[1]. Any aliases defined here can be used just
-	as the built-in pretty formats could. For example, defining
-	"pretty.hash =3D format:%H" would cause the invocation
-	"git log --pretty=3Dhash" to be equivalent to running
-	"git log --pretty=3Dformat:%H". Note that an alias with the same
-	name as a built-in format will be silently ignored.
+	as the built-in pretty formats could. For example,
+	running `git config pretty.changelog "format:* %H %s"`
+	would cause the invocation `git log --pretty=3Dchangelog`
+	to be equivalent to running `git log '--pretty=3Dformat:* %H %s'`.
+	Note that an alias with the same name as a built-in format
+	will be silently ignored.
=20
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
diff --git a/pretty.c b/pretty.c
index 1c16bf8..9e3b26b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -42,7 +42,7 @@ static int git_pretty_formats_config(const char *var,=
 const char *value, void *c
 	if (prefixcmp(var, "pretty."))
 		return 0;
=20
-	name =3D &var[7];
+	name =3D &var[strlen("pretty.")];
 	for (i =3D 0; i < builtin_formats_len; i++) {
 		if (!strcmp(commit_formats[i].name, name))
 			return 0;
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
=2Esh
index af96984..cb9f2bd 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -14,53 +14,61 @@ test_expect_success 'set up basic repos' '
 	git commit -m initial &&
 	git add bar &&
 	test_tick &&
-	git commit -m "add bar"'
+	git commit -m "add bar"
+'
=20
 test_expect_success 'alias builtin format' '
 	git log --pretty=3Doneline >expected &&
 	git config pretty.test-alias oneline &&
 	git log --pretty=3Dtest-alias >actual &&
-	test_cmp expected actual'
+	test_cmp expected actual
+'
=20
 test_expect_success 'alias masking builtin format' '
 	git log --pretty=3Doneline >expected &&
 	git config pretty.oneline "%H" &&
 	git log --pretty=3Doneline >actual &&
-	test_cmp expected actual'
+	test_cmp expected actual
+'
=20
 test_expect_success 'alias user-defined format' '
 	git log --pretty=3D"format:%h" >expected &&
 	git config pretty.test-alias "format:%h" &&
 	git log --pretty=3Dtest-alias >actual &&
-	test_cmp expected actual'
+	test_cmp expected actual
+'
=20
 test_expect_success 'alias user-defined tformat' '
 	git log --pretty=3D"tformat:%h" >expected &&
 	git config pretty.test-alias "tformat:%h" &&
 	git log --pretty=3Dtest-alias >actual &&
-	test_cmp expected actual'
+	test_cmp expected actual
+'
=20
-test_expect_code 128 'alias non-existant format' '
+test_expect_success 'alias non-existant format' '
 	git config pretty.test-alias format-that-will-never-exist &&
-	git log --pretty=3Dtest-alias'
+	test_must_fail git log --pretty=3Dtest-alias
+'
=20
 test_expect_success 'alias of an alias' '
 	git log --pretty=3D"tformat:%h" >expected &&
 	git config pretty.test-foo "tformat:%h" &&
 	git config pretty.test-bar test-foo &&
-	git log --pretty=3Dtest-bar >actual &&
-	test_cmp expected actual'
+	git log --pretty=3Dtest-bar >actual && test_cmp expected actual
+'
=20
 test_expect_success 'alias masking an alias' '
 	git log --pretty=3Dformat:"Two %H" >expected &&
 	git config pretty.duplicate "format:One %H" &&
 	git config --add pretty.duplicate "format:Two %H" &&
 	git log --pretty=3Dduplicate >actual &&
-	test_cmp expected actual'
+	test_cmp expected actual
+'
=20
-test_expect_code 128 'alias loop' '
+test_expect_success 'alias loop' '
 	git config pretty.test-foo test-bar &&
 	git config pretty.test-bar test-foo &&
-	git log --pretty=3Dtest-foo'
+	test_must_fail git log --pretty=3Dtest-foo
+'
=20
 test_done
