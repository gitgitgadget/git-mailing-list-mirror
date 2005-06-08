From: Eugene Surovegin <ebs@ebshome.net>
Subject: [PATCH] fix cg-commit new file handling
Date: Tue, 7 Jun 2005 22:59:42 -0700
Message-ID: <20050608055942.GA7151@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 08 07:56:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DftXa-00076p-J2
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 07:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVFHF7p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 01:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVFHF7p
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 01:59:45 -0400
Received: from gate.ebshome.net ([64.81.67.12]:63364 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S262115AbVFHF7n (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 01:59:43 -0400
Received: (qmail 8453 invoked by uid 1000); 7 Jun 2005 22:59:42 -0700
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.5.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi!

There is a problem with committing new files with the current cogito 
version.

I got an error like this: 
  fatal: Unable to add arch/ppc/kernel/dcr.S to database

I think this is caused by the incorrect file list parsing in 
cg-commit precommit_update(): it expects new files prefixed with "A", 
while they are prefixed with "N".

The following trivial patch fixes this.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -227,7 +227,7 @@ precommit_update () {
 	for file in "$@"; do
 		op=${file%% *}
 		fname=${file#* }
-		[ "$op" = "A" ] || [ "$op" = "D" ] || [ "$op" = "M" ] || op=M
+		[ "$op" = "N" ] || [ "$op" = "D" ] || [ "$op" = "M" ] || op=M
 		eval "queue$op[\${#queue$op[@]}]=\"\$fname\""
 	done
 	# XXX: Do we even need to do the --add and --remove update-caches?


