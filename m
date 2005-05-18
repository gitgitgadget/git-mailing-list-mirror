From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/1] Diff-helper update
Date: Tue, 17 May 2005 23:28:07 -0700
Message-ID: <7v3bslqc94.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pasky@ucw.cz
X-From: git-owner@vger.kernel.org Wed May 18 08:28:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYI21-0005me-VT
	for gcvg-git@gmane.org; Wed, 18 May 2005 08:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVERG2Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 02:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVERG2Q
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 02:28:16 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:22766 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261979AbVERG2J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2005 02:28:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050518062808.EALT26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 May 2005 02:28:08 -0400
To: torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is just a cover letter but the next patch implements the
rename detection I told you about.

The output from the patched version is attached at the end of
this message as a demonstration.

My plan is to get the documentation and the framework in place
with this patch first.  The basic strategy is to hold created
and deleted files while we parse the incoming diff-tree output,
and match them up at the end, looking for usefully similar pair.

The similarity evaluator included in this round of patch detects
exact renames only, which is not very useful in practice, but
that would be improved in the later round.  It will probably be
done with the same deltify code Nico is using.

$ git-diff-tree -r \
    13ab4462d2aefb252d7c916bd537151856b7c967 \
    99665af5c0be0fe4319b39183e84917993153576 | ./git-diff-helper -r
diff -git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -45,7 +45,7 @@ with a '-p' option, they do not produce 
 instead they produce a patch file.
 ...
diff -git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -17,7 +17,7 @@ extern void diff_change(unsigned mode1, 
 
 extern void diff_unmerge(const char *path);
 
-/* These are for diff-tree-helper */
+/* These are for diff-helper */
 
 struct diff_spec {
 	unsigned char blob_sha1[20];
diff -git a/diff-tree-helper.c b/diff-helper.c
rename old diff-tree-helper.c
rename new diff-helper.c
diff -git a/Documentation/git-diff-tree-helper.txt b/Documentation/git-diff-helper.txt
rename old Documentation/git-diff-tree-helper.txt
rename new Documentation/git-diff-helper.txt


