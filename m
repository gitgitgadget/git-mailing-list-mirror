From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] simple euristic for further free packing improvements
Date: Mon, 15 May 2006 22:53:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605152237240.18071@localhost.localdomain>
References: <Pine.LNX.4.64.0605132305580.18071@localhost.localdomain>
 <Pine.LNX.4.64.0605151129540.18071@localhost.localdomain>
 <7v4pzqhh3t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 04:53:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfpgI-0005Ts-HX
	for gcvg-git@gmane.org; Tue, 16 May 2006 04:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWEPCxD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 22:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWEPCxD
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 22:53:03 -0400
Received: from relais.videotron.ca ([24.201.245.36]:1105 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751086AbWEPCxB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 22:53:01 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IZC00D2B80C9SC0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 15 May 2006 22:53:01 -0400 (EDT)
In-reply-to: <7v4pzqhh3t.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20094>

On Mon, 15 May 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > @@ -1038,8 +1038,8 @@ static int try_delta(struct unpacked *tr
> >  
> >  	/* Now some size filtering euristics. */
> >  	size = trg_entry->size;
> > -	max_size = size / 2 - 20;
> > -	if (trg_entry->delta)
> > +	max_size = (size/2 - 20) / (src_entry->depth + 1);
> > +	if (trg_entry->delta && trg_entry->delta_size <= max_size)
> >  		max_size = trg_entry->delta_size-1;
> >  	src_size = src_entry->size;
> >  	sizediff = src_size < size ? size - src_size : 0;
> 
> At the first glance, this seems rather too agressive.  It makes
> me wonder if it is a good balance to penalize the second
> generation base by requiring it to produce a small delta that is
> at most half as we normally would (and the third generation a
> third), or maybe the penalty should kick in more gradually, like
> e.g. ((max_depth * 2 - src_entry->depth) / (max_depth * 2).
> 
> Having said that, judging from your past patches, I learned to
> trust that you have tried tweaking this part and settled on this
> simplicity and elegance, so I'll take the patch as is -- if
> somebody wants to play with it that can always be done to
> further improve things.

Actually I didn't play with that part that much.  The only thing I tried 
besides this version was (size - 20) / (src_entry->depth + 1) but it 
produced larger packs than the current version.

So I thought it was better to provide a simple initial rule and leave 
possible improvements for later.


Nicolas
