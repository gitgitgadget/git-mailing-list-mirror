From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 4/4] cygwin: Use native Win32 API for stat
Date: Mon, 29 Sep 2008 08:34:00 -0700
Message-ID: <20080929153400.GJ17584@spearce.org>
References: <20080927084349.GC21650@dpotapov.dyndns.org> <200809272035.03833.johannes.sixt@telecom.at> <20080927215406.GG21650@dpotapov.dyndns.org> <200809281124.08364.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Marcus Griep <marcus@griep.us>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Sep 29 17:35:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkKmH-0006M7-Vp
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 17:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbYI2PeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 11:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbYI2PeD
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 11:34:03 -0400
Received: from george.spearce.org ([209.20.77.23]:44796 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbYI2PeB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 11:34:01 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7E6A43835F; Mon, 29 Sep 2008 15:34:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200809281124.08364.johannes.sixt@telecom.at>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97026>

Johannes Sixt <johannes.sixt@telecom.at> wrote:
> On Samstag, 27. September 2008, Dmitry Potapov wrote:
> > On Sat, Sep 27, 2008 at 08:35:03PM +0200, Johannes Sixt wrote:
> > > > +core.cygwinNativeStat::
> > >
> > > This name is *really* odd, for two reasons:
> ...
> > It was Shawn's suggestion. I don't care much about the name as long as
> > it is explained in the documentation... Therefore, I accepted what Shawn
> > said without giving it any thought.
> 
> Shawn is an importen git-o-maniac, but it's certainly not blasphemy to 
> question his words of wisdom ;)

As Hannes points out, blindly accepting anything I say might not
be a good idea.  I have my moments of sanity, but I'm far, far
from perfect.  ;-)

> My point is that emphasis on "stat" in the name is wrong: That's about 
> implementation, but not about the effect. Why wouldn't 'ignoreCygwinFSTricks' 
> be specific enough?

I like this a lot better.  I could see us also bypassing other Cygwin
functions like open() in order to get faster system calls for Git.
Since it would be byassing the same Cygwin path name translation
code it should be controlled by the same flag.

> (And the length of the name doesn't 
> worry me, considering how many people would want to change the default.)

Agreed.  Most people setting it would copy and paste from the
documentation anyway.

I wonder though if we can't automatically implement it by grabbing
a copy of the Cygwin mount table and comparing those paths to
$GIT_DIR or $GIT_WORK_TREE.  If any mount table entry is contained
within either of them then we know we can't use the native stat.
Its rather common for neither of these to contain a mount point,
and it is therefore easy to enable the native stat.

-- 
Shawn.
