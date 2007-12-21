From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-pull: don't complain about branch merge config if only
	fetching tags
Date: Fri, 21 Dec 2007 12:44:00 +0000
Message-ID: <20071221124400.20725.qmail@db93e79e204cd8.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 13:44:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5hEd-0003Ok-Qb
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 13:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761046AbXLUMno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 07:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760972AbXLUMno
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 07:43:44 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:60199 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760796AbXLUMnn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 07:43:43 -0500
Received: (qmail 20726 invoked by uid 1000); 21 Dec 2007 12:44:00 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69063>

When running git pull with the -t switch, it properly fetches tags, but
complains about missing information on how to merge.  Since there's
nothing to merge, make git-pull simply exit after fetching the tags.

The problem has been reported by Joey Hess through
 http://bugs.debian.org/456035

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 git-pull.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 698e82b..43be0bd 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -112,6 +112,11 @@ case "$merge_head" in
 	     exit 1;;
 	  *) exit $?;;
 	esac
+	# exit if only tags have been fetched
+	not_for_merge=$(sed -e '/	not-for-merge	tag/d' \
+			"$GIT_DIR"/FETCH_HEAD)
+	test "$not_for_merge" != '' || exit 0
+
 	curr_branch=${curr_branch#refs/heads/}
 
 	echo >&2 "You asked me to pull without telling me which branch you"
-- 
1.5.3.7
