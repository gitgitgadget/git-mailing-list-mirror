From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fsck: --no-dangling omits "dangling object" information
Date: Tue, 28 Feb 2012 15:25:20 -0800
Message-ID: <7v7gz6y1zz.fsf_-_@alter.siamese.dyndns.org>
References: <20120226204357.GA26088@ecki>
 <7vty2ddzqj.fsf@alter.siamese.dyndns.org>
 <7vhayddxgp.fsf@alter.siamese.dyndns.org>
 <20120227191846.GB1600@sigill.intra.peff.net>
 <7vr4xg6pn2.fsf@alter.siamese.dyndns.org> <20120227211316.GA29081@ecki>
 <7vhayc55a7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 29 00:25:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2WQJ-0002Qb-Oz
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 00:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965880Ab2B1XZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 18:25:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42993 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965522Ab2B1XZX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 18:25:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B96D87A31;
	Tue, 28 Feb 2012 18:25:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=91BefXie+5u4JDAOYgGLQVtj1y0=; b=U0kvci
	0zCmvGuAbMVNP1ml2XOxDFlE9T2DLsAN97qw/QZftS0wKDS8OfoFK4yqgehubHsv
	cMKTpeJj9AiyjZw5Kaj5G8VI5Fi0qiF37ZbVtcCnogQ5kXUtA55vXT2ckhc7nsx7
	kc+Dr9isOlJ4iQajMHGcpWLy7eR+9WIfl55ZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BjDxSFJWKqz8qamKTWAneI2o/e92PjJ3
	g4O2dksEqfbOlnfxPKTFqGKCdvSEwtJTQRm7165rEii/wixRxG9od+7thGZmDrro
	kuwxYNBNvT+NUgasQfR2KeTjr2zrmWwThAyTYmXzS4XhLca5j0Ok8wEAdTvD74JG
	53mBiFVWgz4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B11207A30;
	Tue, 28 Feb 2012 18:25:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A60E77A2F; Tue, 28 Feb 2012
 18:25:21 -0500 (EST)
In-Reply-To: <7vhayc55a7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 27 Feb 2012 13:34:56 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7BD8BBBA-6263-11E1-8D35-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191794>

The default output from "fsck" is often overwhelmed by informational
message on dangling objects, especially if you do not repack often, and a
real error can easily be buried.

Add "--no-dangling" option to omit them, and update the user manual to
demonstrate its use.

Based on a patch by Clemens Buchacher, but reverted the part to change
the default to --no-dangling, which is unsuitable for the first patch.
The usual three-step procedure to break the backward compatibility over
time needs to happen on top of this, if we were to go in that direction.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I butchered Clemens's patch and added "--no-dangling", and reverted the
   part that flips the default.  I also took the authorship blame, as I do
   not share the final goal of fliping the default (yet), but our first
   steps should be in the same direction, which is this patch.

 Documentation/git-fsck.txt    |    7 ++++++-
 Documentation/git-repack.txt  |    2 +-
 Documentation/user-manual.txt |   15 +++++++--------
 builtin/fsck.c                |    7 +++++--
 t/t1450-fsck.sh               |    6 +-----
 5 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 6c47395..47e2f19 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
 	 [--[no-]full] [--strict] [--verbose] [--lost-found]
-	 [--[no-]progress] [<object>*]
+	 [--[no-]dangling] [--[no-]progress] [<object>*]
 
 DESCRIPTION
 -----------
@@ -30,6 +30,11 @@ index file, all SHA1 references in .git/refs/*, and all reflogs (unless
 	Print out objects that exist but that aren't reachable from any
 	of the reference nodes.
 
+--dangling::
+--no-dangling::
+	Print objects that exist but that are never 'directly' used (default).
+	`--no-dangling` can be used to squech this information from the output.
+
 --root::
 	Report root nodes.
 
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 40af321..4c1aff6 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -34,7 +34,7 @@ OPTIONS
 	Especially useful when packing a repository that is used
 	for private development. Use
 	with '-d'.  This will clean up the objects that `git prune`
-	leaves behind, but `git fsck --full` shows as
+	leaves behind, but `git fsck --full --dangling` shows as
 	dangling.
 +
 Note that users fetching over dumb protocols will have to fetch the
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index f13a846..6c7fee7 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1582,7 +1582,7 @@ Checking the repository for corruption
 
 The linkgit:git-fsck[1] command runs a number of self-consistency checks
 on the repository, and reports on any problems.  This may take some
-time.  The most common warning by far is about "dangling" objects:
+time.
 
 -------------------------------------------------
 $ git fsck
@@ -1597,9 +1597,11 @@ dangling tree b24c2473f1fd3d91352a624795be026d64c8841f
 ...
 -------------------------------------------------
 
-Dangling objects are not a problem.  At worst they may take up a little
-extra disk space.  They can sometimes provide a last-resort method for
-recovering lost work--see <<dangling-objects>> for details.
+You will see informational messages on dangling objects. They are objects
+that still exist in the repository but are no longer referenced by any of
+your branches, and can (and will) be removed after a while with "gc".
+You can run `git fsck --no-dangling` to supress these messages, and still
+view real errors.
 
 [[recovering-lost-changes]]
 Recovering lost changes
@@ -3295,15 +3297,12 @@ it is with linkgit:git-fsck[1]; this may be time-consuming.
 Assume the output looks like this:
 
 ------------------------------------------------
-$ git fsck --full
+$ git fsck --full --no-dangling
 broken link from    tree 2d9263c6d23595e7cb2a21e5ebbb53655278dff8
               to    blob 4b9458b3786228369c63936db65827de3cc06200
 missing blob 4b9458b3786228369c63936db65827de3cc06200
 ------------------------------------------------
 
-(Typically there will be some "dangling object" messages too, but they
-aren't interesting.)
-
 Now you know that blob 4b9458b3 is missing, and that the tree 2d9263c6
 points to it.  If you could find just one copy of that missing blob
 object, possibly in some other repository, you could move it into
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 8c479a7..67eb553 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -29,6 +29,7 @@ static int errors_found;
 static int write_lost_and_found;
 static int verbose;
 static int show_progress = -1;
+static int show_dangling = 1;
 #define ERROR_OBJECT 01
 #define ERROR_REACHABLE 02
 #define ERROR_PACK 04
@@ -221,8 +222,9 @@ static void check_unreachable_object(struct object *obj)
 	 * start looking at, for example.
 	 */
 	if (!obj->used) {
-		printf("dangling %s %s\n", typename(obj->type),
-		       sha1_to_hex(obj->sha1));
+		if (show_dangling)
+			printf("dangling %s %s\n", typename(obj->type),
+			       sha1_to_hex(obj->sha1));
 		if (write_lost_and_found) {
 			char *filename = git_path("lost-found/%s/%s",
 				obj->type == OBJ_COMMIT ? "commit" : "other",
@@ -614,6 +616,7 @@ static char const * const fsck_usage[] = {
 static struct option fsck_opts[] = {
 	OPT__VERBOSE(&verbose, "be verbose"),
 	OPT_BOOLEAN(0, "unreachable", &show_unreachable, "show unreachable objects"),
+	OPT_BOOL(0, "dangling", &show_dangling, "show dangling objects"),
 	OPT_BOOLEAN(0, "tags", &show_tags, "report tags"),
 	OPT_BOOLEAN(0, "root", &show_root, "report root nodes"),
 	OPT_BOOLEAN(0, "cache", &keep_cache_objects, "make index objects head nodes"),
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 5b8ebd8..5b79c51 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -27,12 +27,8 @@ test_expect_success 'loose objects borrowed from alternate are not missing' '
 		git init &&
 		echo ../../../.git/objects >.git/objects/info/alternates &&
 		test_commit C fileC one &&
-		git fsck >../out 2>&1
+		git fsck --no-dangling >../actual 2>&1
 	) &&
-	{
-		grep -v dangling out >actual ||
-		:
-	} &&
 	test_cmp empty actual
 '
 
-- 
1.7.9.2.344.g3e8c86
