From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [ANNOUNCE] tig 0.7
Date: Thu, 31 May 2007 12:51:13 -0700
Message-ID: <465F2731.2080707@midwinter.com>
References: <20070531123808.GA25719@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Thu May 31 21:51:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Htqgc-0004Hv-Qw
	for gcvg-git@gmane.org; Thu, 31 May 2007 21:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756781AbXEaTvP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 15:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760601AbXEaTvP
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 15:51:15 -0400
Received: from tater.midwinter.com ([216.32.86.90]:56937 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756781AbXEaTvO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 15:51:14 -0400
Received: (qmail 30613 invoked from network); 31 May 2007 19:51:13 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=HgUBoaBIXXH518qqOEkpJyg3jV/PmHVkW1NEsa0Y3MtNhTZf1M2/7qzx5ZV1JMUr  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 31 May 2007 19:51:13 -0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <20070531123808.GA25719@diku.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48818>

This doesn't build on OS X out of the box, FYI. It needs the following 
tweaks (which break the build on Linux, so I'm not suggesting you apply 
this -- looks like you might need a configure script or at least some 
conditionals in the Makefile.) The change to tig.c cleans up a compiler 
warning, but it does build fine without that change.

---
 Makefile |    2 +-
 tig.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 57196b0..db5844c 100644
--- a/Makefile
+++ b/Makefile
@@ -19,7 +19,7 @@ endif
 
 RPM_VERSION = $(subst -,.,$(VERSION))
 
-LDLIBS = -lcurses
+LDLIBS = -lcurses -liconv
 CFLAGS = -Wall -O2 '-DVERSION="$(VERSION)"'
 DFLAGS = -g -DDEBUG -Werror
 PROGS  = tig
diff --git a/tig.c b/tig.c
index e918fe6..e94ef4b 100644
--- a/tig.c
+++ b/tig.c
@@ -1913,7 +1913,7 @@ update_view(struct view *view)
                        line[linelen - 1] = 0;
 
                if (opt_iconv != ICONV_NONE) {
-                       char *inbuf = line;
+                       const char *inbuf = line;
                        size_t inlen = linelen;
 
                        char *outbuf = out_buffer;
-- 
1.5.2.35.ga334
