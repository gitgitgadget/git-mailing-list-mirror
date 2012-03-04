From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v3 0/4] submodules: Use relative paths to gitdir and work
 tree
Date: Sun, 04 Mar 2012 22:11:49 +0100
Message-ID: <4F53DA95.2020402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysGit Mailinglist <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 04 22:12:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Iiv-0000Gj-Ot
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 22:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550Ab2CDVMC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 16:12:02 -0500
Received: from fmmailgate07.web.de ([217.72.192.248]:42083 "EHLO
	fmmailgate07.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217Ab2CDVMA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 16:12:00 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate07.web.de (Postfix) with ESMTP id 3E630D5DE52
	for <git@vger.kernel.org>; Sun,  4 Mar 2012 22:11:59 +0100 (CET)
Received: from [192.168.178.48] ([91.3.220.167]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MgwO8-1RiDUc12oq-00Muw9; Sun, 04 Mar 2012 22:11:58
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
X-Provags-ID: V02:K0:aTAe5Z4LtPfPdgoY1fo1YEOFkno7VHZWP4pi9LoqJNc
 kSZLYoR2QWy/7trWc4/rggnr9YR/ykR7iAUEORZX5Kqzz5LklF
 fMtyS5jvPn0F0tJeFLlasuIYc07YgjcOdvsxehlfWSHhpAxJsS
 sALAsroaZN8i68WMoIaln6LAtqvb5866GXafJXV7ftKoVorRkk
 71LNI52Boj4EOP7nD6tHg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192173>

This is the third round of the former two patch series. It applies
cleanly on current master and maint and IMO is maint stuff as it fixes
bugs related to submodules. Those were introduced when moving the git
directory into that of the superproject and using a gitfile instead.

The first patch is unchanged from version one, in the second I did
address the concerns raised about the while loop. Those two patches
make superprojects movable again.

The third patch started as a mere refactoring, but while working on
it I noticed it also fixes an issue when submodules are moved around
inside a superproject.

The forth patch is provided by Johannes Sixt and addresses the issue
that under windows both POSIX and Windows style paths may occur which
sometimes broke the computation of relative paths.

Now all issues I'm aware of are fixed and tested for. In the next step
I'll be looking into teaching git mv to handle submodules, as just
mv'ing them someplace else, upating .gitmodules and adding the paths
isn't sufficient anymore. The core.worktree setting - and sometimes the
gitfile too (when the submodule is moved to a different directory level)
- have to be updated too to make that work (That would be easier if git
could treat the directory a gitfile was found in as a candidate for the
work tree, as then we could get rid of the core.worktree setting, but
we don't have that functionality).

Jens Lehmann (4):
  submodules: always use a relative path to gitdir
  submodules: always use a relative path from gitdir to work tree
  submodules: refactor computation of relative gitdir path
  submodules: fix ambiguous absolute paths under Windows

 git-submodule.sh            |   58 +++++++++++++++++++++----------------------
 t/t7400-submodule-basic.sh  |   22 ++++++++++++++++
 t/t7406-submodule-update.sh |   17 +++++++++++++
 3 files changed, 68 insertions(+), 29 deletions(-)

-- 
1.7.9.2.362.g684a8
