From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 3/4] Add a function to release all packs
Date: Mon, 05 Oct 2015 22:33:06 +0200
Organization: gmx
Message-ID: <78d0edaeb0f707da24ea08f4bb8517f9ad5be775.1444076827.git.johannes.schindelin@gmx.de>
References: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
 <cover.1444076827.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 22:33:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjCRr-00027l-Eg
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 22:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbbJEUdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 16:33:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:50368 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751647AbbJEUdO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 16:33:14 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MYsEZ-1a4s4W4AMN-00VjiH; Mon, 05 Oct 2015 22:33:08
 +0200
In-Reply-To: <cover.1444076827.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:Fevd/0ganAmYVsaxx++MZcfTRGisGpK+Bg8rC1jAhKdViRzLJUs
 JQMj+IuRXZY9wJ2057Iw2j3laK1un6kBJntYjUVqr9DICj0s0bKOXv4cSaP/6ImrOwekIZ0
 /43B/GU7XuiMkCMCQVe9Y2Ywy/j6kZviLaRSfyhbcIl0kFnfu6lThz/Uom7yfayF6WJPT2J
 U25gxXhkrUNPRx7VTch0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hhQwKTNQooM=:xadxR0RdbYX3fQkSrp2yMi
 YgLPy5c1qP1RDn25N9pl2Oc/uaOpp9s+39akWR//hzmHoP3TEQJtc4okOgAeAI9AZsvUGoDMi
 Q0Zeb6DHnnZPxkTII/lvWUCv8MSadyg2BKnoJWzGq6vApfU7GT2O0dam2q7Yt03inBe/lNTSw
 /rOaJDEmwAvgwSXQO6Qed5MFfQ5sJ88QjLywYLC8nZXao6T08SlXRYEqrGO9firrRwuCHoHOp
 qjmCuLpTjQWkuPXh/rBWmOXAhvHlxGkJO2jqRj3zm53KEoKuhoj+mYEadUZPxd9oT6c4tJ+Q2
 7DP9QZOjzL91uctwztZJv1ScHmZAeFmj/7tpXRBvNXMeBC1mk9hQhtKzERaiYi6zH0YsOQnK7
 xhJOO5FqCoyQ0S8spLKBjTmm/xnhU0OB6XmW98yyPOzqMBO6Pu5IP9/Xe6ORO4VUe0aSvebvT
 xYQY8KiQExYt9P19SHWdUYcYOIEKkUkxKQpwTIIsmpDlWMh+nnpscvq7Ln511WydTldv7D69h
 j8aNXuNbcwLcXeHbpVHAkqhbZnSdEO69slYvfCvgpSJqu2c7CNbfGnVPYIdjmg3rpYLcLGPxJ
 m/AQ4Km/c5hc/Mt8Xng8PpeVebJ6gqZJmZaR/Uxy7QHTSiWN2+Ucnqu1qiIhiF/zBmwxWSZQI
 p1pUk9hoWhnJuTMBUnSdEN7eQejMgDf6AgmaJKQpSQmrWsc5b44zlMC0gaukza5wo3rzMLLMY
 QFGEEKfm3G8G2/3rwJ8CgHe3CzeeHUoH8f8PLl+Rbq3TCJAQGAt69CFA+Xifc2KBVDN28q9/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279084>

On Windows, files that are in use cannot be removed or renamed. That
means that we have to release pack files when we are about to, say,
repack them. Let's introduce a convenient function to close them
pack files.

While at it, we consolidate the close windows/close fd/close index
stanza in `free_pack_by_name()` into the `close_pack()` function that
is used by the new `close_all_packs()` function to avoid repeated code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h     |  1 +
 sha1_file.c | 20 +++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 752031e..57f6a74 100644
--- a/cache.h
+++ b/cache.h
@@ -1275,6 +1275,7 @@ extern void close_pack_index(struct packed_git *);
 
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 extern void close_pack_windows(struct packed_git *);
+extern void close_all_packs(void);
 extern void unuse_pack(struct pack_window **);
 extern void free_pack_by_name(const char *);
 extern void clear_delta_base_cache(void);
diff --git a/sha1_file.c b/sha1_file.c
index 8c3c913..fe823fe 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -798,6 +798,22 @@ static int close_pack_fd(struct packed_git *p)
 	return 1;
 }
 
+static void close_pack(struct packed_git *p)
+{
+	close_pack_windows(p);
+	close_pack_fd(p);
+	close_pack_index(p);
+}
+
+void close_all_packs(void)
+{
+	struct packed_git *p;
+
+	for (p = packed_git; p; p = p->next)
+		close_pack(p);
+}
+
+
 /*
  * The LRU pack is the one with the oldest MRU window, preferring packs
  * with no used windows, or the oldest mtime if it has no windows allocated.
@@ -906,9 +922,7 @@ void free_pack_by_name(const char *pack_name)
 		p = *pp;
 		if (strcmp(pack_name, p->pack_name) == 0) {
 			clear_delta_base_cache();
-			close_pack_windows(p);
-			close_pack_fd(p);
-			close_pack_index(p);
+			close_pack(p);
 			free(p->bad_object_sha1);
 			*pp = p->next;
 			if (last_found_pack == p)
-- 
2.5.3.windows.1.3.gc322723
