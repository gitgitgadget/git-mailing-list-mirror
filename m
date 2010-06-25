From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/4] msvc: Select the "fast" definition of the {get,put}_be32()
 macros
Date: Fri, 25 Jun 2010 21:13:06 +0100
Message-ID: <4C250DD2.2030801@ramsay1.demon.co.uk>
References: <4C2264B6.5010906@ramsay1.demon.co.uk> <20100624112148.GA12485@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 26 20:02:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSZi4-0008P4-EV
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 20:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718Ab0FZSCW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jun 2010 14:02:22 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:36242 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753455Ab0FZSCS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Jun 2010 14:02:18 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1OSZhp-00026j-n3; Sat, 26 Jun 2010 18:02:17 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20100624112148.GA12485@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149763>

Jonathan Nieder wrote:
> Ramsay Jones wrote:
>=20
>> diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
>> index d893475..e102856 100644
>> --- a/block-sha1/sha1.c
>> +++ b/block-sha1/sha1.c
>> @@ -70,6 +70,7 @@
>>   */
>> =20
>>  #if defined(__i386__) || defined(__x86_64__) || \
>> +    defined(_M_IX86) || defined(_M_X64) || \
>>      defined(__ppc__) || defined(__ppc64__) || \
>>      defined(__powerpc__) || defined(__powerpc64__) || \
>>      defined(__s390__) || defined(__s390x__)
>=20
> Looks good to me, for what it=E2=80=99s worth.  You might want a simi=
lar
> change on line 57:
>=20
> =20
> -#if defined(__i386__) || defined(__x86_64__)
> +#if defined(__i386__) || defined(__x86_64__) || \
> +	defined(_M_IX86) || defined(_M_X64)
>    #define setW(x, val) (*(volatile unsigned int *)&W(x) =3D (val))

I looked at this, but decided not to make this change (while adding
an item to my TODO list to investigate further).

After reading the large comment before line 57, and with a vague
recollection of the mailing list discussion, I was left with the
impression that this was aimed specifically at a quirk of the gcc
code generator. In other words, maybe line 57 should read:

#if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))

I don't know ... anyway I suspect that msvc has a different set of
code generation quirks! :-P

It should probably be investigated at some point, but I don't think
it's an urgent issue (and the msvc build will be no worse off ;-).

ATB,
Ramsay Jones
