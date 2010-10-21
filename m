From: Jeff King <peff@peff.net>
Subject: [PATCH] docs: give more hints about how "add -e" works
Date: Thu, 21 Oct 2010 10:30:35 -0400
Message-ID: <20101021143034.GA16083@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 16:30:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8w9Y-0007EW-Ll
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 16:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571Ab0JUO3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 10:29:54 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35178 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753380Ab0JUO3x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 10:29:53 -0400
Received: (qmail 5613 invoked by uid 111); 21 Oct 2010 14:29:52 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 21 Oct 2010 14:29:52 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Oct 2010 10:30:35 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159509>

The previous text was not exactly accurate; it is OK to
change space and minus lines, but only in certain ways. This
patch attempts to cover explicitly what can be done at the
individual line level, and cautions the user that
conceptually larger changes (like modifying a line) require
some understanding of the patch format.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm sorting through some old topics in my personal repository and either
abandoning them or cleaning them up and submitting them. I thought this
one was worth doing. Original thread here:

  http://article.gmane.org/gmane.comp.version-control.git/130345

This version tries to address your points, Junio. It also seems that the
formatting issues have been magically fixed upstream in the past year. :)

 Documentation/git-add.txt |   32 +++++++++++++++++++++++++++++---
 1 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 73378b2..40deb03 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -92,9 +92,35 @@ See ``Interactive mode'' for details.
 	edit it.  After the editor was closed, adjust the hunk headers
 	and apply the patch to the index.
 +
-*NOTE*: Obviously, if you change anything else than the first character
-on lines beginning with a space or a minus, the patch will no longer
-apply.
+The intent of this option is to pick and choose lines of the patch to
+apply, or even to modify the contents of lines to be staged. There are
+three line types in a patch: addition lines (beginning with a plus),
+removal lines (beginning with a minus), and context lines (beginning
+with a space). In general, it should be safe to:
++
+--
+* remove addition lines (don't stage the line)
+* modify the content of any addition lines (stage modified contents)
+* add new addition lines (stage the new line)
+* convert context lines to removal lines (stage removal of line)
+* convert removal lines to context lines (don't stage removal)
+--
++
+Similarly, your patch will likely not apply if you:
++
+--
+* add context or removal lines
+* delete removal or context lines
+* modify the contents of context or removal lines
+--
++
+NOTE: In the first list above, the results given for each action are
+with respect to that patch line only. Conceptual changes like
+modification of a line in the original file are actually represented by
+removal of the old line followed by addition of the new line. Deleting
+only the addition line of this pair but leaving the removal line would
+therefore convert the modification into a deletion. In other words, use
+this feature with caution, as it is easy to stage unintended changes.
 
 -u::
 --update::
-- 
1.7.3.1.235.gdd6c0
