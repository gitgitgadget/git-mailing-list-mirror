From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack
 file format"
Date: Tue, 11 Jul 2006 21:20:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607112116270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <20060711145527.GA32468@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org> <Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
 <Pine.LNX.4.63.0607112031150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0607111153170.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Baldwin <cnb@fc.hp.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 11 21:20:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0Nmb-0000Qg-QP
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 21:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWGKTUa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 15:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWGKTUa
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 15:20:30 -0400
Received: from mail.gmx.net ([213.165.64.21]:40677 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751141AbWGKTUa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 15:20:30 -0400
Received: (qmail invoked by alias); 11 Jul 2006 19:20:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp015) with SMTP; 11 Jul 2006 21:20:28 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607111153170.5623@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23728>

Hi,

On Tue, 11 Jul 2006, Linus Torvalds wrote:

> On Tue, 11 Jul 2006, Johannes Schindelin wrote:
> 
> > You might want to add a comment saying "since the type is lowercase in 
> > ascii format, object_type must be 6 or 7, which is an invalid object 
> > type." It took me a little to figure that out...
> 
> It's not even correct in my version - I check the ASCII header _first_, so 
> by the time it looks at the binary one, it already knows it's not ascii.

Just realized it all by myself...

> Or, more likely, the parse_sha1_header() function should just be changed 
> to check the binary format first (and then add your comment about why that 
> is safe).

Yes, exactly.

> > > +	bits = 4;
> > > +	while (!(c & 0x80)) {
> > > +		if (bits >= 8*sizeof(unsigned long))
> > > +			return -1;
> > > +		c = *hdr++;
> > > +		size += (unsigned long) (c & 0x7f) << bits;
> > > +		bytes++;
> > > +		bits += 7;
> > > +	}
> > 
> > Are you not losing the last byte by putting the "while" _before_ instead 
> > of _after_ the loop?
> 
> No. The very first byte can have the 0x80 end marker, when the size was 
> between 0..15.

Yes, I understand now. I was a little confused by the way it is written...

Thanks for the clarification,
Dscho
