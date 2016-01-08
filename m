From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 2/4] compat/basename: make basename() conform to POSIX
Date: Fri, 8 Jan 2016 17:21:15 +0100 (CET)
Message-ID: <abd20a9fb53d702cb878b8fa767881e7c1ef2148.1452270051.git.johannes.schindelin@gmx.de>
References: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de> <cover.1452270051.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 17:21:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHZnH-00076w-0n
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 17:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880AbcAHQVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 11:21:32 -0500
Received: from mout.gmx.net ([212.227.15.15]:61157 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755611AbcAHQVY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 11:21:24 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MNHqL-1aJWej1NJh-006sog; Fri, 08 Jan 2016 17:21:16
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452270051.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Fh8doN266VBYQWSmd3ijyZyQspmncxgGEd+XN9RYw7O9F1wdbGH
 UM0sP9tcjV5xhynr+holVgJUmFkVxT8nzCvSB3jYmhQW/fNWLtKbONNaRHbyp1X1u+/kbWM
 qDDFCNA/WwY1BHqd30kKjSq5jj55ZFSW2MO2ppnWIUXpapVVSSRGQwVn6CZh7aZ0xlrGmm0
 t8P7BbrcJ+k8XwUzKGBTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gt/85YagP7s=:PzvAuXa1mhkVCzW8ipg1iL
 +B5uaiW7VQ9ItOUG9aTjPfoVHAqjyNf36nMwkVP8sdXKYFzT8FgKIaYvfUGZu/CA1IpKNNyZO
 Uewcez3U4tZB+A8KIqcN8a9J7n2C3N4sQGANpiJJHyQwmV/PrmR1FR9gY4Tpvv6fEWE59l8Xk
 +1QCE0fki3ZL9/oDWFqqUzODjEVQ5xAC/+c7uQoihqTDOKzPfs7jy7uLu//DBjc545WtnBKPH
 EoP//aN9wfVIoghabSi7U6r4gxmhYbW55XNntj2bnTemc11GUGBMqMBUT6XdrT9QhSWHXRgru
 tFBl8LoCyL8Un2xLsa8uN4mccaMjviQU/fgZY0e8IHF77vTCvdrUVpgjOT2PjDMY3QX2i5AYZ
 VlvEp5VDCqhigFA4dnZK3JvP196gQx1ccpHjdUADAcjRifYDe/qdGkfR51MJ4iSf8/EFAuREm
 dT/5cb6HJZiIcxpc20V8sOpt5py7gCL7DaumqzxJnlGRTwslLDhAdlySkZC6wwKIAT8tvnxne
 e/kr+08xYp09tZ4XvYlrp7fwzeuW4NFpEkWvA79GoUJn9C3+PnV605eToFrC0OGvz3B3bchG/
 7kX8Haeijt9LIR6h7PS6huLlFGU3nUgSWBogRr67+R4y3A6WICsrtSCi4L0i3YuREO/JYDtjs
 s0NAsYxc2cO2gQ/MHOp2tvHF0UAzuxo5pxZFSGsRksxSWH/bBAN8vK5HyoFb8h/1fQvfuy2I+
 a7e6en3Fxhd4lwtegF0sctbrkz5tI9MbozNZqivJdfzJaSfcjk82iuqdiaitOrORcwPLNYlW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283566>

According to POSIX, basename("/path/") should return "path", not
"path/". Likewise, basename(NULL) and basename("abc") should both
return ".".

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
