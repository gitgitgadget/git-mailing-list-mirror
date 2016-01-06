From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 1/2] commit: allow editing the commit message even in
 shared repos
Date: Wed, 6 Jan 2016 14:09:43 +0100 (CET)
Message-ID: <38701d9358765af334ce405eb4a29f0063dae670.1452085713.git.johannes.schindelin@gmx.de>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de> <cover.1452085713.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 14:10:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGnqy-0004dP-7F
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 14:10:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbcAFNKC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 08:10:02 -0500
Received: from mout.gmx.net ([212.227.15.18]:61885 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930AbcAFNKA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 08:10:00 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lu8Ri-1a7hIF0Qpa-011VQN; Wed, 06 Jan 2016 14:09:45
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452085713.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:EVECNzsgfpGpDdlmH3u3zpyGTGDmmaN4QVij/MJSI8Ewf6GDRLw
 +CtgVTsdBrutM7MhWRstHtKzMAwzXKyLaoPOA7mizbblfNmHwwWloJvGThgeMT02a856wgw
 xIRwcMp/UCsdjY905YCIKOtFfJ+/VEmLP8J9N+rM2mFL+WzyDRHmsMh/P5GXo07fEgo89YC
 hIFdYnv1aQAud7Ge74dsQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tS/89CfSiWc=:RUNRa1dg3XfKFYfFb0Gobm
 2bUHrbHXKITGH0eoMN8m7WdXDzXjdiRTEU6iW8BvuXmFHc8ImJMSIuBR6XqlSaEN/PdgzuNpL
 eT0eQ7qKMZE12CxcXFlHfX1hifEeRSX7Xwd4phDwCtIg6KkVZBQbEFLnw8Lbp7mn7d2jS5faX
 pzbctDlInDvBWvS8Bus0LiGAJfleegy4431xK+r+RgtoQVViUBe1oH9myNl65mVf7ajDZenBH
 e2s9TjTSWYecBUR7AbbJnxx18nupB4ey8+P3roAUCwx2iIBIcEc2cUM6Ca6cymRymvli6C9Ro
 O1TYfiU3IkQmAPKL9MCO0SY7Si5dS9oyGlrN7365j0n4qhiw6y8SCHbxOhivyfEmjJ8YCnWXk
 aXLgTM34XPWdbwCYrWlVgUPEfHmag8sMqPr5b2Wgzss8hGCpSlLe4Fzff5f4eDmcehzoMcorM
 p+DCAzUTGzv39GE1dZ0aGgjf4LBYGW/UxRiQtyurn8w3SDyOWgU6lT2hE7NYdzAloYxLcPENk
 DN1ABD1PHn9SZ1kkV/4vYYnO6pUbb2dBejoXeuSBEoPGvHWWuYpCtsF38Qer8BshNzrSBJy6f
 uQjcKozBLOEwDzqhctjJ++j/doHIoSW40T90n8T+ftIuruZGQqWdoRkYeTBQF06k944aNbE3G
 UYtt6R1BzaxTCs3ha7EJqC1bSfksKdc0apMBWfENCf6L8g0MOwGBoIw6FCn0n8iOE6knaf/FF
 LItuYUhWLsmOSMIg0Q4J+pf6OsZDWvTQV2mEdMyO+JILEh1KyeDTS890boHFDPmbmsmnYQSh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283443>

It was pointed out by Yaroslav Halchenko that the file containing the
commit message is writable only by the owner, which means that we have
to rewrite it from scratch in a shared repository.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/commit.c  |  2 +-
 git-compat-util.h |  1 +
 wrapper.c         | 13 +++++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d054f84..89bf6ad 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -761,7 +761,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		hook_arg2 = "";
 	}
 
-	s->fp = fopen(git_path(commit_editmsg), "w");
+	s->fp = fopen_for_writing(git_path(commit_editmsg));
 	if (s->fp == NULL)
 		die_errno(_("could not open '%s'"), git_path(commit_editmsg));
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 2da0a75..e8f2867 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -733,6 +733,7 @@ extern int xmkstemp_mode(char *template, int mode);
 extern int odb_mkstemp(char *template, size_t limit, const char *pattern);
 extern int odb_pack_keep(char *name, size_t namesz, const unsigned char *sha1);
 extern char *xgetcwd(void);
+extern FILE *fopen_for_writing(const char *path);
 
 #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), (alloc) * sizeof(*(x)))
 
diff --git a/wrapper.c b/wrapper.c
index b43d437..29a45d2 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -391,6 +391,19 @@ FILE *xfdopen(int fd, const char *mode)
 	return stream;
 }
 
+FILE *fopen_for_writing(const char *path)
+{
+	FILE *ret = fopen(path, "w");
+
+	if (!ret && errno == EPERM) {
+		if (!unlink(path))
+			ret = fopen(path, "w");
+		else
+			errno = EPERM;
+	}
+	return ret;
+}
+
 int xmkstemp(char *template)
 {
 	int fd;
-- 
2.6.3.windows.1.300.g1c25e49
