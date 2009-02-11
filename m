From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Drop double-semicolon in C
Date: Tue, 10 Feb 2009 17:48:40 -0800
Message-ID: <7vfxiliw07.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 02:50:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX4Ey-0004oM-RG
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 02:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266AbZBKBsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 20:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752885AbZBKBsu
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 20:48:50 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbZBKBst (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 20:48:49 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B0F4898596;
	Tue, 10 Feb 2009 20:48:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1279198594; Tue,
 10 Feb 2009 20:48:43 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1F11493A-F7DE-11DD-A7A9-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109365>

The worst offenders are "continue;;" and "break;;" in switch statements.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I think this is very trivial.  You can use

   $ git grep -n -e ';;' --and --not -e 'for *(.*;;' -- '*.c'

   to verify I caught all the bad ones.

 fast-import.c |    2 +-
 rerere.c      |    2 +-
 tree.c        |    2 +-
 walker.c      |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 03b13e0..3ef3413 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -869,7 +869,7 @@ static char *create_index(void)
 	/* Generate the fan-out array. */
 	c = idx;
 	for (i = 0; i < 256; i++) {
-		struct object_entry **next = c;;
+		struct object_entry **next = c;
 		while (next < last) {
 			if ((*next)->sha1[0] != i)
 				break;
diff --git a/rerere.c b/rerere.c
index 718fb52..3518207 100644
--- a/rerere.c
+++ b/rerere.c
@@ -290,7 +290,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 			hex = xstrdup(sha1_to_hex(sha1));
 			string_list_insert(path, rr)->util = hex;
 			if (mkdir(git_path("rr-cache/%s", hex), 0755))
-				continue;;
+				continue;
 			handle_file(path, NULL, rr_path(hex, "preimage"));
 			fprintf(stderr, "Recorded preimage for '%s'\n", path);
 		}
diff --git a/tree.c b/tree.c
index dfe4d5f..25d2e29 100644
--- a/tree.c
+++ b/tree.c
@@ -110,7 +110,7 @@ int read_tree_recursive(struct tree *tree,
 		case 0:
 			continue;
 		case READ_TREE_RECURSIVE:
-			break;;
+			break;
 		default:
 			return -1;
 		}
diff --git a/walker.c b/walker.c
index 679adab..e57630e 100644
--- a/walker.c
+++ b/walker.c
@@ -18,7 +18,7 @@ void walker_say(struct walker *walker, const char *fmt, const char *hex)
 static void report_missing(const struct object *obj)
 {
 	char missing_hex[41];
-	strcpy(missing_hex, sha1_to_hex(obj->sha1));;
+	strcpy(missing_hex, sha1_to_hex(obj->sha1));
 	fprintf(stderr, "Cannot obtain needed %s %s\n",
 		obj->type ? typename(obj->type): "object", missing_hex);
 	if (!is_null_sha1(current_commit_sha1))
-- 
1.6.2.rc0.36.g8307
