From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH v3 1/4] poll() exits too early with EFAULT if 1st arg is NULL
Date: Thu, 13 Sep 2012 09:15:44 +0200
Message-ID: <k2s177$l37$1@ger.gmane.org>
References: <003a01cd8cf7$af821100$0e863300$@schmitz-digital.de> <k2n79l$s9e$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 13 09:16:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TC3ep-00045i-Sz
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 09:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210Ab2IMHQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 03:16:06 -0400
Received: from plane.gmane.org ([80.91.229.3]:34061 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069Ab2IMHQF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 03:16:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TC3eg-0003tM-KF
	for git@vger.kernel.org; Thu, 13 Sep 2012 09:16:06 +0200
Received: from dsdf-4db5d951.pool.mediaways.net ([77.181.217.81])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Sep 2012 09:16:06 +0200
Received: from jojo by dsdf-4db5d951.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Sep 2012 09:16:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db5d951.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205358>

Joachim Schmitz wrote:
> Joachim Schmitz wrote:
>> If poll() is used as a milli-second sleep, like in help.c, by passing
>> a NULL in the 1st and a 0 in the 2nd arg, it exits with EFAULT.
>> 
>> As per Paolo Bonzini, the original author, this is a bug and to be
>> fixed like in this commit, which is not to exit if the 2nd arg is 0.
>> 
>> Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
>> ---
>> compat/win32/poll.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/compat/win32/poll.c b/compat/win32/poll.c
>> index 403eaa7..9e7a25c 100644
>> --- a/compat/win32/poll.c
>> +++ b/compat/win32/poll.c
>> @@ -349,7 +349,7 @@ poll (struct pollfd *pfd, nfds_t nfd, int
>> timeout) 
>> 
>>   /* EFAULT is not necessary to implement, but let's do it in the
>>      simplest case. */
>> -  if (!pfd)
>> +  if (!pfd && nfd)
>>     {
>>       errno = EFAULT;
>>       return -1;
> 
> Actually this one is not needed for win32 (nor does win32 suffer from
> a similar bug), so should probably better get added after patch 2/2
> (or as part of it), the move to compat/poll/.

It just got added that was to gnulib, with a commit message of:

don't exit early if NULL is the 1st arg to poll(),
but nfd is 0.  In that case poll should behave like select.

Bye, Jojo
