From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v4 06/16] Add documentation for the 'bidi-import' capability of remote-helpers.
Date: Fri, 17 Aug 2012 22:25:47 +0200
Message-ID: <1345235157-702-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345235157-702-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 22:27:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2T8e-00061V-72
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 22:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758897Ab2HQU1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 16:27:01 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33589 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758887Ab2HQU0w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 16:26:52 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so3663336wgb.1
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 13:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NSUfOzkXV+6s6swqS4Po+ZJit6lDK0Rqb/7KIpvm8qo=;
        b=dKiT5u/usjYNheU18ynQZUJnxu2ELirRbFE7ekoVkq2Huz8OeQPzsSZLz5DZgl0/0+
         Zj6en2UvkdNXQff4megIm74sfJpnrN8v8fbGk83giL3VhxMrTOYlptR+UYb6EeLEjuYu
         aRbsrzXu8DFkSX8tOMvS0U1RBTJAURWPWI/GWjyNnj7/6lmFqentV7d3jof3BJgfFW/R
         sxiNYdCY5efX9i4lQjtYQgJqLSWpTjfY81LBh214iyXruoRc1l3GaXPW0/grKhZ32iEB
         sAiU9suHRHqEcE1G89gA1uUZ7R2SjBMaOxFYvexYaxj5hrxf1ROWiS/IgngIU/uCd8aW
         caGQ==
Received: by 10.180.82.230 with SMTP id l6mr7606618wiy.21.1345235212179;
        Fri, 17 Aug 2012 13:26:52 -0700 (PDT)
Received: from flobuntu.lan (91-115-81-15.adsl.highway.telekom.at. [91.115.81.15])
        by mx.google.com with ESMTPS id k2sm17372232wiz.7.2012.08.17.13.26.50
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 13:26:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345235157-702-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203648>

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
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
