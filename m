From: Johan Herland <johan@herland.net>
Subject: Re: pack operation is thrashing my server
Date: Wed, 13 Aug 2008 18:10:19 +0200
Message-ID: <200808131810.19914.johan@herland.net>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <m363q5t152.fsf@localhost.localdomain> <20080813150425.GC3782@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Nicolas Pitre <nico@cam.org>, Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 18:17:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTJ2U-0006wK-Po
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 18:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbYHMQQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 12:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbYHMQQa
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 12:16:30 -0400
Received: from sam.opera.com ([213.236.208.81]:51773 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751855AbYHMQQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 12:16:29 -0400
X-Greylist: delayed 340 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Aug 2008 12:16:29 EDT
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m7DGAK1o027744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 13 Aug 2008 16:10:20 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <20080813150425.GC3782@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92237>

On Wednesday 13 August 2008, Shawn O. Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
> > Nicolas Pitre <nico@cam.org> writes:
> > > On Tue, 12 Aug 2008, Geert Bosch wrote:
> > > > One nice optimization we could do for those pesky binary large
> > > > objects (like PDF, JPG and GZIP-ed data), is to detect such
> > > > files and revert to compression level 0. This should be
> > > > especially beneficial since already compressed data takes most
> > > > time to compress again.
> > >
> > > That would be a good thing indeed.
> >
> > Perhaps take a sample of some given size and calculate entropy in
> > it? Or just simply add gitattribute for per file compression
> > ratio...
>
> Estimating the entropy would make it "just magic".  Most of Git is
> "just magic" so that's a good direction to take.  I'm not familiar
> enough with the PDF/JPG/GZIP/ZIP stream formats to know what the
> first 4-8k looks like to know if it would give a good indication
> of being already compressed.
>
> Though I'd imagine looking at the first 4k should be sufficient
> for any compressed file.  Having a header composed of 4k of _text_
> before binary compressed data would be nuts.  Or a git-bundle with
> a large refs listing.  ;-)

As for how to estimate entropy, isn't that just a matter of feeding it 
through zlib and compare the output size to the input size? Especially 
if we're already about to feed it through zlib anyway... In other 
words, feed (an initial part of) the data through zlib, and if the 
compression ratio so far looks good, keep going and write out the 
compressed object, otherwise abort zlib and write out the original 
object with compression level 0.

> Hence, "just magic" is probably the better route.

Agreed.


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
