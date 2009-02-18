From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Avoid segfault with 'git branch' when the HEAD is detached
Date: Wed, 18 Feb 2009 19:14:59 +0100 (CET)
Message-ID: <ad680bce413ddea084d84b3fcd7c4cc356c3cb0e.1234980819u.git.johannes.schindelin@gmx.de>
References: <cover.1234980819u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 18 19:17:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZqyw-0004Sd-GK
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 19:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575AbZBRSPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 13:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753549AbZBRSPH
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 13:15:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:48689 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752898AbZBRSPF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 13:15:05 -0500
Received: (qmail invoked by alias); 18 Feb 2009 18:15:03 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp067) with SMTP; 18 Feb 2009 19:15:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19weE9ScndwIPiMneX+kMjpTDqxbOCSgglzVYKVJy
	wttFbWD3m6EarY
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1234980819u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110564>

A recent addition to the ref_item struct was not taken care of, leading
to a segmentation fault when accessing the (uninitialized) "dest" member.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Unfortunately not found by valgrind.

 builtin-branch.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 8c37c78..ded0a82 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -441,7 +441,9 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 	    is_descendant_of(head_commit, with_commit)) {
 		struct ref_item item;
 		item.name = xstrdup("(no branch)");
+		item.len = strlen(item.name);
 		item.kind = REF_LOCAL_BRANCH;
+		item.dest = NULL;
 		item.commit = head_commit;
 		if (strlen(item.name) > ref_list.maxwidth)
 			ref_list.maxwidth = strlen(item.name);
-- 
1.6.2.rc1.349.g70b801
