From: =?ISO-8859-1?Q?=22Peter_Valdemar_M=F8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>
Subject: Git (svn) merge - but ignore certain commits?
Date: Sat, 27 Dec 2008 14:02:01 +0100
Message-ID: <49562749.9060705@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 27 14:06:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGYrf-0007Xj-59
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 14:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbYL0NCJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 08:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753499AbYL0NCH
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 08:02:07 -0500
Received: from smtp21.orange.fr ([80.12.242.47]:60521 "EHLO smtp21.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753424AbYL0NCG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 08:02:06 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2108.orange.fr (SMTP Server) with ESMTP id 57AC31C00096
	for <git@vger.kernel.org>; Sat, 27 Dec 2008 14:02:02 +0100 (CET)
Received: from [192.168.1.39] (ANice-157-1-24-49.w90-28.abo.wanadoo.fr [90.28.47.49])
	by mwinf2108.orange.fr (SMTP Server) with ESMTP id 21EA61C00095
	for <git@vger.kernel.org>; Sat, 27 Dec 2008 14:02:02 +0100 (CET)
X-ME-UUID: 20081227130202139.21EA61C00095@mwinf2108.orange.fr
User-Agent: Thunderbird 2.0.0.18 (X11/20081125)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104003>

Hi,

I'm wondering how to merge a branch back to a master/svn trunk, getting=
=20
"almost" all the commits on the branch. I've experimented with "git=20
merge -s ours" unsuccessfully and don't know how else to proceed.

Background: Our svn trunk has had many solid commits, and a few that=20
aren't ready yet. We need to make a new release without these unready=20
commits but with some new functionality.

Externally to git, a branch was made off of trunk's HEAD. Call it=20
"newbranch".

The idea is to:

* Create a git branch off of svn "newbranch", call it "gitnewbranch".

* "git revert" the "few unready" commits on "gitnewbranch" so we have a=
=20
solid foundation

* add the new functionality to "gitnewbranch"

* "git svn dcommit" to get the new functionality on svn's "newbranch"

* And now the trick: "git merge" "gitnewbranch" back to master. But I=20
want to avoid the "git revert" of the few commits that weren't ready ye=
t.

* "git svn dcommit" master to get the new functionality into svn trunk.

How do I "git merge" all of "gitnewbranch" except the reverts?

I tried doing just the revert step, and then
"git merge -s ours gitnewbranch"
on master, and that seemed to work. Annoyingly (to me :-D) "git log=20
master" does show the reverts that happened on gitnewbranch, but the=20
files in master were not changed. However, when I "git svn rebase", it=20
fails with a
"CONFLICT (content): Merge conflict in <file>".
And hence, "git svn dcommit" fails too.

Is there a way to "git merge gitnewbranch" excluding the reverts, just=20
the "new functionality", so the log of master doesn't even mention the=20
reverts and so "git svn rebase" and "git svn dcommit" work properly?

I guess I could git cherry-pick all the "new functionality" commits fro=
m=20
gitnewbranch to master, but it sort of defeats the coolness of gits=20
branch handling if I have to keep track of the cherry-picked commits=20
manually.

How do I do this "properly"?

Peter
--=20
Peter Valdemar M=F8rch
http://www.morch.com
