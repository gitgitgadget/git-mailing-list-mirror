From: huebbe <nathanael.huebbe@informatik.uni-hamburg.de>
Subject: Re: Bug: Incorrect stripping of the [PATCH] prefix in git-am
Date: Wed, 25 Nov 2015 16:59:35 +0100
Message-ID: <5655DAE7.2000008@informatik.uni-hamburg.de>
References: <5655D3DA.1050403@informatik.uni-hamburg.de>
 <5655D755.8060503@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bOriAFSDOjE71J8Tb6J0F0gcJsHjbeQQC"
To: stefan.naewe@atlas-elektronik.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 16:59:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1cTx-0003sl-F4
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 16:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbbKYP7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 10:59:43 -0500
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:61036 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751858AbbKYP7m (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2015 10:59:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 4687EACA;
	Wed, 25 Nov 2015 16:59:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
	by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id o08Ke46G4u9O; Wed, 25 Nov 2015 16:59:40 +0100 (CET)
Received: from [136.172.14.25] (unknown [136.172.14.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: huebbe)
	by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id A78FFAC9;
	Wed, 25 Nov 2015 16:59:40 +0100 (CET)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <5655D755.8060503@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281717>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bOriAFSDOjE71J8Tb6J0F0gcJsHjbeQQC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yes, it looks like the `--keep-non-patch` option works around this.

However, shouldn't that be the default behaviour?
I mean, what is the point in stripping stuff that is not proven to be ins=
erted by `git` itself?
That's not what I expect a tool to do which I trust.

Cheers,
Nathanael



On 11/25/2015 04:44 PM, stefan.naewe@atlas-elektronik.com wrote:
> Am 25.11.2015 um 16:29 schrieb huebbe:
>> Description:
>>
>> When applying a patch created via `git format-patch` with `git am`,
>> any prefix of the commit message that's within square brackets is stri=
pped from the commit message.
>=20
> As advertised in the man page of 'git am' (or 'git mailinfo' that is).
>=20
> Is 'git am --keep-non-patch' what you're looking for ?
>=20
>>
>>
>> Reproduction:
>>
>>     $ git log --oneline --decorate --graph --all
>>     * b41514b (HEAD) [baz] baz
>>     | * 5e31740 (master) [bar] bar
>>     |/
>>     * aaf5d34 [foo] foo
>>     $ git format-patch aaf5d34
>>     $ git checkout master
>>     $ git am 0001-baz-baz.patch
>>     $ git log --oneline --decorate --graph --all
>>     * d5161b8 (HEAD, master) baz
>>     * 5e31740 [bar] bar
>>     * aaf5d34 [foo] foo
>>
>> I have omitted all output except for the `git log` output for brevity.=

>> As you can see, the commit resulting from `git am` has lost the "[bar]=
" prefix from its commit message.
>>
>> Looking at the patch,
>>
>>     $ cat 0001-baz-baz.patch
>>     From b41514be8a70fd44052bff0d3ce720373ec9cfd8 Mon Sep 17 00:00:00 =
2001
>>     From: Nathanael Huebbe <nathanael.huebbe@informatik.uni-hamburg.de=
>
>>     Date: Wed, 25 Nov 2015 15:28:09 +0100
>>     Subject: [PATCH] [baz] baz
>>
>>     ---
>>      baz | 1 +
>>      1 file changed, 1 insertion(+)
>>      create mode 100644 baz
>>
>>     diff --git a/baz b/baz
>>     new file mode 100644
>>     index 0000000..7601807
>>     --- /dev/null
>>     +++ b/baz
>>     @@ -0,0 +1 @@
>>     +baz
>>     --
>>     2.1.4
>>
>> I see that the commit message contains the "[PATCH]"-prefix that `git =
am` is supposed to strip,
>> yet it seems to incorrectly continue to also strip the "[baz]"-prefix.=

>>
>>
>> Affected versions:
>> I have reproduced the bug with versions 1.9.1, 2.1.4, and 2.6.3
>>
>>
>> Severity:
>> While I do not consider this a high priority bug, it becomes quite irk=
some in some workflows.
>> In my case, an upstream `svn` repository has the policy of using "[bra=
nch-name]" prefixes
>> to the commit messages, which are stripped whenever I transplant a com=
mit using the
>> `git format-patch`/`git am` combination.
>>
>>
>>
>=20
> HTH,
>   Stefan
>=20


--=20
Please be aware that the enemies of your civil rights and your freedom
are on CC of all unencrypted communication. Protect yourself.


--bOriAFSDOjE71J8Tb6J0F0gcJsHjbeQQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJWVdrrAAoJEO3tJW5NCfoM+NUP/RADC0GimEnYCZ67eYiy9Esj
j4esl7p+ocURjwYVhbFDeozVIs7cmV1d8UM9yKIJxjmF5Vrvry6OdqAcLMrZxLVl
KFbdnEeud/HjPTmAEiTduHS1kPHMIyKtDHSqD4ao8u9yCJFoet0DvYUbf5FBqs4Z
J9qwdlAMZb4ArUcr3B/9ASHbtuxMqZNdtSZq3RYG7KUO/v3ELHdyLoZ6cWHf0LFN
CLwLNQybCQsPpsfMReThWUd1kifTBHTfIMtaMGijKRhuGFm8f/LnTs3wlAgmtNLO
X+bSNulT0FiTbAO5n7L71qxKs//4WHLIzkFJ4edo9iWS8AjMKbVyLy8jgxbSZU1R
i66WcROkIWO326ClWy6GElPRvpItVyW+tS6oAiSYi0vSsG0ipRG7ZfZ6frzXH7qH
J45eiVTDPx04VYh2kJVJugU/eVSe5rpPcBo4GUGQi9XVoRDbaiMHGgJNVjHYaCf6
qYkrKSqxUpi3fgsLzfvxV6Vd4nG1vJhxfbmGC4E3/12kkRIm9tdRBGYHXpTHOgCA
0mfrKkKXdSc6S2hrYuvwgaxpWn+4jLMLsd3LoqSffaNfJ2l32KETsF4nmhYXhu/X
yHHZ1E/XpoL7Q9m9EYfrtsdL8ctVnMrHDPLM7Iq9eUE7l1wVP0NT9LKB4PmcEYec
4UOL3kmJguRarKidKyss
=ZKCZ
-----END PGP SIGNATURE-----

--bOriAFSDOjE71J8Tb6J0F0gcJsHjbeQQC--
