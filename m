From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] pack-objects: document --revs, --unpacked and --all.
Date: Tue, 12 Sep 2006 22:59:54 -0700
Message-ID: <7v7j08b92d.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vk64bnnxl.fsf@assigned-by-dhcp.cox.net>
	<ee3hac$n57$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 13 07:59:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNNmw-00078z-3b
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 07:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbWIMF7z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 01:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbWIMF7z
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 01:59:55 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:17079 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751583AbWIMF7y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 01:59:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060913055953.QSNI12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 Sep 2006 01:59:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Mhzj1V0041kojtg0000000
	Wed, 13 Sep 2006 01:59:43 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ee3hac$n57$1@sea.gmane.org> (Jakub Narebski's message of "Mon,
	11 Sep 2006 13:29:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26900>

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Clear enough?

 Documentation/git-pack-objects.txt |   21 ++++++++++++++++++++-
 builtin-pack-objects.c             |    2 +-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 4991f88..d4661dd 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git-pack-objects' [-q] [--no-reuse-delta] [--non-empty]
 	[--local] [--incremental] [--window=N] [--depth=N]
-	{--stdout | base-name} < object-list
+	[--revs [--unpacked | --all]*] [--stdout | base-name] < object-list
 
 
 DESCRIPTION
@@ -56,6 +56,24 @@ base-name::
 	Write the pack contents (what would have been written to
 	.pack file) out to the standard output.
 
+--revs::
+	Read the revision arguments from the standard input, instead of
+	individual object names.  The revision arguments are processed
+	the same way as gitlink:git-rev-list[1] with `--objects` flag
+	uses its `commit` arguments to build the list of objects it
+	outputs.  The objects on the resulting list are packed.
+
+--unpacked::
+	This implies `--revs`.  When processing the list of
+	revision arguments read from the standard input, limit
+	the objects packed to those that are not already packed.
+
+--all::
+	This implies `--revs`.  In addition to the list of
+	revision arguments read from the standard input, pretend
+	as if all refs under `$GIT_DIR/refs` are specifed to be
+	included.
+
 --window and --depth::
 	These two options affects how the objects contained in
 	the pack are stored using delta compression.  The
@@ -103,6 +121,7 @@ Documentation by Junio C Hamano
 
 See Also
 --------
+gitlink:git-rev-list[1]
 gitlink:git-repack[1]
 gitlink:git-prune-packed[1]
 
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 753dd9a..8d7a120 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -15,7 +15,7 @@ #include "list-objects.h"
 #include <sys/time.h>
 #include <signal.h>
 
-static const char pack_usage[] = "git-pack-objects [-q] [--no-reuse-delta] [--non-empty] [--local] [--incremental] [--window=N] [--depth=N] {--stdout | base-name} [--revs [--unpacked | --all]* <ref-list | <object-list]";
+static const char pack_usage[] = "git-pack-objects [-q] [--no-reuse-delta] [--non-empty] [--local] [--incremental] [--window=N] [--depth=N] [--revs [--unpacked | --all]*] [--stdout | base-name] <ref-list | <object-list]";
 
 struct object_entry {
 	unsigned char sha1[20];
-- 
1.4.2.g61af0
