From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] templates/Makefile: install is unnecessary, just use mkdir
 -p
Date: Thu, 21 Aug 2008 19:31:50 -0500
Message-ID: <y-OStBu9jZ4ghBeO7Duf6UrkhSEZFsB9o5V_P-EgCcq3k1diXe1EAA@cipher.nrlssc.navy.mil>
References: <7vhc9hlwt3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Gerrit Pape <pape@smarden.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 02:33:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWKaR-0001gg-4L
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 02:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004AbYHVAcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 20:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbYHVAcA
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 20:32:00 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57215 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbYHVAb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 20:31:59 -0400
Received: by mail.nrlssc.navy.mil id m7M0VpRm006324; Thu, 21 Aug 2008 19:31:51 -0500
In-Reply-To: <7vhc9hlwt3.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 22 Aug 2008 00:31:50.0834 (UTC) FILETIME=[78126120:01C903EE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93236>

From: Junio C Hamano <gitster@pobox.com>

The native install on some platforms (namely IRIX 6.5) treats non-absolute
paths as being relative to the root directory rather than relative to
the current directory. Work around this by avoiding install in this case
since it is unnecessary, and instead depend on the local umask setting
and use mkdir.

Tested-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Junio C Hamano wrote:

> I do not see absolutely any reason to use install there.
> 
> I have to wonder why 9907721 (templates/Makefile: don't depend on local
> umask setting, 2008-02-28) did not do this instead:

works for me.

-brandon


 templates/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/templates/Makefile b/templates/Makefile
index cc3fc30..0722a92 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -23,13 +23,13 @@ all: boilerplates.made custom
 
 bpsrc = $(filter-out %~,$(wildcard *--*))
 boilerplates.made : $(bpsrc)
-	$(QUIET)ls *--* 2>/dev/null | \
+	$(QUIET)umask 022 && ls *--* 2>/dev/null | \
 	while read boilerplate; \
 	do \
 		case "$$boilerplate" in *~) continue ;; esac && \
 		dst=`echo "$$boilerplate" | sed -e 's|^this|.|;s|--|/|g'` && \
 		dir=`expr "$$dst" : '\(.*\)/'` && \
-		$(INSTALL) -d -m 755 blt/$$dir && \
+		mkdir -p blt/$$dir && \
 		case "$$boilerplate" in \
 		*--) ;; \
 		*) cp -p $$boilerplate blt/$$dst ;; \
-- 
1.6.0.21.g35a2e
