From: Federico Mena Quintero <federico@novell.com>
Subject: [PATCH 4/4] Make git-pull complain and give advice when there is
	nothing to pull from
Date: Tue, 02 Oct 2007 18:36:30 -0500
Message-ID: <1191368190.3776.206.camel@cacharro.xalalinux.org>
References: <1190077493.22387.54.camel@cacharro.xalalinux.org>
	 <1190077881.22387.63.camel@cacharro.xalalinux.org>
	 <7v3axbvbto.fsf@gitster.siamese.dyndns.org>
	 <1191367817.3776.192.camel@cacharro.xalalinux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 01:34:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcrGM-0004VD-6p
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 01:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552AbXJBXem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 19:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755412AbXJBXel
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 19:34:41 -0400
Received: from jericho.provo.novell.com ([137.65.248.124]:13908 "EHLO
	jericho.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755362AbXJBXek (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 19:34:40 -0400
Received: from [164.99.193.181] ([164.99.193.181])
	by jericho.provo.novell.com with ESMTP; Tue, 02 Oct 2007 17:34:38 -0600
In-Reply-To: <1191367817.3776.192.camel@cacharro.xalalinux.org>
X-Mailer: Evolution 2.11.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59757>


Signed-off-by: Federico Mena Quintero <federico@gnu.org>
---
 git-pull.sh |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index c3f05f5..74bfc16 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -97,10 +97,24 @@ case "$merge_head" in
 	esac
 	curr_branch=${curr_branch#refs/heads/}
 
-	echo >&2 "Warning: No merge candidate found because value of config option
-         \"branch.${curr_branch}.merge\" does not match any remote branch fetched."
-	echo >&2 "No changes."
-	exit 0
+	echo >&2 "You asked me to pull without telling me which branch you"
+	echo >&2 "want to merge with, and 'branch.${curr_branch}.merge' in"
+	echo >&2 "your configuration file does not tell me either.  Please"
+	echo >&2 "name which branch you want to merge on the command line and"
+	echo >&2 "try again (e.g. 'git pull <repository> <refspec>')."
+	echo >&2 "See git-pull(1) for details on the refspec."
+	echo >&2
+	echo >&2 "If you often merge with the same branch, you may want to"
+	echo >&2 "configure the following variables in your configuration"
+	echo >&2 "file:"
+	echo >&2
+	echo >&2 "    branch.${curr_branch}.remote = <nickname>"
+	echo >&2 "    branch.${curr_branch}.merge = <remote-ref>"
+	echo >&2 "    remote.<nickname>.url = <url>"
+	echo >&2 "    remote.<nickname>.fetch = <refspec>"
+	echo >&2
+	echo >&2 "See git-config(1) for details."
+	exit 1
 	;;
 ?*' '?*)
 	if test -z "$orig_head"
-- 
1.5.2.4
