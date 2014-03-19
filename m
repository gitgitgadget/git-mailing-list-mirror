From: Hiroyuki Sano <sh19910711@gmail.com>
Subject: [PATCH v2 1/3][GSOC] diff: rename read_directory() to get_path_list()
Date: Wed, 19 Mar 2014 20:23:48 +0900
Message-ID: <1395228230-10189-1-git-send-email-sh19910711@gmail.com>
Cc: Hiroyuki Sano <sh19910711@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 12:24:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQEbc-0004QH-G6
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 12:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933773AbaCSLYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 07:24:16 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:43577 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932996AbaCSLYP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 07:24:15 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so8813238pab.38
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 04:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=yRtn+BDW8riKgyXbeYFIiSrA/45TWHgXtKXaK5OVIts=;
        b=cgg28AKrkPmh+StxN3n3II24yPoaOP6Ky78tPWrUMaLobmIPlEowbPt3+GC4pLKg4v
         8L4fOwx8laHSrSAqSLGMFtPajbdB7EzsS3wA6utuLJqjyKd2vKPAZ+vLwMQn6GEOSVfV
         WG3sBuyuGEEfQxORKP7nfbJZVAN8Uxx9qSfcx1gt5abShFe+S+C4h7Blr0lOD4IVVbrr
         DHSfpKh4WxN8FyfsqR1gZupuSlKBvvR8o5Wk3mXv7k9tH9pTOt90b/il0tuZuHWcX4wu
         g7oFmL/9ji91+boEElrbj+dUj28PTfAxgBZzqRm7p4ssDeXObgBIB8QHq4rytwT6m+hp
         L1Rw==
X-Received: by 10.68.238.201 with SMTP id vm9mr39482382pbc.18.1395228255285;
        Wed, 19 Mar 2014 04:24:15 -0700 (PDT)
Received: from localhost (ntfkok023001.fkok.nt.adsl.ppp.infoweb.ne.jp. [218.217.179.1])
        by mx.google.com with ESMTPSA id my6sm61391704pbc.36.2014.03.19.04.24.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Mar 2014 04:24:14 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244435>

Including "dir.h" in "diff-no-index.c", it causes a compile error, because
the same name function read_directory() is declared globally in "dir.h".

This change is to avoid conflicts as above.

Signed-off-by: Hiroyuki Sano <sh19910711@gmail.com>
---
 diff-no-index.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 8e10bff..20b6a8a 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -16,7 +16,7 @@
 #include "builtin.h"
 #include "string-list.h"
 
-static int read_directory(const char *path, struct string_list *list)
+static int get_path_list(const char *path, struct string_list *list)
 {
 	DIR *dir;
 	struct dirent *e;
@@ -107,9 +107,9 @@ static int queue_diff(struct diff_options *o,
 		int i1, i2, ret = 0;
 		size_t len1 = 0, len2 = 0;
 
-		if (name1 && read_directory(name1, &p1))
+		if (name1 && get_path_list(name1, &p1))
 			return -1;
-		if (name2 && read_directory(name2, &p2)) {
+		if (name2 && get_path_list(name2, &p2)) {
 			string_list_clear(&p1, 0);
 			return -1;
 		}
-- 
1.9.0
