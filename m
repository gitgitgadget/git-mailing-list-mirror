From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Why is "git tag --contains" so slow?
Date: Thu, 8 Jul 2010 15:39:39 -0400
Message-ID: <AANLkTikVNkObOxGQhDJ5Qau-vYn2YcomHQW2p2zsMof9@mail.gmail.com>
References: <20100701121711.GF1333@thunk.org> <20100701150331.GA12851@sigill.intra.peff.net> 
	<20100701153842.GA15466@sigill.intra.peff.net> <20100702192612.GM1333@thunk.org> 
	<20100703080618.GA10483@sigill.intra.peff.net> <20100704005543.GB6384@thunk.org> 
	<20100705122723.GB21146@sigill.intra.peff.net> <20100705141012.GA25518@thunk.org> 
	<20100706115826.GA15413@sigill.intra.peff.net> <1278430303.32094.15.camel@wpalmer.simply-domain> 
	<20100707174546.GA4979@coredump.intra.peff.net> <11D5771D-EB47-42E9-BCC3-69C8FE1999EC@MIT.EDU> 
	<m37hl6mdnb.fsf@localhost.localdomain> <alpine.LFD.2.00.1007081515030.6020@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Theodore Tso <tytso@mit.edu>,
	Jeff King <peff@peff.net>, Will Palmer <wmpalmer@gmail.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Jul 08 21:40:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWwx5-0004X0-VP
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 21:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757470Ab0GHTkC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 15:40:02 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49807 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755838Ab0GHTkA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jul 2010 15:40:00 -0400
Received: by gwj18 with SMTP id 18so216624gwj.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 12:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=YKV3aQsp2WTIegqCGb7ZwISHIibJGD+PzD1LIv2bt/U=;
        b=vdrP6rI3q0dPrm2Lo10soKwwJ2koD5u7imsIvBaAlA+uOdvHWlPEatnm+hh4eLg7di
         oR0cMRwtSw3ZQsmmtYX/2SwABgIssJpQJkjGRfphCQHtwgX02IQSEIsOu88MXifZEw6Z
         V5ojfbv0ZUn7iwzwf7qk5JeE2MCzBIlcK9Kr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=cjcXRnmDHxmQaUS3Nt5p7a5OvQtIm/NeB0J3B9afaZqC6EkJvRw2l2NXrfJwASGjf/
         S79C9LllinPyR88azrZ/GKdDrfQQ4ASlQzSSz2jjCBFhhiZ7OoMdvJacYPaDW4Fk/7fW
         NQbMiVwFXYzwi2k5H6BQn3X+YWZLpM2QFmY+M=
Received: by 10.150.218.18 with SMTP id q18mr969072ybg.65.1278617999325; Thu, 
	08 Jul 2010 12:39:59 -0700 (PDT)
Received: by 10.151.45.4 with HTTP; Thu, 8 Jul 2010 12:39:39 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1007081515030.6020@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150604>

On Thu, Jul 8, 2010 at 3:29 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Thu, 8 Jul 2010, Jakub Narebski wrote:
>> By the way, what had happened to the rev-cache project from GSoC 200=
9?
>
> I think the person who worked on it did so in good faith, and that th=
e
> result is well done.
>
> But I personally cannot convince myself this is fundamentally the rig=
ht
> solution to the issue. =A0Maintaining another data structure to work
> around defficiencies in the primary data structure doesn't sound righ=
t
> to me.
>
> I might be looking at this from my own perspective as one of the few
> people who hacked extensively on the Git pack format from the very
> beginning. =A0But I do see a way for the pack format to encode commit=
 and
> tree objects so that walking them would be a simple lookup in the pac=
k
> index file where both the SHA1 and offset in the pack for each parent
> can be immediately retrieved. =A0Same for tree references. =A0No defl=
ating
> required, no binary search, just simple dereferences. =A0And the pack=
 size
> would even shrink as a side effect.

One trick that bup uses is an additional file that sits alongside the
pack and acts as an index.  In bup's case, this is to work around
deficiencies in the .idx file format when using ridiculously huge
numbers of objects (hundreds of millions) across a large number of
packfiles.  But the same concept could apply here: instead of doing
something like rev-cache, you could just construct the "efficient"
part of the packv4 format (which I gather is entirely related to
commit messages), and store it alongside each pack.

This would allow people to incrementally modify git to use the new,
efficient commit object storage, without breaking backward
compatibility with earlier versions of git.  (Just as bup can index
huge numbers of packed objects but still stores them in the plain git
pack format.)

Just a thought.  Thinking of it this way might make it easier to get
over the inertia of an entirely new packfile format.

Have fun,

Avery
