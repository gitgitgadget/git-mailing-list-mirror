X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] repacked packs should be read-only
Date: Wed, 13 Dec 2006 16:25:26 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612131620280.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 13 Dec 2006 22:25:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 17:25:28 EST
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34241>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GucXc-0000Wa-HV for gcvg-git@gmane.org; Wed, 13 Dec
 2006 23:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751633AbWLMWZ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 17:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbWLMWZ3
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 17:25:29 -0500
Received: from relais.videotron.ca ([24.201.245.36]:31972 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751633AbWLMWZ2 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 17:25:28 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JA800FNGE6EJD30@VL-MO-MR001.ip.videotron.ca> for git@vger.kernel.org; Wed,
 13 Dec 2006 16:25:26 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

... just like the other pack creating tools do.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/git-repack.sh b/git-repack.sh
index f150a55..067898f 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -67,6 +67,8 @@ name=$(git-pack-objects --non-empty --all $args </dev/null "$PACKTMP") ||
 if [ -z "$name" ]; then
 	echo Nothing new to pack.
 else
+	chmod a-w "$PACKTMP-$name.pack"
+	chmod a-w "$PACKTMP-$name.idx"
 	if test "$quiet" != '-q'; then
 	    echo "Pack pack-$name created."
