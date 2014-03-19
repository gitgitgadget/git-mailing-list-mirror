From: Brian Bourn <ba.bourn@gmail.com>
Subject: [PATCH v3 1/2][GSoC] diff-no-index: rename read_directory()
Date: Wed, 19 Mar 2014 11:58:21 -0400
Message-ID: <1395244702-659-1-git-send-email-ba.bourn@gmail.com>
Cc: Brian Bourn <ba.bourn@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 16:58:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQItA-0003HX-7T
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 16:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759291AbaCSP6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 11:58:38 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:33753 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759279AbaCSP6g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 11:58:36 -0400
Received: by mail-oa0-f48.google.com with SMTP id m1so8512754oag.35
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=D5xX3MIx32NslKH1b00pPw6u0Jp1+GEMv4Pf8Og7Tmk=;
        b=dAbzyGBh1SxeZiBX7asUkseVZ8MMWeHubI8g6HDYqJQuHc+/MFEgAtYBZC16knRuiM
         dOEC5y8+8fiZ8IkPlNyiXuqv3ty06GTkQfhqCqohDn7sWgAEMTWXeewt5Ikra4XfJReT
         wunp9HvJoLIiAj+VTDIosLLmGun9D0ZkPDH70m0lE66wtQT4QOJjyI9+ela0bt0J/jpA
         5hlJ6IYM95myb/UdFc2eKAVRHZ1VpG7hcZ7zh19LFansivNrMnkG9j6Ou5fzDloQIHqp
         IKhMCDbUyS4k+Jnofy2QeWo7sKwGBwGsUtL/i5HwxLwK88AKCy8njwyZ7vZi+/yhV+5q
         71AQ==
X-Received: by 10.182.107.232 with SMTP id hf8mr1200268obb.75.1395244716283;
        Wed, 19 Mar 2014 08:58:36 -0700 (PDT)
Received: from localhost.localdomain (230.sub-70-196-198.myvzw.com. [70.196.198.230])
        by mx.google.com with ESMTPSA id m7sm38196053obo.7.2014.03.19.08.58.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Mar 2014 08:58:35 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244456>

It would be desirable to replace manual checking of "." or ".."
in diff-no-index.c with is_dot_or_dotdot(), which is defined
in dir.h, however, dir.h declares a read_directory() which conflicts
with a (different) static read_directory() defined
in diff-no-index.c. As a preparatory step, rename the local
read_directory() to avoid the collision.

Signed-off-by: Brian Bourn <ba.bourn@gmail.com>
---
Part 1 of my submission for GSoC
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
