From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] Fix some sparse warnings
Date: Thu, 18 Jul 2013 21:25:50 +0100
Message-ID: <51E84F4E.3050600@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 22:29:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzupB-0004V9-Ov
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 22:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934331Ab3GRU3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 16:29:13 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:50105 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933559Ab3GRU3N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 16:29:13 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 12DA91280B6;
	Thu, 18 Jul 2013 21:29:12 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 4C1D61280A6;
	Thu, 18 Jul 2013 21:29:11 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Thu, 18 Jul 2013 21:29:10 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230738>


Sparse issues some "Using plain integer as NULL pointer" warnings.
Each warning relates to the use of an '{0}' initialiser expression
in the declaration of an 'struct object_info'. The first field of
this structure has pointer type. Thus, in order to suppress these
warnings, we replace the initialiser expression with '{NULL}'.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

This was built on the next branch.

ATB,
Ramsay Jones


 sha1_file.c | 2 +-
 streaming.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 4c2365f..e4ab0a4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2440,7 +2440,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 
 int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 {
-	struct object_info oi = {0};
+	struct object_info oi = {NULL};
 
 	oi.sizep = sizep;
 	return sha1_object_info_extended(sha1, &oi);
diff --git a/streaming.c b/streaming.c
index cac282f..5710065 100644
--- a/streaming.c
+++ b/streaming.c
@@ -135,7 +135,7 @@ struct git_istream *open_istream(const unsigned char *sha1,
 				 struct stream_filter *filter)
 {
 	struct git_istream *st;
-	struct object_info oi = {0};
+	struct object_info oi = {NULL};
 	const unsigned char *real = lookup_replace_object(sha1);
 	enum input_source src = istream_source(real, type, &oi);
 
-- 
1.8.3
