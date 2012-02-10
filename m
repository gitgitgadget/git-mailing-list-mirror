From: Jeff King <peff@peff.net>
Subject: Re: Git documentation at kernel.org
Date: Fri, 10 Feb 2012 15:01:00 -0500
Message-ID: <20120210200100.GA5504@sigill.intra.peff.net>
References: <CAPyqok3USqMxm0gNf_T9vnCoicp9XSwpWUCYJ8jh79h=V_UuOA@mail.gmail.com>
 <20120208213410.GA5768@ecki>
 <7vmx8rtu3e.fsf@alter.siamese.dyndns.org>
 <vpqbop6tyj6.fsf@bauges.imag.fr>
 <FC56A942-EE70-48B7-A2D3-CF53A189A55E@mit.edu>
 <1328900154.3171.27.camel@i5.mricon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Theodore Tso <tytso@MIT.EDU>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>, ftpadmin@kernel.org,
	Petr Onderka <gsvick@gmail.com>, git@vger.kernel.org
To: Konstantin Ryabitsev <icon@mricon.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 21:01:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvweb-0002vj-C1
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 21:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759982Ab2BJUBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 15:01:03 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33499
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754167Ab2BJUBC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 15:01:02 -0500
Received: (qmail 7083 invoked by uid 107); 10 Feb 2012 20:08:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Feb 2012 15:08:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Feb 2012 15:01:00 -0500
Content-Disposition: inline
In-Reply-To: <1328900154.3171.27.camel@i5.mricon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190444>

On Fri, Feb 10, 2012 at 01:55:54PM -0500, Konstantin Ryabitsev wrote:

> I have a few comments off the top of my head:
> 
>      1. "kup rm" will need to be modified, as it currently only allows
>         deleting things that have a matching signature. The alternative
>         is for UNPACK to create a foo.tar.manifest file that will be
>         consulted upon "kup rm" to clean up any unpacked contents upon
>         the deletion of the source archive. Note, that there are many,
>         many gotchas with this solution -- e.g. .manifest should
>         probably contain checksums, too, as there are bound to be
>         conditions when two tarballs reference the same files, and you
>         want to make sure that you delete files matching the contents of
>         the old tarball, not the newer one, etc.

For this particular use case, I don't know if that would be necessary.
According to Junio, previously:

  The k.org site kept these files under /pub/software/scm/git/docs/. The
  in-development "master" version of pages were placed directly
  underneath that directory, and the documentation pages for older
  versions were kept in vX.Y.Z subdirectory of that directory.

If we tweak that slightly to "all versions are kept in vX.Y.Z
subdirectory, and the root version is simply a symlink or redirect to
the latest vX.Y.Z", then there is no deletion required. The pusher is
always adding new versions, and updating a link[1].

But even if it would be sufficient for this use case, kup developers
may not want such a half-implemented scheme in their protocol.

-Peff

[1] There is a slight complication that the subdirectories live _inside_
    of the root directory, so it is not implementable with a single
    symlink.  You could get around that with a few clever http redirects.
