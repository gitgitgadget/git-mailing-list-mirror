From: John Medema <john.medema@uniteddrugs.com>
Subject: Bug Report: git gui clones non-master default branch as master
Date: Thu, 3 Sep 2015 10:01:16 -0700
Message-ID: <CALsXy+1p7ekshWNAvA991nWRcUUFv1zW39G2Wm=U0vvQ2O6PuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, SysAdmin <sysadmin@uniteddrugs.com>,
	IT Dev2 <john.kobinski@uniteddrugs.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 19:01:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXXtM-0005JF-L6
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 19:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818AbbICRBh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2015 13:01:37 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34936 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbbICRBg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Sep 2015 13:01:36 -0400
Received: by ioiz6 with SMTP id z6so65459317ioi.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 10:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=bjtK2ZJ4QE1qcY3CWpsNKaQQJMpLA41peQIBL7bLprg=;
        b=Z792sXCeqAVob70nteA+fo0yDa20p6rHkIxZBXLQijXV9S8oUsHy3RGyW+Q4UKNaUq
         sYypLvHUXAFSgkaWpgftiuyILCH7KxJHdEjFnbvVOKtted/5FOk3ZJH0SJ8XLy3uvnkV
         f1/ak+KCUO/zcnIr5Zio10VftRw0m1zhDNqCgdu471660K0fRMTxUVyhmUQaCHs8J2zk
         fRUivTYHzcgHfrPaQe3Y2qZUTHRhgbzhy5RKXODz7SVIk6Gx+hMtk7togjdKfCkM2pgx
         0+/C01rcJNFL0ZJZWjnhwaByb0obluHc4dFX307+ZrYDBn07ONiTyU4O+4J7u0mInBcK
         KYzQ==
X-Gm-Message-State: ALoCoQn1eUYK1Xkgv7sl3KnWxTkbpJfXouAEqE6nsu4/8McZ7P3eWuT2JV4LesXAqVoDp5x+gvoBIo72tFleDxo68VDXo8PT0zhhlZU8i06gUFpm3u5vGbRKAL3yPRJDOXaVVfjd98gC
X-Received: by 10.107.18.231 with SMTP id 100mr102740ios.15.1441299695430;
 Thu, 03 Sep 2015 10:01:35 -0700 (PDT)
Received: by 10.107.135.155 with HTTP; Thu, 3 Sep 2015 10:01:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277231>

Git gurus, your assistance is needed.

Environment #1:
git version 2.5.0.windows.1
git-gui version 0.20.GITGUI
Windows 7 Pro 64-bit

Environment #2:
git version 1.7.9.msysgit.0
git-gui version 0.16.GITGUI
Windows Server 2003 R2 32-bit

Environment #3:
Linux (check with dscho, https://github.com/git-for-windows/git/issues/=
345)

Issue:
Cloning from Git GUI when the upstream repo has the default branch set
to something other than master (say "develop") yields a local
repository with a single branch named "master". This local master
branch has no pull link, but it has a push link pointing to the
origin/master, leading to a situation where a commit meant for
origin/develop is instead pushed to origin/master. Note that this only
happens when cloning from the Git GUI - using Git Bash creates a local
develop branch pulling & pushing to origin/develop.

To reproduce (example uses fake repo):
1) Open Git GUI
2) Click "Clone Existing Repository"
Source Location: git@github.com:PrivateCo/mytestrepo.git
Target Directory: c:\temp\mytestrepo
Clone
3) Open Git Bash
4) $ cd /c/temp/mytestrepo
5) $ git remote show origin
remote origin Fetch URL: git@github.com:PrivateCo/mytestrepo.git
Push URL: git@github.com:PrivateCo/mytestrepo.git
HEAD branch: develop
Remote branches:
develop tracked
master tracked
Local ref configured for 'git push':
master pushes to master (fast-forwardable)
6) $ git branch -avv
master 846504a 2nd test file, just for develop branch
remotes/origin/develop 846504a 2nd test file, just for develop branch
remotes/origin/master c2b577c initial commit with test file

Workaround (creates new develop branch, wipes out bad master, and
recreates master):
1) Open Git Bash
2) $ cd /c/temp/mytestrepo
3) $ git checkout -b develop --track origin/develop
4) $ git branch -d master
5) $ git checkout -b master --track origin/master
6) $ git remote show origin
remote origin Fetch URL: git@github.com:PrivateCo/mytestrepo.git
Push URL: git@github.com:PrivateCo/mytestrepo.git
HEAD branch: develop
Remote branches:
develop tracked
master tracked
Local branches configured for 'git pull':
develop merges with remote develop
master merges with remote master
Local refs configured for 'git push': develop pushes to develop (up to =
date)
master pushes to master (up to date)
7) $ git branch -avv
develop 846504a [origin/develop] 2nd test file, just for develop branch
master c2b577c [origin/master] initial commit with test file
remotes/origin/develop 846504a 2nd test file, just for develop branch
remotes/origin/master c2b577c initial commit with test file


Let me know if you need any more information.

John Medema
Systems Administrator
United Drugs, a Subsidiary of AAP (American Associated Pharmacies)
john.medema@uniteddrugs.com
7243 N 16th Street, Phoenix, AZ 85020
Office:  602-678-1179 x126
=46ax:  602-639-4631

--=20
HIPAA NOTICE:  It is against United Drugs=E2=80=99 policy to receive or=
 send=20
un-encrypted or non-secured email correspondence containing Protected=20
Health Information (PHI) as defined by HIPAA law.
=20
Please use fax or phone for correspondence containing PHI.

--=20
This email message is for the sole use of the intended recipient(s) and=
 may=20
contain confidential and privileged information. Any unauthorized revie=
w,=20
use, disclosure or distribution is prohibited. If you are not the inten=
ded=20
recipient, contact the sender by reply email, and destroy all copies of=
 the=20
original message.=20
