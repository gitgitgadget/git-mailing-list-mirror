From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 08/14] help.c: Fix detection of custom merge strategy
 on cygwin
Date: Thu, 16 Dec 2010 21:12:37 +0000
Message-ID: <4D0A80C5.4020003@ramsay1.demon.co.uk>
References: <4D07B786.2060602@ramsay1.demon.co.uk> <201012142138.37679.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, jrnieder@gmail.com,
	vmiklos@frugalware.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Dec 16 23:41:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTMWL-0000lG-KL
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 23:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071Ab0LPWlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 17:41:45 -0500
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:65277 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751608Ab0LPWlo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Dec 2010 17:41:44 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1PTMW6-00048E-p1; Thu, 16 Dec 2010 22:41:43 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <201012142138.37679.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163835>

Johannes Sixt wrote:
> On Dienstag, 14. Dezember 2010, Ramsay Jones wrote:
>> @@ -126,7 +126,10 @@ static int is_executable(const char *name)
>>  	    !S_ISREG(st.st_mode))
>>  		return 0;
>>
>> -#ifdef WIN32
>> +#if defined(WIN32) || defined(__CYGWIN__)
>> +#if defined(__CYGWIN__)
>> +if ((st.st_mode & S_IXUSR) == 0)
>> +#endif
>>  {	/* cannot trust the executable bit, peek into the file instead */
>>  	char buf[3] = { 0 };
>>  	int n;
> 
> Do you gain a lot by this extra condition? Wouldn't
> 
> -#ifdef WIN32
> +#if defined(WIN32) || defined(__CYGWIN__)
> 
> be sufficient?

Yes, that would be sufficient. No, I probably don't gain a great deal
(but I have *not* timed it), since the number of files that are tested
by is_executable() is fairly low anyway since they are already filtered
by a filename prefix (eg. git-merge-).

However, if the executable bit is set, then executing the WIN32 code
block is wasted effort (we already know the answer), so why bother?

ATB,
Ramsay Jones
