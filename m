From: Bart van den Burg <bart@burgov.nl>
Subject: Fixing a broken GIT repo
Date: Fri, 18 Nov 2011 11:54:14 +0100
Message-ID: <ja5dgo$nlf$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 12:10:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRMKu-0008WG-Ex
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 12:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588Ab1KRLKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 06:10:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:34312 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604Ab1KRLKI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 06:10:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RRMKc-0008Qu-DT
	for git@vger.kernel.org; Fri, 18 Nov 2011 12:10:06 +0100
Received: from 46.44.157.237 ([46.44.157.237])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 12:10:06 +0100
Received: from bart by 46.44.157.237 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 12:10:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 46.44.157.237
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; nl; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
X-Antivirus: avast! (VPS 111101-3, 01-11-2011), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185648>

Hi

I somehow managed to break my GIT repo. Whenever I try to clone or fetch 
from a clean local repo, I get an error.

I'm able to go back on the server, to the very last commit where 
everything works, but as soon as I make a change locally and push it, it 
breaks again. I've been trying to figure out what's wrong here for about 
two days now, but I'm completely lost.

Here's the steps I take to reproduce the problem.

On the server, I can reset the ref to the last working commit:

git@server:~/shifter_rai.git$ echo 
"cc5693a275c25003edc77b59f5a5c603a857f711" > refs/heads/master

Then, on my local computer, I can clone fine, but after making a commit, 
it breaks again:

bbu@SIT-WST-05 /d/workspace9
$ git clone git@git.samson-it.nl:/home/git/shifter_rai
Cloning into shifter_rai...
remote: Counting objects: 9557, done.
remote: Compressing objects: 100% (1887/1887), done.
remote: Total 9557 (delta 7107), reused 9397 (delta 7019)
Receiving objects: 100% (9557/9557), 2.85 MiB | 1.06 MiB/s, done.
Resolving deltas: 100% (7107/7107), done.

bbu@SIT-WST-05 /d/workspace9
$ cd shifter_rai/

bbu@SIT-WST-05 /d/workspace9/shifter_rai (master)
$ echo "test" > test

bbu@SIT-WST-05 /d/workspace9/shifter_rai (master)
$ git add test
warning: LF will be replaced by CRLF in test.
The file will have its original line endings in your working directory.

bbu@SIT-WST-05 /d/workspace9/shifter_rai (master)
$ git commit
[master 85d1ee9] test
warning: LF will be replaced by CRLF in test.
The file will have its original line endings in your working directory.
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 test

bbu@SIT-WST-05 /d/workspace9/shifter_rai (master)
$ git push
Counting objects: 4, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 271 bytes, done.
Total 3 (delta 1), reused 0 (delta 0)
To git@git.samson-it.nl:/home/git/shifter_rai
    cc5693a..85d1ee9  master -> master

bbu@SIT-WST-05 /d/workspace9/shifter_rai (master)
$ cd ..

bbu@SIT-WST-05 /d/workspace9
$ rm -rf shifter_rai/

bbu@SIT-WST-05 /d/workspace9
$ git clone git@git.samson-it.nl:/home/git/shifter_rai
Cloning into shifter_rai...
remote: Counting objects: 9557, done.
remote: Compressing objects: 100% (1887/1887), done.
remote: Total 9557 (delta 7107), reused 9397 (delta 7019)
Receiving objects: 100% (9557/9557), 2.85 MiB | 1.16 MiB/s, done.
Resolving deltas: 100% (7107/7107), done.
error: refs/remotes/origin/master does not point to a valid object!
error: Trying to write ref refs/heads/master with nonexistant object 
85d1ee957c65485ed9c937a4f1bfdd44fda4ea35
fatal: Cannot update the ref 'HEAD'.

Needless to say, the mentioned object in fact does exist on the server:
git@server:~/shifter_rai.git$ ls -la 
objects/85/d1ee957c65485ed9c937a4f1bfdd44fda4ea35
-r--r--r-- 1 git git 153 Nov 18 11:39 
objects/85/d1ee957c65485ed9c937a4f1bfdd44fda4ea35

Can anyone tell me what is happening here, and how I can fix it?
