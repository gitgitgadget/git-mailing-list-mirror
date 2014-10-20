From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 0/3] Allow building Git with Asciidoctor
Date: Mon, 20 Oct 2014 00:20:35 +0000
Message-ID: <1413764438-297386-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 02:21:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xg0il-0006xT-6N
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 02:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbaJTAUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2014 20:20:52 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49406 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752008AbaJTAUt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Oct 2014 20:20:49 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D86152808F;
	Mon, 20 Oct 2014 00:20:45 +0000 (UTC)
X-Mailer: git-send-email 2.1.1
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is designed to implement the changes necessary to build Git
using Asciidoctor instead of AsciiDoc.

The first two patches are bug fixes, and are unchanged from v1.
Asciidoctor is stricter about some aspects of formatting, and these
patches are required to make the documentation build correctly.

The third patch moves several pieces of the documentation makefile into
variables.  Some of these changes were suggested by Junio, and some of
them were required to simply build correctly.

In this patch, I have maintained the ASCIIDOC_HTML and ASCIIDOC_DOCBOOK
variables, because otherwise there is no way to override the backends
easily, which is required to build.  For Asciidoctor, there is no
xhtml11 backend and the docbook backend produces DocBook 5, which xmlto
doesn't like.

The fourth patch in the previous series has been dropped, as Dan Allen
of the Asciidoctor project has pointed me to a backend-agnostic
implementation of the linkgit macro which is included in the Asciidoctor
project.  The litdd attribute, the only other missing piece, can be
moved to the command line, so the patch became unnecessary.

I've successfully built the documentation with Asciidoctor using the
following command line:

  make doc ASCIIDOC=asciidoctor ASCIIDOC_HTML=html5 \
  ASCIIDOC_DOCBOOK=docbook45 ASCIIDOC_EXTRA="'-alitdd=&#45;&#45;'" \
  ASCIIDOC_CONF=

This resulted in a total build time (documentation only) of 3:17 versus
5:43 for AsciiDoc (a 42% improvement).

brian m. carlson (3):
  Documentation: adjust document title underlining
  Documentation: fix mismatched delimiters in git-imap-send
  Documentation: move some AsciiDoc parameters into variables

 Documentation/Makefile             | 26 +++++++++++++++-----------
 Documentation/git-imap-send.txt    |  4 ++--
 Documentation/git-prune-packed.txt |  2 +-
 Documentation/git-quiltimport.txt  |  2 +-
 Documentation/git-stage.txt        |  2 +-
 5 files changed, 20 insertions(+), 16 deletions(-)

-- 
2.1.1
