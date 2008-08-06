From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] perl/Makefile: make NO_PERL_MAKEMAKER section more robust
Date: Wed, 06 Aug 2008 16:48:19 -0500
Message-ID: <h5b_Uh80WY7UfsGF2hRTiw_nv9rIwlIIGAe3N5lxpTRFqNsS9fmpGw@cipher.nrlssc.navy.mil>
References: <7v7iaurwe4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 23:49:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQqsy-0001UF-TG
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 23:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbYHFVsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 17:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbYHFVsf
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 17:48:35 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58041 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbYHFVse (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 17:48:34 -0400
Received: by mail.nrlssc.navy.mil id m76LmJ3m017661; Wed, 6 Aug 2008 16:48:19 -0500
In-Reply-To: <7v7iaurwe4.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 06 Aug 2008 21:48:19.0767 (UTC) FILETIME=[24061C70:01C8F80E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91544>

This adds the double single quote escaping that is performed for
GIT_BUILD_OPTIONS to the paths in the install section to protect
against paths with spaces, quotes or other funny characters in them.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 perl/Makefile |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/perl/Makefile b/perl/Makefile
index b8547db..4c6b2a2 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -29,13 +29,14 @@ $(makfile): ../GIT-CFLAGS Makefile
 	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
 	echo '	cp private-Error.pm blib/lib/Error.pm' >> $@
 	echo install: >> $@
-	echo '	mkdir -p $(instdir_SQ)' >> $@
-	echo '	$(RM) $(instdir_SQ)/Git.pm; cp Git.pm $(instdir_SQ)' >> $@
-	echo '	$(RM) $(instdir_SQ)/Error.pm' >> $@
+	echo "	mkdir -p "\''$(subst ','\'',$(instdir_SQ))'\' >> $@
+	echo "	$(RM) "\''$(subst ','\'',$(instdir_SQ))/Git.pm'\' >> $@
+	echo "	cp Git.pm "\''$(subst ','\'',$(instdir_SQ))'\' >> $@
+	echo "	$(RM) "\''$(subst ','\'',$(instdir_SQ))/Error.pm'\' >> $@
 	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
-	echo '	cp private-Error.pm $(instdir_SQ)/Error.pm' >> $@
+	echo "	cp private-Error.pm "\''$(subst ','\'',$(instdir_SQ))/Error.pm'\' >> $@
 	echo instlibdir: >> $@
-	echo '	echo $(instdir_SQ)' >> $@
+	echo "	echo "\''$(subst ','\'',$(instdir_SQ))'\' >> $@
 else
 $(makfile): Makefile.PL ../GIT-CFLAGS
 	$(PERL_PATH) $< PREFIX='$(prefix_SQ)'
-- 
1.6.0.rc1.89.g2e7ef.dirty
