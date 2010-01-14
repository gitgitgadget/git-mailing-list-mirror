From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/18] rebase -i: Make the condition for an "if" more transparent
Date: Thu, 14 Jan 2010 06:54:40 +0100
Message-ID: <aa37ee8a68d460df172b23b4999fbe4ce7d77c1e.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 06:56:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVIgj-0002Vo-13
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755577Ab0ANFz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 00:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755308Ab0ANFzW
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:55:22 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58583 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755458Ab0ANFzR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:55:17 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (p4FC1EBF4.dip.t-dialin.net [79.193.235.244])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0E5t4bG001912;
	Thu, 14 Jan 2010 06:55:12 +0100
X-Mailer: git-send-email 1.6.6
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136945>

Test $no_ff separately rather than testing it indirectly by gluing it
onto a comparison of two SHA1s.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-rebase--interactive.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2e56e64..fba8fb6 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -166,7 +166,8 @@ pick_one () {
 	parent_sha1=$(git rev-parse --verify $sha1^) ||
 		die "Could not get the parent of $sha1"
 	current_sha1=$(git rev-parse --verify HEAD)
-	if test "$no_ff$current_sha1" = "$parent_sha1"; then
+	if test -z "$no_ff" -a "$current_sha1" = "$parent_sha1"
+	then
 		output git reset --hard $sha1
 		test "a$1" = a-n && output git reset --soft $current_sha1
 		sha1=$(git rev-parse --short $sha1)
-- 
1.6.6
