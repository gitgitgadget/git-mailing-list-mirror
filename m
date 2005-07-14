From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Document two pack push-pull protocols.
Date: Wed, 13 Jul 2005 20:21:54 -0700
Message-ID: <7v64vem5rh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 05:22:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsuIW-0007ZC-AN
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 05:22:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbVGNDV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 23:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbVGNDV5
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 23:21:57 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:27859 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262872AbVGNDV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 23:21:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050714032155.SIH1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 13 Jul 2005 23:21:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This documents the two pack push-pull protocols used by the
smart upload-fetch/clone and send/receive commands.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

There currently are these two pack push-pull protocols used for
different purposes.  Maybe you invented another today?  I have
not looked beyond your log message.

 Documentation/pack-protocol.txt |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/pack-protocol.txt

3a74ad8bd10e958ddbd4d432ad3140abc5464229
diff --git a/Documentation/pack-protocol.txt b/Documentation/pack-protocol.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/pack-protocol.txt
@@ -0,0 +1,38 @@
+There are two Pack push-pull protocols.
+
+upload-pack (S) | fetch/clone-pack (C) protocol:
+
+	# Tell the puller what commits we have and what their names are
+	S: SHA1 name
+	S: ...
+	S: SHA1 name
+	S: # flush -- it's your turn
+	# Tell the pusher what commits we want, and what we have
+	C: want name
+	C: ..
+	C: want name
+	C: have SHA1
+	C: have SHA1
+	C: ...
+	C: # flush -- occasionally ask "had enough?"
+	S: NAK
+	C: have SHA1
+	C: ...
+	C: have SHA1
+	S: ACK
+	C: done
+	S: XXXXXXX -- packfile contents.
+
+send-pack | receive-pack protocol.
+
+	# Tell the pusher what commits we have and what their names are
+	C: SHA1 name
+	C: ...
+	C: SHA1 name
+	C: # flush -- it's your turn
+	# Tell the puller what the pusher has
+	S: old-SHA1 new-SHA1 name
+	S: old-SHA1 new-SHA1 name
+	S: ...
+	S: # flush -- done with the list
+	S: XXXXXXX --- packfile contents.
