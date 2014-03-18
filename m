From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] gc --aggressive: three phase repacking
Date: Tue, 18 Mar 2014 01:13:43 -0400
Message-ID: <20140318051342.GA17200@sigill.intra.peff.net>
References: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
 <1394976904-15395-6-git-send-email-pclouds@gmail.com>
 <20140318045050.GB8240@sigill.intra.peff.net>
 <CACsJy8CU3JyL74OuurjDr5-FHmBOCRahtXukukCqGx1cTdjvMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 06:13:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPmLW-0001Nf-55
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 06:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbaCRFNp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Mar 2014 01:13:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:41643 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751384AbaCRFNo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 01:13:44 -0400
Received: (qmail 22409 invoked by uid 102); 18 Mar 2014 05:13:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Mar 2014 00:13:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Mar 2014 01:13:43 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8CU3JyL74OuurjDr5-FHmBOCRahtXukukCqGx1cTdjvMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244331>

On Tue, Mar 18, 2014 at 12:00:48PM +0700, Duy Nguyen wrote:

> On Tue, Mar 18, 2014 at 11:50 AM, Jeff King <peff@peff.net> wrote:
> > On Sun, Mar 16, 2014 at 08:35:04PM +0700, Nguy=E1=BB=85n Th=C3=A1i =
Ng=E1=BB=8Dc Duy wrote:
> >
> >> As explained in the previous commit, current aggressive settings
> >> --depth=3D250 --window=3D250 could slow down repository access
> >> significantly. Notice that people usually work on recent history o=
nly,
> >> we could keep recent history more loosely packed, so that repo acc=
ess
> >> is fast most of the time while the pack file remains small.
> >
> > One thing I have not seen is real-world timings showing the slowdow=
n
> > based on --depth. Did I miss them, or are we just making assumption=
s
> > based on one old case from 2009 (that, AFAIK does not have real num=
bers,
> > just speculation)? Has anyone measured the effect of bumping the de=
lta
> > cache size (and its hash implementation)?
>=20
> David tested it with git-blame [1]. I should probably run some tests
> too (I don't remember if I tested some operations last time).
>=20
> http://thread.gmane.org/gmane.comp.version-control.git/242277/focus=3D=
242435

Ah, thanks. I do remember that thread now.

It looks like David's last word is that he gets a significant
performance from bumping the delta base cache size (and number of
buckets). And that matches the timings I just did. I suspect there are
still pathological cases that could behave worse, but it really sounds
like we should be looking into improving that cache as a first step.

-Peff
