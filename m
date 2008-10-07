From: Abdelrazak Younes <younes@lyx.org>
Subject: Re: [QGit bug] git user settings not retrieved when launched for
 Windows explorer
Date: Tue, 07 Oct 2008 14:31:54 +0200
Message-ID: <48EB56BA.5020502@lyx.org>
References: <48EB10C8.4070009@lyx.org>	 <e5bfff550810070410t1097ace4pf401821292fd7565@mail.gmail.com>	 <48EB49B3.1090509@lyx.org> <e5bfff550810070457i702c2935lfcc0b60ae3df4dc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 14:33:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnBkb-0005F1-E4
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 14:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220AbYJGMcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 08:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbYJGMcE
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 08:32:04 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:58395 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753135AbYJGMcD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 08:32:03 -0400
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 42CE8B0196;
	Tue,  7 Oct 2008 14:32:02 +0200 (CEST)
Received: from [192.168.0.10] (gre92-10-88-181-30-42.fbx.proxad.net [88.181.30.42])
	by smtp7-g19.free.fr (Postfix) with ESMTP id E903EB016B;
	Tue,  7 Oct 2008 14:32:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1b1pre) Gecko/20080918110343 Shredder/3.0b1pre
In-Reply-To: <e5bfff550810070457i702c2935lfcc0b60ae3df4dc4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97702>

On 07/10/2008 13:57, Marco Costalba wrote:
> On Tue, Oct 7, 2008 at 1:36 PM, Abdelrazak Younes<younes@lyx.org>  wrote:
>    
>>> Sound like a problem of startup directory: on the command line you
>>> start from the right directory...when you double click on which repo
>>> qgit is open ?
>>>
>>>        
>> None of course. But when I open a repository manually I would expect that
>> this is properly filled in.
>>
>>      
>
> In git.cpp, Git::userInfo() function get info about user by means of
> 'git config' calls, my guess (I cannot it test now) is that 'git
> config' does not work if we are not in a git directory.
>    
No, 'git config user.name' works fine in any directory, even on the 
naked Windows console (I mean without msys bash). So that must be 
something else. I've traced it down to
MyProcess::on_finished().

     isErrorExit =   (exitStatus != QProcess::NormalExit)
                  || (exitCode != 0 && isWinShell)
                  || !errorDesc.isEmpty()
                  ||  canceling;

At this point we have:
exitStatus = NormalExit
exitCode = 1
isWinShell = false
errorDesc.isEmpty() returns true
canceling = false

Which gives 'isErrorExit = false'. I wonder if the isWinShell test is 
correct?

Abdel.
