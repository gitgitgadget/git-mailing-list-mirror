From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH RESEND] git-gui: Fix merge conflict display error when filename
 contains spaces
Date: Fri, 20 Mar 2009 08:52:58 +0100
Message-ID: <49C34B5A.2040807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 08:54:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkZYp-0002wE-GN
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 08:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbZCTHxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 03:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752292AbZCTHxD
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 03:53:03 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:45533 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbZCTHxC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 03:53:02 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 48227FBD89F6
	for <git@vger.kernel.org>; Fri, 20 Mar 2009 08:52:59 +0100 (CET)
Received: from [80.128.127.25] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #277)
	id 1LkZXG-0003Lm-00
	for git@vger.kernel.org; Fri, 20 Mar 2009 08:52:58 +0100
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+5QZDBd/lyDuADRvYmf5s/P6f75B07Kj9+O0Rm
	kdMMJ7mVchK06zMYND0KGFuF8CUl/xQSixEOuMf3LL4Yz7eWXT
	nPB1uN7XEFywpiGi7dRQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113911>

When a merge conflict occurs in a file with spaces in the filename, git-gui showed wrongly "LOCAL: deleted".

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Resending this patch, as i have not received any reply so far.

To reproduce the error with git 1.6.2.1.136.g8e24, i used the following commands:
  mkdir spaces
  cd spaces/
  git init
  echo "a" >file\ with\ spaces
  git add file\ with\ spaces 
  git commit -m a .
  git checkout -b b
  echo "b" >file\ with\ spaces
  git commit -m b .
  git checkout master
  echo "c" >file\ with\ spaces
  git commit -m c .
  git merge b
  git gui
git gui doesn't show the conflict markers as it should, displaying "LOCAL: deleted" instead (but an older git-gui works as expected).

Jens

 git-gui/lib/mergetool.tcl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui/lib/mergetool.tcl b/git-gui/lib/mergetool.tcl
index eb2b4b5..3e1b42b 100644
--- a/git-gui/lib/mergetool.tcl
+++ b/git-gui/lib/mergetool.tcl
@@ -88,7 +88,7 @@ proc merge_load_stages {path cont} {
 	set merge_stages(3) {}
 	set merge_stages_buf {}
 
-	set merge_stages_fd [eval git_read ls-files -u -z -- $path]
+	set merge_stages_fd [eval git_read ls-files -u -z -- {$path}]
 
 	fconfigure $merge_stages_fd -blocking 0 -translation binary -encoding binary
 	fileevent $merge_stages_fd readable [list read_merge_stages $merge_stages_fd $cont]
-- 
1.6.2.1.215.g5d16f
