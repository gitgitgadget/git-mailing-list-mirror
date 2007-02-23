From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH] git-show-ref --verify: Fail if called without a reference
Date: Fri, 23 Feb 2007 20:12:33 +0300
Message-ID: <20070223171232.GA3936@nomad.office.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 23 18:37:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKeMD-0000EQ-FW
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 18:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbXBWRhQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 12:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbXBWRhQ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 12:37:16 -0500
Received: from mh.altlinux.org ([217.16.24.5]:51508 "EHLO
	sendmail.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932459AbXBWRhP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 12:37:15 -0500
X-Greylist: delayed 1439 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Feb 2007 12:37:15 EST
Received: from nomad.office.altlinux.org (localhost.localdomain [127.0.0.1])
	by sendmail.altlinux.org (Postfix) with ESMTP id 2A3E7427801F
	for <git@vger.kernel.org>; Fri, 23 Feb 2007 20:13:12 +0300 (MSK)
Received: by nomad.office.altlinux.org (Postfix, from userid 501)
	id 4A773170D8; Fri, 23 Feb 2007 20:12:33 +0300 (MSK)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40454>

builtin-show-ref.c (cmd_show_ref): Fail if called with --verify option but
without a reference.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 builtin-show-ref.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index 853f13f..75211e6 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -221,9 +221,11 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 	}
 
 	if (verify) {
-		unsigned char sha1[20];
-
+		if (!pattern)
+			die("--verify requires a reference");
 		while (*pattern) {
+			unsigned char sha1[20];
+
 			if (!strncmp(*pattern, "refs/", 5) &&
 			    resolve_ref(*pattern, sha1, 1, NULL)) {
 				if (!quiet)
-- 
1.5.0.1.GIT
