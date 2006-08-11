From: Brendan Cully <brendan@kublai.com>
Subject: git patch format with copy/rename + modify, and binary files
Date: Fri, 11 Aug 2006 13:50:23 -0700
Message-ID: <20060811205022.GA13521@xanadu.kublai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 11 22:51:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBdy3-0005SG-5r
	for gcvg-git@gmane.org; Fri, 11 Aug 2006 22:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWHKUut (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 16:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWHKUus
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 16:50:48 -0400
Received: from zakopane.cs.ubc.ca ([198.162.51.68]:50628 "EHLO
	mail.quuxuum.com") by vger.kernel.org with ESMTP id S932414AbWHKUus
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Aug 2006 16:50:48 -0400
Received: from xanadu.kublai.com (S01060016b6db031a.vc.shawcable.net [24.82.90.210])
	by mail.quuxuum.com (Postfix) with ESMTP id 256505C227
	for <git@vger.kernel.org>; Fri, 11 Aug 2006 13:50:26 -0700 (PDT)
Received: by xanadu.kublai.com (Postfix, from userid 3121)
	id 0316389839D; Fri, 11 Aug 2006 13:50:23 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
X-Operating-System: Darwin 8.7.0 Power Macintosh
User-Agent: Mutt/1.5.12 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25239>

Hi,

While working on an external git patch importer, I noticed that git
patches can break silently when fed to vanilla patch. Take this hunk
from the git tree:

diff --git a/git-pull-script b/git-fetch-script   
similarity index 89%
copy from git-pull-script
copy to git-fetch-script
index bd892c7..17f22af 100755
--- a/git-pull-script
+++ b/git-fetch-script
@@ -39,8 +39,3 @@ download_one "$merge_repo/$merge_name" "

 echo "Getting object database"
 download_objects "$merge_repo" "$(cat "$GIT_DIR"/MERGE_HEAD)"
-
-git-resolve-script \
-       "$(cat "$GIT_DIR"/HEAD)" \
-       "$(cat "$GIT_DIR"/MERGE_HEAD)" \
-       "$merge_repo"

git-apply would presumably create git-fetch-script by copying
git-pull-script then deleting this hunk. Vanilla patch simply deletes
the hunk from git-pull-script. This seems bad. Is there any reason why
git diff shouldn't use

--- a/git-fetch-script
+++ b/git-fetch-script

instead?

On a related note, it'd be nice if the format allowed for some kind of
representation of binary data. I had a half-baked idea that it could
hold a line describing the encoding of the diff, eg

encoding base64

which could indicate that the diff should be decoded as base64 before
being applied. This could allow a patch to hold a binary file add, or
wrap a binary diff, though it doesn't specify what form such a diff
should take...

thoughts?
