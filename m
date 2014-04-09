From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH 17/19] Portable alloca for Git
Date: Wed, 9 Apr 2014 16:48:27 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20140409124827.GA24672@tugrik.mns.mnsspb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
 <f08867ee212e27074dbb4cbb06af408b16dba0a1.1393257006.git.kirr@mns.spb.ru>
 <CABPQNSaVQuXBEnSrs6hdHwEbaBKFr-NjKpuBRNnbkM+HtfJ4Ag@mail.gmail.com>
 <CABPQNSadTGfiue6G+6x7_o10Ri1E7D5vZFU=Cp8rAha+j9jwSA@mail.gmail.com>
 <20140228170012.GA5247@tugrik.mns.mnsspb.ru>
 <CABPQNSYnDjhxjpyZQkNP_qwect_tnPvJ_nEfGSq9qnYFMpehWg@mail.gmail.com>
 <20140305093151.GA3994@tugrik.mns.mnsspb.ru>
 <xmqq1txrp8ur.fsf@gitster.dls.corp.google.com>
 <20140327142250.GC17333@mini.zxlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Gerrit Pape <pape@smarden.org>,
	Petr Salinger <Petr.Salinger@seznam.cz>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Schwinge <tschwinge@gnu.org>, kirr@navytux.spb.ru
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 14:47:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXruU-0004XI-Cg
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 14:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932777AbaDIMrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 08:47:16 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:39812 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932674AbaDIMrN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 08:47:13 -0400
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WXruD-0002pg-DP; Wed, 09 Apr 2014 16:47:05 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WXrvX-0006lU-Lq; Wed, 09 Apr 2014 16:48:27 +0400
Content-Disposition: inline
In-Reply-To: <20140327142250.GC17333@mini.zxlink>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245973>

On Thu, Mar 27, 2014 at 06:22:50PM +0400, Kirill Smelkov wrote:
> On Mon, Mar 24, 2014 at 02:47:24PM -0700, Junio C Hamano wrote:
> > Kirill Smelkov <kirr@mns.spb.ru> writes:
> > 
> > > On Fri, Feb 28, 2014 at 06:19:58PM +0100, Erik Faye-Lund wrote:
> > >> On Fri, Feb 28, 2014 at 6:00 PM, Kirill Smelkov <kirr@mns.spb.ru> wrote:
> > >> ...
> > >> > In fact that would be maybe preferred, for maintainers to enable alloca
> > >> > with knowledge and testing, as one person can't have them all at hand.
> > >> 
> > >> Yeah, you're probably right.
> > >
> > > Erik, the patch has been merged into pu today. Would you please
> > > follow-up with tested MINGW change?
> > 
> > Sooo.... I lost track but this discussion seems to have petered out
> > around here.  I think the copy we have had for a while on 'pu' is
> > basically sound, and can easily built on by platform folks by adding
> > or removing the -DHAVE_ALLOCA_H from the Makefile.
> 
> Yes, that is all correct - that version works and we can improve it in
> the future with platform-specific follow-up patches, if needed.

Junio, thanks for merging this and other diff-tree patches to next.  It
so happened that I'm wrestling with MSysGit today, so please also find
alloca-for-mingw patch attached below.

Thanks,
Kirill

---- 8< ----
Subject: [PATCH] mingw: activate alloca

Both MSVC and MINGW have alloca(3) definitions in malloc.h, so by moving
win32-compat alloca.h from compat/vcbuild/include/ to compat/win32/ ,
which is included by both MSVC and MINGW CFLAGS, we can make alloca()
work on both those Windows environments.

In MINGW, malloc.h has explicit check for GNUC and if it is so, defines
alloca to __builtin_alloca, so it looks like we don't need to add any
code to here-shipped alloca.h to get optimum performance.

Compile-tested on Windows in MSysGit.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 compat/{vcbuild/include => win32}/alloca.h | 0
 config.mak.uname                           | 1 +
 2 files changed, 1 insertion(+)
 rename compat/{vcbuild/include => win32}/alloca.h (100%)

diff --git a/compat/vcbuild/include/alloca.h b/compat/win32/alloca.h
similarity index 100%
rename from compat/vcbuild/include/alloca.h
rename to compat/win32/alloca.h
diff --git a/config.mak.uname b/config.mak.uname
index 17ef893..67bc054 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -480,6 +480,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep = ;
+	HAVE_ALLOCA_H = YesPlease
 	NO_PREAD = YesPlease
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
-- 
1.9.0.msysgit.0.31.g74d1b9a.dirty
