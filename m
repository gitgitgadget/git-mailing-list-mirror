From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/14] fork/exec removal series
Date: Sat, 13 Oct 2007 22:58:57 -0400
Message-ID: <20071014025857.GQ27899@spearce.org>
References: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at> <20071014021149.GO27899@spearce.org> <Pine.LNX.4.64.0710140348550.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <johannes.sixt@telecom.at>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 05:07:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgtpI-0002nS-9k
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 05:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754509AbXJNC7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 22:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754345AbXJNC7J
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 22:59:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35920 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbXJNC7I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 22:59:08 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Igtgl-0005HQ-Bt; Sat, 13 Oct 2007 22:58:47 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C565C20FBAE; Sat, 13 Oct 2007 22:58:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710140348550.25221@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60794>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sat, 13 Oct 2007, Shawn O. Pearce wrote:
> 
> > Since builtin-pack-objects now accepts (limited) pthread support, 
> > perhaps this should be implemented in terms of pthread support when 
> > pthreads are available?
> 
> Falling back to fork() when no pthreads are available?  Yes, that makes 
> sense.
> 
> It might also (marginally) speed up operations, since the switches between 
> threads are cheaper than those between processes, right?

Usually.  If we have a large virtual address space (say due to
opening a bunch of packfiles and reading commits out of them into
struct commit* thingies) and the OS does a giant copy of the page
tables during fork() then the pthread creation should be a heck of
a lot cheaper.

But we most definately *must* continue to support fork() for the
async functions.  Its the most common interface available on one
of our biggest platforms (UNIX).

-- 
Shawn.
