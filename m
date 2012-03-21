From: Alex Merry <dev@randomguy3.me.uk>
Subject: [PATCH v2] Fix git-completion.bash for use in zsh
Date: Wed, 21 Mar 2012 11:06:00 +0000
Message-ID: <1332327960-5208-1-git-send-email-dev@randomguy3.me.uk>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Alex Merry <dev@randomguy3.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 12:25:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAJfE-0002HH-Py
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 12:25:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847Ab2CULZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 07:25:06 -0400
Received: from dorset.eukhosting.net ([92.48.117.51]:48354 "EHLO
	dorset.eukhosting.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767Ab2CULZF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 07:25:05 -0400
X-Greylist: delayed 1095 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Mar 2012 07:25:05 EDT
Received: from cpc1-oxfd8-0-0-cust519.4-3.cable.virginmedia.com ([86.8.142.8]:44447 helo=localhost.localdomain)
	by dorset.eukhosting.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <dev@randomguy3.me.uk>)
	id 1SAJNN-000piC-HH; Wed, 21 Mar 2012 11:06:45 +0000
X-Mailer: git-send-email 1.7.9.4
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - dorset.eukhosting.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - randomguy3.me.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193570>

zsh treats
  local some_var=()
as a function declaration, rather than an array declaration (although
its documentation does not suggest that this should be the case).

With zsh 4.3.15 on Fedora Core 15, this causes
  __git_ps1 " (%s)"
to produce the message
  local:2: command not found: svn_url_pattern
when GIT_PS1_SHOWUPSTREAM="auto", due to the line
  local svn_remote=() svn_url_pattern count n

Simply doing
  local some_var
  some_var=()
fixes the issue.

Signed-off-by: Alex Merry <dev@randomguy3.me.uk>
---

Here it is again, with a better commit message, and no whitespace issues (hopefully).


 contrib/completion/git-completion.bash |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0acbdda..092a34f 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -94,8 +94,9 @@ __gitdir ()
 __git_ps1_show_upstream ()
 {
 	local key value
-	local svn_remote=() svn_url_pattern count n
+	local svn_remote svn_url_pattern count n
 	local upstream=git legacy="" verbose=""
+	svn_remote=()
 
 	# get some config options from git-config
 	local output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
-- 
1.7.6.5
