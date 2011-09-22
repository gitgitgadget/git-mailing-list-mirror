From: wanghui <Hui.Wang@windriver.com>
Subject: Re: [PATCH] abspath: increase array size of cwd variable to PATH_MAX
Date: Thu, 22 Sep 2011 10:09:48 +0800
Message-ID: <4E7A98EC.6040007@windriver.com>
References: <1316425872-30457-1-git-send-email-Hui.Wang@windriver.com> <7v8vpkbhyv.fsf@alter.siamese.dyndns.org> <4E791A40.6040102@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Sep 22 04:10:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6Yjg-0005Gz-2t
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 04:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385Ab1IVCJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 22:09:55 -0400
Received: from mail.windriver.com ([147.11.1.11]:57863 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab1IVCJz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 22:09:55 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p8M29nAH014002
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 21 Sep 2011 19:09:49 -0700 (PDT)
Received: from [128.224.163.220] (128.224.163.220) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0; Wed, 21 Sep
 2011 19:09:49 -0700
User-Agent: Thunderbird 2.0.0.24 (X11/20101027)
In-Reply-To: <4E791A40.6040102@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181875>

Ramsay Jones wrote:
> Junio C Hamano wrote:
>   
>> Wang Hui <Hui.Wang@windriver.com> writes:
>>
>>     
>>> diff --git a/abspath.c b/abspath.c
>>> index f04ac18..2ce1db9 100644
>>> --- a/abspath.c
>>> +++ b/abspath.c
>>> @@ -24,7 +24,7 @@ int is_directory(const char *path)
>>>  const char *real_path(const char *path)
>>>  {
>>>  	static char bufs[2][PATH_MAX + 1], *buf = bufs[0], *next_buf = bufs[1];
>>> -	char cwd[1024] = "";
>>> +	char cwd[PATH_MAX] = "";
>>>       
>> Thanks.
>>
>> This does not make things worse but in the longer term we should move away
>> from using PATH_MAX in general.
>>     
>
> Hmm, the subject line says "... increase array size ...", but that is not
> necessarily what this patch is doing! :-D
>
> Yes, on some platforms PATH_MAX will be larger than 1024 (e.g. 4096 on Linux),
> but that is not even true of all POSIX systems. POSIX defines the *minimum*
> value of PATH_MAX that systems must support (as #define _POSIX_PATH_MAX) of 255.
> [it also requires that POSIX conforming applications must not *require* a value
> larger than 255].
>
> However, we don't have to look too far to find systems with much smaller values.
> On Cygwin, for example:
>
>     $ cat -n junk.c
>          1  #include <stdio.h>
>          2  #include <limits.h>
>          3
>          4  int main(int argc, char *argv[])
>          5  {
>          6          printf("PATH_MAX is %d\n", PATH_MAX);
>          7          return 0;
>          8  }
>     $ gcc -o junk junk.c
>     $ ./junk
>     $ PATH_MAX is 260
>     $ 
>
> On MinGW the answer is 259.
>
> So, I certainly agree that moving away from PATH_MAX is a good idea, but I'm
> not sure I agree that this patch "does not make things worse" ... (I haven't
> given it *any* thought!).
>   
Hi Ramsay,

Do you mean the PATH_MAX of a system should not be the limitation for 
the git. That is to say, the git can handle the path which has name 
longer than PATH_MAX? If it is, my patch is not needed here. :-)
> [Also, note commits f66cf96, fd55a19, 620e2bb, etc...]
>
> ATB,
> Ramsay Jones
>
>
>   
