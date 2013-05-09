From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: git rev-list | git cherry-pick --stdin is leaky
Date: Thu, 09 May 2013 10:24:35 -0700
Message-ID: <518BDBD3.8070602@codeaurora.org>
References: <517F0C18.8060703@codeaurora.org> <51804A02.6080301@lsrfire.ath.cx> <51880FB7.8020701@codeaurora.org> <518BBC6D.9070006@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu May 09 19:24:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaUa8-00063A-LK
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 19:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473Ab3EIRYg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 May 2013 13:24:36 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:25552 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab3EIRYf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 13:24:35 -0400
X-IronPort-AV: E=Sophos;i="4.87,642,1363158000"; 
   d="scan'208";a="45793621"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 May 2013 10:24:35 -0700
Received: from [10.46.166.8] (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 5089510004C7;
	Thu,  9 May 2013 10:24:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <518BBC6D.9070006@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223764>

On 05/09/13 08:10, Ren=E9 Scharfe wrote:
> Am 06.05.2013 22:16, schrieb Stephen Boyd:
>> Ok. I tested it and it definitely helps.
>>
>> =3D=3D10728=3D=3D LEAK SUMMARY:
>> =3D=3D10728=3D=3D    definitely lost: 316,355,458 bytes in 8,652 blo=
cks
>> =3D=3D10728=3D=3D    indirectly lost: 1,327,251,588 bytes in 16,180,=
628 blocks
>> =3D=3D10728=3D=3D      possibly lost: 677,049,918 bytes in 7,381,801=
 blocks
>> =3D=3D10728=3D=3D    still reachable: 9,238,039 bytes in 63,947 bloc=
ks
>> =3D=3D10728=3D=3D         suppressed: 0 bytes in 0 blocks
>>
>> vs.
>>
>> =3D=3D27614=3D=3D LEAK SUMMARY:
>> =3D=3D27614=3D=3D    definitely lost: 2,369,692,222 bytes in 20,005,=
707 blocks
>> =3D=3D27614=3D=3D    indirectly lost: 829,151,786 bytes in 9,594,715=
 blocks
>> =3D=3D27614=3D=3D      possibly lost: 658,069,373 bytes in 6,345,172=
 blocks
>> =3D=3D27614=3D=3D    still reachable: 8,806,386 bytes in 50,199 bloc=
ks
>> =3D=3D27614=3D=3D         suppressed: 0 bytes in 0 blocks
>
> Thanks, Stephen.  I'm going to prepare a series around that patch
> which will (hopefully) show that freeing these entries is safe by
> passing only const pointers down to the callbacks.  It's too late for
> 1.8.3, of course, but it shouldn't take another year as most of that
> series is done already. :)

Yes I started trying to throw const around everywhere but then I just
sent out the email in hopes someone had already solved this problem.

>
> We still have an impressive amount of leakage here.  I wonder why
> "indirectly lost" increased so much.  Do you perhaps still have the
> full output of valgrind for the run with the patch applied?

I think it increased because the first one ran to completion while the
second one failed half way through so it's not an apples to apples
comparison. I can re-run with a certain range that is known not to fail
if you're interested, but I think you got the idea that the patch helps=
=2E

--=20
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
