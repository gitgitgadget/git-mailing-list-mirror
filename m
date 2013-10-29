From: Jeff King <peff@peff.net>
Subject: Re: Why is git-subtree docs XML and not HTML?
Date: Tue, 29 Oct 2013 11:50:37 -0400
Message-ID: <20131029155037.GA3628@sigill.intra.peff.net>
References: <CAHGBnuO1xPrAFG1tvS5zaVD9yefa2VUNYM93YLt1pQ1yJwHkrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: greened@obbligato.org, Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 16:50:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbBZ6-0001Me-NY
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 16:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758203Ab3J2Puk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 11:50:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:57810 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758183Ab3J2Puk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 11:50:40 -0400
Received: (qmail 3364 invoked by uid 102); 29 Oct 2013 15:50:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Oct 2013 10:50:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Oct 2013 11:50:37 -0400
Content-Disposition: inline
In-Reply-To: <CAHGBnuO1xPrAFG1tvS5zaVD9yefa2VUNYM93YLt1pQ1yJwHkrw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236932>

On Tue, Oct 29, 2013 at 03:03:40PM +0100, Sebastian Schuberth wrote:

> I'm currently looking at subtree's Makefile and wondering why the
> generated markup docs is git-subtree.xml, and not git-subtree.html
> like for the rest of the git commands. I have not looked at
> git-subtree.xml because I'm lacking asciidoc right now, but is it just
> a matter of changing the file extension from .xml to .html, or does
> generating a HTML file involve more work?

The XML is an intermediate format for the manpage; the original source
is .txt, from which asciidoc generate docbook .xml, from which xmlto
generate the roff git-subtree.1.

If you want HTML, you need to have asciidoc generate .html from the .txt
directly (you probably _can_ generate it from docbook, but that is more
complicated, and not how regular git commands work).

I think this would do what you want:

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index 435b2de..e9026da 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -21,6 +21,7 @@ GIT_SUBTREE    := git-subtree
 GIT_SUBTREE_DOC := git-subtree.1
 GIT_SUBTREE_XML := git-subtree.xml
 GIT_SUBTREE_TXT := git-subtree.txt
+GIT_SUBTREE_HTML := git-subtree.html
 
 all: $(GIT_SUBTREE)
 
@@ -46,6 +47,10 @@ $(GIT_SUBTREE_XML): $(GIT_SUBTREE_TXT)
 	asciidoc -b docbook -d manpage -f $(ASCIIDOC_CONF) \
 		-agit_version=$(gitver) $^
 
+$(GIT_SUBTREE_HTML): $(GIT_SUBTREE_TXT)
+	asciidoc -b xhtml11 -d manpage -f $(ASCIIDOC_CONF) \
+		-agit_version=$(gitver) $^
+
 test:
 	$(MAKE) -C t/ test
 
