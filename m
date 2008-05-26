From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: gitignore: negating path patterns
Date: Mon, 26 May 2008 10:54:19 +0200
Message-ID: <g1dts5$bmh$1@ger.gmane.org>
References: <g11cvn$ndr$1@ger.gmane.org> <5BBB5607-DF95-4C06-BE6C-C3D7AF475FBF@sb.org> <g15t3j$eoa$1@ger.gmane.org> <ADCBC87D-27A7-4C3F-B11E-8AE217F8AF91@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 10:55:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0YUS-0007rm-ME
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 10:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbYEZIyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 04:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752907AbYEZIyo
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 04:54:44 -0400
Received: from main.gmane.org ([80.91.229.2]:57667 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722AbYEZIyn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 04:54:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K0YTW-0007jx-G8
	for git@vger.kernel.org; Mon, 26 May 2008 08:54:38 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 May 2008 08:54:38 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 May 2008 08:54:38 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <ADCBC87D-27A7-4C3F-B11E-8AE217F8AF91@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82908>

Kevin Ballard venit, vidit, dixit 24.05.2008 00:44:
> On May 23, 2008, at 12:52 AM, Michael J Gruber wrote:
> 
>> Kevin Ballard venit, vidit, dixit 23.05.2008 02:23:
>>> On May 21, 2008, at 7:52 AM, Michael J Gruber wrote:
>>>> Hi there
>>>>
>>>> It seems that negating path patterns in gitignore doesn't work, or I
>>>> don't understand it (or both). With the attached script, git status
>>>> (1.5.5.1) reports "dir/a" as new and "dir/b" as untracked. I would
>>>> rather expect it to report "dir/c" as untracked also.
>>>>
>>>> It seems that "!b" matches to include "dir/b" (reverting the  
>>>> exclusion
>>>> "*" as expected), whereas "!dir/" does not match to include "dir/c".
>>>>
>>>> What's going on here?
>>> "dir/" will not match anything, because paths are compared without   
>>> trailing slashes. Try "!dir".
>> I am sorry, but this is plain wrong, at least if "man gitignore" is  
>> right (see below). "!dir" would match files whose name (pathname  
>> without leading directory name) matches "dir" (i.e.: is dir) and  
>> exclude those from exclusion (include them).
>>
>> Also, replacing "!dir/" by "!dir" in my test script does not change  
>> the result. In fact, for "!dir" the result is as expected and  
>> documented, just for "!dir/" I would expect something else.
>>
>> So, thanks for trying to help, although reading the manual or  
>> testing your advice before would be appreciated even more. ;)
>>
>> Michael
>>
>> From man gitignore:
>>
>> If the pattern ends with a slash, it is removed for the purpose of  
>> the following description, but it would only find a match with a  
>> directory. In other words, foo/ will match a directory foo and paths  
>> underneath it, but will not match a regular file or a symbolic link  
>> foo (this is consistent with the way how pathspec works in general  
>> in git).
> 
> Ahh, the behavior changed in 1.5.5. Pre-1.5.5, if a path ended in a  
> slash, it would never match anything.
> 
> In any case, the problem is the * pattern. Here's what happens:
> 
> At /, the * is evaluated and ignores everything. The !dir/ is  
> evaluated and unignores dir. The !b is evaluated and matches nothing.
> AT /dir, the * is evaluated and ignores everything. The !dir/ is  
> evaluated and matches nothing. The !b is evaluated and unignores b.
> 
> So the problem is the * is recursively applying to the subdirectories.  
> To fix this, use /* as the pattern.

You're right, that's how it works now. Thanks a bunch! Nothings beats 
"using the s/force/source/".

I find this behaviour highly confusing for someone going by 
"gitgnore(5)". I'll try and submit a documentation fix as a first 
attempt at contributing back.

Michael
