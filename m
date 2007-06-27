From: Roman Kagan <rkagan@sw.ru>
Subject: Re: parsecvs fails even on simple input
Date: Wed, 27 Jun 2007 19:33:00 +0400
Message-ID: <20070627153300.GA27933@rkagan.sw.ru>
References: <20070622113625.GD12473@rkagan.sw.ru> <1182720667.13289.41.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Al Viro <viro@zeniv.linux.org.uk>, git@vger.kernel.org
To: Keith Packard <keithp@keithp.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 17:33:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3ZWL-0000WE-N4
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 17:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818AbXF0Pd1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 11:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753627AbXF0Pd1
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 11:33:27 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:37231 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753542AbXF0Pd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 11:33:26 -0400
Received: from rkagan.sw.ru ([192.168.3.19])
	by relay.sw.ru (8.13.4/8.13.4) with ESMTP id l5RFX08j013608
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 27 Jun 2007 19:33:05 +0400 (MSD)
Mail-Followup-To: Roman Kagan <rkagan@sw.ru>,
	Keith Packard <keithp@keithp.com>,
	Al Viro <viro@zeniv.linux.org.uk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1182720667.13289.41.camel@neko.keithp.com>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51051>

On Sun, Jun 24, 2007 at 10:31:07PM +0100, Keith Packard wrote:
> On Fri, 2007-06-22 at 15:36 +0400, Roman Kagan wrote:
> 
> > The problem is the following: after that commit parsecvs tries to add
> > objects to the git tree on its own via calls to libgit; however, in
> > between it runs git-pack-objects.  Thus objects move to pack files
> > without libgit being aware of it; this results in 'ivalid object'
> > errors.
> 
> Sticking a call to reprepare_packed_git() after the pack creation fixes
> this nicely.

Ehm sort of...  Except that I woudn't call that extern declaration
nice.

I'm now tracking down another problem which I didn't see before:
parsecvs apparently doesn't close .git-cvs/log-XXX files and ends up
exhausting the open file descriptor limit.  I'll update when I have more
info.

> >  Wouldn't it be better to teach parsecvs
> > to speak git-fast-import language instead?
> 
> Avoiding fork/exec is rather important for parsecvs perforamance.

Avoiding _one_ fork/exec is certainly not.

OTOH git-fast-import seems to be essentially the public API for the
parsecvs kind of tasks.  It may be wiser from the maintenance POV to use
that instead of direct libgit calls (unless parsecvs is going to land in
the git tree).  I'll try to find the time and take a look at this
somewhere next week.

Roman.
