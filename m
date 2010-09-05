From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 04 Sep 2010 21:32:04 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009042119570.19366@xanadu.home>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
 <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
 <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
 <4C7FC3DC.3060907@gmail.com>
 <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
 <alpine.LFD.2.00.1009021249510.19366@xanadu.home>
 <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
 <alpine.LFD.2.00.1009021624170.19366@xanadu.home>
 <B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
 <7voccezr7m.fsf@alter.siamese.dyndns.org> <20100903183120.GA4887@thunk.org>
 <alpine.LFD.2.00.1009031522590.19366@xanadu.home>
 <04755B03-EE1D-48FA-8894-33AA8E2661C0@mit.edu>
 <AANLkTikVf=X8cLP9s6W9VGOt0EHE4J5MYsBpgKYhrAri@mail.gmail.com>
 <AANLkTim1XMY6Qe+h9LpqfoBzFE+B5AobcOpHx1rDfXwZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Kyle Moffett <kyle@moffetthome.net>, Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 03:32:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os45e-0006GT-9E
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 03:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555Ab0IEBcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 21:32:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22536 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235Ab0IEBcE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 21:32:04 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L8900HV92XGG3D0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 04 Sep 2010 21:32:04 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTim1XMY6Qe+h9LpqfoBzFE+B5AobcOpHx1rDfXwZ@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155406>

On Sat, 4 Sep 2010, Luke Kenneth Casson Leighton wrote:

> so, i believe that a much simpler algorithm is to follow nicolas' advice, and:
> 
> * split up a pack-index file by its fanout (1st byte of SHAs in the idx)
> * create SHA1s of the list of object-refs within an individual fanout
> * compare the per-fanout SHA1s remote and local
> * if same, deduce "oh look, we have that per-fanout list already"
> * grab the per-fanout object-ref list using standard p2p filesharing
> 
> in this way you'd end up breaking down e.g. 50mb of pack-index (for
> e.g. linux-2.6.git) into rouughly 200k chunks, and you'd exchange
> rouughly 50k of network traffic to find out that you'd got some of
> those fanout object-ref-lists already.  which is nice.

Scrap that idea -- this won't work.  The problem is that, by nature, 
SHA1 is totally random.  So if you have, say, 256 objects to transfer 
(and 256 objects is not that much) then, statistically, the probability 
that the SHA1s for those objects end up uniformly distributed across all 
the 256 fanouts is quite high.  the algorithm I mentioned completely 
breaks down in that case.


Nicolas
