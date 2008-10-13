From: Jeff King <peff@peff.net>
Subject: [PATCH] tests: shell negation portability fix
Date: Mon, 13 Oct 2008 05:35:59 -0400
Message-ID: <20081013093558.GA17282@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 11:37:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpJrh-0005Fo-No
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 11:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760422AbYJMJgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 05:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758359AbYJMJgE
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 05:36:04 -0400
Received: from peff.net ([208.65.91.99]:3295 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759297AbYJMJgD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 05:36:03 -0400
Received: (qmail 21335 invoked by uid 111); 13 Oct 2008 09:36:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 13 Oct 2008 05:36:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Oct 2008 05:35:59 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98100>

Commit 969c8775 introduced a test which uses the non-portable construct:

  command1 && ! command2 | command3

which must be

  command1 && ! (command2 | command3)

to work on bsd shells (this is another example of bbf08124, which fixed
several similar cases).

Signed-off-by: Jeff King <peff@peff.net>
---
I had totally forgotten about this monstrosity until my autobuild broke.

diff --git a/t/t4128-apply-root.sh b/t/t4128-apply-root.sh
index bc7a8a8..8f6aea4 100755
--- a/t/t4128-apply-root.sh
+++ b/t/t4128-apply-root.sh
@@ -72,7 +72,7 @@ test_expect_success 'apply --directory (delete file)' '
 	echo content >some/sub/dir/delfile &&
 	git add some/sub/dir/delfile &&
 	git apply --directory=some/sub/dir/ --index patch &&
-	! git ls-files | grep delfile
+	! (git ls-files | grep delfile)
 '
 
 cat > patch << 'EOF'
