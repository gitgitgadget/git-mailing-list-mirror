From: Jeff King <peff@peff.net>
Subject: [PATCH 4/7] archive: advertise user tar-filters in --list
Date: Wed, 15 Jun 2011 18:33:32 -0400
Message-ID: <20110615223332.GD16807@sigill.intra.peff.net>
References: <20110615223030.GA16110@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jun 16 00:33:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWyeZ-000892-2c
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 00:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498Ab1FOWdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 18:33:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45247
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752915Ab1FOWde (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 18:33:34 -0400
Received: (qmail 7529 invoked by uid 107); 15 Jun 2011 22:33:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jun 2011 18:33:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jun 2011 18:33:32 -0400
Content-Disposition: inline
In-Reply-To: <20110615223030.GA16110@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175860>

These can be selected by --format, so we need to let users
know about them. It is especially important for the remote
case, since this is the only method by which users can find
out which formats the remote has configured.

Signed-off-by: Jeff King <peff@peff.net>
---
 archive.c           |    3 +++
 t/t5000-tar-tree.sh |    4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/archive.c b/archive.c
index cf58faa..a987936 100644
--- a/archive.c
+++ b/archive.c
@@ -358,8 +358,11 @@ static int parse_archive_args(int argc, const char **argv,
 		base = "";
 
 	if (list) {
+		struct tar_filter *p;
 		for (i = 0; i < ARRAY_SIZE(archivers); i++)
 			printf("%s\n", archivers[i].name);
+		for (p = tar_filters; p; p = p->next)
+			printf("%s\n", p->name);
 		exit(0);
 	}
 
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 2b2b128..9f959b1 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -267,12 +267,12 @@ test_expect_success 'filters can allow compression levels' '
 	test_cmp expect output
 '
 
-test_expect_failure 'archive --list mentions user filter' '
+test_expect_success 'archive --list mentions user filter' '
 	git archive --list >output &&
 	grep "^fake\$" output
 '
 
-test_expect_failure 'archive --list shows remote user filters' '
+test_expect_success 'archive --list shows remote user filters' '
 	git archive --list --remote=. >output &&
 	grep "^fake\$" output
 '
-- 
1.7.6.rc1.4.g49204
