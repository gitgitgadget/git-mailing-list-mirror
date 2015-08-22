From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 2/3] archive-zip: use a local variable to store the creator
 version
Date: Sat, 22 Aug 2015 21:06:31 +0200
Message-ID: <55D8C837.6070601@web.de>
References: <20150811104056.16465.58131@localhost> <55CBA140.7050301@web.de>
 <20150813022545.30116.44787@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Johannes Schauer <josch@debian.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 21:06:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTE80-0002uV-OI
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 21:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbbHVTGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2015 15:06:52 -0400
Received: from mout.web.de ([212.227.15.14]:50688 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753250AbbHVTGv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2015 15:06:51 -0400
Received: from [192.168.178.36] ([79.253.186.87]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MUnuu-1ZEuFZ47AK-00Y9Qn; Sat, 22 Aug 2015 21:06:34
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <20150813022545.30116.44787@localhost>
X-Provags-ID: V03:K0:3l/JZzJkuuGHMsVuRl91IP2kW2Ps9GW63Kc/WGcEAUeC9uvHYgJ
 TGhF9p7MylOUzAgpkhwxXDGpAC/jVkZMREW2n5zEs3IRz/uiBp/3YVnvm3GQ2viVw+MAf+c
 UiFc89Y6qaPY8fTpWpZEvNJ1O4gfR4i3ndia5bPyNx4ZjJ+aW1/xkdeqnn7HgiWd1fP/bHV
 h2X1+GOcGOnhQQH+IvRww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FXLAK2dQ4GM=:Q1jYDKoXsA5iJVVRBXwwW+
 2QwyxKLvQn0YplFqZQjcbXCfsOU0JesH/016CUy5MQqtFZt2Ct4UJzquvBh6rw9VfAV7c0k0B
 3BYeR0t5vTrMOUTGUjQSK1vscRc+lhUGbgSpPJmiz81H2asGg6Fwx6GBWnyEqcpKkVSUxJdux
 5jsYFTY5okgUZwfr7to3rA+cAnH0Dg3On8Lzczgv+dMYuuv8kzYt3nuKO3GlrGsFakWvhISfk
 dEr7EBLmUqIQCXV9xj4CqsCfM/NT1pJfLZPY30tsn0VbP6WqpQnKWvVYFfOEbgZukD6ATTp7v
 MVOib2wDAlbN2gzasCPrH6I//WzW/j9G1FgCMlnBDn3iZOL4l9h1VSyd9KM0xFVm9E2MJwiLQ
 UqWFVYH9AxhXfCTUqkynz0nu/7UKsjZMzFfF5seK2BbqZ+zug3Krd2FyjKHF4OzDKrF4LiVTK
 ybBMUFP2Fk24EMUTcd/9sO8/GLpI5nMvJ1jUbnptOsLRz9lOKTe4OjAupP9r9S9ypQDy1dLXf
 161cwE2bQXXlYYI3HPmCn9mUUmNwKg/5Q3pmwkluky+XhzrU5gNS852qAy6OtnZSXD87lvodh
 maUKYxHDFdYM61463IPSwkhNHenyWxNkaMOhnE33Ice6bBu0y/mVY8KP/FTOknB4JUUE3pKDl
 hOAPBIWSBNJEpHFubHiZZl2tUrSvOIYaAI+77AF3ea/+KOo8rMX5sfCbjjU5qCYCyGa/TAGXp
 tA5QaKv2SETUmbBfY6O0EXC91riM+tXdB3TFLg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276394>

Use a simpler conditional right next to the code which makes a higher
creator version necessary -- namely symlink handling and support for
executable files -- instead of a long line with a ternary operator.
The resulting code has more lines but is simpler and allows reuse of
the value easily.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 archive-zip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index ae3d67f..2a76156 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -223,6 +223,7 @@ static int write_zip_entry(struct archiver_args *args,
 	unsigned long size;
 	int is_binary = -1;
 	const char *path_without_prefix = path + args->baselen;
+	unsigned int creator_version = 0;
 
 	crc = crc32(0, NULL, 0);
 
@@ -251,6 +252,8 @@ static int write_zip_entry(struct archiver_args *args,
 		method = 0;
 		attr2 = S_ISLNK(mode) ? ((mode | 0777) << 16) :
 			(mode & 0111) ? ((mode) << 16) : 0;
+		if (S_ISLNK(mode) || (mode & 0111))
+			creator_version = 0x0317;
 		if (S_ISREG(mode) && args->compression_level != 0 && size > 0)
 			method = 8;
 
@@ -303,8 +306,7 @@ static int write_zip_entry(struct archiver_args *args,
 	}
 
 	copy_le32(dirent.magic, 0x02014b50);
-	copy_le16(dirent.creator_version,
-		S_ISLNK(mode) || (S_ISREG(mode) && (mode & 0111)) ? 0x0317 : 0);
+	copy_le16(dirent.creator_version, creator_version);
 	copy_le16(dirent.version, 10);
 	copy_le16(dirent.flags, flags);
 	copy_le16(dirent.compression_method, method);
-- 
2.5.0
