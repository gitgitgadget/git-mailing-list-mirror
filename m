From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] rebase: give a better error message for bogus branch
Date: Wed, 26 Jan 2011 19:27:11 -0500
Message-ID: <20110127002711.GB32711@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 27 01:27:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiFhp-0008WR-NP
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 01:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475Ab1A0A1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 19:27:11 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33082 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754471Ab1A0A1L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 19:27:11 -0500
Received: (qmail 10926 invoked by uid 111); 27 Jan 2011 00:27:10 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 27 Jan 2011 00:27:10 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Jan 2011 19:27:11 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165565>

When you give a non-existent branch to git-rebase, it spits
out the usage. This can be confusing, since you may
understand the usage just fine, but simply have made a
mistake in the branch name.

Before:

  $ git rebase origin bogus
  Usage: git rebase ...

After:

  $ git rebase origin bogus
  fatal: no such branch: bogus
  Usage: git rebase ...

Signed-off-by: Jeff King <peff@peff.net>
---
 git-rebase.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 345b18c..cbb0ea9 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -482,6 +482,7 @@ case "$#" in
 	then
 		head_name="detached HEAD"
 	else
+		echo >&2 "fatal: no such branch: $1"
 		usage
 	fi
 	;;
-- 
1.7.4.rc3.5.g8354b
