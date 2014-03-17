From: Hiroyuki Sano <sh19910711@gmail.com>
Subject: [PATCH 1/3][GSOC] diff: rename read_directory() to get_directory_list()
Date: Tue, 18 Mar 2014 06:30:23 +0900
Message-ID: <1395091825-8330-1-git-send-email-sh19910711@gmail.com>
Cc: Hiroyuki Sano <sh19910711@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 22:30:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPf7K-0005B1-EA
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 22:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbaCQVah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 17:30:37 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:39711 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbaCQVag (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 17:30:36 -0400
Received: by mail-pb0-f53.google.com with SMTP id rp16so6260351pbb.12
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 14:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=RmbTRv8Os0o+dWYCyCa90QsSuoZAhgP9JWgiM2UW5/Q=;
        b=duK1zwLo7s1Kf5gtdlrRmFaCZT8gyv4yZD9wPmilUwwrmJ5DM1HptEtUa/UWyIzNR2
         gcuZM0eXFTgYY+5Xxnvp5693NXfnTW4hOLFemM7JThzdYkodxAOQ0pYhN3WKeWF5sO4w
         ZDWktqWD1wMi5SEi/r3m7Ppl7KVQGLLl/LC+Qv3/pubDu2DgMmO3dRK8fSoShrZaHn1v
         O6LjQ5HHKk5Mh1vhdLUXVROvDumPLmRclAWE8jbEHG8ki1z3VYoGbV+CnNn780SI8k81
         TSSEjj1xrnE+i+Lv3odX3wtmwArjgvRz1HpG1qqotQ/5YRLYdg5NPN5r125liHvHHt+s
         olYA==
X-Received: by 10.68.229.106 with SMTP id sp10mr28848522pbc.23.1395091835783;
        Mon, 17 Mar 2014 14:30:35 -0700 (PDT)
Received: from localhost (ntfkok023001.fkok.nt.adsl.ppp.infoweb.ne.jp. [218.217.179.1])
        by mx.google.com with ESMTPSA id ha11sm46175975pbd.17.2014.03.17.14.30.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Mar 2014 14:30:34 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244286>

Including "dir.h" in "diff-no-index.c", it causes a compile error, because
the same name function read_directory() is declared globally in "dir.h".

This change is to avoid conflicts as above.

Signed-off-by: Hiroyuki Sano <sh19910711@gmail.com>
---
 diff-no-index.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 8e10bff..1ed5c9d 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -16,7 +16,7 @@
 #include "builtin.h"
 #include "string-list.h"
 
-static int read_directory(const char *path, struct string_list *list)
+static int get_directory_list(const char *path, struct string_list *list)
 {
 	DIR *dir;
 	struct dirent *e;
@@ -107,9 +107,9 @@ static int queue_diff(struct diff_options *o,
 		int i1, i2, ret = 0;
 		size_t len1 = 0, len2 = 0;
 
-		if (name1 && read_directory(name1, &p1))
+		if (name1 && get_directory_list(name1, &p1))
 			return -1;
-		if (name2 && read_directory(name2, &p2)) {
+		if (name2 && get_directory_list(name2, &p2)) {
 			string_list_clear(&p1, 0);
 			return -1;
 		}
-- 
1.9.0
