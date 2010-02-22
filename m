From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Mon, 22 Feb 2010 15:52:52 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002221552030.1946@xanadu.home>
References: <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <20100219082813.GB17952@dpotapov.dyndns.org>
 <7v635tkta7.fsf@alter.siamese.dyndns.org>
 <7v8waniue8.fsf@alter.siamese.dyndns.org>
 <20100221072142.GA5829@dpotapov.dyndns.org>
 <7vhbpas7ut.fsf@alter.siamese.dyndns.org>
 <20100222033553.GA10191@dpotapov.dyndns.org>
 <7vwry5pxg8.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002221033120.1946@xanadu.home>
 <20100222173122.GG11733@gibbs.hungrycats.org>
 <alpine.LFD.2.00.1002221238110.1946@xanadu.home>
 <7vtyt9cad2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Zygo Blaxell <zblaxell@gibbs.hungrycats.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 21:52:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjfH0-00082e-Cu
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 21:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342Ab0BVUwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 15:52:54 -0500
Received: from relais.videotron.ca ([24.201.245.36]:63425 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199Ab0BVUwx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 15:52:53 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KY900GJFGO4M380@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 22 Feb 2010 15:52:52 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vtyt9cad2.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140712>

On Mon, 22 Feb 2010, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > We do have to make two separate passes anyway.  The first pass is to 
> > hash the data only, and if that hash already exists in the object store 
> > then we call it done and skip over the deflate process which is still 
> > the dominant cost.  And that happens quite often.
> >
> > However, with a really large file, then it becomes advantageous to 
> > simply do the hash and deflate in parallel one chunk at a time, and 
> > simply discard the newly created objects if it happens to already 
> > exists.  That's the whole idea behind the newly introduced 
> > core.bigFileThreshold config variable (but the code to honor it in 
> > sha1_file.c doesn't exist yet).
> 
> The core.bigFileThreshold could be used in sha1_file.c to decide writing
> straight into a new packfile; that would avoid both the later repacking
> cost and the cross directory rename issue for loose object files.

Yep, that's the plan.  Let's find the time now.


Nicolas
