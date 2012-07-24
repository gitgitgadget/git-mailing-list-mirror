From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] t1306: check that XDG_CONFIG_HOME works
Date: Tue, 24 Jul 2012 07:54:22 -0400
Message-ID: <20120724115422.GB7353@sigill.intra.peff.net>
References: <20120724115305.GA7328@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 13:54:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stdh7-0000vs-PA
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 13:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516Ab2GXLyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 07:54:25 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60141 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753468Ab2GXLyY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 07:54:24 -0400
Received: (qmail 15983 invoked by uid 107); 24 Jul 2012 11:54:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Jul 2012 07:54:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2012 07:54:22 -0400
Content-Disposition: inline
In-Reply-To: <20120724115305.GA7328@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202030>

This should override $HOME/.config, but we never actually
tested it.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1306-xdg-files.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index 1569596..4447949 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -113,6 +113,14 @@ test_expect_success 'Checking XDG attributes when HOME is unset' '
 	test_cmp expected actual
 '
 
+test_expect_success 'Prefer XDG_CONFIG_HOME to HOME/.config' '
+	echo "f: attr_f: foo" >expected &&
+	mkdir -p foo/git &&
+	echo "f attr_f=foo" >foo/git/attributes &&
+	XDG_CONFIG_HOME="foo" git check-attr -a f >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'Checking attributes in both XDG and local attributes files' '
 	echo "f -attr_f" >.gitattributes &&
 	echo "f: attr_f: unset" >expected &&
-- 
1.7.11.3.4.g9f70dbb
