From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/6] completion: clarify ls-tree, archive, show completion
Date: Sun,  2 Jun 2013 19:33:42 +0530
Message-ID: <1370181822-23450-7-git-send-email-artagnon@gmail.com>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 02 16:06:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uj8vO-0000xD-Vb
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 16:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301Ab3FBOGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 10:06:20 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:34886 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007Ab3FBOGL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 10:06:11 -0400
Received: by mail-pb0-f48.google.com with SMTP id md4so4472265pbc.21
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 07:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FabMcU+APp56A6w5H8f5DPssot/lOc0aAyIGjYq5OeY=;
        b=ocKwlreu/Ki5ebdVpZVWiNNiWVUkJJSBoaHsAX7CcladfudjlcfFk0rpcfgIXTkU96
         Z6NYjwaL57/K/NMc/30M13wPjS6mcLwCb8QCOpcT7QcggP5PzQzD7NywFL8iNKLRJ8x3
         D1/FJbQyyJk9zm+0O1KJ7+Q3BcViEDVMUZakOg6RXcgFFfHYDdQgScy9naLi0YW0dUTH
         c9EBtvXJEhgvetb1WHI8Treax7PLSJygmZqMlettvgQo25NxnWUiGxCFzwrRJK6NYuVm
         yzD0oJQ4Oo9vl82nG+zfB1BYtmKU4VKAY97OQEH+TPB5yC6029unW1aQEk00UJHpMDNk
         SdLw==
X-Received: by 10.66.230.199 with SMTP id ta7mr21367792pac.153.1370181971236;
        Sun, 02 Jun 2013 07:06:11 -0700 (PDT)
Received: from localhost.localdomain ([122.164.162.188])
        by mx.google.com with ESMTPSA id aj2sm55150689pbc.1.2013.06.02.07.06.09
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Jun 2013 07:06:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.457.g2410d5e
In-Reply-To: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226156>

Currently, the 'git ls-tree', 'git archive', and 'git show' completions
use __git_complete_file (aliased to __git_complete_revlist_file).

In the case of 'git ls-tree' and 'git archive', they necessarily require
a tree-ish argument (and optionally a pathspec filter, or "file
argument"):

  $ git ls-tree hot-branch git.c
  $ git archive HEAD~4 git.c

So, __git_complete_file is a misleading name.

In the case of 'git show', it can take a pathspec and default the
revision to HEAD like:

  $ git show git.c

(which is useful if git.c was modified in HEAD)

However, this usage is not idiomatic at all.  The more common usage is
like:

  $ git show HEAD~1
  $ git show origin/pu:git.c

So, __git_complete_file is again a poor name.

Replace these three instances of __git_complete_file with
__git_complete_revlist_file, without making any functional changes.

Remove __git_complete_file, as it has no other callers.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8d70c30..84d1548 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -592,11 +592,6 @@ __git_complete_diff_index_file ()
 	esac
 }
 
-__git_complete_file ()
-{
-	__git_complete_revlist_file
-}
-
 __git_complete_revlist ()
 {
 	__git_complete_revlist_file
@@ -1007,7 +1002,7 @@ _git_archive ()
 		return
 		;;
 	esac
-	__git_complete_file
+	__git_complete_revlist_file
 }
 
 _git_bisect ()
@@ -1476,7 +1471,7 @@ _git_ls_remote ()
 
 _git_ls_tree ()
 {
-	__git_complete_file
+	__git_complete_revlist_file
 }
 
 # Options that go well for log, shortlog and gitk
@@ -2382,7 +2377,7 @@ _git_show ()
 		return
 		;;
 	esac
-	__git_complete_file
+	__git_complete_revlist_file
 }
 
 _git_show_branch ()
-- 
1.8.3.457.g2410d5e
