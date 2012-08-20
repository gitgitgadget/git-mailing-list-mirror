From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v5 06/16] Add documentation for the 'bidi-import' capability of remote-helpers
Date: Mon, 20 Aug 2012 23:52:12 +0200
Message-ID: <1345499542-15536-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345499542-15536-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 23:53:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Zuu-0008V9-Md
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 23:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755632Ab2HTVx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 17:53:27 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35819 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755743Ab2HTVxP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 17:53:15 -0400
Received: by wgbfm10 with SMTP id fm10so3842056wgb.1
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 14:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SLiBTLOHDAbS2snbFelZJoSxoNeDEVOTPzDwQ4rPcu4=;
        b=gfw1g0Xx0Ah+IAlw3MXeEscbV73dU8AQH0nAZ4NAkwGc3+4w6qsiPwhUQpVSWIm+ba
         F5wjyN00pbkZw1BLDo4VIdPZ08/hj+Jd96Oaa/2vkrAxl0xGG23BE4BjkzpWHYOudAUA
         PQT4ecVBnk1SsFDJrOg6nzQX4IQMH90TgGY/5AapTOEgI3AQL3RZOqE3vGwapPV0tCfu
         bQJv0GsPkNRnyMA0CxYWefnLPRS36MuhA/BSW+MiVpz/X+caBbjQ8dRJS3JT9cSEZKcI
         cckexwhu9/EtWdmW0eM303+8CgmxXHgW+yeHK3qv5sImJfi4WnyZHDAg0OCy3XvLXGmY
         GGfg==
Received: by 10.180.74.33 with SMTP id q1mr30872964wiv.4.1345499594015;
        Mon, 20 Aug 2012 14:53:14 -0700 (PDT)
Received: from flomedio.lan (91-115-90-54.adsl.highway.telekom.at. [91.115.90.54])
        by mx.google.com with ESMTPS id w7sm30196654wiz.0.2012.08.20.14.53.11
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 14:53:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345499542-15536-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203884>

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-remote-helpers.txt |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index f5836e4..5faa48e 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -98,6 +98,20 @@ advertised with this capability must cover all refs reported by
 the list command.  If no 'refspec' capability is advertised,
 there is an implied `refspec *:*`.
 
+'bidi-import'::
+	The fast-import commands 'cat-blob' and 'ls' can be used by remote-helpers
+    to retrieve information about blobs and trees that already exist in
+    fast-import's memory. This requires a channel from fast-import to the
+    remote-helper.
+    If it is advertised in addition to "import", git establishes a pipe from
+	fast-import to the remote-helper's stdin.
+	It follows that git and fast-import are both connected to the
+	remote-helper's stdin. Because git can send multiple commands to
+	the remote-helper it is required that helpers that use 'bidi-import'
+	buffer all 'import' commands of a batch before sending data to fast-import.
+    This is to prevent mixing commands and fast-import responses on the
+    helper's stdin.
+
 Capabilities for Pushing
 ~~~~~~~~~~~~~~~~~~~~~~~~
 'connect'::
@@ -286,7 +300,12 @@ terminated with a blank line. For each batch of 'import', the remote
 helper should produce a fast-import stream terminated by a 'done'
 command.
 +
-Supported if the helper has the "import" capability.
+Note that if the 'bidi-import' capability is used the complete batch
+sequence has to be buffered before starting to send data to fast-import
+to prevent mixing of commands and fast-import responses on the helper's
+stdin.
++
+Supported if the helper has the 'import' capability.
 
 'connect' <service>::
 	Connects to given service. Standard input and standard output
-- 
1.7.9.5
