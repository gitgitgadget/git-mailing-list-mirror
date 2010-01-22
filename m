From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Remove diff machinery dependency from read-cache
Date: Thu, 21 Jan 2010 21:35:08 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001212131230.1726@xanadu.home>
References: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain>
 <7vljfrp6g2.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001211215080.13231@localhost.localdomain>
 <alpine.LFD.2.00.1001211355500.13231@localhost.localdomain>
 <alpine.LFD.2.00.1001211515470.13231@localhost.localdomain>
 <7v636vj7c2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 03:35:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY9Mj-0005Sv-BT
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 03:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755850Ab0AVCfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 21:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755838Ab0AVCfK
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 21:35:10 -0500
Received: from relais.videotron.ca ([24.201.245.36]:54856 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755832Ab0AVCfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 21:35:09 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KWM00HZAN6KQZE0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 21 Jan 2010 21:35:08 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v636vj7c2.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137724>

On Thu, 21 Jan 2010, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > On Thu, 21 Jan 2010, Linus Torvalds wrote:
> >> 
> >> We could fix it a few ways
> >> 
> >>  - ignore it. Most git programs will get the pack handling functions 
> >>    anyway, since they want to get object reading.
> >
> > In fact, we should probably remove git-show-index. It may have some 
> > historical significance as a pack-file index debugger, but it has no 
> > actual redeeming features now, considering that the binary is a megabyte 
> > of useless crud with debugging info.
> >
> > However, we do actually use it in t/t5302-pack-index.sh. So in the 
> > meantime, how about this hacky patch to simply just avoid xmalloc, and 
> > separating out the trivial hex functions into "hex.o".
> >
> > This results in
> >
> >   [torvalds@nehalem git]$ size git-show-index 
> >        text    data     bss     dec     hex filename
> >      222818    2276  112688  337782   52776 git-show-index (before)
> >        5696     624    1264    7584    1da0 git-show-index (after)
> >
> > which is a whole lot better, no?
> >
> > (Or make it a built-in, if we actually think we want to carry it along in 
> > the long run)
> 
> We tend to not remove things unless we are absolutely certain nobody uses
> it, so probably making it built-in would be preferrable.  I don't think
> show-index is used very often if ever, but scripts that use hash-object
> would use it really often and would do so via its --stdin interface if it
> knows that it is creating more than a dozen objects, so start-up time
> required to map the whole git is probably not an issue.

I do use it, but for developing/debugging pack stuff.
I don't suggest removing it, but I don't think making it a built-in has 
value either.

So I really think that Linus' patch (which is missing hex.c btw) is a 
good thing to do, even if only for the cleanup value.

Then, git-show-index could probably become test-show-index and no longer 
leave the build directory.


Nicolas
