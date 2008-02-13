From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] hash-object: don't rely on order of --stdin, -w arguments
Date: Wed, 13 Feb 2008 19:03:38 +0000
Message-ID: <20080213190338.7393.qmail@d70c5cbe18d4bd.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 20:04:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPMtg-0001uL-Nl
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 20:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756567AbYBMTDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 14:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754956AbYBMTDV
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 14:03:21 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:51565 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754666AbYBMTDU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 14:03:20 -0500
Received: (qmail 7394 invoked by uid 1000); 13 Feb 2008 19:03:38 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73811>

Fix 'git hash-object --stdin -w' to actually write the object, just as
'git hash-object -w --stdin' does.

Reported by Josh Triplett through
 http://bugs.debian.org/464432

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 hash-object.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hash-object.c b/hash-object.c
index 0a58f3f..ff60f0f 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -41,6 +41,7 @@ int main(int argc, char **argv)
 	const char *prefix = NULL;
 	int prefix_length = -1;
 	int no_more_flags = 0;
+	int hashstdin = 0;
 
 	git_config(git_default_config);
 
@@ -64,9 +65,8 @@ int main(int argc, char **argv)
 			}
 			else if (!strcmp(argv[i], "--help"))
 				usage(hash_object_usage);
-			else if (!strcmp(argv[i], "--stdin")) {
-				hash_stdin(type, write_object);
-			}
+			else if (!strcmp(argv[i], "--stdin"))
+				hashstdin = 1;
 			else
 				usage(hash_object_usage);
 		}
@@ -79,5 +79,7 @@ int main(int argc, char **argv)
 			no_more_flags = 1;
 		}
 	}
+	if (hashstdin)
+		hash_stdin(type, write_object);
 	return 0;
 }
-- 
1.5.4.1
