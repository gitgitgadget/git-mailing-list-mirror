X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsserver: Avoid miscounting bytes in Perl v5.8.x
Date: Thu,  7 Dec 2006 16:38:50 +1300
Message-ID: <11654627303222-git-send-email-martin@catalyst.net.nz>
NNTP-Posting-Date: Thu, 7 Dec 2006 03:37:36 +0000 (UTC)
Cc: Martin Langhoff <martin@catalyst.net.nz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.1.g7923a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33545>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsA4i-0002op-FM for gcvg-git@gmane.org; Thu, 07 Dec
 2006 04:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968056AbWLGDhO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 22:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968077AbWLGDhO
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 22:37:14 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:57559 "EHLO
 mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S968056AbWLGDhM (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 22:37:12 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest) by
 mail1.catalyst.net.nz with esmtp (Exim 4.50) id 1GsA4L-0006my-Sl; Thu, 07 Dec
 2006 16:37:09 +1300
Received: from martin by mltest with local (Exim 3.36 #1 (Debian)) id
 1GsA5y-0005hb-00; Thu, 07 Dec 2006 16:38:50 +1300
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org

At some point between v5.6 and 5.8 Perl started to assume its input,
output and filehandles are UTF-8. This breaks the counting of bytes
for the CVS protocol, resulting in the client expecting less data
than we actually send, and storing truncated files.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>
---

This has gone unfixed for quite a while. I thought I had seen
a patch posted addressing it, but it may have been for something else.

In fact, our heavily patched gitweb.cgi has needed a similar patch
as well. Snapshot downloads were getting corrupted until we added
use bytes; there too. I'm not sure how current gitweb does it though...

---
 git-cvsserver.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index ca519b7..197014d 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -17,6 +17,7 @@
 
 use strict;
 use warnings;
+use bytes;
 
 use Fcntl;
 use File::Temp qw/tempdir tempfile/;
-- 
1.4.4.1.g7923a
