From: "Wink Saville" <wink@saville.com>
Subject: Re: Git branching & pulling
Date: Sat, 19 May 2007 09:31:43 -0700
Message-ID: <d4cf37a60705190931rca1187ap9b98becb6c7c3b2a@mail.gmail.com>
References: <d4cf37a60705182240s414243a6wae69d26f70f64dd5@mail.gmail.com>
	 <7v8xblz71o.fsf@assigned-by-dhcp.cox.net>
	 <7vzm41xsa2.fsf@assigned-by-dhcp.cox.net>
	 <464E97A4.4050702@midwinter.com>
	 <7vveepxr7m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Steven Grimm" <koreth@midwinter.com>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 18:31:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpRqS-0003Ej-QY
	for gcvg-git@gmane.org; Sat, 19 May 2007 18:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499AbXESQbp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 12:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754518AbXESQbp
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 12:31:45 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:4886 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499AbXESQbo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 12:31:44 -0400
Received: by nz-out-0506.google.com with SMTP id r28so1679739nza
        for <git@vger.kernel.org>; Sat, 19 May 2007 09:31:43 -0700 (PDT)
Received: by 10.114.67.2 with SMTP id p2mr1567089waa.1179592303309;
        Sat, 19 May 2007 09:31:43 -0700 (PDT)
Received: by 10.114.137.15 with HTTP; Sat, 19 May 2007 09:31:43 -0700 (PDT)
In-Reply-To: <7vveepxr7m.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47755>

> Ah, if you ever interact with only single remote repository,
> then that is certainly a valid reason not to say anything else.

For reference my git version:

wink@ic2d1:~/linux/kvm-linux-2.6$ git --version
git version 1.5.2.rc0.g520d


This is very close to my situation, except in the mothership
is linux-2.6.git, kvm.git or git.git. So I have two primary objectives, first
periodically synchronize my repository with the remotes. Second, synchronize
my branches with their "remotes".

My expectations are that when I'm on a branch and do a git-pull with no
parameters I should "fetch" from that branches "remotes" and "merge" into
the current branch. This is how linus's repo seems to work.

But with kvm.git it appears I need to be quite explicit:

wink@ic2d1:~/linux/kvm-linux-2.6$ git-checkout -b test
Switched to a new branch "test"
wink@ic2d1:~/linux/kvm-linux-2.6$ git-pull
fatal: 'master': unable to chdir or not a git archive
fatal: The remote end hung up unexpectedly
Cannot get the repository state from master
wink@ic2d1:~/linux/kvm-linux-2.6$ git-pull .
error: Object 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c is a tree, not a commit
error: Object 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c is a tree, not a commit
Already up-to-date.
wink@ic2d1:~/linux/kvm-linux-2.6$ git-pull . master
Already up-to-date.
wink@ic2d1:~/linux/kvm-linux-2.6$

So to get consistent behavior it seems I should
always use the two parameter form. But the behavior
with no parameters was very convenient and less
error prone as the branch should always know
from where it was cloned:)

Here is another experiment cloning a local repo created
with 1.5.2-rc0 where tried git-pull's:

wink@ic2d1:~$ git-clone testgit testgit-clone
Initialized empty Git repository in /home/wink/testgit-clone/.git/
remote: Generating pack...
remote: Done counting 6 objects.
remote: Deltifying 6 objects...
remote: /6) done/6) done
remote: Total 6 (delta 0), reused 0 (delta 0)
Indexing 6 objects...
 100% (6/6) done


wink@ic2d1:~$ cd testgit-clone/
wink@ic2d1:~/testgit-clone$ git-pull
Already up-to-date.
wink@ic2d1:~/testgit-clone$ git-pull .
Already up-to-date.
wink@ic2d1:~/testgit-clone$ git-pull ../testgit
Already up-to-date.
wink@ic2d1:~/testgit-clone$ git-pull ../testgit master
Already up-to-date.
wink@ic2d1:~/testgit-clone$ git-checkout -b test master
Switched to a new branch "test"
wink@ic2d1:~/testgit-clone$ git-pull .
Already up-to-date.
wink@ic2d1:~/testgit-clone$ git-pull . master
Already up-to-date.
wink@ic2d1:~/testgit-clone$ git-pull
Warning: No merge candidate found because value of config option
         "branch.test.merge" does not match any remote branch fetched.
No changes.
wink@ic2d1:~/testgit-clone$


Why did last git-pull generate the warning, this seems wrong?

Regards,

Wink Saville
