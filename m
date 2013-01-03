From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/4] test: Add target test-lint-shell-syntax
Date: Thu, 03 Jan 2013 01:23:26 +0100
Message-ID: <50E4CF7E.9090302@web.de>
References: <201301012240.10722.tboegi@web.de> <20130102094635.GD9328@sigill.intra.peff.net> <50E4BF58.4090808@web.de> <20130102232239.GA27952@sigill.intra.peff.net> <50E4C9B5.8070308@web.de> <7vlicbyvc2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 01:24:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqYbK-0001ts-4w
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 01:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031Ab3ACAXo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2013 19:23:44 -0500
Received: from mout.web.de ([212.227.15.4]:56205 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753015Ab3ACAXm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 19:23:42 -0500
Received: from [192.168.2.107] ([79.244.162.201]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0Md4V8-1TZRBK2G8Y-00INBC; Thu, 03 Jan 2013 01:23:29
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vlicbyvc2.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:vR1/ZmWqT/tak3mDs3jMFMIrCWp04v8XOp4LPps8AeD
 MJZ4GLSxbfxSyvbi+dM3XRmYWwUbSK2HQB//7hA6uTu8NdVK1Q
 POP6l4SVcChQYxj2NUG5vK5nRwVF8UHGlQFsdfnxWIG61RSJNP
 816Z3qFpb62EA2ghyxvwPUl15jOtio/2105YAvKnCfw7OPOkdA
 oHfbc/tiV5sgmJiEN50uQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212563>

On 03.01.13 01:16, Junio C Hamano wrote:
> Torsten B=F6gershausen <tboegi@web.de> writes:
>=20
>> At least on my system the following combination works:
>>
>> git diff
>> diff --git a/t/Makefile b/t/Makefile
>> index f8f8c54..391a5ca 100644
>> --- a/t/Makefile
>> +++ b/t/Makefile
>> @@ -8,7 +8,7 @@
>> =20
>>  #GIT_TEST_OPTS =3D --verbose --debug
>>  SHELL_PATH ?=3D $(SHELL)
>> -PERL_PATH ?=3D /usr/bin/perl
>> +PERL_PATH =3D "/Users/tb/projects/git/tb/pe rl"
>=20
> I do not think that will fly.  Having that in the main Makefile
> where the existing users of the symbol relies on it without any
> surrounding quotes, e.g.
>=20
> $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl GIT-VERSION-FILE
> 	$(QUIET_GEN)$(RM) $@ $@+ && \
> 	INSTLIBDIR=3D`MAKEFLAGS=3D $(MAKE) -C perl -s --no-print-directory i=
nstlibdir` && \
> 	sed -e '1{' \
> 	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
> 	    -e '	h' \
> 	    -e '	s=3D.*=3Duse lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || =
"'"$$INSTLIBDIR"'"));=3D' \
> 	    -e '	H' \
> 	    -e '	x' \
> 	    -e '}' \
> 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
> 	    $@.perl >$@+ && \
> 	chmod +x $@+ && \
> 	mv $@+ $@
>=20
> where $(PERL_PATH_SQ) is defined to replace each ' in $(PERL_PATH)
> with '\'' so that '$(PERL_PATH_SQ)' becomes a shell-safe way to
> quote the value of PERL_PATH without quotes, your definition will
> look for a relative path that is inside a directory named '"'
> (that's a single double-quote).

Thanks to all for the explanations, fixing up and queing.

And good news:
pu today is "clean",there where no problems found:

commit d69ea46220647c048d332c471a184446cce17627
Merge: e552539 fcf30b3
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed Jan 2 12:44:33 2013 -0800


When the dust has settled, we can either enable the check always, or me=
ntion
"make test-lint-shell-syntax" in the Documentation.
