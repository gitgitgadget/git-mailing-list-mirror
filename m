From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/4] diffcore-pickaxe: further refactor count_match()
Date: Sat, 28 Feb 2009 19:15:46 +0100
Message-ID: <49A97F52.4080405@lsrfire.ath.cx>
References: <cover.1235629933.git.gitster@pobox.com> <cd73512d11e63554396983ed4e9556b2d18b3e4a.1235629933.git.gitster@pobox.com> <49A88FA7.1020402@lsrfire.ath.cx> <7vy6vrgxnn.fsf@gitster.siamese.dyndns.org> <7v8wnrgkjw.fsf@gitster.siamese.dyndns.org> <49A937B8.1030205@lsrfire.ath.cx> <7vmyc6foj3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 19:17:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdTka-0004Ix-2X
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 19:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbZB1SPv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Feb 2009 13:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbZB1SPv
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 13:15:51 -0500
Received: from india601.server4you.de ([85.25.151.105]:50316 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbZB1SPu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 13:15:50 -0500
Received: from [10.0.1.101] (p57B7E62B.dip.t-dialin.net [87.183.230.43])
	by india601.server4you.de (Postfix) with ESMTPSA id 702622F8075;
	Sat, 28 Feb 2009 19:15:48 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <7vmyc6foj3.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111783>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> I get this (Ubuntu 8.10 x64, Fedora 10 x64 using the same Linux repo=
,
>> Windows Vista x64 using a different Linux repo with the same HEAD on
>> NTFS and msysgit, numbers are the elapsed time in seconds, best of f=
ive
>> runs):
>>
>>                            Ubuntu  Fedora  Windows
>>    v1.6.2-rc2                8.14    8.16    9.236
>>    v1.6.2-rc2+[1-4]          2.43    2.45    2.995
>>    v1.6.2-rc2+[1-4]+memmem   1.31    1.25    2.917
>>    v1.6.2-rc2+[1-3]+memmem   1.51    1.16    8.455
>>
>> Ubuntu has glibc 2.8, while Fedora 10 has glibc 2.9, with a new and =
more
>> efficient memmem() implementation.  On Windows, we use our own naive
>> memmem() implementation.
>=20
> Yeah, what does glibc use these days?  Some variant of Boyer-Moore?

No, the algorithm is called Two Way, which, unlike Boyer-Moore, only
needs constant space.  The implementation seems to originate from this =
bug:

	http://sourceware.org/bugzilla/show_bug.cgi?id=3D5514

And the algorithm is documented here:

	http://www-igm.univ-mlv.fr/~lecroq/string/node26.html

Ren=C3=A9
