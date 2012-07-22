From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Makefile: fix location of listing produced by "make
 subdir/foo.s"
Date: Sun, 22 Jul 2012 18:47:26 -0500
Message-ID: <20120722234726.GC2012@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 01:48:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St5sk-0001WG-GA
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 01:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538Ab2GVXrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 19:47:32 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56362 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab2GVXrb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 19:47:31 -0400
Received: by obbuo13 with SMTP id uo13so8607694obb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 16:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=e0Pyo4uGffOzgjbL1AO1yMG94kRUwutL6odz61euOOY=;
        b=Xojo1e3Wf4JMYVyEMLlVly3zbBWgwzQbXshUXmE5p26F2abbK0ZStUAcPg/Fh5/Ojo
         DDK+qMoKuw85TyfBjttGu/kF/c0IxZ1wTouN/J2Z/O0GSRk/PB/O/SwQrZ5okvtS43AF
         TflHEFS8mWMfzXAVyybJhh/vcH/Ud5+/xU5dlyqub5ogUxgFZZCawlMKwwB6Brf7whrP
         dkZKBhGvpgmfpe8+oWFCLhl3CZqJlID4PwsXGnQg0LMqLdXOlG6qqaBQP0qunDTcP4bF
         tBgQicx18HO/8PiAXpqdmREUfHDHJMHDhtCnXwfVmxh5VfMx63/4ziScRndm54sEYJfk
         8QDA==
Received: by 10.50.190.163 with SMTP id gr3mr9290798igc.22.1343000850685;
        Sun, 22 Jul 2012 16:47:30 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id uy3sm4653351igc.14.2012.07.22.16.47.29
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 16:47:30 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201876>

When I invoke "make block-sha1/sha1.s", 'make' runs $(CC) -S without
specifying where it should put its output and the output ends up in
./sha1.s.  Confusing.

Add an -o option to the .s rule to fix this.  We were already doing
that for most compiler invocations but had forgotten it for the
assembler listings.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

This patch is from below the scissors at
http://thread.gmane.org/gmane.comp.version-control.git/201434/focus=201485

I think it's a good change, but as usual it's nice if someone else
takes a look at it and gives it a sanity check.  If it seems sane,
I'd be happy to see it applied.  What do you think?

Thanks,
Jonathan

 Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 285c660e..8bfa19cd 100644
--- a/Makefile
+++ b/Makefile
@@ -2263,7 +2263,7 @@ $(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs)
 endif
 
 %.s: %.c GIT-CFLAGS FORCE
-	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
+	$(QUIET_CC)$(CC) -o $@ -S $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
 
 ifdef USE_COMPUTED_HEADER_DEPENDENCIES
 # Take advantage of gcc's on-the-fly dependency generation
-- 
1.7.10.4
