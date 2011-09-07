From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] t6300: add more body-parsing tests
Date: Wed, 7 Sep 2011 13:43:28 -0400
Message-ID: <20110907174328.GB11355@sigill.intra.peff.net>
References: <20110902175323.GA29761@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Sep 07 19:43:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1MA9-0001dx-QI
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 19:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011Ab1IGRnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 13:43:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37331
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755992Ab1IGRna (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 13:43:30 -0400
Received: (qmail 3941 invoked by uid 107); 7 Sep 2011 17:44:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Sep 2011 13:44:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2011 13:43:28 -0400
Content-Disposition: inline
In-Reply-To: <20110902175323.GA29761@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180886>

The current tests don't actually check parsing commit and
tag messages that have both a subject and a body (they just
have single-line messages).

Signed-off-by: Jeff King <peff@peff.net>
---
This is mostly to help make sure the next patch doesn't regress this
case.

 t/t6300-for-each-ref.sh |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 7dc8a51..6fa4d52 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -37,6 +37,7 @@ test_atom() {
 	case "$1" in
 		head) ref=refs/heads/master ;;
 		 tag) ref=refs/tags/testtag ;;
+		   *) ref=$1 ;;
 	esac
 	printf '%s\n' "$3" >expected
 	test_expect_${4:-success} "basic atom: $1 $2" "
@@ -359,4 +360,23 @@ test_expect_success 'an unusual tag with an incomplete line' '
 
 '
 
+test_expect_success 'create tag with subject and body content' '
+	cat >>msg <<-\EOF &&
+		the subject line
+
+		first body line
+		second body line
+	EOF
+	git tag -F msg subject-body
+'
+test_atom refs/tags/subject-body subject 'the subject line'
+test_atom refs/tags/subject-body body 'first body line
+second body line
+'
+test_atom refs/tags/subject-body contents 'the subject line
+
+first body line
+second body line
+'
+
 test_done
-- 
1.7.6.10.g62f04
