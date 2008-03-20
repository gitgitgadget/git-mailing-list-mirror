From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Two bugs with renaming
Date: Wed, 19 Mar 2008 21:22:57 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803192120410.3020@woody.linux-foundation.org>
References: <slrnfu37vn.d2i.jgoerzen@katherina.lan.complete.org> <alpine.LFD.1.00.0803192059120.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 05:23:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcCJe-0003hO-Vo
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 05:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbYCTEXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 00:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbYCTEXF
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 00:23:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43247 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750896AbYCTEXD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2008 00:23:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2K4MxgI014716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 19 Mar 2008 21:23:00 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2K4MvqM021203;
	Wed, 19 Mar 2008 21:22:58 -0700
In-Reply-To: <alpine.LFD.1.00.0803192059120.3020@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.28 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77622>



On Wed, 19 Mar 2008, Linus Torvalds wrote:
> 
> With the new unpack-trees logic it's pretty easy to *not* unpack with DF 
> conflicts (add a flag that tells us to use "base_name_compare()" instead 
> of "df_name_compare()" in do_compare_entry()), and maybe we can then make 
> builtin-merge-recursive.c set that flag. [...]

Looking at that, the first thing we should probably do is to make those 
existing flags be bitfields rather than "int" before we add even more 
flags there.

Hmm?

			Linus

---
 unpack-trees.h |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/unpack-trees.h b/unpack-trees.h
index 50453ed..ad8cc65 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -9,16 +9,16 @@ typedef int (*merge_fn_t)(struct cache_entry **src,
 		struct unpack_trees_options *options);
 
 struct unpack_trees_options {
-	int reset;
-	int merge;
-	int update;
-	int index_only;
-	int nontrivial_merge;
-	int trivial_merges_only;
-	int verbose_update;
-	int aggressive;
-	int skip_unmerged;
-	int gently;
+	unsigned int reset:1,
+		     merge:1,
+		     update:1,
+		     index_only:1,
+		     nontrivial_merge:1,
+		     trivial_merges_only:1,
+		     verbose_update:1,
+		     aggressive:1,
+		     skip_unmerged:1,
+		     gently:1;
 	const char *prefix;
 	int pos;
 	struct dir_struct *dir;
