From: Jeff King <peff@peff.net>
Subject: Re: compactionHeuristic=true is not used by interactive staging
Date: Tue, 14 Jun 2016 17:42:11 -0400
Message-ID: <20160614214211.GB21560@sigill.intra.peff.net>
References: <CAEtHF9Na7yppEzuutp5=98KjLucgq=7Xv9GPidhaYEuC0oeqQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alex =?utf-8?B?UHJlbmfDqHJl?= <alexprengere@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 23:42:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCw6K-0000Vu-6I
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 23:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbcFNVmP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2016 17:42:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:54866 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750771AbcFNVmO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 17:42:14 -0400
Received: (qmail 15126 invoked by uid 102); 14 Jun 2016 21:42:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 17:42:14 -0400
Received: (qmail 505 invoked by uid 107); 14 Jun 2016 21:42:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 17:42:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2016 17:42:11 -0400
Content-Disposition: inline
In-Reply-To: <CAEtHF9Na7yppEzuutp5=98KjLucgq=7Xv9GPidhaYEuC0oeqQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297335>

On Tue, Jun 14, 2016 at 04:22:54PM +0200, Alex Preng=C3=A8re wrote:

> Hello,
> I just did a fresh clone of git from Github and installed the version
> 2.9.0 on Fedora 22.
>=20
> I tried the new compactionHeuristic =3D true, which is awesome.
> The only thing that struck me was that this option was not used when
> doing an interactive staging, meaning `git diff` and `git add -p` wil=
l
> format patches differently. Perhaps this is intended and there is a
> way to force interactive staging to use specific diff options, but I
> did not find it in the doc.

That's because it's handled in the "UI config", and plumbing commands
are not affected (and "add -p" is built on plumbing commands). The same
is true of diff.algorithm, for instance.

To make this work, add--interactive would have to manually enable
particular options that it thinks it can handle (and in fact this is
done with diff.algorithm already). So we'd need a patch similar to
2cc0f53 (add--interactive: respect diff.algorithm, 2013-06-12).

Nobody noticed so far because originally the compaction heuristic was o=
n
by default, and so just worked everywhere. But we backed off on that at
the last minute after finding a few cases where the diff looks worse.

-Peff
