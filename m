From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <andreas.faerber@web.de>
Subject: [PATCH 6/6] Always provide a fallback when hardlinks fail
Date: Sun, 17 Aug 2008 11:00:51 +0200
Message-ID: <0EFF470D-341A-4619-910A-0F9C663D0B51@web.de>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 17 11:02:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUe9S-0006Ho-NH
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 11:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbYHQJBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 05:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751986AbYHQJBP
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 05:01:15 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:41356 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbYHQJBO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 05:01:14 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 2BFEDE6E4513;
	Sun, 17 Aug 2008 11:01:13 +0200 (CEST)
Received: from [91.18.70.145] (helo=[10.0.1.1])
	by smtp05.web.de with asmtp (TLSv1:AES128-SHA:128)
	(WEB.DE 4.109 #226)
	id 1KUe8O-00011d-00; Sun, 17 Aug 2008 11:01:13 +0200
X-Mailer: Apple Mail (2.926)
X-Sender: Andreas.Faerber@web.de
X-Provags-ID: V01U2FsdGVkX1/tJBzyGFWGPePHHaEU/1MS+MtZQdQFbOpNN2pv
	YtBd3F/r2J9vmZGRUkPTBeqF+T94gG+oJBdb5surGpzcYl5HnN
	9NtkFtTSRTQ0RsoR2t7g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92589>

BFS does not support hardlinks, so suppress the resulting error  
messages.

Signed-off-by: Andreas Faerber <andreas.faerber@web.de>
Acked-by: Ingo Weinhold <ingo_weinhold@gmx.de>
Acked-by: Scott McCreary <scottmc2@gmail.com>
---
In one place cp was already used as fallback, so I went that route.
Personally I would also be okay with symlinks as alternative.

  Makefile |    6 +++---
  1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 3daf9ac..7dc4bbd 100644
--- a/Makefile
+++ b/Makefile
@@ -1106,7 +1106,7 @@ help.o: help.c common-cmds.h GIT-CFLAGS
  		'-DGIT_INFO_PATH="$(infodir_SQ)"' $<

  $(BUILT_INS): git$X
-	$(QUIET_BUILT_IN)$(RM) $@ && ln git$X $@
+	$(QUIET_BUILT_IN)$(RM) $@ && ln git$X $@ 2>/dev/null || cp git$X $@

  common-cmds.h: ./generate-cmdlist.sh command-list.txt

@@ -1373,10 +1373,10 @@ endif
  	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
  	if test "z$$bindir" != "z$$execdir"; \
  	then \
-		ln -f "$$bindir/git$X" "$$execdir/git$X" || \
+		ln -f "$$bindir/git$X" "$$execdir/git$X" 2>/dev/null || \
  		cp "$$bindir/git$X" "$$execdir/git$X"; \
  	fi && \
-	{ $(foreach p,$(BUILT_INS), $(RM) "$$execdir/$p" && ln "$$execdir/git 
$X" "$$execdir/$p" ;) } && \
+	{ $(foreach p,$(BUILT_INS), $(RM) "$$execdir/$p" && ln "$$execdir/git 
$X" "$$execdir/$p" 2>/dev/null || cp "$$execdir/git$X" "$$execdir/ 
$p" ;) } && \
  	if test "z$$bindir" != "z$$execdir"; \
  	then \
  		$(RM) "$$execdir/git$X"; \
-- 
1.6.0.rc3.32.g8aaa
