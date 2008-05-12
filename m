From: Justin Leung <jleung@redback.com>
Subject: Re: Verilog/ASIC development support is insufficient in git , help!
Date: Mon, 12 May 2008 11:54:16 -0700
Message-ID: <48289258.4010406@redback.com>
References: <20080511172549.28205.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Mon May 12 20:55:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvdAz-0001l6-6d
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 20:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755055AbYELSyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 14:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755054AbYELSyT
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 14:54:19 -0400
Received: from prattle.redback.com ([155.53.12.9]:44099 "EHLO
	prattle.redback.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754943AbYELSyS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 14:54:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by prattle.redback.com (Postfix) with ESMTP id 32BC7CB93F1;
	Mon, 12 May 2008 11:54:17 -0700 (PDT)
Received: from prattle.redback.com ([127.0.0.1])
 by localhost (prattle [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26984-07; Mon, 12 May 2008 11:54:17 -0700 (PDT)
Received: from [155.53.72.61] (havant.redback.com [155.53.72.61])
	by prattle.redback.com (Postfix) with ESMTP id F2FEFCB93F0;
	Mon, 12 May 2008 11:54:16 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <20080511172549.28205.qmail@science.horizon.com>
X-Virus-Scanned: by amavisd-new at redback.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81905>


Thanks George . 

is the git-cvsserver usable?

I wanted to try it , but the inability to tag from the cvs side is not 
something that i can sell to my managements .

 Justin


George Spelvin wrote:
>> - no incremental revision numbers (they are so scared of the 40hex SHA1)
>>
>> - Inability to reference without SHA1, they want simple numbering (ie,
>>   version 100, 120, 120.1, 130.4.5)
>>
>> - Inability to refer to a file by a simple number
>> (the backend guys will be confused by SHA1; they can't work with anything
>> more than 4-5 digits)
>>     
>
> This is Fundamentally Impossible in a distributed system.  You can try
> to fake it, but you just end up with horrible corner cases.  Basically,
> without a central server, who makes sure the incremental numbers are
> assigned without collisions?
>
> HOWEVER:
>
> - You can use abbreviated SHA1 references.  5-6 digits will do to start,
>   and you can go slightly longer when it becomes necessary.  Due to the
>   "birthday paradox", you need a  hash code space larger than (number of
>   objects)*(number of commits) to guarantee minimal chance of ambiguity.
>
> - You can have a post-commit hook that creates a simple numbered tag
>   for each commit to the "master" repository.  You guys working
>   independently will have to get a little fancier, but the "master"
>   can have simple numbers.
>
> Between those two, it should be pretty reasonable.
>
> To get what you're asking for, you'd have to have a "read-only git" that
> can ONLY pull from a centralized server that assigns the simple numbers,
> and can never do local commits.
>
> I think that seems kind of pointless to the developers.  They'd like to
> give your hardware guys the CHANCE to learn git, even if most only
> use a very small subset of it.
>
> Is it that hard to tell them to "ignore that box in gitk"?
>
>   
>> - Complexity of commands (although we can have warpper, but real git
>>   commands for non-sw guys is not going to happen)
>>
>> Most hardware chip designers were using CVS since their first job.
>> It suited the purpose very well.
>>     
>
> You can use git-cvsserver to give them a CVS interface if that's what
> they're happy with...
>
>   
>> We don't use branches.
>> Our model is strict forward with a centralized, one main branch model to
>> avoid mistakes.
>> We see branches as evil; some merges in Verilog codes means another 10+
>> hours of simulation and regression.
>>     
>
> I realize it's a big culture shock, but what git does with branch merges is
> *exactly* what CVS does with "cvs update".  So there truly is no evil.
> You can certainly use a "git rebase" style instead, but that's just style;
> it doesn't change the basic underlying issue: as soon as you drop strict
> locking and allow concurrent development, you have merges.
>
> "cvs update" basically does a "git rebase" and so doesn't show the merges
> in the revision history, but they're there, and the possibility of
> bugs is exactly the same.
>
> "git push" and "cvs commit" both have exactly the same rules: you
> may not append to the server history unless you've fetched the
> latest and resolved any conflicts.
>
> CVS branches are Horrible Awful Painful Things and I don't blame you
> for avoiding them.  Git doesn't force you to use branches, but they're
> downright pleasant to use, and provide a more accurate representation
> in the development history of the actual concurrent development.
>
>   
>> - 'git-show-branch' actually show reversed serialized version numbers (we
>>   want it the other way, accending)
>>     
>
> If you assign sequential version number tags on the central server, then
> you want an option for it to use tags rather than just branch names.  That
> will take care of this quite nicely.  Unfortunately, I can't seem to find
> it right now.  Gitk does show tags in a very natural way.
>   
