From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] docs: manpage XML depends on asciidoc.conf
Date: Sun, 6 Jan 2013 04:01:53 -0800
Message-ID: <20130106120153.GB22081@elie.Belkin>
References: <20130105160017.GD6440@serenity.lan>
 <20130105232800.GF3247@elie.Belkin>
 <7vbod2pzxd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Sergey Vlasov <vsu@altlinux.ru>,
	Thomas Ackermann <th.acker66@arcor.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 13:02:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trovn-0007hb-Dd
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 13:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569Ab3AFMCC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 07:02:02 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:46451 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755944Ab3AFMCA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 07:02:00 -0500
Received: by mail-pa0-f42.google.com with SMTP id rl6so10198047pac.1
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 04:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xd/Pxvf0Eb6nzxH2lPfb4aHNgoexZS24sdpjI8zErVU=;
        b=B9t+sj42LF5Jfwk4iBjPGvqaDUm1eHL9Z4T+nanE4C9l+yGTByMXVHL7h65Y4PcDzf
         WMj1goQIvpKFtm4WJvJHuAWWEfEM65chlEVQ++pSoG4OFmgn5IfdmDb5NXNLWUbIzpB1
         bi6e2gGOUGRfGLLN2AXkQBKyg4Pj+1Ji62f6WX8RJog8OTeujeTgGSBGRj3OLxvgw62o
         4vFpDavrMNsP4taNI2wC+IOpLB6dw56ElSqNjALdH+TBo4S4RRwgEWfN7OXA0nVY7VHR
         ub95T7Q9a+H0u6mBiFtGpB6Wy06fdi7E1J9rw9bUPmkdjTMBc0G2ezumeMXRN6qkQD9Z
         upYg==
X-Received: by 10.66.82.35 with SMTP id f3mr168330254pay.49.1357473719849;
        Sun, 06 Jan 2013 04:01:59 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id nw9sm35703232pbb.42.2013.01.06.04.01.57
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Jan 2013 04:01:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vbod2pzxd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212795>

When building manual pages, the source text is transformed to XML with
AsciiDoc before the man pages are generated from the XML with xmlto.

Fix the dependencies in the Makefile so that the XML files are rebuilt
when asciidoc.conf changes and not just the manual pages from
unchanged XML, and move the dependencies from a recipeless rule to the
rules with commands that use asciidoc.conf to make the dependencies
easier to understand and maintain.

Reported-by: John Keeping <john@keeping.me.uk>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> Care to do a real patch?

Here you go.

 Documentation/Makefile | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index e53d333e..971977b8 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -178,8 +178,6 @@ all: html man
 
 html: $(DOC_HTML)
 
-$(DOC_HTML) $(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7): asciidoc.conf
-
 man: man1 man5 man7
 man1: $(DOC_MAN1)
 man5: $(DOC_MAN5)
@@ -257,7 +255,7 @@ clean:
 	$(RM) $(cmds_txt) *.made
 	$(RM) manpage-base-url.xsl
 
-$(MAN_HTML): %.html : %.txt
+$(MAN_HTML): %.html : %.txt asciidoc.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
 		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
@@ -270,7 +268,7 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_XMLTO)$(RM) $@ && \
 	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
-%.xml : %.txt
+%.xml : %.txt asciidoc.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf \
 		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
@@ -286,7 +284,7 @@ technical/api-index.txt: technical/api-index-skel.txt \
 	$(QUIET_GEN)cd technical && '$(SHELL_PATH_SQ)' ./api-index.sh
 
 technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
-$(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt
+$(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt asciidoc.conf
 	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b xhtml11 -f asciidoc.conf \
 		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) $*.txt
 
-- 
1.8.1
