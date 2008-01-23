From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's not in 'master', and likely not to be until 1.5.4
Date: Tue, 22 Jan 2008 23:44:28 -0500
Message-ID: <20080123044428.GK24004@spearce.org>
References: <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org> <47908CAF.90101@viscovery.net> <alpine.LSU.1.00.0801181948060.5731@racer.site> <alpine.LSU.1.00.0801182055340.5731@racer.site> <20080121044632.GH24004@spearce.org> <alpine.LSU.1.00.0801211034040.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 23 05:45:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHXUB-00018U-9W
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 05:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097AbYAWEoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 23:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753135AbYAWEoe
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 23:44:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43554 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbYAWEod (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 23:44:33 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JHXTF-000350-Nj; Tue, 22 Jan 2008 23:44:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3478E20FBAE; Tue, 22 Jan 2008 23:44:28 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801211034040.5731@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71509>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Note: There might be yet a better way.  Instead of trying each and every 
> time, we could detect the presence of msgfmt with something like this:
> 
> +ifeq $(shell msgfmt2 2>/dev/null >/dev/null; echo $?) = 127
> +	MSGFMT = $(TCL_PATH) po/po2msg.sh
> +endif

I like it.  I'm applying this diff (which I tested) to git-gui:

diff --git a/Makefile b/Makefile
index 1baf4b0..5f1023e 100644
--- a/Makefile
+++ b/Makefile
@@ -198,6 +198,9 @@ ifdef NO_MSGFMT
 	MSGFMT ?= $(TCL_PATH) po/po2msg.sh
 else
 	MSGFMT ?= msgfmt
+	ifeq ($(shell $(MSGFMT) >/dev/null 2>&1 || echo $$?),127)
+		MSGFMT := $(TCL_PATH) po/po2msg.sh
+	endif
 endif
 
 msgsdir     = $(gg_libdir)/msgs

-- 
Shawn.
