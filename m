From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git cherry not marking commits with equivalent upstream
Date: Thu, 1 Jul 2010 22:41:51 +0200
Message-ID: <20100701204151.GA6354@atjola.homenet>
References: <1278012954-sup-3724@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Andrew Pimlott <andrew@pimlott.net>
X-From: git-owner@vger.kernel.org Thu Jul 01 22:42:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUQaH-0007aK-R0
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 22:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758236Ab0GAUmA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 16:42:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:51203 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757763Ab0GAUl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 16:41:59 -0400
Received: (qmail invoked by alias); 01 Jul 2010 20:41:57 -0000
Received: from i59F55AB1.versanet.de (EHLO atjola.homenet) [89.245.90.177]
  by mail.gmx.net (mp005) with SMTP; 01 Jul 2010 22:41:57 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/NlpQqON7N3iShSlK2WVbehF4rxrNhEJlkK+6ONT
	pzDJf1Q5M5HKqq
Content-Disposition: inline
In-Reply-To: <1278012954-sup-3724@pimlott.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150081>

On 2010.07.01 12:38:45 -0700, Andrew Pimlott wrote:
> The documentation for git-cherry says it marks changes in the current
> checkout that have an "equivalent" change in the upstream branch.  It
> even says it's useful when feeding patches upstream by email instead =
of
> git, which is what I'm doing (with CVS instead of email).  But it
> doesn't seem to work for me.
>=20
> I'll simulate cloning an upstream repo, creating and commiting a patc=
h,
> then sending it via email upstream to have it applied there, then
> pulling the upstream commit (the upstream repo is a, mine is b):
>=20
>     ~% mkdir a && cd a
>     ~/a% git init
>     Initialized empty Git repository in /home/andrew/a/.git/
>     ~/a% touch a
>     ~/a% git add a
>     ~/a% git commit -m 1
>     [master (root-commit) be4fa74] 1
>      0 files changed, 0 insertions(+), 0 deletions(-)
>      create mode 100644 a
>     ~/a% git clone . ../b && cd ../b
>     Initialized empty Git repository in /home/andrew/b/.git/
>     ~/b% echo test > a
>     ~/b% git add a
>     ~/b% git commit -m 2
>     [master 551e90a] 2
>      1 files changed, 1 insertions(+), 0 deletions(-)
>     ~/b% cd ../a
>     ~/a% echo test > a
>     ~/a% git add a
>     ~/a% git commit -m 3
>     [master bb13e6c] 3
>      1 files changed, 1 insertions(+), 0 deletions(-)
>     ~/a% cd ../b
>     ~/b% git pull
>     remote: Counting objects: 5, done.
>     remote: Total 3 (delta 0), reused 0 (delta 0)
>     Unpacking objects: 100% (3/3), done.
>     From /home/andrew/a/.
>        be4fa74..bb13e6c  master     -> origin/master
>     Merge made by recursive.
>     ~/b% cat a
>     test

pull =3D fetch + merge, so your history in "b" looks like this:

  2 (origin/master)
 / \
1   M (master)
 \ /
  3

So "2" is common to both branches and thus ignored by cherry. If you
just fetch instead of merging, you get the result you expected:

doener@atjola:b (master) $ git fetch=20
remote: Counting objects: 5, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
=46rom /home/doener/y/a
   4815708..dfbbb81  master     -> origin/master

doener@atjola:b (master) $ git cherry
- 2544e5a7f5d6b545d9e24ba9dcac74861b0bf15c

But once I merge:
doener@atjola:b (master) $ git merge origin/master
Merge made by recursive.

doener@atjola:b (master) $ git cherry
+ 2544e5a7f5d6b545d9e24ba9dcac74861b0bf15c

Bj=F6rn
