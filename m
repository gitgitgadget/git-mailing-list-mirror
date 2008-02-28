From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: msgmft segfaulting on tiger
Date: Wed, 27 Feb 2008 19:32:12 -0500
Message-ID: <20080228003212.GP8410@spearce.org>
References: <46a038f90802211553g735215c6q260ddc49ac149bb5@mail.gmail.com> <46a038f90802211559w457c5460k7447ba8b38352713@mail.gmail.com> <20080222065836.GE8410@spearce.org> <46a038f90802220957y7db67d8nb6b7ad784124546a@mail.gmail.com> <47C5A974.7080207@gmail.com> <alpine.LSU.1.00.0802271825330.22527@racer.site> <47C5AEFA.5020004@gmail.com> <alpine.LSU.1.00.0802272203270.22527@racer.site> <7vablmqc7q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Gabriel =?utf-8?Q?Salda=C3=B1a?= <gsaldana@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 01:32:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUWhh-0003zk-1S
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 01:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757860AbYB1AcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 19:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757407AbYB1AcS
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 19:32:18 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58215 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754141AbYB1AcR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 19:32:17 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JUWgt-0004ye-GS; Wed, 27 Feb 2008 19:32:03 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 63FC720FBAE; Wed, 27 Feb 2008 19:32:12 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vablmqc7q.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75331>

Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> $ msgfmt --tcl; echo $?
> >> msgfmt: unrecognized option `--tcl'
> >> Try `msgfmt --help' for more information.
> >> 1
> >
> > Darn.  I think that's the same exit code as for any other invocation 
> > without filename.
> 
> How about...
> 
>     $ msgfmt --tcl -l C -d . /dev/null; echo $?


I can't test this, my msgfmt --tcl works properly.  Can someone
who has a msgfmt lacking tcl support confirm this will work?

--8<--
[PATCH] git-gui: Gracefully fall back to po2msg.sh if msgfmt --tcl fails

Mac OS X Tiger may have a msgfmt available but it doesn't understand
how to implement --tcl.  Falling back to po2msg.sh on such systems
is a reasonable behavior.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Makefile |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 01e0a46..1bd11eb 100644
--- a/Makefile
+++ b/Makefile
@@ -224,6 +224,11 @@ else
 	ifeq ($(shell $(MSGFMT) >/dev/null 2>&1 || echo $$?),127)
 		MSGFMT := $(TCL_PATH) po/po2msg.sh
 	endif
+	ifeq (msgfmt,$(MSGFMT))
+	ifeq ($(shell $(MSGFMT) --tcl -l C -d . /dev/null || echo $?),1)
+		MSGFMT := $(TCL_PATH) po/po2msg.sh
+	endif
+	endif
 endif
 
 msgsdir     = $(gg_libdir)/msgs
-- 
1.5.4.3.295.g6b554


-- 
Shawn.
