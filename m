From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC v3 0/4] Improving performance of git clean
Date: Wed, 22 Apr 2015 15:46:01 -0400
Message-ID: <20150422194601.GB27656@peff.net>
References: <1429389672-30209-1-git-send-email-erik.elfstrom@gmail.com>
 <20150420221414.GA13813@hank>
 <CAMpP7NaUv10Ox0gNsE8cg4hUnNNiFi8NZSLw6F6SW+SLrt0VwQ@mail.gmail.com>
 <20150421212427.GB13230@peff.net>
 <CAMpP7NbruKC97L1ROXV0Up9Fks8FJmgB_nxTTWpSHp-8VVE+Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Git List <git@vger.kernel.org>
To: erik =?utf-8?B?ZWxmc3Ryw7Zt?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:46:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl0b2-0007b6-Un
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 21:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758169AbbDVTqE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2015 15:46:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:48788 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757193AbbDVTqD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 15:46:03 -0400
Received: (qmail 12519 invoked by uid 102); 22 Apr 2015 19:46:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 14:46:03 -0500
Received: (qmail 13342 invoked by uid 107); 22 Apr 2015 19:46:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 15:46:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2015 15:46:01 -0400
Content-Disposition: inline
In-Reply-To: <CAMpP7NbruKC97L1ROXV0Up9Fks8FJmgB_nxTTWpSHp-8VVE+Xw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267625>

On Wed, Apr 22, 2015 at 09:30:20PM +0200, erik elfstr=C3=B6m wrote:

> On Tue, Apr 21, 2015 at 11:24 PM, Jeff King <peff@peff.net> wrote:
> >
> > If I understand correctly, the reason that you need per-run setup i=
s
> > that your "git clean" command actually cleans things, and you need =
to
> > restore the original state for each time-trial. Can you instead use=
 "git
> > clean -n" to do a dry-run? I think what you are timing is really th=
e
> > "figure out what to clean" step, and not the cleaning itself.
>=20
> Yes, that is the problem. A dry run will spot this particular perform=
ance
> issue but maybe we lose some value as a general performance test if
> we only do "half" the clean? Admittedly we clearly lose some value in
> the current state as well due to the copying taking more time than th=
e
> cleaning. I could go either way here.

I guess it is a matter of opinion. I think testing only the "find out
what to clean" half separately is actually beneficial, because it helps
us isolate any slowdown. If we want to add a test for the other half, w=
e
can, but I do not actually think it is currently that interesting (it i=
s
just calling unlink() in a loop).

So even leaving the practical matters aside, I do not think it is a bad
thing to split it up. When you add in the fact that it is practically
much easier to test the first half, it seems to me that testing just
that is a good first step.

-Peff
