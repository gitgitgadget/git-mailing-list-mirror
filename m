From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] basic threaded delta search
Date: Fri, 07 Sep 2007 12:19:26 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0709071211420.21186@xanadu.home>
References: <11890591912193-git-send-email-nico@cam.org>
 <11890591923123-git-send-email-nico@cam.org>
 <11890591923270-git-send-email-nico@cam.org>
 <1189059193250-git-send-email-nico@cam.org>
 <7vwsv4cm6b.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.9999.0709061014280.21186@xanadu.home>
 <20070907061105.GA1379@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Fri Sep 07 18:19:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITgYR-0005sB-BP
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 18:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbXIGQTa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 12:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757509AbXIGQTa
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 12:19:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27646 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757469AbXIGQT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 12:19:29 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JO000JJRAOEH720@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 07 Sep 2007 12:19:26 -0400 (EDT)
In-reply-to: <20070907061105.GA1379@auto.tuwien.ac.at>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58047>

On Fri, 7 Sep 2007, Martin Koegler wrote:

> On Thu, Sep 06, 2007 at 10:48:06AM -0400, Nicolas Pitre wrote:
> > On Thu, 6 Sep 2007, Junio C Hamano wrote:
> > > Also how would this interact with the LRU
> > > delta base window we discussed a week or two ago?
> > 
> > This is completely orthogonal.
> 
> Maybe we should adjust the split point of the the object list so, that
> objects with the same name hash are processed by one thread, as the LRU
> could provide the most benefit for these objects.
> 
> I think of something like (totally untested):
>         for (i = 0; i < NR_THREADS; i++) {
>                 unsigned sublist_size = list_size / (NR_THREADS - i);
> +		while (sublist_size < list_size && list[0]->hash == list[1]->hash)
> +			sublist_size++;

I guess you mean list[sublist_size-1]->hash == list[sublist_size]->hash.
But yeah that is a good idea.


Nicolas
