From: "Pascal Obry" <pascal@obry.net>
Subject: rebase, file permissions and removed file
Date: Mon, 27 Oct 2008 15:02:42 +0100
Message-ID: <a2633edd0810270702x416bb659ke183b0cc6266071@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 27 15:04:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuShL-0002cE-Lj
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 15:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbYJ0OCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 10:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbYJ0OCo
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 10:02:44 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:45461 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbYJ0OCo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 10:02:44 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2065153wfd.4
        for <git@vger.kernel.org>; Mon, 27 Oct 2008 07:02:43 -0700 (PDT)
Received: by 10.141.210.13 with SMTP id m13mr3283213rvq.25.1225116162501;
        Mon, 27 Oct 2008 07:02:42 -0700 (PDT)
Received: by 10.141.51.13 with HTTP; Mon, 27 Oct 2008 07:02:42 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99232>

In short,

   - a branch is created
   - a file is removed from master
   - the same file has its permissions changed on the branch
   - we rebase the branch on master
   - how to resolve the conflict?

Following is a script to reproduce the problem, see comment at the end.

Any idea? Thanks.

<<
-- #!/bin/sh

rm -fr repo

mkdir repo
cd repo
git init

touch file1 file2
chmod a+x file*
git add .
git ci -m "First rev"

git checkout -b fixperms
chmod a-x file1
git add file1
git ci -m "Fix perm file1"

git checkout master
git rm file1
git ci -m "Remove file1"

git checkout fixperms

git rebase master

# At this point there is a conflict as expected
# file1 has been removed on master, and file1 had its permissions changed
# on fixperms branch.
#
# What I find confusing is that:
#    $ git diff
# and
#    $ git diff --cached
#
# are reporting nothing.
#
# Ok, file1 has been removed, let's then remove it as it is right:
#
#   $ git rm file1
#   fatal: pathspec 'file1' did not match any files
#
# Ok, so what's the proper way to fix that! What should I do to be able to
# continue the rebase:
#
#   $ git rebase --continue
>>

--

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
