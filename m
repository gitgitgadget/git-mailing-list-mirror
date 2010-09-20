From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 15/37] merge-recursive: Rename conflict_rename_rename*() for clarity
Date: Mon, 20 Sep 2010 02:28:48 -0600
Message-ID: <1284971350-30590-16-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:28:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxbjU-0005rH-B5
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871Ab0ITI2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:28:08 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:63516 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755828Ab0ITI2C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:02 -0400
Received: by mail-pz0-f46.google.com with SMTP id 34so1070478pzk.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+tJN12C/PGAYTlE9FMQ/t4l0HJC2aHLwHw8ApJX3Kso=;
        b=bFXGZr4Nru+fwsDcvtMcY948F+DIJetZ7dv9xycLn3ykru75/z13YyduIAcCsmBYr7
         w31CE/OtCXacdL/DNsvIfCRCmCsmGSC42xbY976bDZPViNZjiEpLU50PKVxme3HzuWGQ
         5ZGlbINGRgS1/vjLY4rU3MyHeF6rsr6uxzIjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Iu3ZCLBJsOMmrnJFZbzGYkdZlP4r8mtYNakoegWBgbVivIw8ZaUvfq5K8YZyt4GimO
         be+/IR4ko0cz3v9NyixY0/BZSARpZ1w19grcq1Ivt+dxA92uUQ6ui3nbZJUMP8I3Xy7u
         qFxxydeCZkSOj8HvZ7ucBn2ZdDztdSxYGG/xA=
Received: by 10.142.233.16 with SMTP id f16mr7333849wfh.339.1284971282297;
        Mon, 20 Sep 2010 01:28:02 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.00
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156570>

The names conflict_rename_rename and conflict_rename_rename_2 did not make
it clear what they were handling.  Since the first of these handles one
file being renamed in both branches to different files, while the latter
handles two different files being renamed to the same thing, add a little
'1to2' and '2to1' suffix on these and an explanatory comment to make their
intent clearer.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8f45cec..cc1ab92 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -731,12 +731,13 @@ static struct merge_file_info merge_file(struct merge_options *o,
 	return result;
 }
 
-static void conflict_rename_rename(struct merge_options *o,
-				   struct rename *ren1,
-				   const char *branch1,
-				   struct rename *ren2,
-				   const char *branch2)
+static void conflict_rename_rename_1to2(struct merge_options *o,
+					struct rename *ren1,
+					const char *branch1,
+					struct rename *ren2,
+					const char *branch2)
 {
+	/* One file was renamed in both branches, but to different names. */
 	char *del[2];
 	int delp = 0;
 	const char *ren1_dst = ren1->pair->two->path;
@@ -783,12 +784,13 @@ static void conflict_rename_dir(struct merge_options *o,
 	free(new_path);
 }
 
-static void conflict_rename_rename_2(struct merge_options *o,
-				     struct rename *ren1,
-				     const char *branch1,
-				     struct rename *ren2,
-				     const char *branch2)
+static void conflict_rename_rename_2to1(struct merge_options *o,
+					struct rename *ren1,
+					const char *branch1,
+					struct rename *ren2,
+					const char *branch2)
 {
+	/* Two files were renamed to the same thing. */
 	char *new_path1 = unique_path(o, ren1->pair->two->path, branch1);
 	char *new_path2 = unique_path(o, ren2->pair->two->path, branch2);
 	output(o, 1, "Renaming %s to %s and %s to %s instead",
@@ -890,7 +892,7 @@ static int process_renames(struct merge_options *o,
 					update_file(o, 0, ren1->pair->one->sha1,
 						    ren1->pair->one->mode, src);
 				}
-				conflict_rename_rename(o, ren1, branch1, ren2, branch2);
+				conflict_rename_rename_1to2(o, ren1, branch1, ren2, branch2);
 			} else {
 				struct merge_file_info mfi;
 				remove_file(o, 1, ren1_src, 1);
@@ -1005,7 +1007,7 @@ static int process_renames(struct merge_options *o,
 				       "Rename %s->%s in %s",
 				       ren1_src, ren1_dst, branch1,
 				       ren2->pair->one->path, ren2->pair->two->path, branch2);
-				conflict_rename_rename_2(o, ren1, branch1, ren2, branch2);
+				conflict_rename_rename_2to1(o, ren1, branch1, ren2, branch2);
 			} else
 				try_merge = 1;
 
-- 
1.7.3.271.g16009
