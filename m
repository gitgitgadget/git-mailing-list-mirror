From: Chris Packham <judge.packham@gmail.com>
Subject: Re: git loses commits on git pull --rebase with Dictator and
 Lieutenants Workflow
Date: Fri, 30 Jan 2015 07:08:29 +1300
Message-ID: <CAFOYHZBs=r016FE6ENOnYMs85D9XetTWtVR+faBL5Sj-91=ezg@mail.gmail.com>
References: <loom.20150128T203924-608@post.gmane.org>
	<CAFOYHZDLPr1sJ2Agyq6tT=ahpgNp=eL_Q4c=-iDd9i_JqFNTcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>
To: Dick <dick@mrns.nl>
X-From: git-owner@vger.kernel.org Thu Jan 29 19:08:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGtWL-0006QH-Mj
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 19:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755913AbbA2SIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 13:08:31 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:64873 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857AbbA2SIa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2015 13:08:30 -0500
Received: by mail-pa0-f46.google.com with SMTP id lj1so41890750pab.5
        for <git@vger.kernel.org>; Thu, 29 Jan 2015 10:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NmJCKJx3iKgbYI0Cu19GbtoLGkdBhwgP1LmQJdX+NYs=;
        b=rUH+daZCPSyaRCvp3VI1IHCNV8s9bM3nCMYJr5RR7+luRKYLe472e3l+sXvYRbcVfh
         boZj0bwMLGAKPLNWdSHcgHymanazwdnXAwcR0xp3DMCq2bJE7RC/kGLBfIlsGkfaQcue
         SWaFmgY0DunE9iHq20FOG28Hvx7ystwrF7hBYS8VDyIAK4OBVB1sQVvjLcSoLGxxwvnh
         8w3RFg31Udv4eWGACYOrDbiQje8fy9z5XyswLb0spv6Qe8VkXPqRRzLi67b8BUQZJhCl
         23m+GZl6d/tm0ZYgnAT1P0BfcBonxhOZ6qjn7aeAcYcFeu80OV0JF5ZWCi3n2XaWEMP8
         on9A==
X-Received: by 10.66.146.39 with SMTP id sz7mr2531875pab.59.1422554909706;
 Thu, 29 Jan 2015 10:08:29 -0800 (PST)
Received: by 10.70.109.199 with HTTP; Thu, 29 Jan 2015 10:08:29 -0800 (PST)
In-Reply-To: <CAFOYHZDLPr1sJ2Agyq6tT=ahpgNp=eL_Q4c=-iDd9i_JqFNTcg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263156>

On Fri, Jan 30, 2015 at 6:27 AM, Chris Packham <judge.packham@gmail.com> wrote:
> Hi,
>
> On Thu, Jan 29, 2015 at 8:49 AM, Dick <dick@mrns.nl> wrote:
>> Hi all,
>>
>> I've encountered a problem with the Dictator and Lieutenants Workflow. I've
>> configured remote origin so it pulls from the "blessed repository" and
>> pushes to the "developer public" repository.
>>
>> When the "blessed repository" has the same branch name as the "developer
>> public" repository git pull seems to drop commits.
>>
>> I've create a test script to demonstrate, left is the blessed repository,
>> right.git is the developer public and right is the developer private
>> repository.
>>
>> rm -rf left/ right/ right.git/
>> git init left
>> cd left/
>> echo "hello world" > test.txt
>> git add test.txt
>> git commit -m .
>> cd ..
>> git clone --bare left right.git
>> git clone right.git/ right
>> cd right
>> git remote set-url origin ../left
>> git remote set-url origin --push ../right.git
>> echo "bye world" >> test.txt
>> git commit -a -m .
>> git push
>> git log
>> echo "start: two commits, ok"
>> git fetch
>> git rebase origin/master
>> git log
>> echo "manual fetch/rebase: two commits, still ok"
>> git pull --rebase
>> git log
>> echo "pull: one commits, oops?"
>>
>> Am I using git wrong or is this a git bug?
>>
>> Thanks for having a look!
>>
>> Dick
>
> I can confirm the behaviour that Dick is seeing with git 2.0.4
> (happens to be what I was running on my laptop). Just rebuilding
> 2.3.0-rc2 now.

Also happens on 2.3.0-rc2

>
> AFAIK 'git fetch && git rebase origin/master' and 'git pull -r' in the
> scenario above should be roughly equivalent.
>
> I'll see if I can work the testcase above into an actual test script.
