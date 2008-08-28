From: Nicolas Pitre <nico@cam.org>
Subject: Re: Git-aware HTTP transport
Date: Thu, 28 Aug 2008 14:40:21 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808281432240.1624@xanadu.home>
References: <48B36BCA.8060103@zytor.com> <20080826145857.GF26523@spearce.org>
 <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org>
 <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org>
 <7vhc95iwcs.fsf@gitster.siamese.dyndns.org> <48B6DABD.7090800@zytor.com>
 <20080828171052.GC21072@spearce.org> <48B6DE7A.1020207@zytor.com>
 <20080828172623.GD21072@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 20:41:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYmR4-0006iP-VX
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 20:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbYH1Sk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 14:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbYH1Sk2
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 14:40:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12705 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbYH1Sk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 14:40:27 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6B00BGAQIFDHL0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 28 Aug 2008 14:39:51 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080828172623.GD21072@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94110>

On Thu, 28 Aug 2008, Shawn O. Pearce wrote:

> "H. Peter Anvin" <hpa@zytor.com> wrote:
> > Shawn O. Pearce wrote:
> >> "H. Peter Anvin" <hpa@zytor.com> wrote:
> >>>
> >>> I *think* the "native" git protocol uses binary here.  It makes sense 
> >>> to  be consistent, to allow them to share code?
> >>
> >> No, the native protocol is horribly verbose here:
> >>
> >> 	0032want ac3abe10ed54d512fbbaeb7cef19972eedd8e4a8
> >> 	...
> >>
> >> so its doing it in hex, and its using 10 bytes of "framing" for
> >> every SHA-1 it sends as each is sent in its own pkt-line with the
> >> have/want header.
> >
> > Hm.  It's probably not enough data to worry significantly about.
> 
> Should I change the HTTP protocol then to use the same format,
> so they have a better chance at sharing code between them?

Given that the ref exchange happens on multiple lines (one ref per line) 
in the native protocol, and that your proposal is using one line for 
multiple refs, I don't see this as a big factor wrt code reuse.  Since 
you'll have separate "output" code anyway, why not simply going with 
refs in straight binary for the HTTP protocol?  Even the debugability of 
refs exchange in plain text is dubious especially with all refs on the 
same line (that'll be a pain to split refs out of a long stream of hex 
by hand).


Nicolas
