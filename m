From: "J.V." <jvsrvcs@gmail.com>
Subject: Re: Git: Unexpected behaviour?
Date: Fri, 11 Nov 2011 17:24:02 -0700
Message-ID: <4EBDBCA2.7070603@gmail.com>
References: <1321044904175-6986736.post@n2.nabble.com> <4EBD9428.3030506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat Nov 12 01:24:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RP1OQ-000272-Ms
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 01:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644Ab1KLAYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 19:24:18 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61854 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab1KLAYR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 19:24:17 -0500
Received: by yenr9 with SMTP id r9so3684270yen.19
        for <git@vger.kernel.org>; Fri, 11 Nov 2011 16:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=CRrmWjd/mwypj3cGKu31TPzJxrh9VX8YUwhs5CrSr9A=;
        b=YfnwrPQRbNXWrcBDRxTnswYEtC8Vnp5sTCQN/RSgdK4+AcuOFznUI4r7V3dqAxylEP
         3caTY7qseVQAhzKPyuTEAJLzGKlABvAeqpuEF6WFqPwM3+Q0QtkqJtyWTF6I0HmCK2AM
         /x0OHcDyotnW1IgT9YYUX6QbNUWMoj/DNJSvE=
Received: by 10.68.34.67 with SMTP id x3mr2264070pbi.100.1321057456700;
        Fri, 11 Nov 2011 16:24:16 -0800 (PST)
Received: from [192.168.43.253] (mf22636d0.tmodns.net. [208.54.38.242])
        by mx.google.com with ESMTPS id g8sm15777624pbe.11.2011.11.11.16.24.11
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Nov 2011 16:24:15 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EBD9428.3030506@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185296>

OK so "work tree" is a new term for me.  I thought we were in isolated 
sandboxes called "branches" and changes made in a branch would stay in 
that branch regardless.

so anything in the "work tree" is over layed on top of my branch if 
there are no conflicts?

On 11/11/2011 2:31 PM, Chris Packham wrote:
> Hi,
>
> On 12/11/11 09:55, Jvsrvcs wrote:
>> Unexpected git behaviour
>>
>> ---
>> # First create a local git repo
>>
>> $mkdir gitexample
>> $git config --global user.name "my name"
>> $git config --global user.email "me@me.com"
>> $git init
>> $git add .
>> $git commit -m 'initial commit'
>>
>> # Create/Edit an empty file
>> $vi readme.txt
>>
>> # add a single line: "this was added in the master branch."
>> $git commit -a
> One thing to remember is that this is the same as "git add readme.txt"
> and "git commit" (I'll explain why below).
>
>> # create and checkout a new branch (from master)
>> $git branch test
>> $git checkout test
>>
>> # edit the readme.txt file and do not commit
>> # add the text:  "this was added in the test branch.", save and exit
>> $vi readme.txt
> At this point the changes are in the work tree. They aren't added to the
> test branch until you commit them.
>
>> #now switch back to master
>> $git checkout master
> When you have uncommited changes in the work tree that don't conflict
> with the contents of the branch you are checking out git will happily
> carry them along for you. If they did conflict then git would refuse to
> switch to the new branch.
>
>> $cat readme.txt
>>
>> #You will see both lines in the master.
>>
>> Question #1:
>> 	Why was this line added in the *master branch?
> Because the second change hasn't been committed it isn't in either
> branch. It's in the work tree.
>
>> --- even further surprising
>> In the master branch, now do a commit
>> $git commit -a
>>
>> cat readme.txt ( you will see the line in the master now that was added in
>> the test branch )
>>
>> Question #2:
>> 	Why did this happen?
> Because you asked for it to happen.
>
>> # Now switch back to the test branch
>> $git checkout test
>> $cat readme.txt
>>
>> You will only see the one line: "This was added in the master branch"
>>
>> Question #3:
>> 	Why did this happen?
> Because the second change was committed (in the master branch) it is
> no-longer floating in the work tree so when you switch branches you get
> the contents of the file in that branch.
>
>> and NOT the line added in that branch: "this was added in the test branch"
>> <= this line is gone
>>
>> What is the reason for this?
>>
>> 1) Why do I see uncommitted changes in the branches made off master in the
>> master branch?
>> 2) Why, if I commit them in the master, do the disappear in the branch in
>> which they were made?
>>
>> This is confusing, I would think the * master branch would be left
>> untouched.  This would solve issue #2.
>>
> Hopefully this will explain things a little better
>
> [work-tree] -- git add ->  [index] -- git commit -->  [HEAD]
>
> work-tree: the area on the file system where your code is checked out.
> index: also known as the staging area, this is represents what will end
> up in the next commit.
> HEAD: a general term for the current branch.
>
> As you can see that until a change is committed it isn't in _any_
> branch. When you type "git checkout test" or "git checkout master" HEAD
> will be updated. Changes in the work-tree or the index will be carried
> along (provided they don't conflict with the new HEAD).
>
> Hope that helps.
>
>
