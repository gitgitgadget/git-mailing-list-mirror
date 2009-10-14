From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git hang with corrupted .pack
Date: Wed, 14 Oct 2009 12:42:39 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910141234540.20122@xanadu.home>
References: <20091014042249.GA5250@hexapodia.org>
 <20091014142351.GI9261@spearce.org>
 <alpine.LFD.2.00.0910141208170.20122@xanadu.home>
 <20091014161259.GK9261@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andy Isaacson <adi@hexapodia.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 14 19:34:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My7kD-0004Dh-Um
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 19:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787AbZJNR2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 13:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbZJNR2J
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 13:28:09 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61704 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486AbZJNR2I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 13:28:08 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KRI007TFJR3KC70@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 14 Oct 2009 12:42:39 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20091014161259.GK9261@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130309>

On Wed, 14 Oct 2009, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@fluxnic.net> wrote:
> > > Some types of corruption to a pack may confuse the deflate stream
> > > which stores an object.  In Andy's reported case a 36 byte region
> > > of the pack was overwritten, leading to what appeared to be a valid
> > > deflate stream that was trying to produce a result larger than our
> > > allocated output buffer could accept.
> ...
> > This is unfortunate that making a test case for this isn't exactly 
> > trivial.
> 
> Hmmm.  We could do something like manually create a pack file of
> one non-delta blob whose pack header length is 16, but use a zlib
> stream whose result body is 64.  Prior to this fix, we'd be stuck
> in the infinite loop.  :-)

Ah, of course.

> Its a PITA to create though, you have to hand-craft the test vector
> and save it in the repository, we can't produce such a pack with
> any real code we ship.

Can be done easily with dd though, see do_corrupt_object() in t5303 for 
example.


Nicolas
