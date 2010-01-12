From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCHv2 1/3] lib-rebase: Provide clearer debugging info about what the editor did
Date: Tue, 12 Jan 2010 16:38:34 +0100
Message-ID: <a6ef19853c00263c2875026cb438ce46d3fcf950.1263310175.git.mhagger@alum.mit.edu>
References: <7vr5pw3pwp.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 16:39:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUiq8-0004Z3-5x
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 16:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863Ab0ALPjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 10:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865Ab0ALPjX
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 10:39:23 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:45196 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab0ALPjW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 10:39:22 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (ssh.berlin.jpk.com [212.222.128.135])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0CFd2FR019745;
	Tue, 12 Jan 2010 16:39:17 +0100
X-Mailer: git-send-email 1.6.6.140.ga53ad
In-Reply-To: <7vr5pw3pwp.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1263310175.git.mhagger@alum.mit.edu>
References: <cover.1263310175.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136726>

(For testing "rebase -i"): Output the "rebase -i" command script
before and after the edits, to make it clearer what the editor did.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/lib-rebase.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index f4dda02..0fce595 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -29,6 +29,7 @@ test -z "$EXPECT_COUNT" ||
 test -z "$FAKE_LINES" && exit
 grep -v '^#' < "$1" > "$1".tmp
 rm -f "$1"
+echo 'rebase -i script before editing:'
 cat "$1".tmp
 action=pick
 for line in $FAKE_LINES; do
@@ -36,12 +37,12 @@ for line in $FAKE_LINES; do
 	squash|fixup|edit|reword)
 		action="$line";;
 	*)
-		echo sed -n "${line}s/^pick/$action/p"
-		sed -n "${line}p" < "$1".tmp
 		sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
 		action=pick;;
 	esac
 done
+echo 'rebase -i script after editing:'
+cat "$1"
 EOF
 
 	test_set_editor "$(pwd)/fake-editor.sh"
-- 
1.6.6.140.ga53ad
