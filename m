From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Burdet?= <jfburdet@revelate.com>
Subject: Problem using git-filter-branch to move tree when repository name
 contains space
Date: Fri, 01 Apr 2011 16:30:26 +0200
Message-ID: <4D95E182.6030903@revelate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 16:31:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5fO1-0002Tp-4e
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 16:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab1DAObf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2011 10:31:35 -0400
Received: from [85.232.47.149] ([85.232.47.149]:53324 "EHLO
	mail-server-02.titaninternet.co.uk" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751813Ab1DAObf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 10:31:35 -0400
Received: from cust.static.46-14-222-70.swisscomdata.ch ([46.14.222.70] helo=[127.0.0.1])
	by mail-server-02.titaninternet.co.uk with esmtpa (Exim 4.69)
	(envelope-from <jfburdet@revelate.com>)
	id 1Q5fNZ-0002C3-Ty
	for git@vger.kernel.org; Fri, 01 Apr 2011 15:31:14 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170589>

Hi,

I want to move my repository (wich is contained in a directory whose
name's containing a space)  root tree to a subdirectory.

I followed what's documented in
http://www.kernel.org/pub/software/scm/git/docs/git-filter-branch.html =
,
using the last example :

git filter-branch --index-filter \
        'git ls-files -s | sed "s-\t\"*-&newsubdir/-" |
                GIT_INDEX_FILE=3D$GIT_INDEX_FILE.new \
                        git update-index --index-info &&
         mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD


But, look at the following two scenario:

Scenario 1 : Repository have no space in it, everything works fine :
jfburdet@nagios:~$ mkdir gittest
jfburdet@nagios:~$ cd gittest/
jfburdet@nagios:~/gittest$ git init
Initialized empty Git repository in /home/jfburdet/gittest/.git/
jfburdet@nagios:~/gittest$ touch a_file
jfburdet@nagios:~/gittest$ git add .
jfburdet@nagios:~/gittest$ git commit -m "A commit"
[master (root-commit) e6261d5] A commit
 Committer: jfburdet <jfburdet@(none)>
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 a_file
 jfburdet@nagios:~/gittest$ git filter-branch --index-filter \
>         'git ls-files -s | sed "s-\t\"*-&newsubdir/-" |
>                 GIT_INDEX_FILE=3D$GIT_INDEX_FILE.new \
>                         git update-index --index-info &&
>          mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
Rewrite e6261d591357f39e1b4f95c0dfeb7a133e211161 (1/1)
Ref 'refs/heads/master' was rewritten

Scenario 2 : Repository have space in its directory name, making the
command fails
jfburdet@nagios:~$ mkdir "git test"
jfburdet@nagios:~$ cd "git test"
jfburdet@nagios:~/git test$
jfburdet@nagios:~/git test$ git init
Initialized empty Git repository in /home/jfburdet/git test/.git/
jfburdet@nagios:~/git test$ touch a_file
jfburdet@nagios:~/git test$ git add .
jfburdet@nagios:~/git test$ git commit -m "A commit"
[master (root-commit) 3658e30] A commit
 Committer: jfburdet <jfburdet@(none)>
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 a_file
jfburdet@nagios:~/git test$ git filter-branch --index-filter \
>         'git ls-files -s | sed "s-\t\"*-&newsubdir/-" |
>                 GIT_INDEX_FILE=3D$GIT_INDEX_FILE.new \
>                         git update-index --index-info &&
>          mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
Rewrite 3658e305df3ace21d39bf57dd4e0e5627818dfcc (1/1)mv: target
`test/.git-rewrite/t/../index' is not a directory
index filter failed: git ls-files -s | sed "s-  \"*-&newsubdir/-" |
                GIT_INDEX_FILE=3D$GIT_INDEX_FILE.new \
                        git update-index --index-info &&
         mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE
jfburdet@nagios:~/git test$


I tried to tweak the sed expression with no success. Can someone help m=
e
with that ?

Please note that I can't simply rename the directory before firing up
"git filter-branch" because I'm in a process of merging repositories an=
d
their name are mandatory.

Cheers,

Jean-Fran=E7ois,
