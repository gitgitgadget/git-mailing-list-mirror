From: Nicolas Pitre <nico@cam.org>
Subject: Re: bad object
Date: Wed, 22 Apr 2009 19:20:20 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904221914190.6741@xanadu.home>
References: <20090422184842.GC9541@fieldses.org>
 <7vbpqo31fx.fsf@gitster.siamese.dyndns.org>
 <20090422210001.GI9541@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Apr 23 01:22:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwllX-0002Yl-KL
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 01:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbZDVXU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 19:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbZDVXU1
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 19:20:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43894 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbZDVXU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 19:20:26 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KII007EDZG3EGJ0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 22 Apr 2009 19:19:16 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090422210001.GI9541@fieldses.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117281>

On Wed, 22 Apr 2009, J. Bruce Fields wrote:

> On Wed, Apr 22, 2009 at 12:58:42PM -0700, Junio C Hamano wrote:
> > "J. Bruce Fields" <bfields@fieldses.org> writes:
> > 
> > > Just today operations started warning:
> > >
> > > 	error: Could not read 4e69489a0ac11a9b62a25923975bfc370a30eae5
> > >
> > > This is Documentation/networking/baycom.txt from
> > > 518e6540831c69422faecceee8f964bd439ac9d0 (pre-2.6.13), which is easy
> > > enough to find from another repository and fix the problem.
> > >
> > > But I'm curious--how do I find out what pack file that object should be
> > > in, and what the corruption looks like?
> > 
> > The former you should be able to read from either "verify-pack -v" or
> > "show-index" output.
> 
> Thanks.  So:
> 
> bfields@pig:~/local/linux-2.6$ git verify-pack -v .git/objects/pack/pack-691dbdb94f881bc07a0befa45f288466bde6207b
> error: Packfile index for .git/objects/pack/pack-691dbdb94f881bc07a0befa45f288466bde6207b.pack SHA1 mismatch
> error: packed 000000e0199ffeffffffd143feffd143feff00c0 from .git/objects/pack/pack-691dbdb94f881bc07a0befa45f288466bde6207b.pack is corrupt
> .git/objects/pack/pack-691dbdb94f881bc07a0befa45f288466bde6207b.pack: bad

This is really strange and suspicious to have 
"000000e0199ffeffffffd143feffd143feff00c0" as a SHA1 reference.  It 
somehow lacks quite some randomness.

> I don't have another copy of the pack 691dbdb94....  I guess I could run
> git-unpack-objects and see what it produces for the bad blob?

It will produce nothing but some other error messages.

What you can do is to manually copy the object or a pack containing that 
object into your repository and repack which would get rid of the error.  
But you might want to keep the broken pack and its index around for 
further analysis.


Nicolas
