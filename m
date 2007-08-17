From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Fix read-tree merging more than 3 trees using 3-way
 merge
Date: Thu, 16 Aug 2007 17:59:18 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708161750550.30176@woody.linux-foundation.org>
References: <600399.61066.qm@web52807.mail.re2.yahoo.com>
 <7vbqd8o1qs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Perrin Meyer <perrinmeyer@yahoo.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 03:00:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILqCr-0005F4-F3
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 03:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbXHQBAY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 21:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752195AbXHQBAY
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 21:00:24 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58506 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752772AbXHQBAX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Aug 2007 21:00:23 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7H0xOIL018632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 16 Aug 2007 17:59:25 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7H0xI72014809;
	Thu, 16 Aug 2007 17:59:19 -0700
In-Reply-To: <7vbqd8o1qs.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-4.748 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56035>



On Wed, 15 Aug 2007, Junio C Hamano wrote:
>
> For multi-base merges, we allowed read-tree -m to take more than
> three trees (the last two are our and their branches, and all the
> earlier ones, typically one but potentially more, are used as the
> merge base).  Unfortunately, the conversion done by commit 933bf40
> broke this.

Sorry. I didn't even realize people did this. Oops.

I note that the thign you committed limited the number of trees to 4. 
May I suggest this patch in addition to your patch? Also, is 4 actually 
the real maximum? Maybe it should be raised?

What *is* the behaviour for four trees? Reading "unpack_trees()" source 
implies that all other trees go into stage 1, where the first matching 
entry is used?

		Linus

---
 builtin-read-tree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index f6764b9..d5f849b 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -21,7 +21,7 @@ static int list_tree(unsigned char *sha1)
 {
 	struct tree *tree;
 
-	if (nr_trees >= 4)
+	if (nr_trees >= MAX_TREES)
 		return -1;
 	tree = parse_tree_indirect(sha1);
 	if (!tree)
