From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sun, 20 Jan 2013 11:48:53 +0100
Message-ID: <50FBCB95.6020201@web.de>
References: <20130106120917.GC22081@elie.Belkin> <7vfw2enl2l.fsf@alter.siamese.dyndns.org> <50E9F7C2.1000603@gmail.com> <FBDECCA565D94DF9838DD81FE2E2543A@black> <7v1udxladc.fsf@alter.siamese.dyndns.org> <50EB8EB5.6080204@gmail.com> <CALxABCYHRp17rcoOca1xWG9S19fq2rotz8FEKo09jNdrgMLiyQ@mail.gmail.com> <CALxABCavvW77djKQnbQsjCBcahmMfrP24SDz609NG-94_ifZ9Q@mail.gmail.com> <50F303D8.20709@gmail.com> <50F5A435.5090408@ramsay1.demon.co.uk> <20130120101007.GD16339@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Stephen & Linda Smith <ischis2@cox.net>,
	Eric Blake <eblake@redhat.com>,
	msysGit <msysgit@googlegroups.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 11:49:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwsSs-0001OI-8h
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 11:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509Ab3ATKtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 05:49:03 -0500
Received: from mout.web.de ([212.227.17.12]:59026 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249Ab3ATKtC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 05:49:02 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0M7bYJ-1T1lej1LR1-00waKh; Sun, 20 Jan 2013 11:48:55
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <20130120101007.GD16339@elie.Belkin>
X-Provags-ID: V02:K0:R2IY3F1s2Dj2q0WID+lroaEyBYlT6xa0QKHLfmZP9mv
 rtv3LcKAoPL6N9MU2sTSQLM2HumOWxQaew4XeJVSJCzCjRuQaB
 2+LqMlhmI3lEoVUHc283/NZI6aDLz4uV7YniAkrAWxbobxaqth
 lUx8i4KBl9sBORFnkm2uGGz8q1G4H7Jq1NdIq4zaRmnhmOFizQ
 TxIumXCQS+36Nsze//HeA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214000>

On 20.01.13 11:10, Jonathan Nieder wrote:
> Ramsay Jones wrote:
> 
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -85,12 +85,6 @@
>>  #define _NETBSD_SOURCE 1
>>  #define _SGI_SOURCE 1
>>  
>> -#ifdef WIN32 /* Both MinGW and MSVC */
>> -#define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
>> -#include <winsock2.h>
>> -#include <windows.h>
>> -#endif
> 
> So, do I understand correctly that the above conditional should be
> something like
> 
>  #if defined(WIN32) && !defined(__CYGWIN__)
> 
> to allow dropping the CYGWIN_V15_WIN32API setting?
> 
> "defined(WIN32)" is used throughout git to mean "win32 and not
> cygwin", so if I understand correctly we would either need to do
> 
>  #if defined(WIN32) && defined(__CYGWIN__)
>  # undef WIN32
>  #endif
> 
> or define a new GIT_WIN32 (name is just a placeholder) macro to use
> consistently in its stead.
> 
> Thanks for investigating.
> Jonathan

I wonder, if if we can go one step further:

Replace
#ifdef WIN32 /* Both MinGW and MSVC */
#define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
#include <winsock2.h>
#include <windows.h>
#endif

with
#if defined(_MSC_VER)
#define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
#include <winsock2.h>
#include <windows.h>
#endif

Any thougths from msysGit ?
/Torsten
