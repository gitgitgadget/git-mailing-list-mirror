From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/2] Fix uninitialized variable in get_refs_via_rsync().
Date: Fri, 15 Jan 2010 00:28:59 +0100
Message-ID: <201001150029.00191.richard@nod.at>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 00:35:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVZEF-0001Q3-SB
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 00:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756952Ab0ANXfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 18:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757463Ab0ANXfs
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 18:35:48 -0500
Received: from a.ns.miles-group.at ([217.188.240.210]:51051 "EHLO
	radon.swed.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757008Ab0ANXfq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 18:35:46 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jan 2010 18:35:46 EST
Received: (qmail 4242 invoked by uid 89); 14 Jan 2010 23:29:03 -0000
Received: by simscan 1.3.1 ppid: 4234, pid: 4238, t: 0.0801s
         scanners: attach: 1.3.1 clamav: 0.92.1
/m: 
Received: from unknown (HELO raccoon.localnet) (richard@nod.at@212.183.103.98)
  by radon.swed.at with ESMTPA; 14 Jan 2010 23:29:02 -0000
User-Agent: KMail/1.12.4 (Linux/2.6.25.20-0.5-pae; KDE/4.3.4; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137038>

This fixes a crash when cloning via rsync://.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 transport.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/transport.c b/transport.c
index b5332c0..3b489b3 100644
--- a/transport.c
+++ b/transport.c
@@ -143,7 +143,7 @@ static const char *rsync_url(const char *url)
 static struct ref *get_refs_via_rsync(struct transport *transport, int 
for_push)
 {
 	struct strbuf buf = STRBUF_INIT, temp_dir = STRBUF_INIT;
-	struct ref dummy, *tail = &dummy;
+	struct ref dummy = {0}, *tail = &dummy;
 	struct child_process rsync;
 	const char *args[5];
 	int temp_dir_len;
-- 
1.6.5.7
