From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 1/2] filter-branch: remove an unnecessary use of 'git read-tree'
Date: Tue, 15 Dec 2009 09:42:06 +0100
Message-ID: <4B274BDE.8000504@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 09:42:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKSz4-0002SE-RG
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 09:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbZLOImN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 03:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbZLOImN
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 03:42:13 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:45855 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751385AbZLOImM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 03:42:12 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NKSyt-0006TK-5E; Tue, 15 Dec 2009 09:42:07 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id DBEC21660F;
	Tue, 15 Dec 2009 09:42:06 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135280>

From: Johannes Sixt <j6t@kdbg.org>

The intent of this particular call to 'git read-tree' was to fill an
index. But in fact, it only allocated an empty index. Later in the
program, the index is filled anyway by calling read-tree with specific
commits, and considering that elsewhere the index is even removed (i.e.,
it is not relied upon that the index file exists), this first call of
read-tree is completely redundant.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Calling read-tree without arguments is not allowed according to the
 documentation. The next patch will enforce this.

 -- Hannes

 git-filter-branch.sh |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index cb9d202..195b5ef 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -259,7 +259,6 @@ test -s "$tempdir"/heads ||

 GIT_INDEX_FILE="$(pwd)/../index"
 export GIT_INDEX_FILE
-git read-tree || die "Could not seed the index"

 # map old->new commit ids for rewriting parents
 mkdir ../map || die "Could not create map/ directory"
-- 
1.6.6.rc1.46.g1635
