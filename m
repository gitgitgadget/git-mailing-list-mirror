From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Disable asciidoc 8.4.1+ semantics for `{plus}` and friends
Date: Thu, 16 Jul 2009 15:54:06 +0200
Message-ID: <8e1edb4fb24a009e8eee419df31d0ae17a63a866.1247752162.git.trast@student.ethz.ch>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 15:54:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRRPp-0007Wg-QK
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 15:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757019AbZGPNyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 09:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756905AbZGPNyW
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 09:54:22 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:54221 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755580AbZGPNyV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 09:54:21 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 16 Jul 2009 15:54:20 +0200
Received: from localhost.localdomain ([129.132.210.198]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 16 Jul 2009 15:54:19 +0200
X-Mailer: git-send-email 1.6.4.rc1.193.g17735.dirty
X-OriginalArrivalTime: 16 Jul 2009 13:54:19.0445 (UTC) FILETIME=[EA5F5E50:01CA061C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123403>

asciidoc 8.4.1 changed the semantics of inline backtick quoting so
that they disable parsing of inline constructs, i.e.,

  Input:	`{plus}`
  Pre 8.4.1:	+
  Post 8.4.1:	{plus}

Fix this by defining the asciidoc attribute 'no-inline-literal'
(which, per the 8.4.1 changelog, is the toggle to return to the old
behaviour) when under ASCIIDOC8.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I checked the output of 8.4.4 with ASCIIDOC8 and ASCIIDOC_NO_ROFF set.
I unfortunately cannot test if the extra attribute affects pre-8.4.1
versions.  (If it conflicts, we will have to introduce yet another
ASCIIDOC_* option, but I'm trying to avoid it.)


 Documentation/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 7a8037f..06b0c57 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -84,7 +84,7 @@ endif
 #
 
 ifdef ASCIIDOC8
-ASCIIDOC_EXTRA += -a asciidoc7compatible
+ASCIIDOC_EXTRA += -a asciidoc7compatible -a no-inline-literal
 endif
 ifdef DOCBOOK_XSL_172
 ASCIIDOC_EXTRA += -a git-asciidoc-no-roff
-- 
1.6.4.rc1.193.g17735.dirty
