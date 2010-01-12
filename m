From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 18/18] symlinks.c: remove unused functions
Date: Mon, 11 Jan 2010 23:53:01 -0800
Message-ID: <1263282781-25596-19-git-send-email-gitster@pobox.com>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com>
Cc: Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 08:53:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUbZW-0004h8-TC
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 08:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509Ab0ALHxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 02:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753495Ab0ALHxt
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 02:53:49 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41307 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507Ab0ALHxr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 02:53:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E7BCA8E8BB;
	Tue, 12 Jan 2010 02:53:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6ysz
	ellHm0I1rdaYqSHZLnAf5SM=; b=w2BH4BKT+P6PJXfl/tPOItU78gxMT4woYqfr
	5iFFyUL8hzvV8G6zQBSqZBBHQhPdLlghGdLOOmfKYVFYh+aLwigDKHiCgg46CM43
	QHyfDn2Sn56XnNMfzel0x597UlrUHUDXNga7GAVtPLvKNQb6lL4ycjBmgz+w1ZH8
	Xr0cp5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	AZGLuJDtwCOK0+xuO6aeRRQ5ct1CoYEbKXPty+IecJcxnGibkJgcjGwYXU3SdTUO
	A6I+0OSNl1Nl3EhuuD/9oLgTul+fO63XfwIzZQBgCMRPQPisf8hrhWWF2c6WHrqd
	B7ryewC6it1W5+Ktf0Jw0UJNFm0sgoYi/S3ja7NyLhQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D4D7F8E8B8;
	Tue, 12 Jan 2010 02:53:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FC558E8B6; Tue, 12 Jan
 2010 02:53:44 -0500 (EST)
X-Mailer: git-send-email 1.6.6.280.ge295b7.dirty
In-Reply-To: <1263282781-25596-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9C5AA35E-FF4F-11DE-99AA-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136685>

invalidate_lstat_cache() and clear_lstat_cache() are not used anywhere.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h    |    2 --
 symlinks.c |   31 -------------------------------
 2 files changed, 0 insertions(+), 33 deletions(-)

diff --git a/cache.h b/cache.h
index 90edb5b..b4b2ba7 100644
--- a/cache.h
+++ b/cache.h
@@ -782,8 +782,6 @@ extern int has_symlink_leading_path(const char *name, int len);
 extern int threaded_has_symlink_leading_path(struct cache_def *, const char *, int);
 extern int has_symlink_or_noent_leading_path(const char *name, int len);
 extern int has_dirs_only_path(const char *name, int len, int prefix_len);
-extern void invalidate_lstat_cache(const char *name, int len);
-extern void clear_lstat_cache(void);
 extern void schedule_dir_for_removal(const char *name, int len);
 extern void remove_scheduled_dirs(void);
 
diff --git a/symlinks.c b/symlinks.c
index 7b0a86d..8860120 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -179,37 +179,6 @@ static int lstat_cache(struct cache_def *cache, const char *name, int len,
 	return ret_flags;
 }
 
-/*
- * Invalidate the given 'name' from the cache, if 'name' matches
- * completely with the cache.
- */
-void invalidate_lstat_cache(const char *name, int len)
-{
-	int match_len, previous_slash;
-	struct cache_def *cache = &default_cache;	/* FIXME */
-
-	match_len = longest_path_match(name, len, cache->path, cache->len,
-				       &previous_slash);
-	if (len == match_len) {
-		if ((cache->track_flags & FL_DIR) && previous_slash > 0) {
-			cache->path[previous_slash] = '\0';
-			cache->len = previous_slash;
-			cache->flags = FL_DIR;
-		} else {
-			reset_lstat_cache(cache);
-		}
-	}
-}
-
-/*
- * Completely clear the contents of the cache
- */
-void clear_lstat_cache(void)
-{
-	struct cache_def *cache = &default_cache;	/* FIXME */
-	reset_lstat_cache(cache);
-}
-
 #define USE_ONLY_LSTAT  0
 
 /*
-- 
1.6.6.280.ge295b7.dirty
