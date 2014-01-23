From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] t4010: match_pathspec_depth() and trailing slash
 after submodule
Date: Thu, 23 Jan 2014 22:25:40 +0100
Message-ID: <52E188D4.20904@web.de>
References: <2550653.GHkhBQDSTk@localhost.localdomain>	<1390483326-32258-1-git-send-email-pclouds@gmail.com>	<1390483326-32258-2-git-send-email-pclouds@gmail.com> <xmqqa9emtngr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pawel.sikora@agmk.net
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 22:25:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6Rme-0003NQ-K7
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 22:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbaAWVZq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jan 2014 16:25:46 -0500
Received: from mout.web.de ([212.227.17.12]:55837 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755155AbaAWVZo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 16:25:44 -0500
Received: from [192.168.178.41] ([79.193.68.245]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MeBPe-1VxBIB1AY2-00Pt5W for <git@vger.kernel.org>;
 Thu, 23 Jan 2014 22:25:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <xmqqa9emtngr.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:HffwYBXZvp49JJqoV+vqw6Ew+f0GvJA4HjY64vycPSI952N/fPu
 FJf6IIsywb83HoUtyQns30Sb+Vva5SBrI2fL4SgvHxM6npKoX2Kil6uydS1RDTFqbDTasIs
 rxCeGC4gYbaUucwBYENKtNMaDlWsiNEDs+QLd9IJ/XGl2IBVZepQEZRZESDvyj/S4CFpDPk
 Llo4O5jjgO6GrSBKiIr8A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240959>

Am 23.01.2014 22:09, schrieb Junio C Hamano:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>> diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
>> index 15a4912..b54251a 100755
>> --- a/t/t4010-diff-pathspec.sh
>> +++ b/t/t4010-diff-pathspec.sh
>> @@ -127,4 +127,10 @@ test_expect_success 'diff-tree ignores trailing=
 slash on submodule path' '
>>  	test_cmp expect actual
>>  '
>> =20
>> +test_expect_failure 'diff-cache ignores trailing slash on submodule=
 path' '
>> +	git diff --name-only HEAD^ submod >expect &&
>> +	git diff --name-only HEAD^ submod/ >actual &&
>=20
> I actually doubt that the second line is expecting the right
> behaviour in the first place.  As far as the top-level project is
> concerned, "submod" is the name it wants, as there is nothing
> underneath it.  Even if asked to recurse infinite levels, the caller
> shouldn't be feeding paths like "submod/a/b/c" to
> match_pathspec_depth() in the first place, no?

Agreed, "submod/a/b/c" would not make sense here. But a single
trailing '/' does mark "submod" as a directory, which I think is
ok for a submodule. And it makes life easier for the user if we
accept that, as shell completion will add it there automatically.
