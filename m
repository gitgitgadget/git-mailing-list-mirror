From: Brian Bourn <ba.bourn@gmail.com>
Subject: [PATCH v2 1/2] [GSoC] diff: rename read_directory()
Date: Wed, 19 Mar 2014 02:29:37 -0400
Message-ID: <1395210578-1532-1-git-send-email-ba.bourn@gmail.com>
Cc: Brian Bourn <ba.bourn@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 07:29:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQA0i-0003h1-KF
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 07:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbaCSG3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 02:29:52 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:62053 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbaCSG3v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 02:29:51 -0400
Received: by mail-ig0-f174.google.com with SMTP id h18so10847998igc.1
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 23:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=hCx2bMbNDn0nYpMdoBVv3ibuU9Yp5tsTeRVzkxtoaGM=;
        b=NHFwSYuKSaPI4BhqQGgAJ7hpXmmnGX2wfvfiLYU/Ms/d3nMaqGpgLcAh1csbm0p/0U
         xCCky9LJ3HKzDk7FAaM7LW2qt0g8yuk1KnBKG3DTMt94yvmO7/FYM0IJ3EKMVUfqY9YW
         ZMiHUxncL96VmBaXEjd0Zen516yg82NYLOyfopu3vB7tZrsQq6Rxu9+qMNVW1WL5EbJY
         SP9oEKKFkKnrj9NPr5pWNnpBizSU1c+iH7riNK/7AG2jSOGef2/KuG222Y/zJD3g9p85
         qyJL49N6DyD9sjG3V4It9zjd6q+25HTMvClpcjzSoZ9QxyJe2mBb62IXowNhPhWdUBdq
         191Q==
X-Received: by 10.43.156.18 with SMTP id lk18mr244724icc.77.1395210591116;
        Tue, 18 Mar 2014 23:29:51 -0700 (PDT)
Received: from arch.hil-sldcohx.den.wayport.net ([50.95.219.56])
        by mx.google.com with ESMTPSA id y9sm31313024igl.7.2014.03.18.23.29.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Mar 2014 23:29:50 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244412>

From: Brian Bourn <ba.bourn@gmail.com>

It is desirable to replace manual checking of "." or ".."
in diff-no-index.c with is_dot_or_dotdot(), which is defined
in dir.h. However, dir.h declares a read_directory which conflicts
with a (different) static read_directory() defined in
in diff-no-index.c. As a preparatory step, rename the local
read_directory() to avoid the collision

Signed-off-by: Brian Bourn <ba.bourn@gmail.com>
---
Part 1 of my GSoC submission
 diff-no-index.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 8e10bff..ec51106 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -16,7 +16,7 @@
 #include "builtin.h"
 #include "string-list.h"
 
-static int read_directory(const char *path, struct string_list *list)
+static int read_directory_contents(const char *path, struct string_list *list)
 {
 	DIR *dir;
 	struct dirent *e;
@@ -107,9 +107,9 @@ static int queue_diff(struct diff_options *o,
 		int i1, i2, ret = 0;
 		size_t len1 = 0, len2 = 0;
 
-		if (name1 && read_directory(name1, &p1))
+		if (name1 && read_directory_contents(name1, &p1))
 			return -1;
-		if (name2 && read_directory(name2, &p2)) {
+		if (name2 && read_directory_contents(name2, &p2)) {
 			string_list_clear(&p1, 0);
 			return -1;
 		}
-- 
1.9.0
