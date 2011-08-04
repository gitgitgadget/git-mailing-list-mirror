From: Jon Jensen <jon@endpoint.com>
Subject: [PATCH] Add option hooks.diffopts to customize change summary in
 post-receive-email
Date: Wed, 3 Aug 2011 21:36:08 -0600 (MDT)
Message-ID: <alpine.DEB.2.02.1108032117240.12142@ybpnyubfg6.ybpnyqbznva6>
References: <alpine.DEB.2.02.1108022132230.3386@ybpnyubfg6.ybpnyqbznva6> <7vr552ba4e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 05:36:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoojK-0001Ks-B0
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 05:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975Ab1HDDgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 23:36:11 -0400
Received: from mail.endcrypt.com ([74.205.105.202]:43301 "EHLO
	mail.endcrypt.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574Ab1HDDgK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 23:36:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.endcrypt.com (Postfix) with ESMTP id 3346930E27;
	Thu,  4 Aug 2011 03:36:09 +0000 (UTC)
In-Reply-To: <7vr552ba4e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178664>

This makes it easy to customize the git diff-tree options, for example
to include -p to include inline diffs.

It defaults to the current options "--stat --summary --find-copies-harder"
and thus is backward-compatible.

Signed-off-by: Jon Jensen <jon@endpoint.com>
Improved-by: Junio C Hamano <gitster@pobox.com>
---

Thanks for the suggestion, Junio. It makes a lot of sense.

Jon


 contrib/hooks/post-receive-email |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 9c678e6..cd5664d 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -60,6 +60,11 @@
 #   email body. If not specified, there is no limit.
 #   Lines beyond the limit are suppressed and counted, and a final
 #   line is added indicating the number of suppressed lines.
+# hooks.diffopts
+#   Alternate options for the git diff-tree invocation that shows changes.
+#   Default is "--stat --summary --find-copies-harder". Add -p to those
+#   options to include a unified diff of changes in addition to the usual
+#   summary output.
 #
 # Notes
 # -----
@@ -447,7 +452,7 @@ generate_update_branch_email()
 	# non-fast-forward updates.
 	echo ""
 	echo "Summary of changes:"
-	git diff-tree --stat --summary --find-copies-harder $oldrev..$newrev
+	git diff-tree $diffopts $oldrev..$newrev
 }
 
 #
@@ -724,6 +729,8 @@ envelopesender=$(git config hooks.envelopesender)
 emailprefix=$(git config hooks.emailprefix || echo '[SCM] ')
 custom_showrev=$(git config hooks.showrev)
 maxlines=$(git config hooks.emailmaxlines)
+diffopts=$(git config hooks.diffopts)
+: ${diffopts:="--stat --summary --find-copies-harder"}
 
 # --- Main loop
 # Allow dual mode: run from the command line just like the update hook, or
-- 
1.7.6.233.gd79bc
