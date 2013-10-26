From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 1/2] refs: remove unused function invalidate_ref_cache
Date: Sat, 26 Oct 2013 19:03:01 +0200
Message-ID: <1382806982-20634-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 26 19:03:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Va7GX-0008TR-9r
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 19:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982Ab3JZRDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 13:03:03 -0400
Received: from mail-ea0-f178.google.com ([209.85.215.178]:61720 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849Ab3JZRDC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 13:03:02 -0400
Received: by mail-ea0-f178.google.com with SMTP id a15so1320096eae.23
        for <git@vger.kernel.org>; Sat, 26 Oct 2013 10:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=36KnWEV8zHOZhWXwJwOlBwe+L5JeDpcWy52YvKc4zoU=;
        b=DsOjqQNM0MQkLZtz0TUqowWEKVzD/74b6lY9kdEI4tqFPrHaIjmAiIVBwZ/xVd2SNK
         ym0Ms+F5kYBJ9xMYKe/yj8MjLGmNMNW+XmTIof7XRPR4mTb/Fo2TNuFULbVgABk69Hcz
         Cxi67/rTDhEevlW3XyGvzLXtSOQyEGZZ0+9pQ0CXWt/td8iwzJbt8Ge1Ex5+mFDYsRt7
         6x4NbJ/wp4IXmgfN30ZRxgVEsFrtVG0bzzhAY2An3laTFZfZ2+9q5a23pyYe60giKB+2
         QWNmuF1hifViXqwAtuSnC08H0tlwLIFS3lljYchBkmXJlsZSvuKWQeYwdvPSqDs/5Gs0
         g4vw==
X-Received: by 10.14.241.141 with SMTP id g13mr3447836eer.75.1382806980376;
        Sat, 26 Oct 2013 10:03:00 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id d7sm33145345eem.8.2013.10.26.10.02.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 26 Oct 2013 10:02:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.1.605.g23c6912
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236758>

The function 'invalidate_ref_cache' was introduced in 79c7ca5 (2011-10-17,
invalidate_ref_cache(): rename function from invalidate_cached_refs())
by a rename and elevated to be publicly usable in 8be8bde (2011-10-17,
invalidate_ref_cache(): expose this function in the refs API)

However it is not used anymore, as 8bf90dc (2011-10-17, write_ref_sha1():
only invalidate the loose ref cache) and (much) later 506a760 (2013-04-22,
refs: change how packed refs are deleted) removed any calls to this
function. So it seems as if we don't need that function any more,
good bye!

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 refs.c | 7 -------
 refs.h | 8 --------
 2 files changed, 15 deletions(-)

diff --git a/refs.c b/refs.c
index 3710748..f9c1957 100644
--- a/refs.c
+++ b/refs.c
@@ -947,13 +947,6 @@ static struct ref_cache *get_ref_cache(const char *submodule)
 	return refs;
 }
 
-void invalidate_ref_cache(const char *submodule)
-{
-	struct ref_cache *refs = get_ref_cache(submodule);
-	clear_packed_ref_cache(refs);
-	clear_loose_ref_cache(refs);
-}
-
 /* The length of a peeled reference line in packed-refs, including EOL: */
 #define PEELED_LINE_LENGTH 42
 
diff --git a/refs.h b/refs.h
index b113377..87a1a79 100644
--- a/refs.h
+++ b/refs.h
@@ -165,14 +165,6 @@ extern void unlock_ref(struct ref_lock *lock);
 /** Writes sha1 into the ref specified by the lock. **/
 extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
 
-/*
- * Invalidate the reference cache for the specified submodule.  Use
- * submodule=NULL to invalidate the cache for the main module.  This
- * function must be called if references are changed via a mechanism
- * other than the refs API.
- */
-extern void invalidate_ref_cache(const char *submodule);
-
 /** Setup reflog before using. **/
 int log_ref_setup(const char *ref_name, char *logfile, int bufsize);
 
-- 
1.8.4.1.605.g23c6912
