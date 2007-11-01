From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/5] prune-packed: don't call display_progress() for every
 file
Date: Thu, 01 Nov 2007 08:06:32 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0711010736430.21255@xanadu.home>
References: <1193770655-20492-1-git-send-email-nico@cam.org>
 <1193770655-20492-2-git-send-email-nico@cam.org>
 <20071101025830.GX14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 13:06:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InYoz-0000mn-PM
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 13:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756002AbXKAMGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 08:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755838AbXKAMGe
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 08:06:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39670 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbXKAMGd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 08:06:33 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQT005UKTMW4OD4@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 01 Nov 2007 08:06:33 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071101025830.GX14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62945>

On Wed, 31 Oct 2007, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > The progress count is per fanout directory, so it is useless to call
> > it for every file as the count doesn't change that often.
> 
> If you go back into the history and look at the commit message for
> when I introduced this per-object display_progress() call we find
> the following:
> 
>  commit b5d72f0a4cd3cce945ca0d37e4fa0ebbfcdcdb52
>  Author: Shawn O. Pearce <spearce@spearce.org>
>  Date:   Fri Oct 19 00:08:37 2007 -0400
> 
> [...snip...]
>     We perform the display_progress() call from within the very innermost
>     loop in case we spend more than 1 second within any single object
>     directory.  This ensures that a progress_update event from the
>     timer will still trigger in a timely fashion and allow the user to
>     see the progress meter.

Hmmmm OK.  I overlooked that.

> During my testing with a 40,000 loose object case (yea, I fully
> unpacked a git.git clone I had laying around) my system stalled
> hard in the first object directory.  A *lot* longer than 1 second.
> So I got no progress meter for a long time, and then a progress
> meter appeared on the second directory.

But then don't you get a "0% (1/256)" on the screen for a while, like if 
it was stalled?  Might be better than nothing at all I suppose...

> So I'm a little against this patch.  But I think I understand why
> you think its worth doing.  I just consider the progress feedback
> more important than the few machine cycles avoiding it saves.

OK, I don't mind reverting the patch, or actually providing another one 
to move the call back inside the loop since other changes will prevent a 
clean revert.


Nicolas
