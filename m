From: Jeff King <peff@peff.net>
Subject: [PATCH 16/16] t7505: use SHELL_PATH in hook
Date: Wed, 12 Mar 2008 17:42:43 -0400
Message-ID: <20080312214243.GQ26286@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:43:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZYjN-00037X-BJ
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 22:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbYCLVmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 17:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbYCLVmq
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 17:42:46 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2702 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703AbYCLVmp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 17:42:45 -0400
Received: (qmail 3795 invoked by uid 111); 12 Mar 2008 21:42:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Mar 2008 17:42:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2008 17:42:43 -0400
Content-Disposition: inline
In-Reply-To: <cover.1205356737.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77007>

The hook doesn't run properly under Solaris /bin/sh. Let's
use the SHELL_PATH the user told us about already instead.

Signed-off-by: Jeff King <peff@peff.net>
---
I discussed this before, but I never followed up with a patch. So here
it is.

 t/t7505-prepare-commit-msg-hook.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 7ddec99..fd67996 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -25,7 +25,8 @@ export FAKE_EDITOR
 HOOKDIR="$(git rev-parse --git-dir)/hooks"
 HOOK="$HOOKDIR/prepare-commit-msg"
 mkdir -p "$HOOKDIR"
-cat > "$HOOK" <<'EOF'
+echo "#!$SHELL_PATH" > "$HOOK"
+cat >> "$HOOK" <<'EOF'
 #!/bin/sh
 if test "$2" = commit; then
   source=$(git-rev-parse "$3")
-- 
1.5.4.4.543.g30fdd.dirty
