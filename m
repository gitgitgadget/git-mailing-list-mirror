From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Mon, 22 Feb 2010 10:40:59 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002221033120.1946@xanadu.home>
References: <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <20100219082813.GB17952@dpotapov.dyndns.org>
 <7v635tkta7.fsf@alter.siamese.dyndns.org>
 <7v8waniue8.fsf@alter.siamese.dyndns.org>
 <20100221072142.GA5829@dpotapov.dyndns.org>
 <7vhbpas7ut.fsf@alter.siamese.dyndns.org>
 <20100222033553.GA10191@dpotapov.dyndns.org>
 <7vwry5pxg8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 16:41:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjaPI-0007cK-8g
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 16:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090Ab0BVPlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 10:41:05 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58829 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770Ab0BVPlD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 10:41:03 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KY9003RY28BHWM0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 22 Feb 2010 10:41:00 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vwry5pxg8.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140692>

On Sun, 21 Feb 2010, Junio C Hamano wrote:

> Dmitry Potapov <dpotapov@gmail.com> writes:
> 
> > If you look at speed-up numbers, you can think that the numbers are
> > unstable, but in fact, the best time in 5 runs does not differ more
> > than 0.01s between those trials. But because difference for >=128Kb
> > is 0.05s or less, the accuracy of the above numbers is less than 25%.
> 
> Then wouldn't it make the following statement...
> 
> > But overall the outcome is clear -- read() is always a winner.
> 
> "... a winner, below 128kB; above that the difference is within noise and
> measurement error"?

read() is not always a winner.  A read() call will always have the data 
duplicated in memory.  Especially with large files, it is more efficient 
on the system as a whole to mmap() a 50 MB file rather than allocating 
an extra 50 MB of anonymous memory that cannot be paged out (except to 
the swap file which would be yet another data duplication).  With mmap() 
when there is memory pressure the read-only mapped memory is simply 
dropped with no extra IO.

So when read() is not _significantly_ faster than mmap() then it should 
not be used.


Nicolas
