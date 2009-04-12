From: Orestis Markou <orestis@orestis.gr>
Subject: Re: git-svn doesn't recognise trunk as parent of branch
Date: Sun, 12 Apr 2009 22:27:58 +0300
Message-ID: <2EF72ACD-BD4E-4326-85F2-6BD0DF433D75@orestis.gr>
References: <F562B0FA-6E9F-45AD-ADD5-D6EE1AD9C248@orestis.gr> <20090412185440.GA25300@m62s10.vlinux.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 12 21:29:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lt5N5-0005nT-1K
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 21:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbZDLT2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 15:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588AbZDLT2F
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 15:28:05 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:45793 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbZDLT2C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 15:28:02 -0400
Received: by mail-bw0-f169.google.com with SMTP id 17so1785036bwz.37
        for <git@vger.kernel.org>; Sun, 12 Apr 2009 12:28:01 -0700 (PDT)
Received: by 10.103.134.8 with SMTP id l8mr2932868mun.116.1239564480990;
        Sun, 12 Apr 2009 12:28:00 -0700 (PDT)
Received: from ?192.168.1.5? (athedsl-129796.home.otenet.gr [85.75.82.163])
        by mx.google.com with ESMTPS id 23sm8087995mun.0.2009.04.12.12.27.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Apr 2009 12:28:00 -0700 (PDT)
In-Reply-To: <20090412185440.GA25300@m62s10.vlinux.de>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116390>

Many thanks - I'll try that. I would have to do this for every branch,  
but it's definitely a major help.

Orestis
--
orestis@orestis.gr
http://orestis.gr/




On 12 Apr 2009, at 21:54, Peter Baumann wrote:

> On Sun, Apr 12, 2009 at 07:40:46PM +0300, Orestis Markou wrote:
>> Hello there - this is my first post to this ML, so please be kind!
>>
>> I have previously used git-svn with great success. However, in this
>> project, the svn repo layout is a bit unusual and I'm having getting
>> git-svn to do the correct thing.
>>
>> The repository I'm trying to clone is a subdirectory under a huge  
>> repo:
>>
>> http://svn.example.com/projects/trunk/MyProject/Production
>>
>> which has trunk, branches and tags and a couple of other directories
>> (which I'm not interested in).
>>
>> Complications so far:
>>
>> * I don't have read access to the lower directories, only to  
>> Production
>> * Being a part of a big repo, the initial revision is something like
>> 2000
>> * trunk, branches, tags where not created in the same revision. trunk
>> didn't exist until revision say 2050.
>>
>>
>> Doing 'git svn init -s
>> http://svn.example.com/projects/trunk/MyProject/Production'  
>> produces the
>> following configuration:
>>
>> [svn-remote "svn"]
>> url = http://svn.example.com/trunk/projects/MyProject/Production
>> fetch = trunk:refs/remotes/trunk
>> branches = trunk/projects/MyProject/Production/branches/*:refs/ 
>> remotes/*
>> tags = trunk/projects/MyProject/Production/tags/*:refs/remotes/tags/*
>>
>> Fetching this fetches only trunk and no branches.
>>
>> Amending the config to be:
>>
>> [svn-remote "svn"]
>> 	url = http://svn.example.com/trunk/projects/MyProject/Production/
>> 	fetch = trunk:refs/remotes/trunk
>> 	branches = branches/*:refs/remotes/*
>> 	tags = tags/*:refs/remotes/tags/*
>>
>>
>> and fetching (minor issue - have to start from scratch again), does
>> fetch all commits. However, there is no link between branches and  
>> trunk.
>> Using gitk (don't know how else to visualise this) shows branches as
>> having no parent. Indeed, in the fetch messages there is no 'found
>> possible parent' message. Also, when creating new branches in svn,
>> nothing shows up in git until a change happens. Then the branch is
>> created (again, with no parent).
>>
>> The only case where a correct parent was set was when someone  
>> branched
>> *from a branch*. Then the usual 'found possible parent' message
>> appeared, and gitk shows a sane tree.
>>
>> I'm on Mac OS X, git version 1.6.2.2.471.g6da14 (built from source,
>> master branch). This includes a recent commit that fixed an issue  
>> with
>> deep directories in git-svn, (without it I couldn't get the branches
>> anyway), but it doesn't seem to have fixed the problem completely.
>>
>> Any pointers welcome.
>
> It might be that git svn can't work with this strange repo or with  
> trunk
> created after the branches (no idea if this is a bug or  
> intentional), but I'll
> show you a easy way how to fix the git repo after the import by  
> using grafts.
>
> If you have a wrongly connected development (which you are trying to  
> fix) line like
> the following example:
>
> Time goes from left to right
>
> 	1 - 2 - 3 - 5 - 6       branchA
>
>       	        a - b - c - d   trunk
>
> you could fix it by connecting the graph using
>
> 	echo a 2 >> .git/info/grafts
>
> to get something like this
>
> 	1 - 2 - 3 - 5 - 6       branchA
> 	      \
>       	        a - b - c - d   trunk
>
> Replace 'a' and '2' with the sha1 value of the corresponding commit.  
> The same
> way you could teach git about merges in svn. To make the changes  
> permantent,
> use something like
>
> 	git filter-branch --tag-name-filter cat -- --all
>
> (Pls. check the manpage, I'm not that familiar with git filter-branch)
>
> -Peter
