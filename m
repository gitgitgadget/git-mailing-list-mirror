From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/3] improve reliability of fixup_pack_header_footer()
Date: Fri, 29 Aug 2008 16:14:14 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808291609030.1624@xanadu.home>
References: <alpine.LFD.1.10.0808282142490.1624@xanadu.home>
 <1219975624-7653-1-git-send-email-nico@cam.org>
 <20080829044459.GA28492@spearce.org>
 <alpine.LFD.1.10.0808290844200.1624@xanadu.home>
 <20080829143023.GA7403@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 22:15:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZANQ-00085h-NB
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 22:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbYH2UOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 16:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbYH2UOU
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 16:14:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23473 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbYH2UOU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 16:14:20 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6D0049FPJQBMF1@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 29 Aug 2008 16:14:14 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080829143023.GA7403@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94327>

On Fri, 29 Aug 2008, Shawn O. Pearce wrote:

> Oh, yea, that makes sense.  It still seems like playing with fire.
> 
> I'd rather the caller pass in the proper offset than rely on it
> being the current position of the fd.  Especially if the caller
> does actually have it available.
> 
> If you change anything, I'd like to see this lseek(SEEK_CUR) go away.

Done.  I struggled a bit since it simply didn't work initially -- see 
the first patch in the updated series.

> > And another thing I had in store (but for which you _again_ beat me to :-) )
> > is to realign data reads onto filesystem blocks.
> 
> That _really_ made the JGit code ugly.  But I think its worth it.

See my version.  I think it is reasonably clear.

> I also want to try and buffer the whole object appending we do
> during fixThinPack(), as right now we write the object header in
> one write and then compressed data bursts in the others.  Moving it
> to at least write a full 4k at a time should remove about 2 write
> calls per object.

Yep.  In the C git case, moving to sha1write() added that buffering 
for free.


Nicolas
