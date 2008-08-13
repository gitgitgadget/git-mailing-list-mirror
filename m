From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: pack operation is thrashing my server
Date: Wed, 13 Aug 2008 08:04:25 -0700
Message-ID: <20080813150425.GC3782@spearce.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> <87vdy71i6w.fsf@basil.nowhere.org> <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com> <20080813031503.GC5855@spearce.org> <70550C21-8358-4BEF-A7BA-3A41C1ACB346@adacore.com> <alpine.LFD.1.10.0808131036590.4352@xanadu.home> <m363q5t152.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>, Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 17:06:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTHuk-0000nC-88
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 17:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbYHMPE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 11:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbYHMPE1
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 11:04:27 -0400
Received: from george.spearce.org ([209.20.77.23]:49850 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609AbYHMPE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 11:04:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0578438375; Wed, 13 Aug 2008 15:04:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <m363q5t152.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92226>

Jakub Narebski <jnareb@gmail.com> wrote:
> Nicolas Pitre <nico@cam.org> writes:
> > On Tue, 12 Aug 2008, Geert Bosch wrote:
> > 
> > > One nice optimization we could do for those pesky binary large objects
> > > (like PDF, JPG and GZIP-ed data), is to detect such files and revert
> > > to compression level 0. This should be especially beneficial
> > > since already compressed data takes most time to compress again.
> > 
> > That would be a good thing indeed.
> 
> Perhaps take a sample of some given size and calculate entropy in it?
> Or just simply add gitattribute for per file compression ratio...

Estimating the entropy would make it "just magic".  Most of Git is
"just magic" so that's a good direction to take.  I'm not familiar
enough with the PDF/JPG/GZIP/ZIP stream formats to know what the
first 4-8k looks like to know if it would give a good indication
of being already compressed.

Though I'd imagine looking at the first 4k should be sufficient
for any compressed file.  Having a header composed of 4k of _text_
before binary compressed data would be nuts.  Or a git-bundle with
a large refs listing.  ;-)

Using a gitattribute inside of pack-objects is not "simple".
We currently only support reading attributes from the working
directory if I recall correctly.  pack-objects may not have a
working directory.

Hence, "just magic" is probably the better route.

-- 
Shawn.
