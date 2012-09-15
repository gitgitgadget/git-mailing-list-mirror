From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] test-string-list.c: Fix some sparse warnings
Date: Sat, 15 Sep 2012 17:18:42 +0100
Message-ID: <5054AA62.2040603@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Sat Sep 15 19:23:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCw5f-0006yu-U3
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 19:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850Ab2IORX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 13:23:29 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:44331 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754834Ab2IORX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 13:23:28 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 5AA80A640C1;
	Sat, 15 Sep 2012 18:23:27 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 9982CA640BB;	Sat, 15 Sep 2012 18:23:26 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;	Sat, 15 Sep 2012 18:23:25 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205568>


In particular, sparse complains as follows:

        SP test-string-list.c
    test-string-list.c:10:6: warning: symbol 'parse_string_list' was not \
        declared. Should it be static?
    test-string-list.c:18:6: warning: symbol 'write_list' was not \
        declared. Should it be static?
    test-string-list.c:25:6: warning: symbol 'write_list_compact' was not \
        declared. Should it be static?
    test-string-list.c:38:5: warning: symbol 'prefix_cb' was not \
        declared. Should it be static?

In order to suppress the warnings, since the above symbols do not
need more than file scope, we simply include the static modifier
in their declaration.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Michael,

If you need to re-roll your 'mh/string-list' branch, could you
please squash the relevent parts of this patch into those commits.

Thanks!

ATB,
Ramsay Jones

 test-string-list.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test-string-list.c b/test-string-list.c
index 5e9631f..4693295 100644
--- a/test-string-list.c
+++ b/test-string-list.c
@@ -7,7 +7,7 @@
  * list (as opposed to "", which indicates a string list containing a
  * single empty string).  list->strdup_strings must be set.
  */
-void parse_string_list(struct string_list *list, const char *arg)
+static void parse_string_list(struct string_list *list, const char *arg)
 {
 	if (!strcmp(arg, "-"))
 		return;
@@ -15,14 +15,14 @@ void parse_string_list(struct string_list *list, const char *arg)
 	(void)string_list_split(list, arg, ':', -1);
 }
 
-void write_list(const struct string_list *list)
+static void write_list(const struct string_list *list)
 {
 	int i;
 	for (i = 0; i < list->nr; i++)
 		printf("[%d]: \"%s\"\n", i, list->items[i].string);
 }
 
-void write_list_compact(const struct string_list *list)
+static void write_list_compact(const struct string_list *list)
 {
 	int i;
 	if (!list->nr)
@@ -35,7 +35,7 @@ void write_list_compact(const struct string_list *list)
 	}
 }
 
-int prefix_cb(struct string_list_item *item, void *cb_data)
+static int prefix_cb(struct string_list_item *item, void *cb_data)
 {
 	const char *prefix = (const char *)cb_data;
 	return !prefixcmp(item->string, prefix);
-- 
1.7.12
