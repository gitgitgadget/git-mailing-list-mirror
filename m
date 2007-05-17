From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Smart fetch via HTTP?
Date: Thu, 17 May 2007 11:48:47 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705171143350.6410@racer.site>
References: <20070515201006.GD3653@efreet.light.src>
 <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com>
 <Pine.LNX.4.64.0705161232120.6410@racer.site>
 <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com>
 <Pine.LNX.4.64.0705170152470.6410@racer.site> <20070517010335.GU3141@spearce.org>
 <alpine.LFD.0.99.0705162309310.24220@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu May 17 12:49:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HodXe-0008VJ-82
	for gcvg-git@gmane.org; Thu, 17 May 2007 12:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755060AbXEQKs6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 06:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755195AbXEQKs6
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 06:48:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:47956 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755060AbXEQKs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 06:48:58 -0400
Received: (qmail invoked by alias); 17 May 2007 10:48:56 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp035) with SMTP; 17 May 2007 12:48:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hJzQp1+chQ8XSt143vdukIDIK0hKOj2FuMFwwpx
	CnjxD8gwSXq9QU
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.99.0705162309310.24220@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47509>

Hi,

On Wed, 16 May 2007, Nicolas Pitre wrote:

> Still... I wonder if this could be actually workable.  A typical daily 
> update on the Linux kernel repository might consist of a couple hundreds 
> or a few tousands objects.  This could still be faster to fetch parts of 
> a pack than the whole pack if the size difference is above a certain 
> treshold.  It is certainly not worse than fetching loose objects.
> 
> Things would be pretty horrid if you think of fetching a commit object, 
> parsing it to find out what tree object to fetch, then parse that tree 
> object to find out what other objects to fetch, and so on.
> 
> But if you only take the approach of fetching the pack index files, 
> finding out about the objects that the remote has that are not available 
> locally, and then fetching all those objects from within pack files 
> without even looking at them (except for deltas), then it should be 
> possible to issue a couple requests in parallel and possibly have decent 
> performances.  And if it turns out that more than, say, 70% of a 
> particular pack is to be fetched (you can determine that up front), then 
> it might be decided to fetch the whole pack.
> 
> There is no way to sensibly keep those objects packed on the receiving 
> end of course, but storing them as loose objects and repacking them 
> afterwards should be just fine.
> 
> Of course you'll get objects from branches in the remote repository you 
> might not be interested in, but that's a price to pay for such a hack.  
> On average the overhead shouldn't be that big anyway if branches within 
> a repository are somewhat related.
> 
> I think this is something worth experimenting.

I am a bit wary about that, because it is so complex. IMHO a cgi which 
gets, say, up to a hundred refs (maybe something like ref~0, ref~1, ref~2, 
ref~4, ref~8, ref~16, ... for the refs), and then makes a bundle for that 
case on the fly, is easier to do.

Of course, as with all cgi scripts, you have to make sure that DOS attacks 
have a low probability of success.

Ciao,
Dscho
