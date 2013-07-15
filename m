From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] Fix some sparse warnings
Date: Mon, 15 Jul 2013 18:31:29 +0100
Message-ID: <51E431F1.6050002@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 15 19:53:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uymy3-0003L1-UK
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 19:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590Ab3GORxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 13:53:38 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:49017 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752910Ab3GORxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 13:53:25 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id BAC631280B5;
	Mon, 15 Jul 2013 18:53:23 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id D596D1280A8;
	Mon, 15 Jul 2013 18:53:22 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Mon, 15 Jul 2013 18:53:21 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230502>


Sparse issues three "Using plain integer as NULL pointer" warnings.
Each warning relates to the use of an '{0}' initialiser expression
in the declaration of an 'struct object_info'. The first field of
this structure has pointer type. Thus, in order to suppress these
warnings, we replace the initialiser expression with '{NULL}'.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Jeff,

If you need to re-roll the patches in your 'jk/in-pack-size-measurement'
branch, could you please squash this (or something like it) into the
patches equivalent to commit 7c07385d ("zero-initialize object_info structs",
07-07-2013) [sha1_file.c and streaming.c] and commit 778d263a ("cat-file: add
--batch-disk-sizes option", 07-07-2013) [builtin/cat-file.c].

Thanks!

ATB,
Ramsay Jones


 builtin/cat-file.c | 2 +-
 sha1_file.c        | 2 +-
 streaming.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index bf12883..860576e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -135,7 +135,7 @@ static int batch_one_object(const char *obj_name, int print_contents)
 	if (print_contents == BATCH)
 		contents = read_sha1_file(sha1, &type, &size);
 	else if (print_contents == BATCH_DISK_SIZES) {
-		struct object_info oi = {0};
+		struct object_info oi = {NULL};
 		oi.disk_sizep = &size;
 		type = sha1_object_info_extended(sha1, &oi);
 	}
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
