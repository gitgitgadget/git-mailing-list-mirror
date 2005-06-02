From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Use correct U*MAX.
Date: Thu, 02 Jun 2005 09:47:33 -0700
Message-ID: <7vwtpc7lju.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vy89ums2l.fsf@assigned-by-dhcp.cox.net>
	<7vis0xkjn4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 18:46:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdsoA-0002nM-Gl
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 18:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVFBQrk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 12:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVFBQrk
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 12:47:40 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:14469 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261192AbVFBQrf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2005 12:47:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050602164735.NNZN550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Jun 2005 12:47:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vis0xkjn4.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Wed, 01 Jun 2005 11:38:07 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The largest "unsigned long" value is ULONG_MAX, not UINT_MAX.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** Linus, you may be unable to spell, but I cannot type ;-).

 count-delta.c     |    4 ++--
 diff.c            |    4 ++--
 diffcore-break.c  |    2 +-
 diffcore-rename.c |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/count-delta.c b/count-delta.c
--- a/count-delta.c
+++ b/count-delta.c
@@ -46,7 +46,7 @@ unsigned long count_delta(void *delta_bu
 
 	/* the smallest delta size possible is 6 bytes */
 	if (delta_size < 6)
-		return UINT_MAX;
+		return ULONG_MAX;
 
 	data = delta_buf;
 	top = delta_buf + delta_size;
@@ -83,7 +83,7 @@ unsigned long count_delta(void *delta_bu
 
 	/* sanity check */
 	if (data != top || out != dst_size)
-		return UINT_MAX;
+		return ULONG_MAX;
 
 	/* delete size is what was _not_ copied from source.
 	 * edit size is that and literal additions.
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -256,7 +256,7 @@ static struct sha1_size_cache *locate_si
 		first = next+1;
 	}
 	/* not found */
-	if (size == UINT_MAX)
+	if (size == ULONG_MAX)
 		return NULL;
 	/* insert to make it at "first" */
 	if (sha1_size_cache_alloc <= sha1_size_cache_nr) {
@@ -338,7 +338,7 @@ int diff_populate_filespec(struct diff_f
 		struct sha1_size_cache *e;
 
 		if (size_only) {
-			e = locate_size_cache(s->sha1, UINT_MAX);
+			e = locate_size_cache(s->sha1, ULONG_MAX);
 			if (e) {
 				s->size = e->size;
 				return 0;
diff --git a/diffcore-break.c b/diffcore-break.c
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -63,7 +63,7 @@ static int very_different(struct diff_fi
 	/* Estimate the edit size by interpreting delta. */
 	delta_size = count_delta(delta, delta_size);
 	free(delta);
-	if (delta_size == UINT_MAX)
+	if (delta_size == ULONG_MAX)
 		return 0; /* error in delta computation */
 
 	if (base_size < delta_size)
diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -176,7 +176,7 @@ static int estimate_similarity(struct di
 	/* Estimate the edit size by interpreting delta. */
 	delta_size = count_delta(delta, delta_size);
 	free(delta);
-	if (delta_size == UINT_MAX)
+	if (delta_size == ULONG_MAX)
 		return 0;
 
 	/*
------------

