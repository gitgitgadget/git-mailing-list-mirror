From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] imap-send: properly error out if imap.host is not set in
	config
Date: Wed, 26 Mar 2008 18:05:17 +0000
Message-ID: <20080326180517.23968.qmail@945917b39a7083.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 19:06:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jea0b-0005ti-Li
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 19:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091AbYCZSFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 14:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754454AbYCZSFA
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 14:05:00 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:59138 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753505AbYCZSE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 14:04:59 -0400
Received: (qmail 23969 invoked by uid 1000); 26 Mar 2008 18:05:17 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78294>

If no imap host is specified in the git config, git imap-send used
to try to lookup a null pointer through gethostbyname(), causing a
segfault.  Since setting the imap.host variable is mandatory,
imap-send now properly fails with an explanatory error message.

The problem has been reported by picca through
 http://bugs.debian.org/472632

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 imap-send.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 10cce15..04afbc4 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1302,6 +1302,10 @@ main(int argc, char **argv)
 		fprintf( stderr, "no imap store specified\n" );
 		return 1;
 	}
+	if (!server.host) {
+		fprintf( stderr, "no imap host specified\n" );
+		return 1;
+	}
 
 	/* read the messages */
 	if (!read_message( stdin, &all_msgs )) {
-- 
1.5.4.4
