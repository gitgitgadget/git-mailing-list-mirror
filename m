From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add --summary to git-format-patch by default
Date: Wed, 17 Jan 2007 13:51:44 -0800
Message-ID: <7vac0hqq33.fsf@assigned-by-dhcp.cox.net>
References: <7vk5zlqqum.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 17 22:51:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7IhB-0006Ql-Ch
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 22:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbXAQVvr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 16:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbXAQVvq
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 16:51:46 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:36031 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbXAQVvp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 16:51:45 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070117215145.QLSR29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Wed, 17 Jan 2007 16:51:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id CMs21W00V1kojtg0000000; Wed, 17 Jan 2007 16:52:02 -0500
To: git@vger.kernel.org
In-Reply-To: <7vk5zlqqum.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 17 Jan 2007 13:35:13 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37043>

This adds --summary output in addition to the --stat to the
output from git-format-patch by default.

I think additions, removals and filemode changes are rare but
notable events and always showing it makes sense.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * An alternative would be to give --summary whenever --stat is
   asked for _any_ diff family of commands, which might make
   sense but I suspect is going too far.  At least format-patch
   is a good place to add this since it allows accidental mode
   changes to be caught at the last minute before sending the
   message out to the public.

   Opinions?

diff --git a/builtin-log.c b/builtin-log.c
index 9453e6d..c32a1df 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -468,7 +468,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		die ("unrecognized argument: %s", argv[1]);
 
 	if (!rev.diffopt.output_format)
-		rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
+		rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY | DIFF_FORMAT_PATCH;
 
 	if (!output_directory)
 		output_directory = prefix;
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..master b/t/t4013/diff.format-patch_--attach_--stdout_initial..master
index b4745e1..e5ddd6f 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master
@@ -19,6 +19,7 @@ This is the second commit.
  file0   |    3 +++
  file2   |    3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
+ delete mode 100644 file2
 --------------g-i-t--v-e-r-s-i-o-n
 Content-Type: text/x-patch;
  name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
@@ -77,6 +78,7 @@ Content-Transfer-Encoding: 8bit
  dir/sub |    2 ++
  file1   |    3 +++
  2 files changed, 5 insertions(+), 0 deletions(-)
+ create mode 100644 file1
 --------------g-i-t--v-e-r-s-i-o-n
 Content-Type: text/x-patch;
  name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
@@ -126,6 +128,7 @@ Content-Transfer-Encoding: 8bit
  file0   |    3 +++
  file3   |    4 ++++
  3 files changed, 9 insertions(+), 0 deletions(-)
+ create mode 100644 file3
 --------------g-i-t--v-e-r-s-i-o-n
 Content-Type: text/x-patch;
  name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..master^ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
index a9d1cd3..d0dd19b 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
@@ -19,6 +19,7 @@ This is the second commit.
  file0   |    3 +++
  file2   |    3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
+ delete mode 100644 file2
 --------------g-i-t--v-e-r-s-i-o-n
 Content-Type: text/x-patch;
  name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
@@ -77,6 +78,7 @@ Content-Transfer-Encoding: 8bit
  dir/sub |    2 ++
  file1   |    3 +++
  2 files changed, 5 insertions(+), 0 deletions(-)
+ create mode 100644 file1
 --------------g-i-t--v-e-r-s-i-o-n
 Content-Type: text/x-patch;
  name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..side b/t/t4013/diff.format-patch_--attach_--stdout_initial..side
index 57b9d0b..67a95c5 100644
--- a/t/t4013/diff.format-patch_--attach_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..side
@@ -17,6 +17,7 @@ Content-Transfer-Encoding: 8bit
  file0   |    3 +++
  file3   |    4 ++++
  3 files changed, 9 insertions(+), 0 deletions(-)
+ create mode 100644 file3
 --------------g-i-t--v-e-r-s-i-o-n
 Content-Type: text/x-patch;
  name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
diff --git a/t/t4013/diff.format-patch_--stdout_initial..master b/t/t4013/diff.format-patch_--stdout_initial..master
index c33302e..8b88ca4 100644
--- a/t/t4013/diff.format-patch_--stdout_initial..master
+++ b/t/t4013/diff.format-patch_--stdout_initial..master
@@ -10,6 +10,7 @@ This is the second commit.
  file0   |    3 +++
  file2   |    3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
+ delete mode 100644 file2
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -53,6 +54,7 @@ Subject: [PATCH] Third
  dir/sub |    2 ++
  file1   |    3 +++
  2 files changed, 5 insertions(+), 0 deletions(-)
+ create mode 100644 file1
 
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
@@ -87,6 +89,7 @@ Subject: [PATCH] Side
  file0   |    3 +++
  file3   |    4 ++++
  3 files changed, 9 insertions(+), 0 deletions(-)
+ create mode 100644 file3
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
diff --git a/t/t4013/diff.format-patch_--stdout_initial..master^ b/t/t4013/diff.format-patch_--stdout_initial..master^
index 03d0f96..47a4b88 100644
--- a/t/t4013/diff.format-patch_--stdout_initial..master^
+++ b/t/t4013/diff.format-patch_--stdout_initial..master^
@@ -10,6 +10,7 @@ This is the second commit.
  file0   |    3 +++
  file2   |    3 ---
  3 files changed, 5 insertions(+), 3 deletions(-)
+ delete mode 100644 file2
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..8422d40 100644
@@ -53,6 +54,7 @@ Subject: [PATCH] Third
  dir/sub |    2 ++
  file1   |    3 +++
  2 files changed, 5 insertions(+), 0 deletions(-)
+ create mode 100644 file1
 
 diff --git a/dir/sub b/dir/sub
 index 8422d40..cead32e 100644
diff --git a/t/t4013/diff.format-patch_--stdout_initial..side b/t/t4013/diff.format-patch_--stdout_initial..side
index d10a465..e765088 100644
--- a/t/t4013/diff.format-patch_--stdout_initial..side
+++ b/t/t4013/diff.format-patch_--stdout_initial..side
@@ -9,6 +9,7 @@ Subject: [PATCH] Side
  file0   |    3 +++
  file3   |    4 ++++
  3 files changed, 9 insertions(+), 0 deletions(-)
+ create mode 100644 file3
 
 diff --git a/dir/sub b/dir/sub
 index 35d242b..7289e35 100644
