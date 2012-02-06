From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] imap-send: remove dead code
Date: Mon, 6 Feb 2012 01:29:37 -0500
Message-ID: <20120206062937.GA9931@sigill.intra.peff.net>
References: <20120206062713.GA9699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 07:29:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuI5A-0000fe-6C
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 07:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706Ab2BFG3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 01:29:40 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58598
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432Ab2BFG3j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 01:29:39 -0500
Received: (qmail 24063 invoked by uid 107); 6 Feb 2012 06:36:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 01:36:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 01:29:37 -0500
Content-Disposition: inline
In-Reply-To: <20120206062713.GA9699@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190028>

The imap-send code was adapted from another project, and
still contains many unused bits of code. One of these bits
contains a type "struct string_list" which bears no
resemblence to the "struct string_list" we use elsewhere in
git. This causes the compiler to complain if git's
string_list ever becomes part of cache.h.

Let's just drop the dead code.

Signed-off-by: Jeff King <peff@peff.net>
---
This is necessary for patch 2, which does include string-list.h in
cache.h. If you read my cover letter, I think patch 2 might not be the
best approach. However, I think it might be worth applying this just as
a cleanup (e.g., even without the build problems, grepping for "struct
string_list" turns up this useless cruft).

 imap-send.c |   23 -----------------------
 1 files changed, 0 insertions(+), 23 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index e40125a..972ad62 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -42,28 +42,6 @@ struct store_conf {
 	unsigned trash_remote_new:1, trash_only_new:1;
 };
 
-struct string_list {
-	struct string_list *next;
-	char string[1];
-};
-
-struct channel_conf {
-	struct channel_conf *next;
-	char *name;
-	struct store_conf *master, *slave;
-	char *master_name, *slave_name;
-	char *sync_state;
-	struct string_list *patterns;
-	int mops, sops;
-	unsigned max_messages; /* for slave only */
-};
-
-struct group_conf {
-	struct group_conf *next;
-	char *name;
-	struct string_list *channels;
-};
-
 /* For message->status */
 #define M_RECENT       (1<<0) /* unsyncable flag; maildir_* depend on this being 1<<0 */
 #define M_DEAD         (1<<1) /* expunged */
@@ -71,7 +49,6 @@ struct group_conf {
 
 struct message {
 	struct message *next;
-	/* struct string_list *keywords; */
 	size_t size; /* zero implies "not fetched" */
 	int uid;
 	unsigned char flags, status;
-- 
1.7.9.rc1.29.g43677
