From: Jeff King <peff@peff.net>
Subject: [PATCH] subtree: add makefile target for html docs
Date: Tue, 29 Oct 2013 12:30:37 -0400
Message-ID: <20131029163037.GB3628@sigill.intra.peff.net>
References: <CAHGBnuO1xPrAFG1tvS5zaVD9yefa2VUNYM93YLt1pQ1yJwHkrw@mail.gmail.com>
 <20131029155037.GA3628@sigill.intra.peff.net>
 <CAHGBnuNDBH-V+Ebi27BOE8ebNQdhn+MCvabh97_zL3nTctz4yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, greened@obbligato.org,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 17:30:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbCBs-0000G0-5c
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 17:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758305Ab3J2Qam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 12:30:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:57837 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758260Ab3J2Qak (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 12:30:40 -0400
Received: (qmail 5198 invoked by uid 102); 29 Oct 2013 16:30:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Oct 2013 11:30:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Oct 2013 12:30:37 -0400
Content-Disposition: inline
In-Reply-To: <CAHGBnuNDBH-V+Ebi27BOE8ebNQdhn+MCvabh97_zL3nTctz4yA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236934>

On Tue, Oct 29, 2013 at 05:03:53PM +0100, Sebastian Schuberth wrote:

> I just gave it a try and it works nicely:
> 
> Tested-by: Sebastian Schuberth <sschuberth@gmail.com>
> 
> Also, the clean target already contains "*.html", so nothing else to
> do there. Any chance to get this queued in pu?

Here it is with a commit message, and the additional wiring into "make
doc".

-- >8 --
Subject: subtree: add makefile target for html docs

The Makefile currently builds the roff manpage, but not the
html form. As some people may prefer the latter, let's make
it an option to build that, too. We also wire it into "make
doc" so that it is built by default.

This patch does not build or install it as part of
"install-doc"; that would require extra infrastructure to
handle installing the html as we do in git's regular
Documentation/ tree. That can come later if somebody is
interested.

Tested-by: Sebastian Schuberth <sschuberth@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/subtree/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index 435b2de..4030a16 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -21,13 +21,14 @@ GIT_SUBTREE    := git-subtree
 GIT_SUBTREE_DOC := git-subtree.1
 GIT_SUBTREE_XML := git-subtree.xml
 GIT_SUBTREE_TXT := git-subtree.txt
+GIT_SUBTREE_HTML := git-subtree.html
 
 all: $(GIT_SUBTREE)
 
 $(GIT_SUBTREE): $(GIT_SUBTREE_SH)
 	cp $< $@ && chmod +x $@
 
-doc: $(GIT_SUBTREE_DOC)
+doc: $(GIT_SUBTREE_DOC) $(GIT_SUBTREE_HTML)
 
 install: $(GIT_SUBTREE)
 	$(INSTALL) -d -m 755 $(DESTDIR)$(libexecdir)
@@ -46,6 +47,10 @@ $(GIT_SUBTREE_XML): $(GIT_SUBTREE_TXT)
 	asciidoc -b docbook -d manpage -f $(ASCIIDOC_CONF) \
 		-agit_version=$(gitver) $^
 
+$(GIT_SUBTREE_HTML): $(GIT_SUBTREE_TXT)
+	asciidoc -b xhtml11 -d manpage -f $(ASCIIDOC_CONF) \
+		-agit_version=$(gitver) $^
+
 test:
 	$(MAKE) -C t/ test
 
-- 
1.8.4.1.898.g8bf8a41.dirty
