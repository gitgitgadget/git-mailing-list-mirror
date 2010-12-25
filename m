From: Michel Briand <michelbriand@free.fr>
Subject: Re: FIX/COMMENT: git remote manual page
Date: Sat, 25 Dec 2010 12:41:04 +0100
Message-ID: <20101225124104.06a4f83c@eana.kheb.homelinux.org>
References: <20101222021546.4b24c4e9@eana.kheb.homelinux.org>
	<AANLkTim_pHYEZ+7-Rm5N4Ycw2MTHD8AhvZrZqNhttkck@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 25 12:46:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWSaA-0005sB-TY
	for gcvg-git-2@lo.gmane.org; Sat, 25 Dec 2010 12:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260Ab0LYLlN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Dec 2010 06:41:13 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:37542 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915Ab0LYLlN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Dec 2010 06:41:13 -0500
Received: from eana.kheb.homelinux.org (unknown [82.234.51.186])
	by smtp2-g21.free.fr (Postfix) with ESMTP id F3D614B00F8;
	Sat, 25 Dec 2010 12:41:05 +0100 (CET)
In-Reply-To: <AANLkTim_pHYEZ+7-Rm5N4Ycw2MTHD8AhvZrZqNhttkck@mail.gmail.com>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164171>


Nguyen Thai Ngoc Duy <pclouds@gmail.com> - Sat, 25 Dec 2010 17:48:58
+0700

>On Wed, Dec 22, 2010 at 8:15 AM, Michel Briand <michelbriand@free.fr> =
wrote:
>> Hello,
>>
>> I tried the example given at the bottom if the manual page of git
>> remote.
>>
>> =B7 =A0 Imitate git clone but track only selected branches
>>
>> $ mkdir project.git
>> $ cd project.git
>> $ git init
>> $ git remote add -f -t master -m master origin git://example.com/git=
=2Egit/
>> $ git merge origin
>>
>> It works like it is written.
>>
>> But it seems this does not work with my special setup:
>> - I use GIT_DIR and GIT_WORK_TREE to specify another location for my
>> =A0repository, and to work from another directory,
>> - I name my remote with a custom name (not origin).
>
>So you set GIT_DIR and GIT_WORK_TREE before running "git remote add"?
>

Yes.

>> It fails at the last command :
>>
>> =A0 =A0fatal: <my name> - not something we can merge
>
>It fails to see "<my name>" points to a commit. Maybe it fails to read
>remote information from config..
>

Huh, I don't know.

>> But if I try the command :
>>
>> =A0 =A0git merge <my name>/master
>>
>> the error message is different :
>>
>> =A0 =A0fatal: This operation must be run in a work tree
>> =A0 =A0fatal: read-tree failed
>>
>> I cd to the work tree and issue the same last command.
>> Then it works.
>
>What git version are use using? I did
>
>GIT_DIR=3Dgit/.git GIT_WORK_TREE=3Dgit git/git merge origin # or a spe=
cific branch
>
>and it worked fine here (recent master). That message means work-tree
>settings are not propagated to git-read-tree (run by git-merge).

Hi,

I'm running Debian squeeze. Git is version 1.7.2.3.

Here is the complete command sequence I used:

~/tmp/git $ mkdir toto toto_wk
~/tmp/git $ GIT_DIR=3Dtoto GIT_WORK_TREE=3Dtoto_wk git init
Initialized empty Git repository in xxxxxxxxxxxxxxxx/tmp/git/toto/
~/tmp/git $ GIT_DIR=3Dtoto GIT_WORK_TREE=3Dtoto_wk git remote add -f -t=
 master -m master TOTO xxxxxx/shlib=20
Updating TOTO
remote: Counting objects: 36, done.
remote: Compressing objects: 100% (32/32), done.
remote: Total 36 (delta 9), reused 0 (delta 0)
Unpacking objects: 100% (36/36), done.
=46rom xxxxxxxxxxxxxxxxx/shlib
 * [new branch]      master     -> TOTO/master
=46rom xxxxxxxxxxxxxxxxx/shlib
 * [new tag]         1.0        -> 1.0
 * [new tag]         1.0.1      -> 1.0.1
~/tmp/git $ GIT_DIR=3Dtoto GIT_WORK_TREE=3Dtoto_wk git merge TOTO
fatal: This operation must be run in a work tree
fatal: read-tree failed
~/tmp/git $ ls toto_wk/
<NOTHING>

I re-issue the latest command :

~/tmp/git $ GIT_DIR=3Dtoto GIT_WORK_TREE=3Dtoto_wk git merge TOTO
Already up-to-date.

Strange isn't it ?

But directory is still empty
~/tmp/git $ ls toto_wk/
<NOTHING>

Trying to recover :

~/tmp/git $ GIT_DIR=3Dtoto GIT_WORK_TREE=3Dtoto_wk git reset --hard

The directory is correct (in sync with my master branch).

If I do :

=2E..git init
=2E..git remote add...
cd toto_wk
GIT_DIR=3D../toto GIT_WORK_TREE=3D. git merge TOTO

It works !

Adding /master after remote name doesn't make any difference. Please
forget this idea.

The problem seems to reside in the work tree parameter (. or not).

Cheers,
Michel
