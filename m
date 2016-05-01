From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] git-fixup: automatically create a fixup commit
Date: Sun, 1 May 2016 12:53:34 +0300
Message-ID: <1462096410-8813-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 11:53:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awo4M-00025h-JN
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 11:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbcEAJxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 05:53:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37018 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbcEAJxh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 05:53:37 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 188FE83F46
	for <git@vger.kernel.org>; Sun,  1 May 2016 09:53:36 +0000 (UTC)
Received: from redhat.com (ovpn-116-21.ams2.redhat.com [10.36.116.21])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u419rYU6032555
	for <git@vger.kernel.org>; Sun, 1 May 2016 05:53:35 -0400
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293146>

Sometimes I get a broken patch, apply it and then need to fix it up. git
commit --fixup is perfect for this, but makes me look up the commit that
created the breakage manually. git-fixup is a tool to speed this up.
Several heuristics would be reasonable for locating the problematic
commit:
1. look up the last commit that touched the
   file(s) affected by the fixup
2. look up the last commit that touched the
   line(s) affected by the fixup

this implements the first heuristic.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/git-fixup | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100755 contrib/git-fixup

diff --git a/contrib/git-fixup b/contrib/git-fixup
new file mode 100755
index 0000000..79f4e34
--- /dev/null
+++ b/contrib/git-fixup
@@ -0,0 +1,8 @@
+if
+	git diff --cached --quiet 
+then
+	echo "Nothing to commit!"
+	exit 1
+else
+	git commit --fixup=$(git log --pretty=format:%H -1 $(git diff --cached --name-only)) "$@"
+fi
-- 
MST
