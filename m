From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: Bug report about symlinks
Date: Fri, 01 Aug 2014 00:04:25 +0200
Message-ID: <53DABD69.7010004@web.de>
References: <web-416867478@relay1.vsu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nikolay Avdeev <avdeev@math.vsu.ru>
X-From: git-owner@vger.kernel.org Fri Aug 01 00:05:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCyT8-0005of-18
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 00:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbaGaWE5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jul 2014 18:04:57 -0400
Received: from mout.web.de ([212.227.17.11]:51316 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120AbaGaWE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 18:04:57 -0400
Received: from [192.168.178.27] ([79.250.190.245]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LcPSk-1Wmx3Q0Nss-00ju6a; Fri, 01 Aug 2014 00:04:54
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <web-416867478@relay1.vsu.ru>
X-Provags-ID: V03:K0:jwgPsMEh0+euU4jdqXnOBNrnVg/TGjl9A+Ejh3MXGFDWi7uJMhq
 1sLzywHktwAjvjCO/n7btzSNbqBk5zG6nA0bLf9Jo4g0XLHbIzjzx2F3J/GIFK9dOXieBVf
 QHmy545a54hY0GOJPl/I9q0O7646x6Vpc3X2nHXYIvCVdEN2vTXNB9vGqeuSHiVrFfm8w02
 clexOIDgwt07eWuusmkTw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254615>

Am 31.07.2014 um 21:50 schrieb Nikolay Avdeev:
> I've noticed something strange with git status when replacing a folde=
r with
> symlink to another folder.
> There is a git repo with script with demo in the attachment.

Let's try and make this a bit easier for folks to follow along.

# Create test repo with two directories with two files each.
$ git init
Initialized empty Git repository in /tmp/.git/
$ mkdir a b
$ echo x >a/equal
$ echo x >b/equal
$ echo y >a/different
$ echo z >b/different
$ git add a b
$ git commit -minitial
[master (root-commit) 6d36895] initial
  4 files changed, 4 insertions(+)
  create mode 100644 a/different
  create mode 100644 a/equal
  create mode 100644 b/different
  create mode 100644 b/equal

# Replace one directory with a symlink to the other.
$ rm -rf b
$ ln -s a b

# First git status call.
$ git status
On branch master
Changes not staged for commit:
   (use "git add/rm <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working direc=
tory)

         deleted:    b/different

Untracked files:
   (use "git add <file>..." to include in what will be committed)

         b

no changes added to commit (use "git add" and/or "git commit -a")

# Stage the changes.
$ git add b

# Second git status call.
$ git status
On branch master
Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)

         new file:   b
         deleted:    b/different
         deleted:    b/equal

# Commit the staged changes.
$ git commit -msymlinked
[master 4498f28] symlinked
  3 files changed, 1 insertion(+), 2 deletions(-)
  create mode 120000 b
  delete mode 100644 b/different
  delete mode 100644 b/equal


That the first and second status call report different results is a=20
feature; staging changes using git add alters the status.  A commit=20
after the first status call would be empty.

It could be debated if the first git status call should also report=20
b/equal as deleted.

Ren=C3=A9
