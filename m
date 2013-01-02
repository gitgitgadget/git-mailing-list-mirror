From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/4] test: Add target test-lint-shell-syntax
Date: Thu, 03 Jan 2013 00:58:45 +0100
Message-ID: <50E4C9B5.8070308@web.de>
References: <201301012240.10722.tboegi@web.de> <20130102094635.GD9328@sigill.intra.peff.net> <50E4BF58.4090808@web.de> <20130102232239.GA27952@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 03 00:59:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqYDD-0000M0-8z
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 00:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769Ab3ABX6t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2013 18:58:49 -0500
Received: from mout.web.de ([212.227.17.11]:64052 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785Ab3ABX6r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 18:58:47 -0500
Received: from [192.168.2.107] ([79.244.162.201]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MZlR4-1TaWzb3ObG-00LUdc; Thu, 03 Jan 2013 00:58:46
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20130102232239.GA27952@sigill.intra.peff.net>
X-Provags-ID: V02:K0:ek3H41lbmy1+O91ALKWbtybVCieI6xG8BKnaWhi9xsH
 MKe+ba4mEOY2kBStSipkRmxgSCNaAFcQNSxssTWsAGDuyTZZoX
 6cZpCKjq97oCezaEPqOCMywPgu3De7jI1X4LMAQQ+3ZlQauU9l
 yP7c+k4IgzTV2ih8xMI9/g7uZ2vNcyjd/AIKDOgHrAcfB/SAIL
 UWTWTqBwkFqvm6OjJOEmQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212559>

On 03.01.13 00:22, Jeff King wrote:
> On Thu, Jan 03, 2013 at 12:14:32AM +0100, Torsten B=F6gershausen wrot=
e:
>=20
>>> This is wrong if $(PERL_PATH) contains spaces, no? Doing "$(PERL_PA=
TH)"
>>> is also wrong, because the expansion happens in 'make', and a
>>> $(PERL_PATH) with double-quotes would fool the shell. Since we expo=
rt
>>> $PERL_PATH, I think doing:
>>>
>>>   "$$PERL_PATH"" check-non-portable-shell.pl $(T)
>> Thanks, but:            =20
>> - The double "" after PERL_PATH makes the string un-terminated.
>=20
> Yeah, sorry, typo on my part.
>=20
>> - Using "$$PERL_PATH" expands from make into "$PERL_PATH" on the com=
mand line
>=20
> Right. That's what I intended.
>=20
>> - If the Makefile looks like this:
>> PERL_PATH =3D "/Users/tb/projects/git/tb/pe rl"
>> [snip]
>> $(PERL_PATH) check-non-portable-shell.pl $(T)
>> The command line will look like this:
>> "/Users/tb/projects/git/tb/pe rl" check-non-portable-shell.pl t0000-=
basic.sh ...
>>
>> So I think that PERL_PATH should be quoted when it is defined in the=
 Makefile.
>=20
> Does a $PERL_PATH with quotes actually work?
At least on my system the following combination works:

git diff
diff --git a/t/Makefile b/t/Makefile
index f8f8c54..391a5ca 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -8,7 +8,7 @@
=20
 #GIT_TEST_OPTS =3D --verbose --debug
 SHELL_PATH ?=3D $(SHELL)
-PERL_PATH ?=3D /usr/bin/perl
+PERL_PATH =3D "/Users/tb/projects/git/tb/pe rl"
 TAR ?=3D $(TAR)
 RM ?=3D rm -f
 PROVE ?=3D prove

~/projects/git/tb/t> ls -l "/Users/tb/projects/git/tb/pe rl"
lrwxr-xr-x  1 tb  staff  13 Jan  3 00:33 /Users/tb/projects/git/tb/pe r=
l -> /usr/bin/perl

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
And this works as well, is that what you intended?
Note: "single Dollar"
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
 git diff
diff --git a/t/Makefile b/t/Makefile
index f8f8c54..f624f95 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -8,7 +8,7 @@
=20
 #GIT_TEST_OPTS =3D --verbose --debug
 SHELL_PATH ?=3D $(SHELL)
-PERL_PATH ?=3D /usr/bin/perl
+PERL_PATH =3D /Users/tb/projects/git/tb/pe rl
 TAR ?=3D $(TAR)
 RM ?=3D rm -f
 PROVE ?=3D prove
@@ -57,7 +57,7 @@ test-lint-executable:
                echo >&2 "non-executable tests:" $$bad; exit 1; }
=20
 test-lint-shell-syntax:
-       $(PERL_PATH) check-non-portable-shell.pl $(T)
+       "$(PERL_PATH)" check-non-portable-shell.pl $(T)
=20



> Usually in our runtime environment, commands that are handed to git a=
re
> assumed to be passed directly to the shell, and you need to quote. E.=
g.,
> setting diff.external to:
>=20
>   [diff]
>   external =3D "foo --bar"
>=20
> will let the shell split the argument out; if you have a space, you
> would want to set it like:
>=20
>   [diff]
>   external =3D "'command with space'"
>=20
> This is the most flexible way to do it.
>=20
> However, for Makefile variables, I think we do not (and cannot) follo=
w
> the same rule.  Notice that all of the uses of $PERL_PATH in the test
> suite enclose it in quotes. Having extra quotes would break those
> invocations. And the value of $PERL_PATH will be put on the #!-line,
> which cannot not be quoted.
>=20
> -Peff
I followed these lines as an example:

test-results/git-smoke.tar.gz: test-results
	$(PERL_PATH) ./harness \
		--archive=3D"test-results/git-smoke.tar.gz" \
		$(T)

(and make smoke did not work, as we don't have ./harness :-(

Do we need some cleanup/improvements here as well?

/Torsten
