From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/5] Make test-path-utils more robust against incorrect use
Date: Sat,  7 Feb 2009 16:08:27 +0100
Message-ID: <1234019311-6449-2-git-send-email-j6t@kdbg.org>
References: <498CAF73.6050409@lsrfire.ath.cx>
 <1234019311-6449-1-git-send-email-j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: rene.scharfe@lsrfire.ath.cx
X-From: git-owner@vger.kernel.org Sat Feb 07 16:17:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVovW-0006PA-AC
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 16:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbZBGPPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 10:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752358AbZBGPPf
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 10:15:35 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:39643 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbZBGPPd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 10:15:33 -0500
Received: from localhost.localdomain (unknown [93.83.142.38])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 58E4310A715;
	Sat,  7 Feb 2009 16:08:32 +0100 (CET)
X-Mailer: git-send-email 1.6.1.297.g9b01e
In-Reply-To: <1234019311-6449-1-git-send-email-j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108856>

Previously, this test utility happily returned with exit code 0 if garbage
was thrown at it. Now it reports failure if an unknown function name was
given on the command line.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 test-path-utils.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/test-path-utils.c b/test-path-utils.c
index 2c0f5a3..7e6fc8d 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -7,6 +7,7 @@ int main(int argc, char **argv)
 		int rv = normalize_absolute_path(buf, argv[2]);
 		assert(strlen(buf) == rv);
 		puts(buf);
+		return 0;
 	}
 
 	if (argc >= 2 && !strcmp(argv[1], "make_absolute_path")) {
@@ -15,12 +16,16 @@ int main(int argc, char **argv)
 			argc--;
 			argv++;
 		}
+		return 0;
 	}
 
 	if (argc == 4 && !strcmp(argv[1], "longest_ancestor_length")) {
 		int len = longest_ancestor_length(argv[2], argv[3]);
 		printf("%d\n", len);
+		return 0;
 	}
 
-	return 0;
+	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
+		argv[1] ? argv[1] : "(there was none)");
+	return 1;
 }
-- 
1.6.1.297.g9b01e
