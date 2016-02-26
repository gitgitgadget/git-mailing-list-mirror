From: Fred's Personal <freddiewik@optonline.net>
Subject: Trouble Cloning Git remote repository
Date: Fri, 26 Feb 2016 18:03:37 -0500
Message-ID: <009f01d170e9$ecd5cae0$c68160a0$@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 00:33:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZRt7-0000Wt-0V
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 00:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755734AbcBZXd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 18:33:28 -0500
Received: from mta5.srv.hcvlny.cv.net ([167.206.4.200]:39156 "EHLO
	mta5.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755710AbcBZXd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 18:33:27 -0500
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Feb 2016 18:33:27 EST
Received: from mordor (ool-4350b670.dyn.optonline.net [67.80.182.112])
 by mta5.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTP id <0O36009K0G1PM090@mta5.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Fri, 26 Feb 2016 18:03:26 -0500 (EST)
X-Mailer: Microsoft Outlook 14.0
Content-language: en-us
Thread-index: AdFw6XjkgUODgNfeRxCxIA+GOAg8Xw==
X-Antivirus: AVG for E-mail 2016.0.7442 [4537/11698]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287637>

I am trying to set up a remote Git repository on my network server. 
I want to develop source on several desktops / laptops and want to have a
central repository to sync everything and maintain version control. 
Seems like a good fit for Git, but I cannot get it to work and would
appreciate advice on fixing the configuration or how to troubleshoot to
identify the root cause.
Please let me know what additional info you need to assist.

I have listed the machine configurations and the Git Bash lines from
attempting the git clone.

Configuration:
Local Machine (Host1)
o	Windows 10 - Git for Windows 2.7.1.2-64bit update
o	Git Repository = ~HOME/gitrepository
Remote Machine (Host2)
o	Ubuntu Server 14.04 LTS; Git version 2.7.2
o	Git repository = /srv/centralrepo.git ;created with -bare -shared
o	           Owner= user1; group= developer
o	Created ~/.bashrc to ensure PATH is set correctly with 'interactive
non-login' session
o	After .bashrc runs there is a line from a bash script that causes a
bash error: "bash: user1@Host2: command not found" 

Clone to the remote repository always fails with:
  bash: user1@Host2: command not found
  fatal: Could not read from remote repository.

  Please make sure you have the correct access rights
  and the repository exists.

All command line text shown here is executed from Local Machine(Host1) (from
Windows Git Bash) My comments preceded with ## 
## First cd into local repository and check status;
user1@Host1 MINGW64 ~
$ cd $HOME/gitrepository
user1@Host1 MINGW64 ~/gitrepository (master)
$ git status
On branch master
nothing to commit, working directory clean

## Now try to clone remote repository on Host2 (added set -x to ~/.bashrc
script)
user1@Host1 MINGW64 ~/gitrepository (master)
$ git clone -v ssh://user1@Host2/srv/centralrepo
Cloning into 'centralrepo'...
>>>Lines from $HOME/.bashrc
  + export
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
:/usr/local/games
  +
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
:/usr/local/games
  + PROMPT_COMMAND=
  + CDPATH=
  + '[' '' = yes ']'
  + PS1='${debian_chroot:+($debian_chroot)}\u:\W\$ '
  + export GIT_TRACE_PACKET=1
  + GIT_TRACE_PACKET=1
  + export GIT_TRACE=1
  + GIT_TRACE=1
>>>End of Lines from $HOME/.bashrc
## WHERE DOES The following line COME FROM????What Script spits out this
line????
  + user1@Host2 git-upload-pack /srv/centralrepo
  bash: user1@Host2: command not found
  fatal: Could not read from remote repository.

  Please make sure you have the correct access rights
  and the repository exists.

## Check remote path for interactive non-login session
user1@Host1 MINGW64 ~/gitrepository (master)
$ ssh user1@Host2 echo \$PATH
Enter passphrase for key '/c/Users/user1/.ssh/id_rsa':
## >>>Lines from $HOME/.bashrc (See Above, removed here for clarity)
##  PATH looks okay
+ echo
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr
/local/games
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr
/local/games

## List remote Git respository to check permissions
user1@Host1 MINGW64 ~/gitrepository (master)
$ ssh user1@Host2 ls -al /srv/centralrepo.git
Enter passphrase for key '/c/Users/user1/.ssh/id_rsa':
##  >>>Lines from $HOME/.bashrc (See Above, removed here for clarity)
##  CHECK the permissions and owner of the remote git repository
+ ls -al /srv/centralrepo.git
total 44
drwxrwsrwx 7 user1 developer 4096 Feb 11 21:02 .
drwxrwxrwx 4 user1 developer 4096 Feb  2 08:15 ..
drwxrwsrwx 2 user1 developer 4096 Feb  2 08:16 branches
-rwxrwxrwx 1 user1 developer  224 Feb  4 18:09 config
-rwxrwxrwx 1 user1 developer   26 Feb 11 21:02 description
-rwxrwxrwx 1 user1 developer   23 Feb  2 08:16 HEAD
drwxrwsrwx 2 user1 developer 4096 Feb  2 08:16 hooks
drwxrwsrwx 2 user1 developer 4096 Feb  2 08:16 info
drwxrwsrwx 4 user1 developer 4096 Feb  2 08:16 objects
drwxrwsrwx 4 user1 developer 4096 Feb  2 08:16 refs
-rw-rw-r-- 1 user1 developer   52 Feb 11 19:37 sample.txt

## Try cloning with -u option and path to upload-pack
user1@Host1 MINGW64 ~/gitrepository (master)
$ git clone -u /usr/bin/git-upload-pack ssh://user1@Host2/srv/centralrepo
Cloning into 'centralrepo'...
## >>>Lines from $HOME/.bashrc (See Above, removed here for clarity)
## ***** POSIX directory translation messed up this path
+ user1@Host2 C:/Program Files/Git/usr/bin/git-upload-pack /srv/centralrepo
bash: user1@Host2: command not found
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

## List the remote repository config
user1@Host1 MINGW64 ~/gitrepository (master)
$ ssh user1@Host2 cat /srv/centralrepo.git/config
Enter passphrase for key '/c/Users/user1/.ssh/id_rsa':
## >>>Lines from $HOME/.bashrc (See Above, removed here for clarity)
+ cat /srv/centralrepo.git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = true
        sharedrepository = 1
[receive]
        denyNonFastforwards = true
[remote "origin"]
        uploadpack = /usr/bin/git-upload-pack
        receivepack = /usr/bin/git-receive-pack

## List Git version
user1@Host1 MINGW64 ~/gitrepository (master)
$ ssh user1@Host2 git --version
Enter passphrase for key '/c/Users/phreddyw/.ssh/id_rsa':
## >>>Lines from $HOME/.bashrc (See Above, removed here for clarity)
+ git --version
trace: built-in: git 'version'
git version 2.7.2




Regards,
Fred 
