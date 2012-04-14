From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] sequencer.c: Fix a sparse warning
Date: Sat, 14 Apr 2012 18:26:35 +0100
Message-ID: <4F89B34B.70907@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: nhorman@tuxdriver.com
X-From: git-owner@vger.kernel.org Sat Apr 14 19:28:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ6mD-0000fy-9N
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 19:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478Ab2DNR2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 13:28:40 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:50394 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753321Ab2DNR2j (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Apr 2012 13:28:39 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1SJ6m5-0006j5-c9; Sat, 14 Apr 2012 17:28:38 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195496>


In particular, sparse complains as follows:

        SP sequencer.c
    sequencer.c:262:5: warning: symbol 'run_git_commit' was not \
        declared. Should it be static?

In order to suppress the warning, since the run_git_commit() function
does not need to be a global symbol, we simply add the static modifier
to the function definition.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Neil,

In commit 85b2713d ("git-cherry-pick: add --keep-redundant-commits option",
11-04-2012), you removed the static modifier from run_git_commit() without
adding an extern declaration to the sequencer.h header file. This causes
sparse to bark, as above. However, since that function is not called outside
of sequencer.c, it seems best to simply add it back ... :-)

[Note that, despite remove_sequencer_state() being declared extern in the
header file, it is also not used outside sequencer.c, so ... ]

So, if you need to re-submit this patch, could you please squash this patch
into your commit. Thanks!

ATB,
Ramsay Jones

 sequencer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index d4262cf..6f28430 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -259,7 +259,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
  * If we are revert, or if our cherry-pick results in a hand merge,
  * we had better say that the current user is responsible for that.
  */
-int run_git_commit(const char *defmsg, struct replay_opts *opts, int empty)
+static int run_git_commit(const char *defmsg, struct replay_opts *opts, int empty)
 {
 	struct argv_array array;
 	int rc;
-- 
1.7.10
