From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2 v2] Documentation/git-remote-helpers: explain how import works with multiple refs
Date: Thu,  1 Sep 2011 18:49:37 +0200
Message-ID: <1314895778-17482-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqd3fk1cq5.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 01 18:50:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzASm-0002yQ-37
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 18:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131Ab1IAQty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 12:49:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45397 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342Ab1IAQtx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 12:49:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p81Gn16N004432
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 1 Sep 2011 18:49:01 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1QzASX-00034X-Vc; Thu, 01 Sep 2011 18:49:46 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1QzASX-0004Yd-TH; Thu, 01 Sep 2011 18:49:45 +0200
X-Mailer: git-send-email 1.7.7.rc0.75.g56f27
In-Reply-To: <vpqd3fk1cq5.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 01 Sep 2011 18:49:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p81Gn16N004432
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1315500544.66449@Hn4Q6iJVG865YQGNi8C3cQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180543>

This is important for two reasons:

* when two "import" lines follow each other, only one "done" command
  should be issued in the fast-import stream, not one per "import".

* The blank line terminating an import command should not be confused
  with the one terminating the sequence of commands.

While we're there, illustrate the corresponding explanation for push
batches with an example.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
No real change since v1, but resending together with the other to make
it a "patch serie" ;-)

 Documentation/git-remote-helpers.txt |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 760b164..526fc6a 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -241,7 +241,22 @@ Supported if the helper has the "fetch" capability.
 'push' +<src>:<dst>::
 	Pushes the given local <src> commit or branch to the
 	remote branch described by <dst>.  A batch sequence of
-	one or more push commands is terminated with a blank line.
+	one or more 'push' commands is terminated with a blank line
+	(if there is only one reference to push, a single 'push' command
+	is followed by a blank line). For example, the following would
+	be two batches of 'push', the first asking the remote-helper
+	to push the local ref 'master' to the remote ref 'master' and
+	the local 'HEAD' to the remote 'branch', and the second
+	asking to push ref 'foo' to ref 'bar' (forced update requested
+	by the '+').
++
+------------
+push refs/heads/master:refs/heads/master
+push HEAD:refs/heads/branch
+\n
+push +refs/heads/foo:refs/heads/bar
+\n
+------------
 +
 Zero or more protocol options may be entered after the last 'push'
 command, before the batch's terminating blank line.
@@ -266,6 +281,11 @@ Supported if the helper has the "push" capability.
 Especially useful for interoperability with a foreign versioning
 system.
 +
+Just like 'push', a batch sequence of one or more 'import' is
+terminated with a blank line. For each batch of 'import', the remote
+helper should produce a fast-import stream terminated by a 'done'
+command.
++
 Supported if the helper has the "import" capability.
 
 'connect' <service>::
-- 
1.7.7.rc0.75.g56f27
