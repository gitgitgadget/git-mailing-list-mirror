From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 1/2] commit: allow editing the commit message even in
 shared repos
Date: Mon, 11 Jan 2016 19:35:49 +0100 (CET)
Message-ID: <38701d9358765af334ce405eb4a29f0063dae670.1452537321.git.johannes.schindelin@gmx.de>
References: <cover.1452085713.git.johannes.schindelin@gmx.de> <cover.1452537321.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 19:36:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIhKC-0003e0-Hh
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 19:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933119AbcAKSgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 13:36:11 -0500
Received: from mout.gmx.net ([212.227.17.22]:60714 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932451AbcAKSgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 13:36:09 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MQ7sF-1aDSGC3YRP-005FpZ; Mon, 11 Jan 2016 19:35:51
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452537321.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:bK6Sv03fUSL51Sd6WtHH4qWu80+Mx4CjrRlJACTCnEgLlf0DyVq
 VMTDUuyuZvb2wJhZvnWZ2sI6q8qncoNsOfXw5WxfM2fTLUd4U2x+qXc7B6iOsxjZPt7ToN5
 7/A6uv8+3f3nWnPmxIPjxzb3+Um++kVOdmbMm9X2kRgUqqpc2PAiG4W3d2JJwUk0esA3Haw
 6NjVrd+sJO05b1vUHjswg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QlbdCDcnhO0=:4ehnsTyTBS8yWfOIWMT6af
 0tEyh1DVzOGvppo2eM9CIskmLTGb2EVyMD9IFuFdjBX8xSS0XzDCYzVOaMpJwqj0sY2DKccHU
 tIOa/BAzg4xwGkXNWrU3BKCslux7Ec4ctH9AbFz9Otk2ovkHy6dZVoJj51GHHza6iCEYLjo82
 q3XFOV+os/UvcfuIk2l3mrniLvaX/AinUwdPLoN8Vj1oSJM2WMA2oGu1KINg6AEwWEBHbBJEy
 hll6HLFjWFX0rrZyCe5xtCXPrraVA81JuqqvWGKrJCI9D8Z1MpWklwpragUplbBA8LOLqHFqk
 2BO+TXHN0LmwBi9gPUMWznOEScJ7Gk6PuQka7A9uIRwONWyyTtBVRacf3kkU1jl8wcvnas6vt
 fBhbcsKcoo06iCSjkNzvg2T8v53X7hv3X+9DmtiPKlAiWuKzoT52E5/QyvmEL5xBAF9iN/YAf
 425o2AhzFSmD8LIVF/hTj7Ph+65qPUPN2X0e1RtBsbvYFyONi7qMIvAOLkULK1ueFFu82dvlc
 1UBTqTYZhjfNd4jfsjf/INo9nUZYleV3udSG2d/TlQq54ezDp44i2z27GwQC47mS9dh9f3B1C
 aFXTfjznUoitn7vmojmug8oREcHB02wHZKel4Etq8ZxACoZn/4jEs/QZSpf37lLfnmQtd7C+1
 PXv48Mp4iHLeVa9LJhIRcOrZweiRKFPii93CHzph3JVAEipyjrX48eBBpvj7Hv2vXeqdMbd3e
 i9oiclebVLo9TRfb+vtOSY8nUeoAYT/Oq6mrU6hQxLJomAhnx7IQFTy/akWMJRpxmGCdbxwk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283696>

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
