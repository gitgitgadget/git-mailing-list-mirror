From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 5/6] Silence GCC's "cast of pointer to integer of a different
 size" warning
Date: Mon, 26 Oct 2015 14:15:25 +0100 (CET)
Message-ID: <acd0b0db0a608523f8ca8d7fa47319a296daf34a.1445865176.git.johannes.schindelin@gmx.de>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 14:15:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zqhcb-00011h-AH
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 14:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937AbbJZNP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 09:15:29 -0400
Received: from mout.gmx.net ([212.227.15.15]:59354 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753924AbbJZNP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 09:15:27 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0LwaMR-1aZiO92QVb-018NCC;
 Mon, 26 Oct 2015 14:15:26 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1445865176.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:mECgPkfV7AEYhjcXszcJCPbekcD52v09OsNDrrydYW8lCBjsfEs
 FAgucLnbjHrVVwVRZBjVUfc3xkLhKUUwUBoO0Z1m7V9ogMm6KeH6PJfmzKYwK7/n36E1zzc
 1tNkI3ZRDFJnhtMqPhT7gjvSgYuz8cm6i0N37SpAkBT6RY/uNgIIcEQeePn/NW9R3xHq0/D
 j6kpNClaPrqoNkU/f7chQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:92cLu3T6ndg=:ekkE2J4cVHXrsoJpNWmtXv
 NXawCaBWVbb41FJThewgskHWuraEaD97zsZCgbm2s3mRi20h13FGlHSG2t2+dvSoLgGCnaRQK
 kpeqpDhJIppPtcsorv1w8XDtbjTYOwXo5x1lynaTjQ8Q5hmodAj6ZAp7xxmGItKQclhou1zDm
 7S7bRwa0gh+ATKD6Df5CuEzHUb73GhA3TljRcA1yUNd3J9TAVhSwn9fCbvsqCzPR2QQz6UNaB
 +q/x0SlAzhYAKvnTUcUYNTEiRhrvJ0/DgZrpBTzOn2lPFwifjsItnw585tkPzEuLQ4BJX48A5
 hLucGc8xw0of0WihxGrmUjnz/StEmknc+hmOf5Xt3ympqkWg3MT9JyRUW2cib21oPwEZXtFL9
 NbBxu7GNdmWbHE9/Q0DxuXnUkmrgEsWtdzKEesi8qGJ9fnTayAoUlUUABvjg/q0IddGFwYn8v
 aakIN1NiUOjOKg1v2kAa56UL/sr0yqU6cvp5UUWAXNwn4b+b5sH7sP/46GdzBhMliq6iY5AeT
 dwI5FDU4w7RtwZSe92iilcTZHjSgbzY4u/obCmKxtGh2Gdu6blsFGWFYJUAy4J/c6OQebnnQk
 5bG6wOuT0mqa6xObx5vAL4l0ix84CTez9DRTeVAgZBWm3u79c9VADwwCaHcmlsTkydNIc/aQ2
 aJ4ud+zVVsptfJCqLXIEJRlO7aeQp9UfkBqg8/mE1f+bWZcJIRQflTpqtia5Y5vHU7uR4ElfV
 K6tR2IvlyxnbGzW78fhbHiXjcyiQfBzKTBjwSGIKjT9jL0jt6g/dVtHT0RcheNzku4nep+/w 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280193>

When calculating hashes from pointers, it actually makes sense to cut
off the most significant bits. In that case, said warning does not make
a whole lot of sense.

So let's just work around it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/regex/regcomp.c | 6 ++++--
 pack-revindex.c        | 2 +-
 sha1_file.c            | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index 06f3088..fba5986 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -18,6 +18,8 @@
    Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
    02110-1301 USA.  */
 
+#include <stdint.h>
+
 static reg_errcode_t re_compile_internal (regex_t *preg, const char * pattern,
 					  size_t length, reg_syntax_t syntax);
 static void re_compile_fastmap_iter (regex_t *bufp,
@@ -2577,7 +2579,7 @@ parse_dup_op (bin_tree_t *elem, re_string_t *regexp, re_dfa_t *dfa,
     old_tree = NULL;
 
   if (elem->token.type == SUBEXP)
-    postorder (elem, mark_opt_subexp, (void *) (long) elem->token.opr.idx);
+    postorder (elem, mark_opt_subexp, (void *) (intptr_t) elem->token.opr.idx);
 
   tree = create_tree (dfa, elem, NULL, (end == -1 ? OP_DUP_ASTERISK : OP_ALT));
   if (BE (tree == NULL, 0))
@@ -3806,7 +3808,7 @@ create_token_tree (re_dfa_t *dfa, bin_tree_t *left, bin_tree_t *right,
 static reg_errcode_t
 mark_opt_subexp (void *extra, bin_tree_t *node)
 {
-  int idx = (int) (long) extra;
+  int idx = (int) (intptr_t) extra;
   if (node->token.type == SUBEXP && node->token.opr.idx == idx)
     node->token.opt_subexp = 1;
 
diff --git a/pack-revindex.c b/pack-revindex.c
index 5c8376e..e542ea7 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -21,7 +21,7 @@ static int pack_revindex_hashsz;
 
 static int pack_revindex_ix(struct packed_git *p)
 {
-	unsigned long ui = (unsigned long)p;
+	unsigned long ui = (unsigned long)(intptr_t)p;
 	int i;
 
 	ui = ui ^ (ui >> 16); /* defeat structure alignment */
diff --git a/sha1_file.c b/sha1_file.c
index 50896ff..c5b31de 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2126,7 +2126,7 @@ static unsigned long pack_entry_hash(struct packed_git *p, off_t base_offset)
 {
 	unsigned long hash;
 
-	hash = (unsigned long)p + (unsigned long)base_offset;
+	hash = (unsigned long)(intptr_t)p + (unsigned long)base_offset;
 	hash += (hash >> 8) + (hash >> 16);
 	return hash % MAX_DELTA_CACHE;
 }
-- 
2.1.4
