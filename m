From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH v2 0/7] Allow git log to use mailmap file
Date: Sat, 15 Dec 2012 19:05:47 +0100
Message-ID: <1355594754-27589-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 19:06:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjw84-00011g-1q
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 19:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841Ab2LOSGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 13:06:05 -0500
Received: from mail-wg0-f46.google.com ([74.125.82.46]:37975 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab2LOSGE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 13:06:04 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so1888836wgb.1
        for <git@vger.kernel.org>; Sat, 15 Dec 2012 10:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=B+iFcLLHknQfejisyBSbxQep/8Eo7J7wKGrduzAw4zU=;
        b=fg6YSu6BoicxYS3HGu9PTFqjvHKWRdMOqY4A1Lwat3DensKMtozuJKGIaYE4TokMnS
         uujDYU9e9KRjny/VLBqghuKQvvGJEWgob4VYTND7SI9R+5PAluR+h27ayqFsmgsCgcWJ
         sKvKRq6Bnhi2M24ZOg9sw5ZpHVbJADULXj1YD952oj+z9hTQDOymVCBE//FrAQmfCA2E
         oFLuvOtuik2ndI/ZvGA/8jZsdkZCNkHnQZSdv2YRc8pdaPk+ORMTus6g0C/FaTsKF+Fd
         55bpOIPvtQbm4SB+Lub4KzjMlcHJz7v646Pa7eOroGkJpJnzfk/YXLktLXSzBfKnduyr
         EIow==
Received: by 10.194.179.34 with SMTP id dd2mr9501286wjc.1.1355594762353;
        Sat, 15 Dec 2012 10:06:02 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id bd7sm3570983wib.8.2012.12.15.10.06.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Dec 2012 10:06:01 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211545>

Implement the feature suggested by Rich Mindwinter and Junio C Hamano
(and following his advices)



Allows git show/log commands to map author and committer
names and emails using the mailmap file.

Updates related to this second series:
  - All tests are successful after each patch
  - Use split_ident_line in shortlog.c
  - Documentation has been added to git-log.txt
  - Test has been added to check that we use the file
  - Lots of improvements in the way strbufs are used
  - New interface to map_user()
  - Bunch of other fixes

git glog --committer/--author is still not looking for mailmap user
names.

Antoine Pelisse (7):
  Use split_ident_line to parse author and committer
  mailmap: Remove buffer length limit in map_user
  mailmap: Simplify map_user() interface
  mailmap: Add mailmap structure to rev_info and pp
  pretty: Use mailmap to display username and email
  log: Add --use-mailmap option
  test: Add test for --use-mailmap option

 Documentation/git-log.txt |    5 ++
 builtin/blame.c           |  189 +++++++++++++++++++++------------------------
 builtin/log.c             |    9 ++-
 builtin/shortlog.c        |   53 ++++---------
 commit.h                  |    1 +
 log-tree.c                |    1 +
 mailmap.c                 |   56 ++++++--------
 mailmap.h                 |    4 +-
 pretty.c                  |  111 ++++++++++++++------------
 revision.h                |    1 +
 t/t4203-mailmap.sh        |   14 ++++
 11 files changed, 219 insertions(+), 225 deletions(-)

--
1.7.9.5
