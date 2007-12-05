From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-cvsserver runs hooks/post-update
Date: Wed, 05 Dec 2007 02:59:12 -0800
Message-ID: <7v63zdtnjz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Dec 05 11:59:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzryZ-0008K1-O3
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 11:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbXLEK7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 05:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbXLEK7R
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 05:59:17 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:35219 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbXLEK7R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 05:59:17 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 7433C2F2;
	Wed,  5 Dec 2007 05:59:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 01F029A189;
	Wed,  5 Dec 2007 05:59:35 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67140>

Although we have introduced post-receive, we have not deprecated post-update
hook.  This adds support for it to emulate receive-pack better.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I'd like to have the updated cvsserver by 1.5.4-rc0 so I updated the
   series myself.  Ack, improvements, fixes?

 git-cvsserver.perl |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 11f5127..ecded3b 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1357,6 +1357,12 @@ sub req_ci
 		close $pipe || die "bad pipe: $! $?";
 	}
 
+	### Then hooks/post-update
+	$hook = $ENV{GIT_DIR}.'hooks/post-update';
+	if (-x $hook) {
+		system($hook, "refs/heads/$state->{module}");
+	}
+
     $updater->update();
 
     # foreach file specified on the command line ...
-- 
1.5.3.7-2134-g53f9
