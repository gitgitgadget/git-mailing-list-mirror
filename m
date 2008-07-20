From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] builtin-merge.c: Fix option parsing
Date: Sun, 20 Jul 2008 14:34:47 +0200
Message-ID: <200807201434.47545.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 14:29:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKY2h-0007qe-Ht
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 14:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979AbYGTM2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 08:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754655AbYGTM2g
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 08:28:36 -0400
Received: from smtp.katamail.com ([62.149.157.154]:42986 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753766AbYGTM2f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 08:28:35 -0400
Received: (qmail 17487 invoked by uid 89); 20 Jul 2008 12:28:31 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO host119-56-dynamic.104-80-r.retail.telecomitalia.it) (barra?cuda@katamail.com@80.104.56.119)
  by smtp1-pc with SMTP; 20 Jul 2008 12:28:28 -0000
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89192>

Now "git merge -m" needs a message, and errors out with the usage
text if none is given.
This way, t7600-merge.sh is fixed.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 builtin-merge.c  |    5 +++--
 t/t7600-merge.sh |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 129b4e6..84a541d 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -68,10 +68,11 @@ static int option_parse_message(const struct option *opt,
 
 	if (unset)
 		strbuf_setlen(buf, 0);
-	else {
+	else if (arg) {
 		strbuf_addf(buf, "%s\n\n", arg);
 		have_message = 1;
-	}
+	} else
+		return error("switch `m' requires a value");
 	return 0;
 }
 
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 26cf8dc..5eeb6c2 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -221,7 +221,7 @@ test_expect_success 'setup' '
 
 test_debug 'gitk --all'
 
-test_expect_failure 'test option parsing' '
+test_expect_success 'test option parsing' '
 	test_must_fail git merge -$ c1 &&
 	test_must_fail git merge --no-such c1 &&
 	test_must_fail git merge -s foobar c1 &&
-- 
1.5.6.3
