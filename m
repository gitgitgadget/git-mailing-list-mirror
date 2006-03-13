From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [BUG] imap-send.c fails to build on OSX
Date: Sun, 12 Mar 2006 23:25:52 -0500
Message-ID: <20060313042552.GA18136@spearce.org>
References: <863bhnlo3r.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 05:26:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIedF-0002jU-5t
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 05:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWCME0A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 23:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWCME0A
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 23:26:00 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:18879 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932098AbWCMEZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Mar 2006 23:25:59 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FIeco-0000Zh-BZ; Sun, 12 Mar 2006 23:25:42 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 302D020FBAC; Sun, 12 Mar 2006 23:25:52 -0500 (EST)
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <863bhnlo3r.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17544>

Workarounds for compiling on MacOS X.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---
 "Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
 > 
 >     gcc -o imap-send.o -c -g -O2 -Wall -I/sw/include -I/opt/local/include -DSHA1_HEADER='<openssl/sha.h>'  imap-send.c
 >     imap-send.c:376: error: static declaration of 'vasprintf' follows non-static declaration
 >     /usr/include/stdio.h:297: error: previous declaration of 'vasprintf' was here
 >     make: *** [imap-send.o] Error 1

 This should fix the build issues on Mac OS X.  Not tested on other
 (possibly) more important platforms, like Linux.  :-)

 generate-cmdlist.sh |    2 +-
 imap-send.c         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

base 57f4a482a7fc31e31cafd31fe23f4a4779b2c2f0
last 6854050e1cdaf1b7ab352e1d4757ff5b29a5db93
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 6ee85d5..76ba49c 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -42,7 +42,7 @@ EOF
 while read cmd
 do
     sed -n "/NAME/,/git-$cmd/H;
-	    \$ {x; s/.*git-$cmd - \\(.*\\)/  {\"$cmd\", \"\1\"},/; p}" \
+	    \$ {x; s/.*git-$cmd - \\(.*\\)/  {\"$cmd\", \"\1\"},/; p;}" \
 	"Documentation/git-$cmd.txt"
 done
 echo "};"
diff --git a/imap-send.c b/imap-send.c
index fddaac0..376929f 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -370,7 +370,7 @@ free_generic_messages( message_t *msgs )
 	}
 }
 
-static int
+int
 vasprintf( char **strp, const char *fmt, va_list ap )
 {
 	int len;
-- 
1.2.4.g806b
