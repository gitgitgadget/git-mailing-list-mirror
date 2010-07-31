From: Jeff King <peff@peff.net>
Subject: Re: jk/tag-contains (Re: What's cooking in git.git (Jul 2010, #05;
 Wed, 28))
Date: Sat, 31 Jul 2010 08:33:28 -0400
Message-ID: <20100731123328.GA5273@coredump.intra.peff.net>
References: <7vvd7zuecv.fsf@alter.siamese.dyndns.org>
 <20100730183709.GC18544@coredump.intra.peff.net>
 <20100731060703.GA21207@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 14:33:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfBGA-0005iZ-K2
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 14:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178Ab0GaMde convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 08:33:34 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38404 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859Ab0GaMdd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 08:33:33 -0400
Received: (qmail 9907 invoked by uid 111); 31 Jul 2010 12:33:32 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Sat, 31 Jul 2010 12:33:32 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Jul 2010 08:33:28 -0400
Content-Disposition: inline
In-Reply-To: <20100731060703.GA21207@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152320>

On Sat, Jul 31, 2010 at 01:07:03AM -0500, Jonathan Nieder wrote:

> > The third one is where we start defaulting things to "assume no mor=
e
> > than 1 day of clock skew by default", which can cause incorrect ans=
wers
> > in the face of skew.
>=20
> I think the default should be something that (just barely) works
> correctly for linux-2.6.git.

I am tempted by that (and it is why I made the fourth patch to actually
calculate the worst skew). But my concern is that there are projects
with even worse skew. Maybe that is unfounded.

> > The fourth is just an illustrative patch for per-repo skew detectio=
n.
>=20
> I have been hoping for a chance to look these over, time hasn=E2=80=99=
t come my
> way yet.

It just a git-skew program to calculate the skew, but doesn't do
anything fancy like detect-on-gc. However, it would be nice to have
somebody sanity check the algorithm. Looking at it again, I think it
might actually miss some skew if the skewed commit can be reached in
multiple ways.

> Additional things to do (this is mostly a note to myself):
>=20
>  - refuse to commit with a timestamp long before any parent

Agreed.

>  - refuse to make a commit that would make the total slop too high?

That would be expensive to commit, and if we bound each individual
commit to parent relationship as you mention above, I don't think it
should be necessary.

>  - check slop and warn about it in fsck (maybe your patch does this
>    already)

No, it doesn't, but it is something we should probably do.

>  - document the maximum-total-slop and maximum-single-commit-slop
>    rules!

Definitely.

-Peff
