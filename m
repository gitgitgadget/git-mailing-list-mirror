From: Chris Parsons <chris@edendevelopment.co.uk>
Subject: [PATCH] Updated status to show 'Not currently on any branch' in red
Date: Thu, 15 May 2008 20:37:52 +0100
Message-ID: <612A0CE5-9482-4D27-B2E4-D55F7511A1C2@edendevelopment.co.uk>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 21:45:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwjOK-00011N-99
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 21:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbYEOToi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 15:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbYEOToi
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 15:44:38 -0400
Received: from dedi38.dedi.blackcatnetworks.co.uk ([217.147.94.39]:50319 "HELO
	host1.edendevelopment.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1752080AbYEOToh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 May 2008 15:44:37 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 May 2008 15:44:36 EDT
Received: (qmail 14280 invoked by uid 0); 15 May 2008 19:37:54 -0000
Received: from unknown (HELO ?192.168.0.3?) (chris@edendevelopment.co.uk@91.85.176.111)
  by pa.rsons.org with ESMTPA; 15 May 2008 19:37:54 -0000
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82223>

Hi all, first post and patch, please be gentle :)

I'm a fairly new user to git and have more than once been burnt by  
checking out an arbitrary commit and then checking in code on top of  
that commit. If you realise your mistake quickly, you can reset and  
reapply the commit to a branch, but if you checkout another branch  
your commit can disappear and become hard to find.

Therefore as a help to new users I've turned the 'Not currently on any  
branch' red on 'git status' so that it's harder to miss the fact.

Perhaps git should not allow commits in this case? I'm too much of a  
novice to know whether that's ever needed, but perhaps someone has a  
good reason for allowing it.

Thanks and regards
Chris

Signed-off-by: Chris Parsons <chris@edendevelopment.co.uk>
---
  wt-status.c |    7 +++++--
  wt-status.h |    1 +
  2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index a44c543..42a1ff8 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -18,6 +18,7 @@ static char wt_status_colors[][COLOR_MAXLEN] = {
  	"\033[32m", /* WT_STATUS_UPDATED: green */
  	"\033[31m", /* WT_STATUS_CHANGED: red */
  	"\033[31m", /* WT_STATUS_UNTRACKED: red */
+	"\033[31m", /* WT_STATUS_NOBRANCH: red */
  };

  static const char use_add_msg[] =
@@ -315,7 +316,8 @@ void wt_status_print(struct wt_status *s)
  {
  	unsigned char sha1[20];
  	s->is_initial = get_sha1(s->reference, sha1) ? 1 : 0;
-
+  const char* branch_color = color(WT_STATUS_HEADER);
+
  	if (s->branch) {
  		const char *on_what = "On branch ";
  		const char *branch_name = s->branch;
@@ -323,9 +325,10 @@ void wt_status_print(struct wt_status *s)
  			branch_name += 11;
  		else if (!strcmp(branch_name, "HEAD")) {
  			branch_name = "";
+			branch_color = color(WT_STATUS_NOBRANCH);
  			on_what = "Not currently on any branch.";
  		}
-		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER),
+		color_fprintf_ln(s->fp, branch_color,
  			"# %s%s", on_what, branch_name);
  	}

diff --git a/wt-status.h b/wt-status.h
index 7d61410..f0675fd 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -8,6 +8,7 @@ enum color_wt_status {
  	WT_STATUS_UPDATED,
  	WT_STATUS_CHANGED,
  	WT_STATUS_UNTRACKED,
+	WT_STATUS_NOBRANCH,
  };

  struct wt_status {
-- 
1.5.5.1.249.g3fdb.dirty
