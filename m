From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/12] Makefile: list generated object files in OBJECTS
Date: Tue, 26 Jan 2010 09:52:11 -0600
Message-ID: <20100126155211.GJ4895@progeny.tock>
References: <20100123144201.GA11903@progeny.tock>
 <7v3a1u6bfz.fsf@alter.siamese.dyndns.org>
 <20100126154357.GA4895@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 26 16:52:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZniB-0003qf-AK
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 16:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576Ab0AZPwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 10:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754573Ab0AZPwL
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 10:52:11 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:51202 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753776Ab0AZPwK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 10:52:10 -0500
Received: by ywh6 with SMTP id 6so4140089ywh.4
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 07:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=a+jwauM+j8fHmK/j1kwRsf/t6ZfEPAiOWxykaHQoD6I=;
        b=W6HW6WY6Ivy+Wbyxi3WooeI6oPbRANe3fVvPd/tlYHlcuNGGdteLfqmHEq/JFJ+Gv5
         2rvWT5UWlmX/P/8O+TBxnjsg4Clz5U+qdJExkh3PHGY5J4ghFxHiBHWSCI6n+DMGlw2i
         26GQpSt+n5HHXONttdxPUpZbporprBBTtnzPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MoTK7GaEjhq6ySxS0ZB5yavgScsWjPfiXjwYua+pstcACyEYJW56fUDDdTj0p1Uc22
         NJmtBPCbK9G/oF05tSukMwN0WKk58axa0sDt/XpMZzSKG2QVa5DpdVwRnV1Asy6J3tyE
         7iWc5hMhHxT/tCgm5wk/seBW6k464YjK56OoU=
Received: by 10.150.254.13 with SMTP id b13mr5335441ybi.331.1264521129429;
        Tue, 26 Jan 2010 07:52:09 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm6147788iwn.12.2010.01.26.07.52.08
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 07:52:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100126154357.GA4895@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138049>

Set the OBJECTS variable to a comprehensive list of all object
file targets.  To make sure it is truly comprehensive, restrict
the scope of the %.o pattern rule to only generate objects in
this list.

Attempts to build other object files will fail loudly:

	$ touch foo.c
	$ make foo.o
	make: *** No rule to make target `foo.o'.  Stop.

providing a reminder to add the new object to the OBJECTS list.

The new variable is otherwise unused.  The intent is for later
patches to take advantage of it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 60ef711..0e4e8ff 100644
--- a/Makefile
+++ b/Makefile
@@ -1671,14 +1671,19 @@ GIT_OBJS := $(LIB_OBJS) $(BUILTIN_OBJS) $(TEST_OBJS) \
 	$(patsubst git-%$X,%.o,$(PROGRAMS))
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
+OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS)
+
+ASM_SRC := $(wildcard $(OBJECTS:o=S))
+ASM_OBJ := $(ASM_SRC:S=o)
+C_OBJ := $(filter-out $(ASM_OBJ),$(OBJECTS))
 
 .SUFFIXES:
 
-%.o: %.c GIT-CFLAGS
+$(C_OBJ): %.o: %.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 %.s: %.c GIT-CFLAGS FORCE
 	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $<
-%.o: %.S GIT-CFLAGS
+$(ASM_OBJ): %.o: %.S GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
 $(GIT_OBJS): $(LIB_H)
-- 
1.6.6
