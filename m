From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] name-hash: retire unused index_name_exists()
Date: Fri, 20 Dec 2013 11:05:06 -0500
Message-ID: <1387555506-3882-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 20 17:11:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vu2fo-0005NP-5S
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 17:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357Ab3LTQL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Dec 2013 11:11:29 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:49043 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761Ab3LTQLY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Dec 2013 11:11:24 -0500
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Dec 2013 11:11:24 EST
Received: by mail-ig0-f182.google.com with SMTP id c10so7451228igq.3
        for <git@vger.kernel.org>; Fri, 20 Dec 2013 08:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=J5jiJWli/ZFMMfOMnu7LdiZSQ5lyKAmQKVkeH6uM0ow=;
        b=o8/AsoFyDS+0bdisbJFu7OuDYiNFYkwEruxfXLs3CwIr8fs4JdQUZbI2x6HlOgqTYG
         PTmkwV0s1u3gxCA5mhoVC1Uy///IBrdDeAzg+D5XQBwjwst3EmP2XoDCaaLaPndgKyIn
         7z3KncNO/7vs5zP2ylIdaD9H0YtMUKpO/E+ly5tu+4rsjUXHLcHqhF9/RykI0HDZva4u
         LmtyJW2gl4TYEw7qU5H/LgqeyrHw39BjBqB0kGhdLUhxsFbYQ8x8ro2vz7L/tV061V81
         oKxDY1UTPFR9vyOrnGdsOaRcN387RFI+QHlbZJ5vwKRgcEK8zNOq5Vj9wJqUHfHUbmUC
         WsGg==
X-Received: by 10.43.71.200 with SMTP id yl8mr745696icb.74.1387555517537;
        Fri, 20 Dec 2013 08:05:17 -0800 (PST)
Received: from floomp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id kt2sm12715581igb.1.2013.12.20.08.05.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Dec 2013 08:05:16 -0800 (PST)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239575>

db5360f3f496 (name-hash: refactor polymorphic index_name_exists();
2013-09-17) split index_name_exists() into index_file_exists() and
index_dir_exists() but retained index_name_exists() as a thin wrapper
to avoid disturbing possible in-flight topics. Since this change
landed in 'master' some time ago and there are no in-flight topics
referencing index_name_exists(), retire it.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Perhaps now is a good time to retire this unused function?

This patch conflicts textually with kb/fast-hashmap in 'pu', although,
since both are merely removing functions from name-hash.c at the point
of conflict, the resolution should be straightforward.

 cache.h     | 2 --
 name-hash.c | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/cache.h b/cache.h
index ce377e1..23f207a 100644
--- a/cache.h
+++ b/cache.h
@@ -316,7 +316,6 @@ extern void free_name_hash(struct index_state *istate);
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
 #define cache_dir_exists(name, namelen) index_dir_exists(&the_index, (name), (namelen))
 #define cache_file_exists(name, namelen, igncase) index_file_exists(&the_index, (name), (namelen), (igncase))
-#define cache_name_exists(name, namelen, igncase) index_name_exists(&the_index, (name), (namelen), (igncase))
 #define cache_name_is_other(name, namelen) index_name_is_other(&the_index, (name), (namelen))
 #define resolve_undo_clear() resolve_undo_clear_index(&the_index)
 #define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, at)
@@ -466,7 +465,6 @@ extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
 extern struct cache_entry *index_dir_exists(struct index_state *istate, const char *name, int namelen);
 extern struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
-extern struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int igncase);
 extern int index_name_pos(const struct index_state *, const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
diff --git a/name-hash.c b/name-hash.c
index e5b6e1a..715f95c 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -263,13 +263,6 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
 	return NULL;
 }
 
-struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int icase)
-{
-	if (namelen > 0 && name[namelen - 1] == '/')
-		return index_dir_exists(istate, name, namelen - 1);
-	return index_file_exists(istate, name, namelen, icase);
-}
-
 static int free_dir_entry(void *entry, void *unused)
 {
 	struct dir_entry *dir = entry;
-- 
1.8.3.2
