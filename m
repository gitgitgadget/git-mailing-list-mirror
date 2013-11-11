From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] git-remote-mediawiki build: handle DESTDIR/INSTLIBDIR
 with whitespace
Date: Mon, 11 Nov 2013 12:46:12 -0800
Message-ID: <20131111204612.GP10302@google.com>
References: <20131109022239.GI10302@google.com>
 <vpqli0xstcw.fsf@anie.imag.fr>
 <20131111204504.GM10302@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thorsten Glaser <t.glaser@tarent.de>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Nov 11 21:46:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfyNI-0007a7-Cm
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 21:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821Ab3KKUqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 15:46:17 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:49808 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab3KKUqP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 15:46:15 -0500
Received: by mail-pa0-f54.google.com with SMTP id lj1so2862440pab.41
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 12:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8vO1FYiK6p1313O4jsQAN2KHfN/NFb7o5u12nNruVqQ=;
        b=jsl2LYDfyn1fBCWHUMf9zWa0S83YTdLlER5WIrslwnw/yxTrtLt9+BLrGODWu+NNmy
         MwhvSXtwt6x6wGwLc4nuG0i/uhWzty5u5PbajBKZa6YS+YK7EUnlheRu3YWuGw1dRpsa
         O9dLldSp2Fpu/TTWYpwquiNFM1I7FbeuCQQ+xyE2JMCBSJbXbeal8veXBmr5cjSXld0Y
         zKCo41N0qUeUbNLDPuYid5X8cBRjP/fPL5oJo12gQt3pdURAZ0/9rdmn0Aa1HoEOfWfD
         AcsXE06PP1hYgKeNBDXBOfs3K9Zqfm4F5WciIn81A7L1Ol0+BXsDFhES3JPOiso2YJ+H
         NpQA==
X-Received: by 10.68.244.168 with SMTP id xh8mr31589622pbc.3.1384202775227;
        Mon, 11 Nov 2013 12:46:15 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qn1sm18359613pbc.34.2013.11.11.12.46.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 Nov 2013 12:46:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131111204504.GM10302@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237649>

Quote DESTDIR and INSTLIBDIR for the shell in the same way as is done in
the toplevel Makefile to avoid confusion in case they contain shell
metacharacters.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/mw-to-git/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
index e685dad..a4b6f7a 100644
--- a/contrib/mw-to-git/Makefile
+++ b/contrib/mw-to-git/Makefile
@@ -23,6 +23,8 @@ INSTALL = install
 SCRIPT_PERL_FULL=$(patsubst %,$(HERE)/%,$(SCRIPT_PERL))
 INSTLIBDIR=$(shell $(MAKE) -C $(GIT_ROOT_DIR)/perl \
                 -s --no-print-directory instlibdir)
+DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
+INSTLIBDIR_SQ = $(subst ','\'',$(INSTLIBDIR))
 
 all: build
 
@@ -32,9 +34,9 @@ test: all
 check: perlcritic test
 
 install_pm:
-	$(INSTALL) -d -m 755 $(DESTDIR)$(INSTLIBDIR)/Git
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(INSTLIBDIR_SQ)/Git'
 	$(INSTALL) -m 644 $(GIT_MEDIAWIKI_PM) \
-		$(DESTDIR)$(INSTLIBDIR)/$(GIT_MEDIAWIKI_PM)
+		'$(DESTDIR_SQ)$(INSTLIBDIR_SQ)/$(GIT_MEDIAWIKI_PM)'
 
 build:
 	$(MAKE) -C $(GIT_ROOT_DIR) SCRIPT_PERL="$(SCRIPT_PERL_FULL)" \
-- 
1.8.4.1
