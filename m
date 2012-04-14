From: Thomas Adam <thomas.adam22@gmail.com>
Subject: Merging changes from branches where file paths have changed
Date: Sat, 14 Apr 2012 14:15:38 +0100
Message-ID: <CA+39Oz7m1hGrTEdpSAjBP3EDFSVyKdc6T9CORcwQkjuEbvD4Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 14 15:16:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ2pc-0006PP-KA
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 15:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab2DNNPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 09:15:55 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43877 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653Ab2DNNPy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 09:15:54 -0400
Received: by obbta14 with SMTP id ta14so1701924obb.19
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 06:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=uhnEKsPqC+N8F2yJo2EJra1h7tCx/MBYc+RSOhQ+/Ps=;
        b=rLTX1eA1TuI91jS1nCDWIuZOlVHHYB49AC8IXcZn7maSoY4/GGzcMk9PPSpN2MBlgh
         dGoczaHwUiDJnZHPR0JvbF0ezYiS5KABIa705+7/pOg1W3YaYMUX1jZl+PKu8qFhjBwz
         rLPS62gpuk4hMqPJdEkm+0gFNR2nqd0EKxmkrOq/7OFP6Btf4izlOcgAVIChKLzUIojW
         ESq3B6Sg0oXiadvh3vFq3X3l6DD9eFN8ey/EDae71QA56wfSBtClwNOlT/1QDNdEXEzI
         UstdgEtUMF/K4IA8NpaVYFakHLBMoUZWPdQh3wRPQOFlZD8hatRwl8hYQc0lq+Qen5RQ
         0BeA==
Received: by 10.60.24.164 with SMTP id v4mr6986444oef.51.1334409354300; Sat,
 14 Apr 2012 06:15:54 -0700 (PDT)
Received: by 10.182.33.41 with HTTP; Sat, 14 Apr 2012 06:15:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195490>

Hi all,

I've got two git repositories -- for the purposes of illustration,
I'll call them RepoA, and RepoB.  RepoA is a large repository
originally from a CVS conversion.  Repo B is a repository which has
been formed from git-filter-branch (should it matter) from RepoA.

In doing the conversion -- RepoB contains the same history as in
RepoA, except that RepoB is now a limited subset in terms of its files
that RepoA has (repoB contains commits out of repoA for a specific
subdirectory).   However, the problem I'm wanting to solve now, which
is causing me to scratch my head and go "hmm", is how I go about
merging commits from RepoA and have them in RepoB -- where the commits
from repoA are in the same *directory* as the one which formed RepoB.

In RepoA, for the directory (and all its sub-directories) which is
contained in RepoB, I've got a list of commits -- roughly like the
following:

% cd ./distrib/build/sources/coretree/tree
% git log --oneline master..my/topic/branch -- .

Now in RepoB, I've got all of the directories and files from
./distrib/build/sources/coretree/tree/ in the root, having obtained
this from git-filter-branch from RepoA.  Despite the change of file
locations, the history of the files between the two repositories are
the same.

The commits though coming from "git log" in RepoA touch files in
distrib/build/sources/coretree/tree, yet the files to which I want the
changes for in RepoB are not in "distrib/build/sources/coretree/tree"
-- there all in "./" at the top-level directory for RepoB.  The files
in both once shared the same history -- it's just that now the
locations of those files in RepoB which have changed.

I want to cherry-pick the commits I obtained from the "git log"
command in RepoA, and have them contained in RepoB.  So I thought
something like this would work:

[ In RepoB.... ]:
% git remote add repoA file:///path/to/repoA/
% git fetch repoA
% git checkout specific/branch
% git cherry-pick $SOME_COMMIT_FROM_REPOA

However, this won't work, and doesn't.  Not only do the two
repositories not have any common ancestry, but even if they did, the
file paths from RepoA and RepoB do not match for the commit(s) I would
want to cherry-pick.  As far as I can tell, were I able to convince
Git the file paths did work, then I could cherry-pick them.

Can anyone suggest a good way round this?  I hope I've managed to
explain this adequately; just ask if not.

Thanks in Advance.

-- Thomas Adam
