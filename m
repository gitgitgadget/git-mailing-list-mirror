From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] cg-fetch: support for active symbols in rsync path
Date: Fri, 11 Nov 2005 00:49:29 -0500
Message-ID: <1131688169.31172.34.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 11 06:52:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaRnI-0006SZ-Q4
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 06:49:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVKKFtb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 00:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVKKFtb
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 00:49:31 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:12997 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750711AbVKKFtb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 00:49:31 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EaRn0-0007Uo-3i
	for git@vger.kernel.org; Fri, 11 Nov 2005 00:49:30 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EaRmz-0001vg-Am; Fri, 11 Nov 2005 00:49:29 -0500
To: git <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11561>

t9112-fetch-rsync.sh breaks if cogito is located in a directory
containing e.g. spaces.  The test uses its own rsync replacement
(localrsync) and supplies it to cg-fetch with full patch.  cg-fetch
doesn't quote rsync sufficiently to prevent interpreting the path to
localrsync by the shell.

This bug is unlikely to be a problem in real life, but it's important to
have cogito tests run properly in directories with unusual names, since
it allows to catch a number of more serious problems.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/cg-fetch b/cg-fetch
index 8fa34ce..6dfd02f 100755
--- a/cg-fetch
+++ b/cg-fetch
@@ -102,7 +102,7 @@ get_rsync()
 		shift
 	fi
 
-	eval ${RSYNC:-rsync} $RSYNC_FLAGS $rsync_flags_l -v -Lr \
+	eval '"${RSYNC:-rsync}"' $RSYNC_FLAGS $rsync_flags_l -v -Lr \
 		"$1$appenduri" "$2$appenduri" $redir | $filter
 	return ${PIPESTATUS[0]}
 }


-- 
Regards,
Pavel Roskin
