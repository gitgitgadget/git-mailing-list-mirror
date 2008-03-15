From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Something strange has happened to my git HEADs.
Date: Sat, 15 Mar 2008 18:44:35 +0100
Message-ID: <m38x0j51bw.fsf@maximus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 18:45:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaaS2-0001E8-3e
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 18:45:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbYCORoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 13:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbYCORoj
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 13:44:39 -0400
Received: from khc.piap.pl ([195.187.100.11]:59162 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051AbYCORoi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 13:44:38 -0400
Received: by khc.piap.pl (Postfix, from userid 500)
	id 755B8659F3; Sat, 15 Mar 2008 18:44:35 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77333>

Hi,

Not sure what has happened but it was hardly expected:

1. I have individual bare git repos in ~/scm and ~/scm/linux-2.6 is one
of them (currently):

intrepid:~/scm/linux-2.6$ find -not -type d
./logs/HEAD
./logs/refs/heads/lirc
./logs/refs/heads/viafb
./logs/refs/heads/ixp4xx23
./logs/refs/heads/linux-stable
./logs/refs/heads/wireless
./logs/refs/heads/ixp4xx-hss-chan-old
./logs/refs/heads/alpine
./logs/refs/heads/linux-test
./logs/refs/heads/linux-router-test
./logs/refs/heads/origin
./logs/refs/heads/ixp4xx-upstream
./logs/refs/heads/linux-router (and so on)
./config
./objects/**********
./description
./HEAD
./hooks/pre-rebase
./hooks/applypatch-msg
./hooks/update
./hooks/post-commit
./hooks/commit-msg
./hooks/pre-commit
./hooks/pre-applypatch
./hooks/post-receive
./hooks/post-update
./info/refs

Config file mostly contains:
[diff]
        renames = copies
[core]
        preferSymlinkRefs = true
(plus less relevant things).

intrepid:~/scm/linux-2.6$ cat HEAD 
ref: refs/heads/origin

There used to be a number of refs and heads but now they are all gone:
intrepid:~/scm/linux-2.6$ find refs/
refs/
refs/heads
refs/tags



2. Working dirs using this repo are in /usr/src/linux* and
/usr/src/linux-test is one of them, currently (.git dir):
lrwx 1      30 2007-10-09 00:55 config -> ~/scm/linux-2.6/config
lrwx 1      35 2007-08-24 18:33 description -> ~/scm/linux-2.6/description
-rw- 1     126 2008-02-01 21:39 FETCH_HEAD
lrwx 1      19 2008-03-15 17:52 HEAD -> refs/heads/eelogger
-rw- 1 2220597 2008-03-15 17:56 index
drwx 2    4096 2008-03-15 17:57 info
-rw- 1   21482 2008-03-15 17:57 info/refs
lrwx 1      28 2007-08-24 18:33 logs -> ~/scm/linux-2.6/logs
lrwx 1      31 2007-08-24 18:33 objects -> ~/scm/linux-2.6/objects
-rw- 1      41 2008-03-15 17:56 ORIG_HEAD
-rw- 1   17909 2008-03-15 17:56 packed-refs
lrwx 1      28 2007-08-24 18:33 refs -> ~/scm/linux-2.6/refs


What I did was (copy & paste):
intrepid:/usr/src/linux-test$ git-status 
# On branch eelogger
nothing to commit (working directory clean)

intrepid:/usr/src/linux-test$ git-rebase v2.6.24
First, rewinding head to replay your work on top of it...
Checking out files: 100% (10213/10213), done.
HEAD is now at 4991408... Linux 2.6.24
Applying I2C: Added eelogger driver - EEPROM kernel console logger
Auto packing your repository for optimum performance. You may also
run "git gc" manually. See "git help gc" for more information.
Counting objects: 744096, done.
Compressing objects: 100% (135615/135615), done.
Writing objects: 100% (744096/744096), done.
Total 744096 (delta 613061), reused 738324 (delta 607483)
error: Ref refs/heads/eelogger is at 9465fea31dff47dee3d0e0018d7aa52d16e14c33 but expected e00e34771aac93479c4d939e4e5cceeca64b38f8
fatal: Cannot lock the ref 'refs/heads/eelogger'.
Could not move back to refs/heads/eelogger

Now all references are gone, the objects seem to be packed correctly
into one 230 MB file (there are some individual object files left,
perhaps orphans).

I have been trying to use gitweb while git-rebase was operating but it
wasn't able to find anything.

How could that happened?
I did the same many times and never had anything like that, but perhaps
the symlinks caused that? It never autopacked while rebasing.

/usr/src/linux-test/.git/info/refs seems to contain all the heads and
tags (including the new eeprom head).

e00e34771aac93479c4d939e4e5cceeca64b38f8 is the old eelogger head
9465fea31dff47dee3d0e0018d7aa52d16e14c33 is the new (rebased) head

git-core-1.5.4.1-1.fc8, it's practically up-to-date Fedora 8 x86_64
SMP.
-- 
Krzysztof Halasa
