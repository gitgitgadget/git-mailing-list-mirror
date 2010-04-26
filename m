From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-submodule.sh: properly initialize shell variables
Date: Mon, 26 Apr 2010 11:50:39 +0200
Message-ID: <20100426095039.20264.qmail@7cdeaa1bd53836.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 26 11:50:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Kxl-0001t5-E7
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 11:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695Ab0DZJum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 05:50:42 -0400
Received: from a.ns.smarden.org ([109.68.224.7]:59078 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751439Ab0DZJul (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 05:50:41 -0400
Received: (qmail 20265 invoked by uid 1000); 26 Apr 2010 09:50:39 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145800>

git-submodule inherits variables from the environment it is started in,
expects the internal variables init= and recursive= to have an empty
value, but doesn't initialize them appropriately.  Thanks to the
selftests, this can be reproduced through

 init=1 make test
 recursive=1 make test

With this commit the variables are initialized, and the selftests
succeed even if these variables have some values in the environment.

The bug was discovered through the Debian autobuilders
 http://bugs.debian.org/569594

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 git-submodule.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2dd372a..3319b83 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -21,6 +21,8 @@ command=
 branch=
 reference=
 cached=
+recursive=
+init=
 files=
 nofetch=
 update=
-- 
1.7.0.3
