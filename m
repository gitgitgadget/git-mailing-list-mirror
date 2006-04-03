From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: parsecvs tool now creates git repositories
Date: Mon, 3 Apr 2006 15:58:34 +0200
Organization: Harddisk-recovery.com
Message-ID: <20060403135834.GD16823@harddisk-recovery.com>
References: <1143956188.2303.39.camel@neko.keithp.com> <20060402093906.GH1259@lug-owl.de> <20060402193144.GK1259@lug-owl.de> <1144037456.2303.92.camel@neko.keithp.com> <20060403072554.GN1259@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 03 15:59:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQPZo-0007a1-PD
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 15:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWDCN6g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 09:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWDCN6g
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 09:58:36 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:64924 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751221AbWDCN6g (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 09:58:36 -0400
Received: (qmail 13614 invoked by uid 501); 3 Apr 2006 15:58:34 +0200
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Content-Disposition: inline
In-Reply-To: <20060403072554.GN1259@lug-owl.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18327>

On Mon, Apr 03, 2006 at 09:25:54AM +0200, Jan-Benedict Glaw wrote:
> On Sun, 2006-04-02 21:10:56 -0700, Keith Packard <keithp@keithp.com> wrote:
> > I think this is a bug in your version of flex; I'm using standard lex
> > conventions here. I don't know how to make it work for you.
> 
> It compiles for me with this patch (thanks to Linus for the hint):
> 
> diff --git a/Makefile b/Makefile

[...]

> Would you please verify that it doesn't break things for you?

Almost there. I applied your patch and ran "make clean", but the
Makefile forgets to remove lex.c. Here's an updated patch:

diff --git a/Makefile b/Makefile
index 639353a..5651e70 100644
--- a/Makefile
+++ b/Makefile
@@ -3,7 +3,8 @@ GCC_WARNINGS2=-Wmissing-prototypes -Wmis
 GCC_WARNINGS3=-Wnested-externs -fno-strict-aliasing
 GCC_WARNINGS=$(GCC_WARNINGS1) $(GCC_WARNINGS2) $(GCC_WARNINGS3)
 CFLAGS=-O0 -g $(GCC_WARNINGS)
-YFLAGS=-d
+YFLAGS=-d -l
+LFLAGS=-l
 
 SRCS=gram.y lex.l cvs.h parsecvs.c cvsutil.c revlist.c atom.c revcvs.c git.c
 
@@ -20,4 +21,4 @@ lex.o: lex.c
 y.tab.h: gram.c
 
 clean:
-	rm -f $(OBJS) y.tab.h gram.c parsecvs
+	rm -f $(OBJS) y.tab.h gram.c lex.c parsecvs



It compiles! Ship it! ;-)


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
