From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] ctype.c: Fix a sparse warning
Date: Sun, 04 Mar 2012 19:10:57 +0000
Message-ID: <4F53BE41.5000309@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 04 20:13:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4GsD-0006nd-3C
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 20:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733Ab2CDTNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 14:13:31 -0500
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:62070 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754632Ab2CDTNa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Mar 2012 14:13:30 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1S4Gs5-0004n4-gI; Sun, 04 Mar 2012 19:13:29 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192168>


In particular, sparse complains as follows:

        SP ctype.c
    ctype.c:30:12: warning: symbol 'tolower_trans_tbl' was not declared.\
         Should it be static?

An appropriate extern declaration for the 'tolower_trans_tbl' symbol
is included in the "cache.h" header file. In order to suppress the
warning, therefore, we could replace the "git-compat-util.h" header
inclusion with "cache.h", since "cache.h" includes "git-compat-util.h"
in turn. Here, however, we choose to move the extern declaration for
'tolower_trans_tbl' into "git-compat-util.h", alongside the other
extern declaration from ctype.c for 'sane_ctype'.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

Could you please squash this, or something like it, into
commit 0f871cf5 ("grep: use static trans-case table",28-02-2012).

Thanks!

ATB,
Ramsay Jones

 cache.h           |    3 ---
 git-compat-util.h |    3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 9765b87..9d7bf3d 100644
--- a/cache.h
+++ b/cache.h
@@ -1285,7 +1285,4 @@ extern struct startup_info *startup_info;
 /* builtin/merge.c */
 int checkout_fast_forward(const unsigned char *from, const unsigned char *to);
 
-/* in ctype.c, for kwset users */
-extern const char tolower_trans_tbl[256];
-
 #endif /* CACHE_H */
diff --git a/git-compat-util.h b/git-compat-util.h
index 426ae43..ed11ad8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -457,6 +457,9 @@ static inline int has_extension(const char *filename, const char *ext)
 	return len > extlen && !memcmp(filename + len - extlen, ext, extlen);
 }
 
+/* in ctype.c, for kwset users */
+extern const char tolower_trans_tbl[256];
+
 /* Sane ctype - no locale, and works with signed chars */
 #undef isascii
 #undef isspace
-- 
1.7.9
