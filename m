From: Jeff King <peff@peff.net>
Subject: [PATCH] docs: explain diff.*.binary option
Date: Sun, 9 Jan 2011 15:10:04 -0500
Message-ID: <20110109201003.GA4406@sigill.intra.peff.net>
References: <vpqy670brcb.fsf@bauges.imag.fr>
 <20110105051807.GB5884@sigill.intra.peff.net>
 <vpqr5clsy8g.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jan 09 21:10:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pc1aj-0000ct-Ne
	for gcvg-git-2@lo.gmane.org; Sun, 09 Jan 2011 21:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099Ab1AIUKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jan 2011 15:10:10 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:56182 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045Ab1AIUKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jan 2011 15:10:09 -0500
Received: (qmail 3280 invoked by uid 111); 9 Jan 2011 20:10:07 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 09 Jan 2011 20:10:07 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jan 2011 15:10:04 -0500
Content-Disposition: inline
In-Reply-To: <vpqr5clsy8g.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164861>

This was added long ago as part of the userdiff refactoring
for textconv, as internally it made the code simpler and
cleaner. However, there was never a concrete use case for
actually using the config variable.

Now that Matthieu Moy has provided such a use case, it's
easy to explain it using his example.

Signed-off-by: Jeff King <peff@peff.net>
---
On Sun, Jan 09, 2011 at 07:55:43PM +0100, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> > you can get what you want with:
> >
> >   echo '*.ps diff=ps' >.gitattributes
> >   git config diff.ps.textconv ps2ascii
> >   git config diff.ps.binary true
> 
> Yes, this works great. Thanks.
> 
> Did I miss something, or is this undocumented? I can't find that in
> either man gitattributes or man git-config.

Nope, it was never documented, probably because I never figured out what
it was good for. :)

 Documentation/gitattributes.txt |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 22b8582..a282adb 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -591,6 +591,39 @@ and now produces better output), you can remove the cache
 manually with `git update-ref -d refs/notes/textconv/jpg` (where
 "jpg" is the name of the diff driver, as in the example above).
 
+Marking files as binary
+^^^^^^^^^^^^^^^^^^^^^^^
+
+Git usually guesses correctly whether a blob contains text or binary
+data by examining the beginning of the contents. However, sometimes you
+may want to override its decision, either because a blob contains binary
+data later in the file, or because the content, while technically
+composed of text characters, is opaque to a human reader. For example,
+many postscript files contain only ascii characters, but produce noisy
+and meaningless diffs.
+
+The simplest way to mark a file as binary is to unset the diff
+attribute in the `.gitattributes` file:
+
+------------------------
+*.ps -diff
+------------------------
+
+This will cause git to generate `Binary files differ` (or a binary
+patch, if binary patches are enabled) instead of a regular diff.
+
+However, one may also want to specify other diff driver attributes. For
+example, you might want to use `textconv` to convert postscript files to
+an ascii representation for human viewing, but otherwise treat them as
+binary files. You cannot specify both `-diff` and `diff=ps` attributes.
+The solution is to use the `diff.*.binary` config option:
+
+------------------------
+[diff "ps"]
+  textconv = ps2ascii
+  binary = true
+------------------------
+
 Performing a three-way merge
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
1.7.3.5.4.g0dc52
