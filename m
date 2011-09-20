From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] abspath: increase array size of cwd variable to PATH_MAX
Date: Tue, 20 Sep 2011 23:57:04 +0100
Message-ID: <4E791A40.6040102@ramsay1.demon.co.uk>
References: <1316425872-30457-1-git-send-email-Hui.Wang@windriver.com> <7v8vpkbhyv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Wang Hui <Hui.Wang@windriver.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 19:25:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6QXb-00059I-0Q
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 19:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413Ab1IURYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 13:24:53 -0400
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:56278 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752637Ab1IURYw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 13:24:52 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1R6QXR-0004pN-m6; Wed, 21 Sep 2011 17:24:51 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7v8vpkbhyv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181852>

Junio C Hamano wrote:
> Wang Hui <Hui.Wang@windriver.com> writes:
> 
>> diff --git a/abspath.c b/abspath.c
>> index f04ac18..2ce1db9 100644
>> --- a/abspath.c
>> +++ b/abspath.c
>> @@ -24,7 +24,7 @@ int is_directory(const char *path)
>>  const char *real_path(const char *path)
>>  {
>>  	static char bufs[2][PATH_MAX + 1], *buf = bufs[0], *next_buf = bufs[1];
>> -	char cwd[1024] = "";
>> +	char cwd[PATH_MAX] = "";
> 
> Thanks.
> 
> This does not make things worse but in the longer term we should move away
> from using PATH_MAX in general.

Hmm, the subject line says "... increase array size ...", but that is not
necessarily what this patch is doing! :-D

Yes, on some platforms PATH_MAX will be larger than 1024 (e.g. 4096 on Linux),
but that is not even true of all POSIX systems. POSIX defines the *minimum*
value of PATH_MAX that systems must support (as #define _POSIX_PATH_MAX) of 255.
[it also requires that POSIX conforming applications must not *require* a value
larger than 255].

However, we don't have to look too far to find systems with much smaller values.
On Cygwin, for example:

    $ cat -n junk.c
         1  #include <stdio.h>
         2  #include <limits.h>
         3
         4  int main(int argc, char *argv[])
         5  {
         6          printf("PATH_MAX is %d\n", PATH_MAX);
         7          return 0;
         8  }
    $ gcc -o junk junk.c
    $ ./junk
    $ PATH_MAX is 260
    $ 

On MinGW the answer is 259.

So, I certainly agree that moving away from PATH_MAX is a good idea, but I'm
not sure I agree that this patch "does not make things worse" ... (I haven't
given it *any* thought!).

[Also, note commits f66cf96, fd55a19, 620e2bb, etc...]

ATB,
Ramsay Jones
