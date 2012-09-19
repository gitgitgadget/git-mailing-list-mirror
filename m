From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] test-wildmatch.c: Fix some sparse warnings
Date: Wed, 19 Sep 2012 19:13:41 +0100
Message-ID: <505A0B55.8060609@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 21:10:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEPfT-0002ZV-C4
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 21:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932969Ab2ISTKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 15:10:23 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:33435 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932282Ab2ISTKV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 15:10:21 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id EAC57400286;
	Wed, 19 Sep 2012 20:10:19 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 2F0AB40024D;	Wed, 19 Sep 2012 20:10:19 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta010.tch.inty.net (Postfix) with ESMTP;	Wed, 19 Sep 2012 20:10:18 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205980>


In particular, sparse complains as follows:

        SP test-wildmatch.c
    test-wildmatch.c:40:5: warning: symbol 'wildmatch_errors' was not \
        declared. Should it be static?
    test-wildmatch.c:41:6: warning: symbol 'number_separator' was not \
        declared. Should it be static?
    test-wildmatch.c:45:5: warning: symbol 'explode_mod' was not \
        declared. Should it be static?
    test-wildmatch.c:46:5: warning: symbol 'empties_mod' was not \
        declared. Should it be static?
    test-wildmatch.c:47:5: warning: symbol 'empty_at_start' was not \
        declared. Should it be static?
    test-wildmatch.c:48:5: warning: symbol 'empty_at_end' was not \
        declared. Should it be static?
    test-wildmatch.c:49:6: warning: symbol 'empties' was not \
        declared. Should it be static?

In order to suppress the warnings, we simply add the static modifier
to the declaration of (most of) the above symbols. Note that the
'number_separator' symbol was not actually used, so we removed the
declaration instead. Also, we add the static modifier to the
'fnmatch_errors' variable (not noted above because it was #ifdef-ed
out).

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Nguyen,

If you need to re-roll your 'nd/wildmatch' branch, could you please
squash this patch into the relevent commit(s). Also, I note that two
commits have "compat/wildmatch" in the subject, but the files are
at the top level.

Thanks!

ATB,
Ramsay Jones

 test-wildmatch.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/test-wildmatch.c b/test-wildmatch.c
index b94921b..bb726c8 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -34,19 +34,18 @@
 #ifdef COMPARE_WITH_FNMATCH
 #include <fnmatch.h>
 
-int fnmatch_errors = 0;
+static int fnmatch_errors = 0;
 #endif
 
-int wildmatch_errors = 0;
-char number_separator = ',';
+static int wildmatch_errors = 0;
 
 typedef char bool;
 
-int explode_mod = 0;
-int empties_mod = 0;
-int empty_at_start = 0;
-int empty_at_end = 0;
-char *empties;
+static int explode_mod = 0;
+static int empties_mod = 0;
+static int empty_at_start = 0;
+static int empty_at_end = 0;
+static char *empties;
 
 static struct option options[] = {
   OPT_STRING('e', "empties", &empties, "", ""),
-- 
1.7.12
