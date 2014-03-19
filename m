From: David Kastrup <dak@gnu.org>
Subject: [PATCH] Bump core.deltaBaseCacheLimit to 128MiB
Date: Wed, 19 Mar 2014 10:13:39 +0100
Message-ID: <1395220419-4541-1-git-send-email-dak@gnu.org>
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 10:13:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQCZM-00037O-AT
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 10:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758111AbaCSJNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 05:13:46 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:46563 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757349AbaCSJNp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 05:13:45 -0400
Received: from localhost ([127.0.0.1]:45606 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WQCZE-00061y-14; Wed, 19 Mar 2014 05:13:44 -0400
Received: by lola (Postfix, from userid 1000)
	id A9312EAD28; Wed, 19 Mar 2014 10:13:43 +0100 (CET)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244423>

The default of 16MiB causes serious thrashing for large delta chains
combined with large files.
---
128MiB seems like a big bump, but the limit for files not getting
delta compressed at all is 512MiB and it would appear that they should
be a bit comparable.  It is hard to find good benchmarks here:
basically the best benchmark I found was git blame with
problematically large repositories compressed with the (old)
git-gc --aggressive settings, using not-yet-committed but presented
code (the current blame code spends so much time thrashing in other
places that the benchmark differences are less obvious).

Documentation/config.txt | 2 +-
 environment.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 73c8973..1b6950a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -484,7 +484,7 @@ core.deltaBaseCacheLimit::
 	to avoid unpacking and decompressing frequently used base
 	objects multiple times.
 +
-Default is 16 MiB on all platforms.  This should be reasonable
+Default is 128 MiB on all platforms.  This should be reasonable
 for all users/operating systems, except on the largest projects.
 You probably do not need to adjust this value.
 +
diff --git a/environment.c b/environment.c
index c3c8606..73ed670 100644
--- a/environment.c
+++ b/environment.c
@@ -37,7 +37,7 @@ int core_compression_seen;
 int fsync_object_files;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
-size_t delta_base_cache_limit = 16 * 1024 * 1024;
+size_t delta_base_cache_limit = 128 * 1024 * 1024;
 unsigned long big_file_threshold = 512 * 1024 * 1024;
 const char *pager_program;
 int pager_use_color = 1;
-- 
1.8.3.2
