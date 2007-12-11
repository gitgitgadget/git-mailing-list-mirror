From: Nicolas Pitre <nico@cam.org>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 10:00:56 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712110951070.555@xanadu.home>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
 <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>
 <alpine.LFD.0.99999.0712102231570.555@xanadu.home>
 <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>
 <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com>
 <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>
 <alpine.LFD.0.99999.0712110832251.555@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, gcc@gcc.gnu.org,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 16:01:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J26bn-0007op-14
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 16:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbXLKPA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 10:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbXLKPA6
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 10:00:58 -0500
Received: from relais.videotron.ca ([24.201.245.36]:53832 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbXLKPA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 10:00:57 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSW00K134DKJZ40@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 11 Dec 2007 10:00:56 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.0.99999.0712110832251.555@xanadu.home>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67864>

On Tue, 11 Dec 2007, Nicolas Pitre wrote:

> And yet, this is still missing the actual issue.  The issue being that 
> the 2.1GB pack as a _source_ doesn't cause as much memory to be 
> allocated even if the _result_ pack ends up being the same.
> 
> I was able to repack the 2.1GB pack on my machine which has 1GB of ram. 
> Now that it has been repacked, I can't repack it anymore, even when 
> single threaded, as it start crowling into swap fairly quickly.  It is 
> really non intuitive and actually senseless that Git would require twice 
> as much RAM to deal with a pack that is 7 times smaller.

OK, here's something else for you to try:

	core.deltabasecachelimit=0
	pack.threads=2
	pack.deltacachesize=1

With that I'm able to repack the small gcc pack on my machine with 1GB 
of ram using:

	git repack -a -f -d --window=250 --depth=250

and top reports a ~700m virt and ~500m res without hitting swap at all.
It is only at 25% so far, but I was unable to get that far before.

Would be curious to know what you get with 4 threads on your machine.


Nicolas
