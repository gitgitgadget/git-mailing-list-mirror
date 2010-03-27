From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Fri, 26 Mar 2010 21:56:59 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003262142121.694@xanadu.home>
References: <20100326215600.GA10910@spearce.org>
 <20100326222659.GA18369@progeny.tock> <20100326222950.GB10910@spearce.org>
 <4BAD3C6E.4090604@gmail.com> <20100326230537.GC10910@spearce.org>
 <7v7hoyabiv.fsf@alter.siamese.dyndns.org>
 <32541b131003261656h430d77a8q753c6141297e8f86@mail.gmail.com>
 <4BAD4A82.5070703@gmail.com> <20100327012211.GD10910@spearce.org>
 <alpine.LFD.2.00.1003262125120.694@xanadu.home>
 <20100327013443.GE10910@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Mike.lifeguard" <mike.lifeguard@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 27 02:57:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvLGz-00082a-MU
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 02:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837Ab0C0B5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 21:57:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:10972 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab0C0B5E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 21:57:04 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KZX00J3E42ZINB0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 26 Mar 2010 21:56:59 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100327013443.GE10910@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143312>

On Fri, 26 Mar 2010, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Fri, 26 Mar 2010, Shawn O. Pearce wrote:
> > > Given that GitHub has blessed the world with this corruption,
> > > we may need to modify JGit to accept it.
> > 
> > Should we?
> > 
> > This is going to screw up pack v4 (yes, someday I'll have the time to 
> > make it real).
> 
> Exactly.  I *really* don't want to permit this sort of corruption
> in a Git repository.
> 
> But GitHub's approach here seems to be "Meh, its fine, don't worry
> about it".

It's up to GitHub to fork Git then, and while at it stop calling it Git 
compatible.  Really.  If we start to get slack about the pack format 
like this then every Git reimplementation du jour will make similar 
deviations except in different directions and we'll end up with a mess 
to support.

And in this case there is _no_ excuse as 'git fsck' is actually 
complaining.

My stance has always been that the C Git is authoritative with regards to 
formats and protocols.  It's up to Github to fix their screw-up.

> Its *NOT* fine.  But Avery and Junio might disagree with me.  :-)

FWIW I agree with you.

> Though, FWIW, it might not screw up pack v4.  IIRC from our
> discussions long ago on pack v4, we store "$mode $name" pairs in
> an indexed list, preciously because we needed to support odd modes
> like 10664 from ancient Git binaries.  If we continue to allow this
> corruption, it means we have to ensure $mode is the octal string
> and not the binary value.

Which is a real pity.

In fact, my position is that pack v4 would simply refuse to optimize the 
encoding for such tree objects, period.  Only the non ambiguously 
encoded tree objects would benefit from the v4 improvements.


Nicolas
