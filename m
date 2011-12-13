From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] t5500: give fully-qualified refs to fetch-pack
Date: Mon, 12 Dec 2011 19:44:40 -0500
Message-ID: <20111213004440.GB3699@sigill.intra.peff.net>
References: <20111213003925.GA28403@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin Sawicki <kevin@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 01:44:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaGUB-0003Pv-W8
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 01:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700Ab1LMAon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 19:44:43 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48422
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753472Ab1LMAom (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 19:44:42 -0500
Received: (qmail 8161 invoked by uid 107); 13 Dec 2011 00:51:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 19:51:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 19:44:40 -0500
Content-Disposition: inline
In-Reply-To: <20111213003925.GA28403@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186989>

The fetch-pack documentation is very clear that refs given
on the command line are to be full refs:

  <refs>...::
          The remote heads to update from. This is relative to
          $GIT_DIR (e.g. "HEAD", "refs/heads/master").  When
          unspecified, update from all heads the remote side has.

and this has been the case since fetch-pack was originally documented in
8b3d9dc ([PATCH] Documentation: clone/fetch/upload., 2005-07-14).

Let's follow our own documentation to set a good example,
and to avoid breaking when this restriction is enforced in
the next patch.

Signed-off-by: Jeff King <peff@peff.net>
---
This patch by itself isn't a big deal for backwards compatibility But
if we are violating the constraints in the documentation, then I worry
that others are, too. On the other hand, I seriously doubt anyone is
actually using fetch-pack directly anymore at all.

 t/t5500-fetch-pack.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index bafcca7..9bf69e9 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -97,7 +97,7 @@ test_expect_success 'setup' '
 	git symbolic-ref HEAD refs/heads/B
 '
 
-pull_to_client 1st "B A" $((11*3))
+pull_to_client 1st "refs/heads/B refs/heads/A" $((11*3))
 
 test_expect_success 'post 1st pull setup' '
 	add A11 $A10 &&
@@ -110,9 +110,9 @@ test_expect_success 'post 1st pull setup' '
 	done
 '
 
-pull_to_client 2nd "B" $((64*3))
+pull_to_client 2nd "refs/heads/B" $((64*3))
 
-pull_to_client 3rd "A" $((1*3))
+pull_to_client 3rd "refs/heads/A" $((1*3))
 
 test_expect_success 'clone shallow' '
 	git clone --depth 2 "file://$(pwd)/." shallow
-- 
1.7.8.13.g74677
