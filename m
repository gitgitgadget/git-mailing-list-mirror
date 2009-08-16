From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/2] git_remote_cvs: Use $(shell) in the Makefile
Date: Sun, 16 Aug 2009 13:38:08 -0700
Message-ID: <1250455088-23457-2-git-send-email-davvid@gmail.com>
References: <7v7hx35ym1.fsf@alter.siamese.dyndns.org>
 <1250455088-23457-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, barkalow@iabervon.org,
	Johannes.Schindelin@gmx.de, mhagger@alum.mit.edu,
	David Aguilar <davvid@gmail.com>
To: gitster@pobox.com, johan@herland.net
X-From: git-owner@vger.kernel.org Sun Aug 16 22:38:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McmV7-0004hc-6c
	for gcvg-git-2@lo.gmane.org; Sun, 16 Aug 2009 22:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019AbZHPUio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 16:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755984AbZHPUio
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 16:38:44 -0400
Received: from mail-pz0-f196.google.com ([209.85.222.196]:60466 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755896AbZHPUin (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 16:38:43 -0400
Received: by mail-pz0-f196.google.com with SMTP id 34so1659201pzk.4
        for <git@vger.kernel.org>; Sun, 16 Aug 2009 13:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=kdM36iok0ftqGbj4gRz9I3MfhC2cYbRJESV/pOBSFoA=;
        b=sy36lh4KBUlB2A47qwJ3xKTdR/BH+CDmF1UGf+wXGvwV9GLgoxuqj9x1Gn+vS6HtvN
         7E8r6uR+yiYblhMJbgii5zMZrOtAAdFTY5ET5R3VA05/AKbqr5sltg2q6DMMmcGbUfMI
         m5PD/ijNMO7aMHmiA2OpLsusVEkOyxG9G/3pQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=m6LYkTHmtV1joTlspnWr+9K7NBK8go09/tRqzb7XaeZtjk/FDX4SVYSI+DBQ3eGeri
         Z9uHiFr9ZVYc3YqdenNN/ydi+qszWQe7yDeKNToaigpg0Lps8qOYKnAmr/xHJ7HlA1tN
         4jvKdx2dliFUCe6X+EhvTOBHhwzqmjgcO+l/8=
Received: by 10.114.78.7 with SMTP id a7mr3940299wab.116.1250455125656;
        Sun, 16 Aug 2009 13:38:45 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id v9sm8596624wah.36.2009.08.16.13.38.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Aug 2009 13:38:44 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.169.g64d5
In-Reply-To: <1250455088-23457-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126072>

This updates the git_remote_cvs Makefile to use the same
$(shell <cmd>) style used by the top-level git Makefile.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git_remote_cvs/Makefile |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git_remote_cvs/Makefile b/git_remote_cvs/Makefile
index f52c096..d281d48 100644
--- a/git_remote_cvs/Makefile
+++ b/git_remote_cvs/Makefile
@@ -23,10 +23,13 @@ ifndef V
 	QUIETSETUP = --quiet
 endif
 
-PYLIBDIR=`$(PYTHON_PATH) -c "import sys; print 'lib/python%i.%i/site-packages' % sys.version_info[:2]"`
+PYLIBDIR=$(shell $(PYTHON_PATH) -c \
+	 "import sys; \
+	 print 'lib/python%i.%i/site-packages' % sys.version_info[:2]")
 
 all: $(pysetupfile)
 	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build
+
 install: $(pysetupfile)
 	$(PYTHON_PATH) $(pysetupfile) install \
 		--prefix $(prefix) \
@@ -34,6 +37,7 @@ install: $(pysetupfile)
 
 instlibdir: $(pysetupfile)
 	@echo "$(prefix)/$(PYLIBDIR)"
+
 clean:
 	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) clean -a
 	$(RM) *.pyo *.pyc
-- 
1.6.4.169.g64d5
