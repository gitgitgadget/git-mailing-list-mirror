From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: pack v4 trees with a canonical base
Date: Tue, 10 Sep 2013 17:03:31 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309101652240.20709@syhkavp.arg>
References: <alpine.LFD.2.03.1309091517380.20709@syhkavp.arg>
 <CACsJy8C+SFBRD1czeeK5VBDYT4xA6K+61HgLRnjB+CYJ-2g+uA@mail.gmail.com>
 <xmqqbo40xwnv.fsf@gitster.dls.corp.google.com>
 <alpine.LFD.2.03.1309101615080.20709@syhkavp.arg>
 <xmqq38pcxv5z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 23:04:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJV6Y-0005s2-Pc
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 23:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665Ab3IJVEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 17:04:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35771 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265Ab3IJVEE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 17:04:04 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSX00534H60VEA0@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 10 Sep 2013 17:03:36 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 8A6092DA0625; Tue, 10 Sep 2013 17:03:36 -0400 (EDT)
In-reply-to: <xmqq38pcxv5z.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234482>

On Tue, 10 Sep 2013, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > On Tue, 10 Sep 2013, Junio C Hamano wrote:
> >
> >> There may be trees in the wild that record 100775 or 100777 in the
> >> mode field for executable blobs, which also need to be special
> >> cased.
> >
> > All the file mode bits are always preserved.  So this is not really a 
> > special case as far as the pack v4 encoding is concerned.
> 
> Ahh. OK.  It can theoretically be argued that you could further
> squeeze 13 bits out per tree entry because you would need only 5
> possible values (100644, 100755 120000, 40000, and 160000, all
> octal) for the modes, but we will never know what other modes we
> would want to use in the future, so not being over-tight and using
> 16-bit for this purpose is probably a good trade-off

Absolutely.  I tried not to lose any of the currently available 
extension possibilities in the canonical object format.

> (squeezing 8 bits out per tree entry would make the shape of ident 
> table entry and tree path entry different and may hurt reusing the 
> code to parse these tables).

One could argue that 16 bits is much more than sufficient to encode a 
time zone offset too.  but again this didn't seem worth painting 
ourselves in a corner if ever some creative time zones are used.

Those table are also compressed.  So any repetition of the same mode bit 
pattern or sparseness in the tz bits is likely to be compressed well.


Nicolas
