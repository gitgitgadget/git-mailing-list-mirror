From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/4] test: Add target test-lint-shell-syntax
Date: Thu, 03 Jan 2013 00:14:32 +0100
Message-ID: <50E4BF58.4090808@web.de>
References: <201301012240.10722.tboegi@web.de> <20130102094635.GD9328@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 03 00:15:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqXWe-0006w7-RB
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 00:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811Ab3ABXOt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2013 18:14:49 -0500
Received: from mout.web.de ([212.227.15.4]:56833 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206Ab3ABXOs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 18:14:48 -0500
Received: from [192.168.2.107] ([79.244.162.201]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MfHQo-1Tg8AN2PX8-00OxlV; Thu, 03 Jan 2013 00:14:34
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20130102094635.GD9328@sigill.intra.peff.net>
X-Provags-ID: V02:K0:2s0YDtyKr8ZXMdKWY2g1oCy6XyuLv8Z5+tzfRr23/E3
 aZsQNi6o3H5us2C2Odh0kLr9o7+IGjycxKM5Wi73fmGzoeY66O
 aWyE0cBJn5jBUSrqd3WX8ZbKDLR+lFYZpz8MBxA6/a9G29SxmJ
 PburbWoNcOqCTSxrKbnKKKewYXiYJ2gG5L47McrB5HFmsI/Cjq
 W2cKO4Y5NheZ3IdxpmVlA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212554>

On 02.01.13 10:46, Jeff King wrote:> On Tue, Jan 01, 2013 at 10:40:08PM=
 +0100, Torsten B=F6gershausen wrote:
>=20
>> Add the perl script "check-non-portable-shell.pl" to detect non-port=
able
>> shell syntax
>=20
> Cool. Thanks for adding more test-lint. But...
>=20
>> diff --git a/t/Makefile b/t/Makefile
>> index 88e289f..7b0c4dc 100644
>> --- a/t/Makefile
>> +++ b/t/Makefile
>> @@ -23,7 +23,7 @@ TGITWEB =3D $(sort $(wildcard t95[0-9][0-9]-*.sh))
>> =20
>>  all: $(DEFAULT_TEST_TARGET)
>> =20
>> -test: pre-clean $(TEST_LINT)
>> +test: pre-clean test-lint-shell-syntax $(TEST_LINT)
>>  	$(MAKE) aggregate-results-and-cleanup
>=20
> I do not think it should be a hard-coded dependency of "test", as the=
n
> there is no way to turn it off. It would make more sense to me to set=
 a
> default TEST_LINT that includes it, but could be overridden by the us=
er.
>=20
>>  prove: pre-clean $(TEST_LINT)
>> @@ -43,7 +43,7 @@ clean-except-prove-cache:
>>  clean: clean-except-prove-cache
>>  	$(RM) .prove
>> =20
>> -test-lint: test-lint-duplicates test-lint-executable
>> +test-lint: test-lint-duplicates test-lint-executable test-lint-shel=
l-syntax
>=20
> This, however, is right. The point of "test-lint" is "use all the lin=
t",
> so adding it here makes sense (and anyone who has set "TEST_LINT =3D
> test-lint" will get the new check).
>=20
>> +test-lint-shell-syntax:
>> +	$(PERL_PATH) check-non-portable-shell.pl $(T)
>=20
> This is wrong if $(PERL_PATH) contains spaces, no? Doing "$(PERL_PATH=
)"
> is also wrong, because the expansion happens in 'make', and a
> $(PERL_PATH) with double-quotes would fool the shell. Since we export
> $PERL_PATH, I think doing:
>=20
>   "$$PERL_PATH"" check-non-portable-shell.pl $(T)
Thanks, but:            =20
- The double "" after PERL_PATH makes the string un-terminated.

- Using "$$PERL_PATH" expands from make into "$PERL_PATH" on the comman=
d line

- If the Makefile looks like this:
PERL_PATH =3D "/Users/tb/projects/git/tb/pe rl"
[snip]
$(PERL_PATH) check-non-portable-shell.pl $(T)
The command line will look like this:
"/Users/tb/projects/git/tb/pe rl" check-non-portable-shell.pl t0000-bas=
ic.sh ...

So I think that PERL_PATH should be quoted when it is defined in the Ma=
kefile.

[snip]
Peff, many thanks. Please see V2 patch comming soon
