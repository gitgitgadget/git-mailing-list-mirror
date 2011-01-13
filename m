From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: Applying .gitattributes text/eol changes
Date: Thu, 13 Jan 2011 15:57:50 +0100
Message-ID: <4D2F12EE.4020400@syntevo.com>
References: <4D220500.2000104@syntevo.com> <4D2C4902.4010705@drmicha.warpmail.net> <4D2C62DF.20706@syntevo.com> <4D2EFCBD.4020402@drmicha.warpmail.net> <4D2F0BF3.2000808@syntevo.com> <4D2F0E3A.8090108@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jan 13 15:58:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdOck-00036R-IC
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 15:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756982Ab1AMO56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 09:57:58 -0500
Received: from syntevo.com ([85.214.39.145]:60637 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756599Ab1AMO55 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jan 2011 09:57:57 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTPSA id 93591174006
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <4D2F0E3A.8090108@drmicha.warpmail.net>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165055>

>> If a "git checkout" would (optionally) make sure that all EOLs are
>> properly set according to .gitattributes, the problem would be resolved.
>> As this might be not so easy to implement, my suggestion was to make
>> "git reset --hard" work more unobtrusive. I think we can provide a
>> corresponding patch, if it has chances to get accepted.
> 
> There have been other cases where git update-index --really-refresh
> wasn't enough. You might want to check whether that is a suitable "patch
> attack vector". This might be useful not only for you but also for others.

So your suggestion is to fix "git update-index --really-refresh", so
it's a replacement for "rm .git/index"? This sounds reasonable,
especially as "rm .git/index" is something one feels not comfortable
about when performing the first time ;-)

Anyway, I'm still wondering if it will resolve the "git reset --hard"
problem of re-checking out every file, even if content is already
identical in the working tree. I think that part has to be fixed, too.

What do you think about "git checkout --fix-eols" option as an
alternative? Its uses cases are more limited, though.

--
Best regards,
Marc Strapetz
=============
syntevo GmbH
http://www.syntevo.com
http://blog.syntevo.com



On 13.01.2011 15:37, Michael J Gruber wrote:
> Marc Strapetz venit, vidit, dixit 13.01.2011 15:28:
>>>> case of missing .git/index, Git freshly writes all working tree files,
>>>> ignoring already existing files which already have the correct content.
>>>> Maybe this behavior is by intention and makes sense in some cases. In my
>>>> case it has adverse effects on IDEs and probably other tools which are
>>>> monitoring the file system.
>>>
>>> ...but changing gitattributes is something you don't do routinely in
>>> your workflow; so, at worst there would be an occasional unnecessary run
>>> of your build process.
>>
>> Our Git-SVN bridge does it, potentially on every pull. This is why we
>> currently need to run "rm .git/index && git reset --hard" after every
>> pull, resp. every checkout (switching to another commit may result in
>> changed .gitattributes as well).
> 
> OK, now you're telling us what this is about ;)
> 
>> If a "git checkout" would (optionally) make sure that all EOLs are
>> properly set according to .gitattributes, the problem would be resolved.
>> As this might be not so easy to implement, my suggestion was to make
>> "git reset --hard" work more unobtrusive. I think we can provide a
>> corresponding patch, if it has chances to get accepted.
> 
> There have been other cases where git update-index --really-refresh
> wasn't enough. You might want to check whether that is a suitable "patch
> attack vector". This might be useful not only for you but also for others.
> 
> Michael
> 
> 
