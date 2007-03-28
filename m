From: Jeff King <peff@peff.net>
Subject: [PATCH] t/t6006: add tests for a slightly more complex commit message
Date: Wed, 28 Mar 2007 17:08:36 -0400
Message-ID: <20070328210836.GA7898@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 23:08:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWfNq-0002iw-AH
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 23:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbXC1VIj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 28 Mar 2007 17:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752988AbXC1VIj
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 17:08:39 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3501 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752987AbXC1VIi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Mar 2007 17:08:38 -0400
Received: (qmail 13702 invoked from network); 28 Mar 2007 21:09:09 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 28 Mar 2007 21:09:09 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2007 17:08:36 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43387>

This test does not pass; there is a bug in the printing of
the 'encoding' parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t6006-rev-list-format.sh |   42 ++++++++++++++++++++++++++++++++++++=
++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index ce9c7dc..aab17fa 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -105,4 +105,46 @@ commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
 =1B[31mfoo=1B[32mbar=1B[34mbaz=1B[mxyzzy
 EOF
=20
+cat >commit-msg <<'EOF'
+Test printing of complex bodies
+
+This commit message is much longer than the others,
+and it will be encoded in iso8859-1. We should therefore
+include an iso8859 character: =A1bueno!
+EOF
+test_expect_success 'setup complex body' '
+git-config i18n.commitencoding iso8859-1 &&
+  echo change2 >foo && git-commit -a -F commit-msg
+'
+
+test_format complex-encoding %e <<'EOF'
+commit f58db70b055c5718631e5c61528b28b12090cdea
+iso8859-1
+commit 131a310eb913d107dd3c09a65d1651175898735d
+<unknown>
+commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+<unknown>
+EOF
+
+test_format complex-subject %s <<'EOF'
+commit f58db70b055c5718631e5c61528b28b12090cdea
+Test printing of complex bodies
+commit 131a310eb913d107dd3c09a65d1651175898735d
+changed foo
+commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+added foo
+EOF
+
+test_format complex-body %b <<'EOF'
+commit f58db70b055c5718631e5c61528b28b12090cdea
+This commit message is much longer than the others,
+and it will be encoded in iso8859-1. We should therefore
+include an iso8859 character: =A1bueno!
+
+commit 131a310eb913d107dd3c09a65d1651175898735d
+<unknown>
+commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+<unknown>
+EOF
+
 test_done
--=20
1.5.1.rc2.636.gff57
