From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tag: support --sort=version
Date: Wed, 19 Feb 2014 09:09:09 -0500
Message-ID: <20140219140909.GA20128@sigill.intra.peff.net>
References: <1392817167-29802-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 15:09:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WG7pu-0000Ve-0d
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 15:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562AbaBSOJO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Feb 2014 09:09:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:53319 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752542AbaBSOJN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Feb 2014 09:09:13 -0500
Received: (qmail 14484 invoked by uid 102); 19 Feb 2014 14:09:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Feb 2014 08:09:12 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Feb 2014 09:09:09 -0500
Content-Disposition: inline
In-Reply-To: <1392817167-29802-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242393>

On Wed, Feb 19, 2014 at 08:39:27PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> --sort=3Dversion sorts tags as versions. GNU extension's strverscmp i=
s
> used and no real compat implementation is provided so this is Linux o=
nly.

Sounds like a good goal.

I wonder, if we were to merge the for-each-ref and tag
implementations[1], how this would integrate with for-each-ref's
sorting. It can sort on arbitrary fields like "--sort=3D-*authordate". =
I
think given the syntax you provide, this would fall out naturally as
just another key (albeit a slightly magical one, as it is building on
the %(refname:short) field but using a different comparator).

Would we ever want to version-sort any other field? Perhaps
%(content:subject) for a tag? I'm not sure what would be the most
natural way to specify that. Maybe "--sort=3Dversion:content:subject",
with just "--version" as a synonym for "version:refname:short".

We don't need to do any of that immediately.  This is mostly just me
thinking aloud, to make sure we do not paint ourselves into a corner
compatibility-wise.

-Peff

[1] I have patches which I really need to polish and send out that
    combine the ref-selection code (so tag, branch, and for-each-ref al=
l
    know "--merged", "--contains", etc). I'd really like to combine the
    sorting and formatting code, too, so everybody can use "--sort" and
    "--format" with all of the associated fields.
