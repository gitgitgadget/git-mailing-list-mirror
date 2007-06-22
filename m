From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Make list of features auto-managed.
Date: Fri, 22 Jun 2007 01:15:15 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706220103090.20596@xanadu.home>
References: <20070621045903.GA14047@spearce.org>
 <7v1wg55065.fsf@assigned-by-dhcp.pobox.com>
 <20070621061045.GG8477@spearce.org>
 <7vr6o5zt76.fsf@assigned-by-dhcp.pobox.com>
 <7vhcp1y954.fsf_-_@assigned-by-dhcp.pobox.com>
 <7vwsxxwtrh.fsf@assigned-by-dhcp.pobox.com>
 <alpine.LFD.0.99.0706211137020.20596@xanadu.home>
 <7v7ipxw1bq.fsf@assigned-by-dhcp.pobox.com>
 <20070622032502.GA17393@spearce.org>
 <alpine.LFD.0.99.0706212337030.20596@xanadu.home>
 <20070622043329.GE17393@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 22 07:15:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1bUO-0008Kj-8n
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 07:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbXFVFPS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 01:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbXFVFPS
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 01:15:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40367 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbXFVFPR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 01:15:17 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JK000JC4ULFEK80@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 22 Jun 2007 01:15:16 -0400 (EDT)
In-reply-to: <20070622043329.GE17393@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50676>

On Fri, 22 Jun 2007, Shawn O. Pearce wrote:

> Yes, however my point here is that I think we have historically
> been bad about making our software reasonably future-proof.
> 
> The .pack file has a version field, with value 2.  REF_DELTA is not
> supported by those binaries that predated its introduction.  They are
> unable to properly unpack, index or read a packfile using REF_DELTA.
> Why did the .pack version stay at 2 if REF_DELTA is used in the file?

Because:

1) you wouldn't be able to properly unpack, index or read a pack file 
   using those deltas even with a different pack version _anyway_, and

2) the pack encoding itself has not changed at all.

And #2 is real.  The introduction of an additional object type didn't 
turn the pack content into something that old git versions could 
(mis)interpret and be fooled by.

On the other hand, changes leading to pack version 3 really required a 
pack version bump as those changes could really be misinterpreted by 
older git versions.

The fact that old git versions call the pack corrupt when it contains 
unknown objects is a problem with the error message not the pack 
version.  We even had a bad error message for unknown pack versions too 
before you improved it.


Nicolas
