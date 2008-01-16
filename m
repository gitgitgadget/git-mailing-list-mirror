From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui/Makefile - Don't convert gg_libdir on Cygwin
Date: Wed, 16 Jan 2008 01:40:12 -0500
Message-ID: <20080116064012.GO24004@spearce.org>
References: <1199572355-2720-1-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 07:40:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF1x7-0002MD-TL
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 07:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbYAPGkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 01:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752753AbYAPGkS
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 01:40:18 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55094 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbYAPGkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 01:40:16 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JF1wb-0006Mg-Jo; Wed, 16 Jan 2008 01:40:14 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 22BE620FBC9; Wed, 16 Jan 2008 01:40:12 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1199572355-2720-1-git-send-email-mdl123@verizon.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70640>

Mark Levedahl <mdl123@verizon.net> wrote:
> gg_libdir was converted to an absolute Windows path as a remnant of
> logic to check for relative / absolute location of libraries, but that
> does not work on Cygwin. Converting gg_libdir to a Windows path has the
> nasty side-effect that it cannot be prefixed with $DESTDIR, and this
> precludes installing to a staging directory. So, don't convert it.

Hmmph.  That bites.

>  ifeq ($(uname_O),Cygwin)
>  	GITGUI_SCRIPT := `cygpath --windows --absolute "$(GITGUI_SCRIPT)"`
> -	gg_libdir := $(shell cygpath --windows --absolute "$(gg_libdir)")
>  else

The reason I'm doing the UNIX->Windows conversion here is I run
git-gui on a pure Win32 Tcl/Tk build, one that is a lot more recent
than the version that ships as a Cygwin package.  The pure Win32
Tcl/Tk cannot read UNIX paths, so I cannot allow libdir to be a
UNIX path in that case.

Now earlier we used to use relative paths on Windows to find the
libdir at runtime, but we don't do that anymore either, and I'm
not really sure why.  In theory it should still work to make it
relative when possible, and then my installation with the more
native Tcl/Tk would work just fine.

I guess I'm willing to apply your patch and carry the reverse of your
patch as a local-only hack for my needs, but I wonder if anyone else
is also using git-gui on Cygwin with a pure Win32 Tcl/Tk build...

-- 
Shawn.
