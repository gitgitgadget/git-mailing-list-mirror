From: Paul Martinolich <martinol@nrlssc.navy.mil>
Subject: cloning submodules with children submodules
Date: Fri, 23 Nov 2007 13:17:15 -0600
Message-ID: <BC1DE15A-9225-41D3-A2D7-21A14DF81048@nrlssc.navy.mil>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/mixed; boundary=Apple-Mail-16-642386884
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 20:28:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IveCO-0001ol-C8
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 20:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757471AbXKWT1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 14:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752738AbXKWT1l
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 14:27:41 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59108 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756892AbXKWT1k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 14:27:40 -0500
X-Greylist: delayed 624 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Nov 2007 14:27:40 EST
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id lANJHFWR030276
	for <git@vger.kernel.org>; Fri, 23 Nov 2007 13:17:16 -0600
Received: from garnet.nrlssc.navy.mil ([128.160.22.16]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 23 Nov 2007 13:17:15 -0600
X-Mailer: Apple Mail (2.915)
X-OriginalArrivalTime: 23 Nov 2007 19:17:15.0119 (UTC) FILETIME=[74E8D7F0:01C82E05]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15554001
X-TM-AS-Result: : Yes--8.988400-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTQ3MDE1LTcwNzExOS03MDQz?=
	=?us-ascii?B?NDEtNzAxNzYyLTE4ODAxOS03MDY4MTctNzAwOTcwLTcwMTE0My0x?=
	=?us-ascii?B?MjEzNjctNzA3NjU0LTcxMTk1My03MDA3NTYtNzAyMTQzLTcwMDkx?=
	=?us-ascii?B?OC03MDAxMzMtMTM2MDcwLTcwMDc4Mi03MDAxMDctNzAyNjQ1LTE0?=
	=?us-ascii?B?ODAzOS0xNDgwNTA=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65918>


--Apple-Mail-16-642386884
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

It appears that git clone or git submodule init does not handle  
submodules under submodules.

Given this project tree:

modules/mod_A
modules/mod_B
modules/mod_b

proj_one/mod_A
proj_one/mod_B
proj_one/mod_B/mod_b

proj_two/mod_A
proj_two/mod_B
proj_two/mod_b

The cloning of proj_two works correctly.  However, for proj_one, mod_b  
is not under mod_B:

cloned proj_one

$ ls -a ./
.  ..  .git  .gitmodules  mod_A  mod_B	project.txt
$ ls -a ./mod_A
.  ..
$ ls -a ./mod_B
.  ..
$ more .gitmodules
[submodule "mod_A"]
	path = mod_A
	url = /home/martinol/test/modules/mod_A/.git
[submodule "mod_B"]
	path = mod_B
	url = /home/martinol/test/modules/mod_B/.git
Submodule 'mod_A' (/home/martinol/test/modules/mod_A/.git) registered  
for path 'mod_A'
Submodule 'mod_B' (/home/martinol/test/modules/mod_B/.git) registered  
for path 'mod_B'
Initialized empty Git repository in /home/martinol/test/user_a/ 
proj_one/mod_A/.git/
0 blocks
Submodule path 'mod_A': checked out  
'80298817a0789d039e1fb4a73c9635fce8e7cdd2'
Initialized empty Git repository in /home/martinol/test/user_a/ 
proj_one/mod_B/.git/
0 blocks
Submodule path 'mod_B': checked out  
'21b652610f5e9085f799c424d8a7ef685f5ec440'

submodule init/update proj_one

$ ls -a ./
.  ..  .git  .gitmodules  mod_A  mod_B	project.txt
$ ls -a ./mod_A
.  ..  .git  module.txt
$ ls -a ./mod_B
.  ..  .git  module.txt
$ more .gitmodules
[submodule "mod_A"]
	path = mod_A
	url = /home/martinol/test/modules/mod_A/.git
[submodule "mod_B"]
	path = mod_B
	url = /home/martinol/test/modules/mod_B/.git

public proj_one

$ cd ~/test/proj_one
$ ls -a ./
.  ..  .git  .gitmodules  mod_A  mod_B	project.txt
$ ls -a ./mod_B
.  ..  .git  .gitmodules  mod_b  module.txt
$ more .gitmodules
[submodule "mod_A"]
	path = mod_A
	url = /home/martinol/test/modules/mod_A/.git
[submodule "mod_B"]
	path = mod_B
	url = /home/martinol/test/modules/mod_B/.git
$ more mod_B/.gitmodules
[submodule "mod_b"]
	path = mod_b
	url = /home/martinol/test/modules/mod_b/.git

$ git --version
git version 1.5.3.6

I've attached a script that demonstrates this behavior.

Thanks, Paul


--Apple-Mail-16-642386884
Content-Disposition: attachment;
	filename=sub-sub-modules.sh
Content-Type: application/octet-stream;
	x-unix-mode=0700;
	name="sub-sub-modules.sh"
Content-Transfer-Encoding: 7bit

#/bin/sh

GITDIR=$HOME/test
mk_modules()
{
        mkdir -p $GITDIR/modules/$1
        cd $GITDIR/modules/$1
        git init
        echo "$1" > module.txt
        git add module.txt
        git commit -m "initialize module $1"
        git branch -m master proj_one
}

#  setup public modules

mk_modules mod_A
mk_modules mod_b
mk_modules mod_B

#  create public proj_one project

mkdir -p $GITDIR/proj_one
cd $GITDIR/proj_one

git init
echo "Project One" > project.txt
git add project.txt
git commit -m 'initialize project proj_one'
git branch -m master proj_one

git submodule add $GITDIR/modules/mod_A
git commit -m 'add module mod_A to project proj_one'
git submodule add $GITDIR/modules/mod_B
git commit -m 'add module aps to project proj_one'

cd $GITDIR/proj_one/mod_B
git submodule add $GITDIR/modules/mod_b
git commit -m 'add module mod_b under module mod_B for project proj_one'
git status

#  create public proj_two project

mkdir -p $GITDIR/proj_two
cd $GITDIR/proj_two

git init
echo "Project Two" > project.txt
git add project.txt
git commit -m 'initialize project proj_two'
git branch -m master proj_two

#  create proj_two branch on public modules

cd $GITDIR/modules/mod_A
git checkout -b proj_two
cd $GITDIR/modules/mod_B
git checkout -b proj_two
cd $GITDIR/modules/mod_b
git checkout -b proj_two

#  add these modules to the proj_two project

cd $GITDIR/proj_two
git submodule add $GITDIR/modules/mod_A
git commit -m 'add module mod_A to project proj_two'
git submodule add $GITDIR/modules/mod_B
git commit -m 'add module mod_B to project proj_two'
git submodule add $GITDIR/modules/mod_b
git commit -m 'add module mod_b to project proj_two'

#  clone the proj_two project (user a)

mkdir -p $GITDIR/user_a
cd $GITDIR/user_a
git clone $GITDIR/proj_two
cd $GITDIR/user_a/proj_two

git submodule init
git submodule update

#  clone the proj_two project (user b)

mkdir -p $GITDIR/user_b
cd $GITDIR/user_b
git clone $GITDIR/proj_two
cd $GITDIR/user_b/proj_two

git submodule init
git submodule update

#  clone the proj_one project (user user_a)

mkdir -p $GITDIR/user_a
cd $GITDIR/user_a
git clone $GITDIR/proj_one
cd $GITDIR/user_a/proj_one

echo ""
echo "cloned proj_one"
echo ""

ls -a ./
ls -a ./mod_A
ls -a ./mod_B
more .gitmodules

git submodule init
git submodule update

echo ""
echo "submodule init/update proj_one"
echo ""

ls -a ./
ls -a ./mod_A
ls -a ./mod_B
more .gitmodules

echo ""
echo "public proj_one"
echo ""

cd $GITDIR/proj_one
ls -a ./
ls -a ./mod_B
more .gitmodules
more mod_B/.gitmodules

--Apple-Mail-16-642386884
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit






--Apple-Mail-16-642386884--
