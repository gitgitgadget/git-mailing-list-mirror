From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/4] Convert resolve_ref+xstrdup to new resolve_refdup
 function
Date: Tue, 13 Dec 2011 15:09:12 +0100
Message-ID: <4EE75C88.5060700@alum.mit.edu>
References: <1323688832-32016-1-git-send-email-pclouds@gmail.com> <1323688832-32016-2-git-send-email-pclouds@gmail.com> <7vpqft4qap.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 15:09:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaT2s-0007Pc-1x
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 15:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266Ab1LMOJT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Dec 2011 09:09:19 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:51344 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202Ab1LMOJR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 09:09:17 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBDE9CkX001874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 13 Dec 2011 15:09:12 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vpqft4qap.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187019>

On 12/12/2011 07:07 PM, Junio C Hamano wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>=20
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>=20
> Thanks.
>=20
> The patch looks correct but I have a slight maintainability concern a=
nd a
> suggestion for possible improvement.
>=20
>> ...
>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> index b7c6302..a66d3eb 100644
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -696,17 +696,14 @@ static int switch_branches(struct checkout_opt=
s *opts, struct branch_info *new)
>>  {
>>  	int ret =3D 0;
>>  	struct branch_info old;
>> +	char *path;
>>  	unsigned char rev[20];
>>  	int flag;
>>  	memset(&old, 0, sizeof(old));
>> -	old.path =3D resolve_ref("HEAD", rev, 0, &flag);
>> -	if (old.path)
>> -		old.path =3D xstrdup(old.path);
>> +	old.path =3D path =3D resolve_refdup("HEAD", rev, 0, &flag);
>=20
> This uses "one 'const char *' pointer that is used for reading data f=
rom
> and an extra 'char *' pointer that is used only for freeing" approach=
,
> which has two advantages and one disadvantage:
> [...]
> When naming a "for-freeing" pointer variable, the kind of data the ar=
ea of
> memory happens to contain is of secondary importance. Being deliberat=
ely
> vague about what the area of memory may contain is a good thing, beca=
use
> it actively discourages the program from looking at the area via the
> pointer if the variable is named "to_free" or something that does not
> specify what it contains.

The to_free variable could even be declared void* to make it even less
(ab)usable.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
