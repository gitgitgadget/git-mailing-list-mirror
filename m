From: Tony Finch <dot@dotat.at>
Subject: Re: Newton-Raphson, was Re: Performance issue of 'git branch'
Date: Fri, 24 Jul 2009 00:50:47 +0100
Message-ID: <alpine.LSU.2.00.0907240031470.12180@hermes-2.csi.cam.ac.uk>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907221959330.21520@localhost.localdomain> <alpine.LFD.2.01.0907222009340.21520@localhost.localdomain> <alpine.LSU.2.00.0907231846190.30197@hermes-2.csi.cam.ac.uk> <alpine.LFD.2.01.0907231153010.21520@localhost.localdomain>
 <alpine.LSU.2.00.0907232310220.22113@hermes-2.csi.cam.ac.uk> <alpine.DEB.1.00.0907240114410.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 24 01:51:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU848-0006If-HX
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 01:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459AbZGWXvC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 19:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754100AbZGWXvB
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 19:51:01 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:57130 "EHLO
	ppsw-7.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990AbZGWXvB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 19:51:01 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:44694)
	by ppsw-7.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpa (EXTERNAL:fanf2) id 1MU83j-0003vI-Oc (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Fri, 24 Jul 2009 00:50:47 +0100
Received: from fanf2 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1MU83j-0004Fk-Jk (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Fri, 24 Jul 2009 00:50:47 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <alpine.DEB.1.00.0907240114410.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123897>

On Fri, 24 Jul 2009, Johannes Schindelin wrote:
>
> Think about it, absent any further information than "it is a hash, i.e.
> distributed pretty equally in _any_ byte", even subsets of a sorted list
> will me more or less linear.  And assuming that they are linear is _still_
> your best bet.

The even distribution of the lower-order bytes is irrelevant. We're
looking at the top 20-ish bits for a pack with a million-ish objects. The
more you zoom in the less linear a sorted list of hashes will be, so
assuming linearity at all scales is wrong. It's a bit like fractal
mountains.

> There is no way to achieve [O(1) seeks], best thing you can hope for is
> _expected_ O(1) (e.g. with a hashmap, with exponential worst case).

Of course it's expected. However the worst case is nowhere near
exponential: it's linear because the second-order search is a linear
pagewise scan. But I think in practice, the larger the pack the more that
the randomization of the hash function will smooth out performance
oddities. (Sorry, I don't know enough statistics to be able to say what
the expected error of the linear interpolation is, though I expect it's a
fairly simple formula.) For small packs the number of seeks is 1 anyway.

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.
