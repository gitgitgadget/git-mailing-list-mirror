From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Support 64-bit indexes for pack files.
Date: Mon, 26 Feb 2007 19:24:17 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702261916560.29426@xanadu.home>
References: <200702261540.27080.ttelford.groups@gmail.com>
 <20070226235510.GF1639@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Troy Telford <ttelford.groups@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 01:24:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLq8k-00052w-0f
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 01:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbXB0AYT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 19:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbXB0AYT
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 19:24:19 -0500
Received: from relais.videotron.ca ([24.201.245.36]:21358 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbXB0AYT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 19:24:19 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE300INRIGHOIA1@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Feb 2007 19:24:18 -0500 (EST)
In-reply-to: <20070226235510.GF1639@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40677>

On Mon, 26 Feb 2007, Shawn O. Pearce wrote:

> Our topic also requires us to change the index file format, and
> in doing so we have decided to extend the index records to look
> something like the following[*1*]:
> 
> 	object SHA-1
> 	64-bit offset within packfile
> 	32-bit index of next object in packfile
> 
> The latter field is to help pack-objects reuse existing packfile
> data, as today it needs to sort everything on its own on the fly.
> Having that last field of data will help avoid that, and will keep
> the index nicely aligned for 64-bit accesses to the offset.

Wouldn't that later field help the sliding mmap code as well, knowing in 
advance what storage size a given object has? (I didn't look at the 
sliding mmap code so I don't know).

Actually I've been thinking about another format already.

What about keeping the pack offset as 32 bits like it is today, but for 
index v2 if the top bit is set then this become an index into another 
table containing 64-bit offsets as needed.  This way there is no waste 
of space for most projects where the pack has yet to reach the 2GB limit 
for many years to come.


Nicolas
