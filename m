From: John Ellson <ellson@research.att.com>
Subject: [PATCH] Make GIT-VERSION-GEN tolerate missing git describe command
Date: Fri, 30 Dec 2005 11:23:17 -0500
Message-ID: <dp3mtp$rfm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Dec 30 17:23:51 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EsN2h-0004ON-NY
	for gcvg-git@gmane.org; Fri, 30 Dec 2005 17:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbVL3QXp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Dec 2005 11:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbVL3QXp
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Dec 2005 11:23:45 -0500
Received: from main.gmane.org ([80.91.229.2]:36546 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964811AbVL3QXo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Dec 2005 11:23:44 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EsN2T-0004L6-Bd
	for git@vger.kernel.org; Fri, 30 Dec 2005 17:23:33 +0100
Received: from h-135-207-24-103.research.att.com ([135.207.24.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Dec 2005 17:23:33 +0100
Received: from ellson by h-135-207-24-103.research.att.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Dec 2005 17:23:33 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: h-135-207-24-103.research.att.com
User-Agent: Mail/News 1.5 (X11/20051129)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14112>

I think it is probably a bug that "git non_existent_command"
returns its error message to stdout without an error, where
"git-non_existent_command" behaves differently and does return an
error.

Older versions of git did not implement "git describe"  and
GIT-VERSION-GEN produces an empty version string if run on
a system with such a git installed.  The consequence
is that "make rpm" fails.

This patch fixes GIT-VERSION-GEN so that it works in the
absence of a working "git describe"

----------------------------------------

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 196402c..845b9dc 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -2,7 +2,7 @@

  GVF=GIT-VERSION-FILE

-VN=$(git describe --abbrev=4 HEAD 2>/dev/null) || VN=v1.0.GIT
+VN=$(git-describe --abbrev=4 HEAD 2>/dev/null) || VN=v1.0.GIT
  VN=$(expr "$VN" : v'\(.*\)')
  if test -r $GVF
  then

----------------------------------------


Signed-off-by: John Ellson <ellson@research.att.com>
