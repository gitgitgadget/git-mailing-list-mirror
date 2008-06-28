From: Jochen Voss <voss@seehuhn.de>
Subject: [PATCH] avoid off-by-one error in run_upload_archive
Date: Sat, 28 Jun 2008 17:04:24 +0100
Message-ID: <20080628160424.GA27915@seehuhn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 28 18:51:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCddr-0004Wm-4g
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 18:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbYF1QuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 12:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752781AbYF1QuS
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 12:50:18 -0400
Received: from seehuhn.de ([80.68.93.199]:1194 "EHLO seehuhn.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752777AbYF1QuR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 12:50:17 -0400
X-Greylist: delayed 2749 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Jun 2008 12:50:17 EDT
Received: from vburmah.vpn.seehuhn.de ([10.98.27.6] helo=burmah.maths.warwick.ac.uk)
	by seehuhn.de with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <voss@seehuhn.de>)
	id 1KCcuW-0007Tu-Iv; Sat, 28 Jun 2008 17:04:24 +0100
Received: from voss by burmah.maths.warwick.ac.uk with local (Exim 4.69)
	(envelope-from <voss@seehuhn.de>)
	id 1KCcuW-0007Vi-6e; Sat, 28 Jun 2008 17:04:24 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86728>

Make sure that buf has enough space to store the trailing \0 of
the command line argument, too.

Signed-off-by: Jochen Voss <voss@seehuhn.de>
---
 builtin-upload-archive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index 48ae09e..371400d 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -30,7 +30,7 @@ static int run_upload_archive(int argc, const char **argv, const char *prefix)
 	if (argc != 2)
 		usage(upload_archive_usage);
 
-	if (strlen(argv[1]) > sizeof(buf))
+	if (strlen(argv[1]) + 1 > sizeof(buf))
 		die("insanely long repository name");
 
 	strcpy(buf, argv[1]); /* enter-repo smudges its argument */
-- 
1.5.3.7
