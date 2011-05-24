From: Jeff King <peff@peff.net>
Subject: [PATCH] doc: discuss textconv versus external diff drivers
Date: Tue, 24 May 2011 15:45:27 -0400
Message-ID: <20110524194527.GD584@sigill.intra.peff.net>
References: <1306196874-64687-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junio@kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 21:45:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOxXr-0006Vg-3o
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 21:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755662Ab1EXTpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 15:45:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41205
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752881Ab1EXTp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 15:45:29 -0400
Received: (qmail 21110 invoked by uid 107); 24 May 2011 19:45:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 May 2011 15:45:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 May 2011 15:45:27 -0400
Content-Disposition: inline
In-Reply-To: <1306196874-64687-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174337>

We already talk about how to use each one and how they work,
but it is a reasonable question to wonder why one might use
one over the other.

Signed-off-by: Jeff King <peff@peff.net>
---
This can probably go with Jay's --textconv documentation topic.

 Documentation/gitattributes.txt |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 15aebc6..412c55b 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -593,6 +593,37 @@ and now produces better output), you can remove the cache
 manually with `git update-ref -d refs/notes/textconv/jpg` (where
 "jpg" is the name of the diff driver, as in the example above).
 
+Choosing textconv versus external diff
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+If you want to show differences between binary or specially-formatted
+blobs in your repository, you can choose to use either an external diff
+command, or to use textconv to convert them to a diff-able text format.
+Which method you choose depends on your exact situation.
+
+The advantage of using an external diff command is flexibility. You are
+not bound to find line-oriented changes, nor is it necessary for the
+output to resemble unified diff. You are free to locate and report
+changes in the most appropriate way for your data format.
+
+A textconv, by comparison, is much more limiting. You provide a
+transformation of the data into a line-oriented text format, and git
+uses its regular diff tools to generate the output. There are several
+advantages to choosing this method:
+
+1. Ease of use. It is often much simpler to write a binary to text
+   transformation than it is to perform your own diff. In many cases,
+   existing programs can be used as textconv filters (e.g., exif,
+   odt2txt).
+
+2. Git diff features. By performing only the transformation step
+   yourself, you can still utilize many of git's diff features,
+   including colorization, word-diff, and combined diffs for merges.
+
+3. Caching. Textconv caching can speed up repeated diffs, such as those
+   you might trigger by running `git log -p`.
+
+
 Marking files as binary
 ^^^^^^^^^^^^^^^^^^^^^^^
 
-- 
1.7.4.5.7.g2e01
