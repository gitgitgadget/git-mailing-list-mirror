From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 08/14] help.c: Fix detection of custom merge strategy
 on cygwin
Date: Sat, 18 Dec 2010 20:41:29 +0000
Message-ID: <4D0D1C79.4070203@ramsay1.demon.co.uk>
References: <4D07B786.2060602@ramsay1.demon.co.uk> <201012142138.37679.j6t@kdbg.org> <4D0A80C5.4020003@ramsay1.demon.co.uk> <201012172246.45038.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, jrnieder@gmail.com,
	vmiklos@frugalware.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Dec 18 23:09:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU4yF-00063k-5L
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 23:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279Ab0LRWJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 17:09:39 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:34771 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751708Ab0LRWJi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Dec 2010 17:09:38 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1PU4y9-0007li-X9; Sat, 18 Dec 2010 22:09:37 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <201012172246.45038.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163940>

Johannes Sixt wrote:
> On Donnerstag, 16. Dezember 2010, Ramsay Jones wrote:
>> Johannes Sixt wrote:
>>> On Dienstag, 14. Dezember 2010, Ramsay Jones wrote:
>>>> @@ -126,7 +126,10 @@ static int is_executable(const char *name)
>>>>  	    !S_ISREG(st.st_mode))
>>>>  		return 0;
>>>>
>>>> -#ifdef WIN32
>>>> +#if defined(WIN32) || defined(__CYGWIN__)
>>>> +#if defined(__CYGWIN__)
>>>> +if ((st.st_mode & S_IXUSR) == 0)
>>>> +#endif
>>>>  {	/* cannot trust the executable bit, peek into the file instead */
>>>>  	char buf[3] = { 0 };
>>>>  	int n;
>>> Do you gain a lot by this extra condition? Wouldn't
>>>
>>> -#ifdef WIN32
>>> +#if defined(WIN32) || defined(__CYGWIN__)
>>>
>>> be sufficient?
>> Yes, that would be sufficient. No, I probably don't gain a great deal
>> (but I have *not* timed it), since the number of files that are tested
>> by is_executable() is fairly low anyway since they are already filtered
>> by a filename prefix (eg. git-merge-).
>>
>> However, if the executable bit is set, then executing the WIN32 code
>> block is wasted effort (we already know the answer), so why bother?
> 
> It would have made to code a bit easier to read with one less #if defined(), 
> but it's not a big deal.

Yep, I did consider this:

-#idef WIN32
+#if defined(WIN32) || defined(__CYGWIN__)
+if ((st.st_mode & S_IXUSR) == 0)

but chickened out! ;-) (No, I didn't even test it)
I decided to be conservative here ...

ATB,
Ramsay Jones
