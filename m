From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Re: size_t vs "unsigned long"
Date: Thu, 4 Oct 2007 09:16:55 +0200
Message-ID: <200710040916.55998.wielemak@science.uva.nl>
References: <7vabr0djqr.fsf@gitster.siamese.dyndns.org> <200710032320.00263.wielemak@science.uva.nl> <20071003213601.GD28188@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 04 09:17:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdKxH-0006hB-BC
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 09:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbXJDHQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 03:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752510AbXJDHQ7
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 03:16:59 -0400
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:2265 "EHLO
	smtp-vbr8.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741AbXJDHQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 03:16:58 -0400
Received: from ct.xs4all.nl (ct.xs4all.nl [82.92.39.12])
	by smtp-vbr8.xs4all.nl (8.13.8/8.13.8) with ESMTP id l947GuJJ030557
	for <git@vger.kernel.org>; Thu, 4 Oct 2007 09:16:57 +0200 (CEST)
	(envelope-from wielemak@science.uva.nl)
User-Agent: KMail/1.9.5
In-Reply-To: <20071003213601.GD28188@artemis.corp>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59925>

On Wednesday 03 October 2007 23:36, Pierre Habouzit wrote:
> On Wed, Oct 03, 2007 at 09:19:59PM +0000, Jan Wielemaker wrote:
> > On Wednesday 03 October 2007 22:48, Pierre Habouzit wrote:
> > > On Wed, Oct 03, 2007 at 08:30:04PM +0000, Junio C Hamano wrote:
> > > > Traditionally, inside git, we have used the length of things
> > > > with "unsigned long" for pretty much anything, except where we
> > > > wanted the length exactly sized we used int32_t, uint64_t and
> > > > friends.
> > > >
> > > > A few places pass pointer to unsigned long as the second
> > > > parameter to strbuf_detach(), triggering type mismatch warnings.
> > > > An easy way out is to change strbuf_detach() to take a pointer
> > > > to ulong but I think it is going backwards.  Most places that
> > > > use "unsigned long" can safely be converted (and made more
> > > > correct) to use size_t.
> > >
> > >   Well, afaict, on every linux archs I know of, unsigned longs and
> > > size_t are the same. Though, I don't know if that holds for the msys
> > > port, and if that does not holds, then a s/unsigned long/size_t/ would
> > > help them. Else, for consistency sake, I believe the change is a good
> > > one.
> >
> > Surely on the Microsoft 64-bit compilers size_t is 64-bits and long is
> > 32-bits.  Don't blame me, I'm just the messenger that learned the hard
> > way ...
>
>   Yeah, I've been wondering, and it's the information I had. well, the
> information I had is that sizeof(size_t) is 4 on win32, and 8 on win64,
> OTOH (and this one I'm sure), on windows, longs are 32bits on both (32
> and 64 bits ABIs).
>
>   So replacing unsigned long with size_t's will help the msys port,
> hence I had some insight that this could prove useful, now I'm sure :)

The other types that are useful are intptr_t and uintptr_t, integers
that are guaranteed to be able to hold a pointer. They are defined by
recent versions of the Microsoft compilers and are in <inttypes.h> in
most POSIX systems (at least I didn't have complaints since I started
using them).  I use them for integers holding mangled pointers.  Of
course most clean C programs should not need that.

	--- Jan
