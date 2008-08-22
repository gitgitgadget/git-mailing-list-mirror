From: Jonathan del Strother <maillist@steelskies.com>
Subject: [PATCH] Revert "Convert output messages in merge-recursive to past tense."
Date: Fri, 22 Aug 2008 18:18:44 +0100
Message-ID: <1219425524-77545-1-git-send-email-maillist@steelskies.com>
Cc: spearce@spearce.org,
	Jonathan del Strother <maillist@steelskies.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 19:19:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWaIn-0003cO-Hj
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 19:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbYHVRSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 13:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752934AbYHVRSv
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 13:18:51 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:50682 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbYHVRSu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 13:18:50 -0400
Received: by qw-out-2122.google.com with SMTP id 3so49815qwe.37
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:sender;
        bh=649QQLmfWUtgtuKAaUOyjNUGQBWRsu56dcr9sWhSFbM=;
        b=wXPDoAvtu83NNhgNnwwlja8GDxKU8yfCHlHIXLuVKbU9vnCMvWa3RZkHtEUjG/M/0H
         CK4T1bwlCa0IlAQqT602jhpr5U394mRnukiF5IWYIEBsys5OzliHwRiIIghMMSD/NNq7
         abrK26RQCbU69tP3H+E1QW8RvSE0g9b3/6SsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:sender;
        b=r94Sbx7jsgOh1GE2S7QcAWu5gJXK6C71qxc62dyRCqCONGZQydRXpV3Nw+u9hEQzQy
         rXu2XlGubCXvZg6DcbjVCNE+8xUMaUbo/42/4tcUI6+ViIKSJYBpIOuu4FlCiv6eWjTc
         fesQ3znpcC0OfDXuRqv8dDraXUU1iUUiJjXtY=
Received: by 10.214.79.6 with SMTP id c6mr1785531qab.39.1219425528678;
        Fri, 22 Aug 2008 10:18:48 -0700 (PDT)
Received: from localhost ( [89.105.122.147])
        by mx.google.com with ESMTPS id 26sm3921240qwa.8.2008.08.22.10.18.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Aug 2008 10:18:47 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.6.gc667.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93330>

Now that the progress meter is gone, merge messages make more sense when presented in present tense

This reverts commit 89f40be294363ce4d14ed6931a65561a4e8e9140.

Conflicts:

	builtin-merge-recursive.c
---

I was confused by the output of git-merge recently - you typically get something like this:

  Auto-merged foo.txt
  CONFLICT (content): Merge conflict in foo.txt
  Recorded preimage for 'foo.txt'
  Automatic merge failed; fix conflicts and then commit the result.

The first line of which makes it sounds like it's already managed to merge successfully.
There used to be a progress meter just above this, in the context of which the past tense might make sense.
Now that that meter is gone (ad57cbca61), present tense seems more natural.


 builtin-merge-recursive.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 43e55bf..dfb363e 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -729,13 +729,13 @@ static void conflict_rename_rename(struct rename *ren1,
 	const char *dst_name2 = ren2_dst;
 	if (string_list_has_string(&current_directory_set, ren1_dst)) {
 		dst_name1 = del[delp++] = unique_path(ren1_dst, branch1);
-		output(1, "%s is a directory in %s added as %s instead",
+		output(1, "%s is a directory in %s adding as %s instead",
 		       ren1_dst, branch2, dst_name1);
 		remove_file(0, ren1_dst, 0);
 	}
 	if (string_list_has_string(&current_directory_set, ren2_dst)) {
 		dst_name2 = del[delp++] = unique_path(ren2_dst, branch2);
-		output(1, "%s is a directory in %s added as %s instead",
+		output(1, "%s is a directory in %s adding as %s instead",
 		       ren2_dst, branch1, dst_name2);
 		remove_file(0, ren2_dst, 0);
 	}
@@ -760,7 +760,7 @@ static void conflict_rename_dir(struct rename *ren1,
 				const char *branch1)
 {
 	char *new_path = unique_path(ren1->pair->two->path, branch1);
-	output(1, "Renamed %s to %s instead", ren1->pair->one->path, new_path);
+	output(1, "Renaming %s to %s instead", ren1->pair->one->path, new_path);
 	remove_file(0, ren1->pair->two->path, 0);
 	update_file(0, ren1->pair->two->sha1, ren1->pair->two->mode, new_path);
 	free(new_path);
@@ -773,7 +773,7 @@ static void conflict_rename_rename_2(struct rename *ren1,
 {
 	char *new_path1 = unique_path(ren1->pair->two->path, branch1);
 	char *new_path2 = unique_path(ren2->pair->two->path, branch2);
-	output(1, "Renamed %s to %s and %s to %s instead",
+	output(1, "Renaming %s to %s and %s to %s instead",
 	       ren1->pair->one->path, new_path1,
 	       ren2->pair->one->path, new_path2);
 	remove_file(0, ren1->pair->two->path, 0);
@@ -887,10 +887,10 @@ static int process_renames(struct string_list *a_renames,
 						 branch1,
 						 branch2);
 				if (mfi.merge || !mfi.clean)
-					output(1, "Renamed %s->%s", src, ren1_dst);
+					output(1, "Renaming %s->%s", src, ren1_dst);
 
 				if (mfi.merge)
-					output(2, "Auto-merged %s", ren1_dst);
+					output(2, "Auto-merging %s", ren1_dst);
 
 				if (!mfi.clean) {
 					output(1, "CONFLICT (content): merge conflict in %s",
@@ -924,14 +924,14 @@ static int process_renames(struct string_list *a_renames,
 
 			if (string_list_has_string(&current_directory_set, ren1_dst)) {
 				clean_merge = 0;
-				output(1, "CONFLICT (rename/directory): Renamed %s->%s in %s "
+				output(1, "CONFLICT (rename/directory): Rename %s->%s in %s "
 				       " directory %s added in %s",
 				       ren1_src, ren1_dst, branch1,
 				       ren1_dst, branch2);
 				conflict_rename_dir(ren1, branch1);
 			} else if (sha_eq(src_other.sha1, null_sha1)) {
 				clean_merge = 0;
-				output(1, "CONFLICT (rename/delete): Renamed %s->%s in %s "
+				output(1, "CONFLICT (rename/delete): Rename %s->%s in %s "
 				       "and deleted in %s",
 				       ren1_src, ren1_dst, branch1,
 				       branch2);
@@ -940,19 +940,19 @@ static int process_renames(struct string_list *a_renames,
 				const char *new_path;
 				clean_merge = 0;
 				try_merge = 1;
-				output(1, "CONFLICT (rename/add): Renamed %s->%s in %s. "
+				output(1, "CONFLICT (rename/add): Rename %s->%s in %s. "
 				       "%s added in %s",
 				       ren1_src, ren1_dst, branch1,
 				       ren1_dst, branch2);
 				new_path = unique_path(ren1_dst, branch2);
-				output(1, "Added as %s instead", new_path);
+				output(1, "Adding as %s instead", new_path);
 				update_file(0, dst_other.sha1, dst_other.mode, new_path);
 			} else if ((item = string_list_lookup(ren1_dst, renames2Dst))) {
 				ren2 = item->util;
 				clean_merge = 0;
 				ren2->processed = 1;
-				output(1, "CONFLICT (rename/rename): Renamed %s->%s in %s. "
-				       "Renamed %s->%s in %s",
+				output(1, "CONFLICT (rename/rename): Rename %s->%s in %s. "
+				       "Rename %s->%s in %s",
 				       ren1_src, ren1_dst, branch1,
 				       ren2->pair->one->path, ren2->pair->two->path, branch2);
 				conflict_rename_rename_2(ren1, branch1, ren2, branch2);
@@ -986,9 +986,9 @@ static int process_renames(struct string_list *a_renames,
 					output(3, "Skipped %s (merged same as existing)", ren1_dst);
 				else {
 					if (mfi.merge || !mfi.clean)
-						output(1, "Renamed %s => %s", ren1_src, ren1_dst);
+						output(1, "Renaming %s => %s", ren1_src, ren1_dst);
 					if (mfi.merge)
-						output(2, "Auto-merged %s", ren1_dst);
+						output(2, "Auto-merging %s", ren1_dst);
 					if (!mfi.clean) {
 						output(1, "CONFLICT (rename/modify): Merge conflict in %s",
 						       ren1_dst);
@@ -1039,7 +1039,7 @@ static int process_entry(const char *path, struct stage_data *entry,
 			/* Deleted in both or deleted in one and
 			 * unchanged in the other */
 			if (a_sha)
-				output(2, "Removed %s", path);
+				output(2, "Removing %s", path);
 			/* do not touch working file if it did not exist */
 			remove_file(1, path, !a_sha);
 		} else {
@@ -1086,12 +1086,12 @@ static int process_entry(const char *path, struct stage_data *entry,
 			const char *new_path = unique_path(path, add_branch);
 			clean_merge = 0;
 			output(1, "CONFLICT (%s): There is a directory with name %s in %s. "
-			       "Added %s as %s",
+			       "Adding %s as %s",
 			       conf, path, other_branch, path, new_path);
 			remove_file(0, path, 0);
 			update_file(0, sha, mode, new_path);
 		} else {
-			output(2, "Added %s", path);
+			output(2, "Adding %s", path);
 			update_file(1, sha, mode, path);
 		}
 	} else if (a_sha && b_sha) {
@@ -1105,7 +1105,7 @@ static int process_entry(const char *path, struct stage_data *entry,
 			reason = "add/add";
 			o_sha = (unsigned char *)null_sha1;
 		}
-		output(2, "Auto-merged %s", path);
+		output(2, "Auto-merging %s", path);
 		o.path = a.path = b.path = (char *)path;
 		hashcpy(o.sha1, o_sha);
 		o.mode = o_mode;
-- 
1.6.0.6.gc667.dirty
