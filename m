From: Nicolas Pitre <nico@cam.org>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Wed, 14 May 2008 10:24:17 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0805141017210.23581@xanadu.home>
References: <20080512122900.GA13050@mithlond.arda.local>
 <20080512155243.GA3592@mithlond.arda.local>
 <alpine.DEB.1.00.0805121810501.30431@racer>
 <20080512184334.GB5160@mithlond.arda.local>
 <alpine.LFD.1.10.0805121453250.23581@xanadu.home>
 <20080512190946.GC5160@mithlond.arda.local>
 <alpine.LFD.1.10.0805121527550.23581@xanadu.home>
 <20080512202414.GA8620@mithlond.arda.local>
 <20080512210304.GA17352@glandium.org> <20080512210807.GA22221@glandium.org>
 <20080513001252.GB29038@spearce.org>
 <alpine.LFD.1.10.0805132005550.23581@xanadu.home>
 <7vy76dperf.fsf@gitster.siamese.dyndns.org>
 <18474.44155.823000.368851@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Mike Hommey <mh@glandium.org>, Teemu Likonen <tlikonen@iki.fi>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Juergen Ruehle <j.ruehle@bmiag.de>
X-From: git-owner@vger.kernel.org Wed May 14 16:26:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwHvh-0002G8-Jx
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 16:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762037AbYENOYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 10:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762042AbYENOYc
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 10:24:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47488 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759310AbYENOYb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 10:24:31 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K0V00BAX40HSV30@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 14 May 2008 10:24:17 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <18474.44155.823000.368851@lapjr.intranet.kiel.bmiag.de>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82101>

On Wed, 14 May 2008, Juergen Ruehle wrote:

> Junio C Hamano writes:
>  > The output from rev-list is not surprising.  --unpacked=$this.pack implies
>  > the usual --unpacked behaviour (i.e. only show unpacked objects by not
>  > traversing into commits that are packed)
> 
> The problem is unconditional traversing into commits that are
> unpacked. This behavior is immediately obvious if the packed blob in
> the .keep pack is large. 

That's what I was suspecting too.  And because the Linux repo contains 
many files, then a single commit will fetch a large bunch of objects 
indeed.

> I've been using the following since the large
> object discussion with Dana, but it might be completely broken (though
> the test case is probably correct).

This is not some part of git code I'm familiar with, so I can't tell if 
the patch is broken or not.  What I can do is repeat my simple test 
which produces the following results with your patch:

|$ git rev-list --objects 492c2e4..9404ef0
|362
|
|$ git rev-list --objects --all \
|   --unpacked=pack-6a3438b2702be06697023d80b77e67a73a0b0b5c.pack |
|       wc -l
|362

That's exactly what is expected.


Nicolas
