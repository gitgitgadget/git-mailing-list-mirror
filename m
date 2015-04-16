From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] Move get_max_fd_limit(void) to git_compat_util.h
Date: Thu, 16 Apr 2015 16:17:38 -0700
Message-ID: <1429226259-21622-3-git-send-email-sbeller@google.com>
References: <1429226259-21622-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Apr 17 01:18:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yit2u-00013M-Jp
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 01:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403AbbDPXSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 19:18:03 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36763 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbbDPXR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 19:17:58 -0400
Received: by igblo3 with SMTP id lo3so1614230igb.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2015 16:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KPmAe9eZg87smEi+JVutkuEXuO5JG0wQaIdfVWrV+fw=;
        b=bPvrFzt9CA1v5w/CiPHkIsl48efKnkBFDYBX3A+SllHTMn8/MElwSyKbgsTgN+BGZi
         RH97ElRdzv/b5SDBIkZCmjutql4xKzKwcsOT2dAu5vqQMBFvuzmJB3yTTVxXQZNxiVja
         j//dQA+4fMo2IA6EuUg9pSTvqStxypHnRfPEwnmj2EMc4iflSYGJtJolawbxWf3mFN7a
         y2269UfKjheDbbx7tqKf4MTN31eoGFu4Rmq4rs/80VIJqNwLr+4htfg8pmlR9r8oQS/q
         qRI0EGurvYBL70l6Vwl1AmX1UAbTCUDmPwryX85INSG57dM9oXa+wCVOQQ70oALHgOI6
         iv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KPmAe9eZg87smEi+JVutkuEXuO5JG0wQaIdfVWrV+fw=;
        b=g6KsdL5riwiaoRYRlmjOroXbWfiHlryrrSpFWVdRtFn7atqTt/d2eK0wE/CoOWLNhq
         pdDzutdyXFs/sNL7jQz3jWD/F3ELO0DA6c5nSKlsajA9wtyhor8K2aUAEasGs+fOr24y
         Q6Lf3qqmpA5XzHwaVA5Zl56Px50YIkL3KJa6qtzj4NNwq3X1CFyoJ5OGDgkayZZtqdA0
         s/lHP5dV3eDkE8sYLEjwAX2x1qigyy4ru2LRmrFgcmNKnzPO9NHGFg9TX3AlHcwZxuCl
         M4QM9/WyJf041sgGfaOJmYwRo5IOvGWhGWOOa4oO007KMXMvS4rYk/QHpAWOjXJb9taU
         YvTQ==
X-Gm-Message-State: ALoCoQl1DjEq4OpFDnEiuO5Vuxeftn+QORorx+oTmm7daIneV6MnxSsxgDgiOZ3c9uM4JjkfVbI6
X-Received: by 10.107.137.28 with SMTP id l28mr241941iod.23.1429226277881;
        Thu, 16 Apr 2015 16:17:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:fdc7:e96c:1b25:2317])
        by mx.google.com with ESMTPSA id s85sm5276492ioe.28.2015.04.16.16.17.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 Apr 2015 16:17:57 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1429226259-21622-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267341>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-compat-util.h |  1 +
 sha1_file.c       | 41 -----------------------------------------
 wrapper.c         | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index bc8fc8c..2c55ca7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -675,6 +675,7 @@ extern int xmkstemp_mode(char *template, int mode);
 extern int odb_mkstemp(char *template, size_t limit, const char *pattern);
 extern int odb_pack_keep(char *name, size_t namesz, const unsigned char *sha1);
 extern char *xgetcwd(void);
+extern unsigned int get_max_fd_limit(void);
 
 #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), (alloc) * sizeof(*(x)))
 
diff --git a/sha1_file.c b/sha1_file.c
index 88f06ba..1f2519c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -870,47 +870,6 @@ void free_pack_by_name(const char *pack_name)
 	}
 }
 
-static unsigned int get_max_fd_limit(void)
-{
-#ifdef RLIMIT_NOFILE
-	{
-		struct rlimit lim;
-
-		if (!getrlimit(RLIMIT_NOFILE, &lim))
-			return lim.rlim_cur;
-	}
-#endif
-
-#ifdef _SC_OPEN_MAX
-	{
-		long open_max = sysconf(_SC_OPEN_MAX);
-		if (0 < open_max)
-			return open_max;
-		/*
-		 * Otherwise, we got -1 for one of the two
-		 * reasons:
-		 *
-		 * (1) sysconf() did not understand _SC_OPEN_MAX
-		 *     and signaled an error with -1; or
-		 * (2) sysconf() said there is no limit.
-		 *
-		 * We _could_ clear errno before calling sysconf() to
-		 * tell these two cases apart and return a huge number
-		 * in the latter case to let the caller cap it to a
-		 * value that is not so selfish, but letting the
-		 * fallback OPEN_MAX codepath take care of these cases
-		 * is a lot simpler.
-		 */
-	}
-#endif
-
-#ifdef OPEN_MAX
-	return OPEN_MAX;
-#else
-	return 1; /* see the caller ;-) */
-#endif
-}
-
 /*
  * Do not call this directly as this leaks p->pack_fd on error return;
  * call open_packed_git() instead.
diff --git a/wrapper.c b/wrapper.c
index d5a6cef..493bf6f 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -303,6 +303,47 @@ ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset)
 	return total;
 }
 
+unsigned int get_max_fd_limit(void)
+{
+#ifdef RLIMIT_NOFILE
+	{
+		struct rlimit lim;
+
+		if (!getrlimit(RLIMIT_NOFILE, &lim))
+			return lim.rlim_cur;
+	}
+#endif
+
+#ifdef _SC_OPEN_MAX
+	{
+		long open_max = sysconf(_SC_OPEN_MAX);
+		if (0 < open_max)
+			return open_max;
+		/*
+		 * Otherwise, we got -1 for one of the two
+		 * reasons:
+		 *
+		 * (1) sysconf() did not understand _SC_OPEN_MAX
+		 *     and signaled an error with -1; or
+		 * (2) sysconf() said there is no limit.
+		 *
+		 * We _could_ clear errno before calling sysconf() to
+		 * tell these two cases apart and return a huge number
+		 * in the latter case to let the caller cap it to a
+		 * value that is not so selfish, but letting the
+		 * fallback OPEN_MAX codepath take care of these cases
+		 * is a lot simpler.
+		 */
+	}
+#endif
+
+#ifdef OPEN_MAX
+	return OPEN_MAX;
+#else
+	return 1; /* see the caller ;-) */
+#endif
+}
+
 int xdup(int fd)
 {
 	int ret = dup(fd);
-- 
2.3.0.81.gc37f363
