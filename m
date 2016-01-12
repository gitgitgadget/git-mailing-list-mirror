From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 2/4] compat/basename: make basename() conform to POSIX
Date: Tue, 12 Jan 2016 08:57:30 +0100 (CET)
Message-ID: <a7375faaba405354b30bc19c6edbdb1ef7c68ab1.1452585382.git.johannes.schindelin@gmx.de>
References: <cover.1452536924.git.johannes.schindelin@gmx.de> <cover.1452585382.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 08:57:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aItpr-0000ia-7m
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 08:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761839AbcALH5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 02:57:42 -0500
Received: from mout.gmx.net ([212.227.17.20]:60887 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761829AbcALH5k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 02:57:40 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0McR00-1aaZCt2hVY-00HgcF; Tue, 12 Jan 2016 08:57:31
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452585382.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:3R6FSZW9eoqeJbUc2RqNfmaDyp+K1zQlAff/8BXBgB4F0HhsjwR
 KO0NT7U+LYAubmxzuDCV7kHwZBU3XMt1HSWJuuntXKpWMifoYxvPxB5t4rsB5IGBvZfgud9
 25fCpwJNU6AEk7XyJplEUGv3B7U6g0FZY92s8nAhcO5HFcof3skGq7XzKaZIKksL+3XED+O
 /YliCWvsj4Y60kn6d2E4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:74tLf1G4bW8=:1PVXJs2jHTmHJAxDG3HJ2k
 lcoKnD5+JH3TwJMPKr4l2mBXktelHTIJQnNxy91MxuspAYhokjApG6dhE4o+qWvoH3oLlNp3F
 sjye4qUAsioGEGX/P3MlZ5yk9aTa+L5H26sNjbobA1EOlEeZquXjYXOjVI8A2CgkL8+U9ew+l
 +gm3De5k3gzB8bRqd8mYBlEtbt+vYTWTpVg+VKpXxgh7LcIt5ZZtnzZDRilLPZMyIIYYTGSyn
 dYuIVlASIUDGr++EnqaiDtxtfCNR/1CsIPndw647S+qL0jVqE3qqbom8i+k93uzlCueq+g8Ou
 TgSZoi7vqob15fQcRbjwnrjvLzJ/EhgzSz2yrl3Jm8IAYpd1mpdQ8ShYJhstlO+5DyfRw1KMv
 o4znRRRRmR0RdkdUhf4mh/FpN47Iv6KSE8oHiHhD+Q5jO0IZeY7RDflVFciIuW9ShiF/uzvS+
 KRcN9y7ETcJnViLHhpIDDoVAgFagCyoa42Y/olvJNyqrYjAHVayKX0/uuQ1oj/Ou+fdBBwzlf
 67Uyh3BrDiXQXE9fH7w0n+AG8aPDB/c6lRln6Q5X0PoRTd2tTWuSHgASNq661HVgBcjHohyBS
 sflmP1EoMklIGfKcPWsw+YZEEPXNkcNFy1sn4bP4IVc2j+Vr5vymuRByQhFioqWSGZhxn5JXV
 O6e74FvS1wSqp439cr3E+2NeJAEkD4Kps3N+O3JfugqDFEso3O2QD/zBmQHLRFwKq1JsxRiG+
 ARleHZY+vsMqItEpmCtcIi4g7SppQNkLMrMHx2nn4f/XyG4UeT++hJD3VtaYObW1+zrD7Q0z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283772>

According to POSIX, basename("/path/") should return "path", not
"path/". Likewise, basename(NULL) and basename("") should both
return "." to conform.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/basename.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/compat/basename.c b/compat/basename.c
index 9f00421..0f1b0b0 100644
--- a/compat/basename.c
+++ b/compat/basename.c
@@ -4,10 +4,24 @@
 char *gitbasename (char *path)
 {
 	const char *base;
-	skip_dos_drive_prefix(&path);
+
+	if (path)
+		skip_dos_drive_prefix(&path);
+
+	if (!path || !*path)
+		return ".";
+
 	for (base = path; *path; path++) {
-		if (is_dir_sep(*path))
-			base = path + 1;
+		if (!is_dir_sep(*path))
+			continue;
+		do {
+			path++;
+		} while (is_dir_sep(*path));
+		if (*path)
+			base = path;
+		else
+			while (--path != base && is_dir_sep(*path))
+				*path = '\0';
 	}
 	return (char *)base;
 }
-- 
2.6.3.windows.1.300.g1c25e49
