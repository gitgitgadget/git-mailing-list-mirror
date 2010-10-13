From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Subject: Re: git ls-files handles paths differently in Windows and Mac (probably Linux)
Date: Wed, 13 Oct 2010 13:09:40 +0400
Message-ID: <AEC0873D-4AFC-402E-9D7D-197A7D40DCDD@jetbrains.com>
References: <3C33A244-2449-4A3C-A8B5-2060CE61EE04@jetbrains.com> <AANLkTimB6s_yt6L59xpqsWO_yBsZxuVCiExFoSm9FcN1@mail.gmail.com> <C29949EA-5717-4BA3-936E-354FCB107877@jetbrains.com> <38052CF8-66F3-40FD-8D2D-8FD58A622F7B@jetbrains.com> <AANLkTi=6nJAYKB_MTjXL3oftcWtr_wtdHaULYzRcP6oP@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 11:09:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5xLK-0000b8-3a
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 11:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379Ab0JMJJn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Oct 2010 05:09:43 -0400
Received: from mail.intellij.net ([213.182.181.98]:49683 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203Ab0JMJJn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Oct 2010 05:09:43 -0400
Received: (qmail 16550 invoked by uid 89); 13 Oct 2010 09:09:41 -0000
Received: by simscan 1.1.0 ppid: 16471, pid: 16517, t: 0.0661s
         scanners: regex: 1.1.0 clamav: 0.96
/m: 52
Received: from unknown (HELO loki-mac-pro.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@172.26.240.110)
  by mail.intellij.net with ESMTPA; 13 Oct 2010 09:09:41 -0000
In-Reply-To: <AANLkTi=6nJAYKB_MTjXL3oftcWtr_wtdHaULYzRcP6oP@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158911>


12.10.2010, =D7 19:25, Alex Riesen =CE=C1=D0=C9=D3=C1=CC(=C1):
>=20
> Besides, if you have to just check if the tree under a path is change=
d
> you can always use
> --exit-code or --quiet to "git diff", it will speed them up.

Unfortunately, that's not enough: I have to know which files have chang=
ed and how (created, deleted, modified).
Also I feel that it's not the size of the output which is slow - the sc=
an of directories itself is.=20


>> And also "git diff --name-status" doesn't show unversioned files.
>> As I've found, "git ls-files" is the only command which shows unvers=
ioned files (except git status), isn't it?
>=20
> Yes, you're right. What are you trying to do, BTW?

I'm developing a plugin for Git integration for IntelliJ IDEA (an IDE f=
or Java and other languages).
And the task I'm working now is to get the status of index and working =
tree. I want to make it as fast as possible.
To work with a Git repository I start a process with git native command=
s, so every command to execute is additional cost.
(Maybe I could work with the filesystem and raw Git repository, but it =
would be an overhead).

If we forget about "git status --porcelain" there is no single command =
to get the whole status. I could use=20
"git ls-files -ov" for unversioned files + "git diff --name-status" for=
 all other.
OR=20
"git ls-files -douvm" for the changes in the working tree + "git diff-i=
ndex --cached" for the changes in the index.
OR
"git ls-files -ov" for unversioned + "git diff-files" for other files i=
n the working tree + "git diff-index --cached" for the changes in the i=
ndex.
or maybe something else

I've made a script which executes these commands (which allow to get th=
e total status) on a large repository many times.=20
My results show that "ls-files -douvm"+"git diff-index --cached" is the=
 fastest combination.

Do you think I could achieve the same result in a simpler or faster way=
?

Thanks a lot.

----------------------------------
Kirill Likhodedov
JetBrains, Inc
http://www.jetbrains.com
"Develop with pleasure!"
