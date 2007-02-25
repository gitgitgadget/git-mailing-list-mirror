From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Problems installing as root
Date: Sun, 25 Feb 2007 01:12:58 -0500
Message-ID: <20070225061258.GA1415@spearce.org>
References: <erpljl$ln9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: walt <wa1ter@myrealbox.com>
X-From: git-owner@vger.kernel.org Sun Feb 25 07:13:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLCdK-0008Tt-A5
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 07:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbXBYGNF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 01:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932773AbXBYGNF
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 01:13:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:32831 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932630AbXBYGND (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 01:13:03 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HLCd2-00071t-F7; Sun, 25 Feb 2007 01:13:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 61CA720FBAE; Sun, 25 Feb 2007 01:12:58 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <erpljl$ln9$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40536>

walt <wa1ter@myrealbox.com> wrote:
> I'm current as of this morning (7bd59dee...) and I'm still seeing
> two problems with doing 'make' as myself but 'make install' as
> root.
> 
> First, 'make install' as root leaves dozens of files owned by root
> in my personal source directory.  A minor nit, but inconvenient
> during the next 'make'.

Which files, specifically?  I'm sure that the following would be
built as root during 'make install':

  GIT-CFLAGS
  GIT-VERSION-FILE
  git-gui/GIT-VERSION-FILE
  git-gui/CREDITS-FILE

as these are rebuilt automatically everytime the Makefile runs,
as they are embedding version data from HEAD.  But others would be
interesting to know about.
 
> Second, this is a more recent problem with 'make install':
> make -C git-gui all
> make[1]: Entering directory `/usr/local/mnt/wa1ter/src/git/git-gui'
> GITGUI_VERSION = 0.6.GITGUI

Hmm.  You can't get the right version number for git-gui.  Do you
have tags fetched?

In order to build completely from source git-gui needs its gitgui-*
tags in refs/tags.  Junio pushed the gitgui-0.6.1 tag when he merged
that version into `maint`.

> make[1]: Leaving directory `/usr/local/mnt/wa1ter/src/git/git-gui'
> make[1]: Entering directory `/usr/local/mnt/wa1ter/src/git/git-gui'
> /bin/sh ./CREDITS-GEN
> error: Cannot locate authorship information.
> make[1]: *** [CREDITS-FILE] Error 1

Same error as above.  Only this time it made the build stop, rather
than assuming some default version (0.6.GITGUI).
 
> Now, CREDITS-FILE was generated during 'make' (I checked) so there
> was no need to generate it again during 'make install', yes?

Odd.  We created the CREDITS-FILE during `make` but then barfed
during `make install` by acting like we cannot locate the gitgui tag?

What does `git tag -l | grep gitgui-` give you when run as root?


As a workaround you may be able to copy `git-gui/CREDITS-FILE` to
`git-gui/credits`, then run `make install`.  CREDITS-GEN defaults
to the credits file, as that is shipped in the tarfile.

-- 
Shawn.
