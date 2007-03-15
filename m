From: mcdmx <mcdmx@users.sf.net>
Subject: [PATCH] cogito: Escape $* in cg admin-setuprepro to fix problems
 with older bash versions
Date: Thu, 15 Mar 2007 14:53:35 +0100
Message-ID: <etbj4u$sh6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 15 15:01:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRqW9-0004MO-8C
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 15:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422708AbXCOOBS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 10:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422709AbXCOOBS
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 10:01:18 -0400
Received: from main.gmane.org ([80.91.229.2]:48743 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422708AbXCOOBR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 10:01:17 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HRqUt-0004rF-1T
	for git@vger.kernel.org; Thu, 15 Mar 2007 15:00:03 +0100
Received: from obelix.objectxp.com ([62.2.156.213])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Mar 2007 15:00:03 +0100
Received: from mcdmx by obelix.objectxp.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Mar 2007 15:00:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: obelix.objectxp.com
User-Agent: Icedove 1.5.0.9 (X11/20061220)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42281>

Using $* in the _Here_ document at the end of cg-admin-setuprepro seriously confuses Bash
v2.0.5b and causes lines produced by the _Here_ document to look something like

##  EEnnaabbllee ggiitt--uuppddaattee--sseerrvveerr--iinnffoo

The problem does not occur with Bash 3.1.x. The patch below fixes this by escaping the
dollar in "$*".

diff --git a/cg-admin-setuprepo b/cg-admin-setuprepo
index d407798..a37b6ae 100755
--- a/cg-admin-setuprepo
+++ b/cg-admin-setuprepo
@@ -91,7 +91,7 @@ fi
 _git="$uri"
 cat <<_SCRIPT_EOF_ | $shell $shellarg

-die() { echo "$*" >&2; exit 1; }
+die() { echo "\$*" >&2; exit 1; }

 export GIT_DIR="$uri"
