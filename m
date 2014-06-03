From: Jeff King <peff@peff.net>
Subject: [PATCH] error_resolve_conflict: drop quotations around operation
Date: Tue, 3 Jun 2014 03:23:49 -0400
Message-ID: <20140603072349.GA32206@sigill.intra.peff.net>
References: <20140603071717.GA32038@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 09:23:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrj4d-0003A8-C4
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 09:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbaFCHXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 03:23:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:36435 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752525AbaFCHXv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 03:23:51 -0400
Received: (qmail 8123 invoked by uid 102); 3 Jun 2014 07:23:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jun 2014 02:23:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jun 2014 03:23:49 -0400
Content-Disposition: inline
In-Reply-To: <20140603071717.GA32038@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250617>

When you try to commit with unmerged entries, you get an
error like:

  $ git commit
  error: 'commit' is not possible because you have unmerged files.

The quotes around "commit" are clunky; the user doesn't care
that this message is a template with the command-name filled
in.  Saying:

  error: commit is not possible because you have unmerged files

is easier to read. As this code is called from other places,
we may also end up with:

  $ git merge
  error: merge is not possible because you have unmerged files

  $ git cherry-pick foo
  error: cherry-pick is not possible because you have unmerged files

  $ git revert foo
  error: revert is not possible because you have unmerged files

All of which look better without the quotes. This also
happens to match the behavior of "git pull", which generates
a similar message (but does not share code, as it is a shell
script).

Signed-off-by: Jeff King <peff@peff.net>
---
I realize this may just be a matter of taste, but I thought I'd put it
forth as a possibility.

I also considered switching the wording to:

  error: cannot commit because you have unmerged files

which I find a little more natural.

 advice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/advice.c b/advice.c
index ef24733..c50ebdf 100644
--- a/advice.c
+++ b/advice.c
@@ -76,7 +76,7 @@ int git_default_advice_config(const char *var, const char *value)
 
 int error_resolve_conflict(const char *me)
 {
-	error("'%s' is not possible because you have unmerged files.", me);
+	error("%s is not possible because you have unmerged files.", me);
 	if (advice_resolve_conflict)
 		/*
 		 * Message used both when 'git commit' fails and when
-- 
2.0.0.rc1.436.g03cb729
