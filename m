From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] pack-objects: fix threaded load balancing
Date: Tue, 11 Dec 2007 12:28:30 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712111227080.555@xanadu.home>
References: <alpine.LFD.0.99999.0712080000120.555@xanadu.home>
 <475EC2AB.60702@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jon Smirl <jonsmirl@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 11 18:28:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J28ua-0007ui-4S
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 18:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbXLKR2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 12:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbXLKR2c
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 12:28:32 -0500
Received: from relais.videotron.ca ([24.201.245.36]:62856 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbXLKR2b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 12:28:31 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSW0088TB7IKS20@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 11 Dec 2007 12:28:31 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <475EC2AB.60702@viscovery.net>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67889>

On Tue, 11 Dec 2007, Johannes Sixt wrote:

> Nicolas Pitre schrieb:
> > @@ -1612,10 +1620,10 @@ static void *threaded_find_deltas(void *arg)
> >  		pthread_mutex_lock(&data_ready);
> >  		pthread_mutex_unlock(&data_request);
> >  
> > -		if (!me->list_size)
> > +		if (!me->remaining)
> >  			return NULL;
> >  
> > -		find_deltas(me->list, me->list_size,
> > +		find_deltas(me->list, &me->remaining,
> >  			    me->window, me->depth, me->processed);
> >  	}
> >  }
> 
> This hunk caught my attention. &data_ready is locked, but not released in
> this function.
> 
> Looking more closely at the code surrounding this hunk, it seems that the
> lock is released in a *different* thread than the one that locked it. This
> works on Linux, but is not portable. We will have to use condition variables
> like every one else does in a producer-consumer-like scenario.

Are you willing to make a patch for it?


Nicolas
