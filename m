From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Tue, 22 Jan 2008 19:08:41 -0500
Message-ID: <20080123000841.GA22704@mit.edu>
References: <alpine.LFD.1.00.0!801211407130.2957@woody.linux-foundation.org> <0CA4DF3F-1B64-4F62-8794-6F82C21BD068@sb.org> <alpine.LFD.1.00.0801211538590.2957@woody.linux-foundation.org> <F663E088-BCAD-4C5D-89D5-EAF97A29C1DE@sb.org> <alpine.LFD.1.00.0801211656130.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801211702050.2957@woody.linux-foundati!on.org> <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 01:09:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHTBB-0006KY-Id
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 01:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754059AbYAWAIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 19:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754061AbYAWAIu
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 19:08:50 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:36196 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753764AbYAWAIs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 19:08:48 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m0N08hfd018554;
	Tue, 22 Jan 2008 19:08:43 -0500 (EST)
Received: from closure.thunk.org (c-66-30-1-139.hsd1.ma.comcast.net [66.30.1.139])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m0N08gkD011614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Jan 2008 19:08:43 -0500 (EST)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JHTAY-0005yM-0k; Tue, 22 Jan 2008 19:08:42 -0500
Content-Disposition: inline
In-Reply-To: <20080122133427.GB17804@mit.edu>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71480>

On Tue, Jan 22, 2008 at 08:34:27AM -0500, Theodore Tso wrote:
> 	* Documenting HFS+'s current pseudo-normalization algorithm.
> 	  It's not enough to say that you need to decompose all
> 	  Unicode characters, since you've claimed that HFS+ doesn't
> 	  decompose Unicode characters after some magic date,
> 	  presumably roughly 9 years ago.

I did some research on this point, since if we really are going to be
compatible with MacOS X's crappy HFS+ system, we need to know what the
decomposition algorithm actually is.  Turns out, there are *two* of
them.  Kevin didn't know what he was talking about.  In fact,
different versions of Mac OS X use different normalization algorithms.

Mac OS X 8.1 through 10.2.x used decompositions based on Unicode 2.1.
Mac OS X 10.3 and later use decompositions based on Unicode 3.2.[1]

As I correctly predicted, Apple is changing their normalization
algorithm in different versions of Mac OS X.  It is not static, which
meands there will be compatibility problems when moving hard drives
between Mac OS X versions.  I don't know if they try to fix this in
their fsck or not, when upgrading from 10.2 to 10.3, but if not,
certain files could disappear as part of the Mac OS X upgrade.  Fun
fun fun.

And clearly Kevin didn't read the tech note very carefully, since it
clearly admits why they did it.  The Mac OS X developers were being
cheasy with how they implemented their HFS B-tree algorithms, and took
the cheap, easy way out.  So yeah, "crappy" is the only word that can
be used for what Mac OS X perpetuated on the world.  Because of that,
a quick Google search shows it causes problems all over the stack, for
many different programs beyond just git, including limewire and
gnutella[2][3], Slim[4], and no doubt others.

[1] http://developer.apple.com/technotes/tn/tn1150.html#UnicodeSubtleties
[2] http://lists.limewire.org/pipermail/gui-dev/2003-January/001110.html
[3] http://osdir.com/ml/network.gnutella.limewire.core.devel/2003-01/msg00000.html
[4] http://forums.slimdevices.com/showthread.php?t=40582

In any case, it seems pretty clear that by now everyone except Kevin
has realized that HFS+ is crappy and causes Internet-wide
interoperability problems.  So I'll justify sending this note by
pointing out the specific table of Mac OS's filesystem corruption
algorithm can be found here:

	  http://developer.apple.com/technotes/tn/tn1150table.html

I'd also recommend that the Mac OS X code try to either figure out
whether it is running on an HFS+ partition, or let the HFS+ workaround
code be something that can be controlled via .git/config.  It
shouldn't be on unconditionally even on a Mac OS X system, since if
the git repository is on a ZFS or NFS filesystem, there's no reason to
pay the overhead of working around the HFS+ bugs.

						- Ted
