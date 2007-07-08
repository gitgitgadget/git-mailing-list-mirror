From: bdowning@lavos.net (Brian Downing)
Subject: Re: git cvsimport branches not consistent with CVS branches
Date: Sun, 8 Jul 2007 16:02:18 -0500
Message-ID: <20070708210217.GE4087@lavos.net>
References: <46903396.1010507@heydon.com.au> <20070708054520.GD4087@lavos.net> <200707081253.06129.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0707081246040.4248@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Gordon Heydon <gordon@heydon.com.au>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 23:02:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7du4-0006Vs-2g
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 23:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756917AbXGHVC2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 17:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756908AbXGHVC2
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 17:02:28 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:25753 "EHLO
	asav08.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756917AbXGHVC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 17:02:27 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav08.insightbb.com with ESMTP; 08 Jul 2007 17:02:26 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah5FAKTtkEZKhvbzR2dsb2JhbACBTIVdiAIBAT8B
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 355CE309F31; Sun,  8 Jul 2007 16:02:18 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707081246040.4248@racer.site>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51918>

On Sun, Jul 08, 2007 at 12:47:16PM +0100, Johannes Schindelin wrote:
> The only problem is that it is a misnomer: it is not fromcvs, but
> fromrcs, since you have to have access at the _files_. This is not
> always possible.

For the problem space I'm interested in (a /fast/ incremental CVS
importer) I think access to the RCS files is a must.  You can use inode
signatures to know which files you have to look at at all since the last
run, and you can abort your parse at the end of the delta section if no
new revisions appeared (rather than continuing to parse the deltatext
section, the largest part of the file).

For the repository I'm interested in (work), running a "real" cvs update
takes two or three minutes on a LAN.  Running a full rlog takes about
10 or so.  With the tricks above, I can import a single file change in
seconds instead.  (That includes the time to rsync the CVS repository
to my local mirror.)

Granted, though, not everyone can get access to the RCS files.

(The name's not really a misnomer though.  There's tons of CVS-specific
crap you have to deal with in the RCS file to successfully import it --
magic branch revision symbols, horrible vendor branch behavior, etc.)

I will try fromcvs; I hadn't looked at it, since from the documentation
it looked like it wasn't incremental.

-bcd
