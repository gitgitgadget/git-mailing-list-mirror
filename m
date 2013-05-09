From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git rev-list | git cherry-pick --stdin is leaky
Date: Thu, 09 May 2013 17:10:37 +0200
Message-ID: <518BBC6D.9070006@lsrfire.ath.cx>
References: <517F0C18.8060703@codeaurora.org> <51804A02.6080301@lsrfire.ath.cx> <51880FB7.8020701@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu May 09 17:11:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaSUZ-0002wm-0S
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 17:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755251Ab3EIPKm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 May 2013 11:10:42 -0400
Received: from india601.server4you.de ([85.25.151.105]:51389 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405Ab3EIPKl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 11:10:41 -0400
Received: from [192.168.2.105] (p4FFD9FB6.dip0.t-ipconnect.de [79.253.159.182])
	by india601.server4you.de (Postfix) with ESMTPSA id D39584B9;
	Thu,  9 May 2013 17:10:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <51880FB7.8020701@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223736>

Am 06.05.2013 22:16, schrieb Stephen Boyd:
> Ok. I tested it and it definitely helps.
>
> =3D=3D10728=3D=3D LEAK SUMMARY:
> =3D=3D10728=3D=3D    definitely lost: 316,355,458 bytes in 8,652 bloc=
ks
> =3D=3D10728=3D=3D    indirectly lost: 1,327,251,588 bytes in 16,180,6=
28 blocks
> =3D=3D10728=3D=3D      possibly lost: 677,049,918 bytes in 7,381,801 =
blocks
> =3D=3D10728=3D=3D    still reachable: 9,238,039 bytes in 63,947 block=
s
> =3D=3D10728=3D=3D         suppressed: 0 bytes in 0 blocks
>
> vs.
>
> =3D=3D27614=3D=3D LEAK SUMMARY:
> =3D=3D27614=3D=3D    definitely lost: 2,369,692,222 bytes in 20,005,7=
07 blocks
> =3D=3D27614=3D=3D    indirectly lost: 829,151,786 bytes in 9,594,715 =
blocks
> =3D=3D27614=3D=3D      possibly lost: 658,069,373 bytes in 6,345,172 =
blocks
> =3D=3D27614=3D=3D    still reachable: 8,806,386 bytes in 50,199 block=
s
> =3D=3D27614=3D=3D         suppressed: 0 bytes in 0 blocks

Thanks, Stephen.  I'm going to prepare a series around that patch which=
=20
will (hopefully) show that freeing these entries is safe by passing onl=
y=20
const pointers down to the callbacks.  It's too late for 1.8.3, of=20
course, but it shouldn't take another year as most of that series is=20
done already. :)

We still have an impressive amount of leakage here.  I wonder why=20
"indirectly lost" increased so much.  Do you perhaps still have the ful=
l=20
output of valgrind for the run with the patch applied?

Thanks,
Ren=E9
