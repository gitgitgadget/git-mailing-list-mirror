From: Jeff King <peff@peff.net>
Subject: [PATCH 3/8] t5800: factor out some ref tests
Date: Tue, 7 Jun 2011 13:20:12 -0400
Message-ID: <20110607172012.GB22111@sigill.intra.peff.net>
References: <20110607171838.GA21685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:20:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTzx1-0000gM-2p
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826Ab1FGRUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:20:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50732
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752525Ab1FGRUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:20:16 -0400
Received: (qmail 16988 invoked by uid 107); 7 Jun 2011 17:20:22 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jun 2011 13:20:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2011 13:20:12 -0400
Content-Disposition: inline
In-Reply-To: <20110607171838.GA21685@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175220>

These are a little hard to read, and I'm about to add more
just like them. Plus the failure output is nicer if we use
test_cmp than a comparison with "test".

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5800-remote-helpers.sh |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 1fb6380..3a37ad0 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -17,6 +17,12 @@ then
 	test_set_prereq PYTHON_24
 fi
 
+compare_refs() {
+	git --git-dir="$1/.git" rev-parse --verify $2 >expect &&
+	git --git-dir="$3/.git" rev-parse --verify $4 >actual &&
+	test_cmp expect actual
+}
+
 test_expect_success PYTHON_24 'setup repository' '
 	git init --bare server/.git &&
 	git clone server public &&
@@ -59,8 +65,7 @@ test_expect_success PYTHON_24 'pushing to local repo' '
 	echo content >>file &&
 	git commit -a -m three &&
 	git push) &&
-	HEAD=$(git --git-dir=localclone/.git rev-parse --verify HEAD) &&
-	test $HEAD = $(git --git-dir=server/.git rev-parse --verify HEAD)
+	compare_refs localclone HEAD server HEAD
 '
 
 test_expect_success PYTHON_24 'synch with changes from localclone' '
@@ -73,8 +78,7 @@ test_expect_success PYTHON_24 'pushing remote local repo' '
 	echo content >>file &&
 	git commit -a -m four &&
 	git push) &&
-	HEAD=$(git --git-dir=clone/.git rev-parse --verify HEAD) &&
-	test $HEAD = $(git --git-dir=server/.git rev-parse --verify HEAD)
+	compare_refs clone HEAD server HEAD
 '
 
 test_done
-- 
1.7.6.rc0.35.gc40cb
