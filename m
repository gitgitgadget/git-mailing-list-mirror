From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] sha1-array: add test-sha1-array and basic tests
Date: Wed, 1 Oct 2014 10:23:36 -0400
Message-ID: <20141001142336.GA19992@peff.net>
References: <542BCBFC.5000509@web.de>
 <CAPig+cQxXccnQCwr7oVfccAQn3sTUpv=b=qHEX1H7abng--=0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 16:23:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZKof-0004ae-Ko
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 16:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbaJAOXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 10:23:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:53695 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751330AbaJAOXh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 10:23:37 -0400
Received: (qmail 26228 invoked by uid 102); 1 Oct 2014 14:23:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Oct 2014 09:23:37 -0500
Received: (qmail 27170 invoked by uid 107); 1 Oct 2014 14:23:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Oct 2014 10:23:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Oct 2014 10:23:36 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQxXccnQCwr7oVfccAQn3sTUpv=b=qHEX1H7abng--=0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257752>

On Wed, Oct 01, 2014 at 10:11:04AM -0400, Eric Sunshine wrote:

> > +echo20() {
> > +       prefix="$1"
> > +       shift
> > +       while test $# -gt 0
> > +       do
> > +               echo "$prefix$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1"
> 
> Each caller of echo20() manually includes a space at the end of
> $prefix. Would it make sense to instead have echo20() do this on
> behalf of the caller?
> 
>     echo "$prefix $1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1"

Not always. For example:

> > +test_expect_success 'ordered enumeration' '
> > +       echo20 "" 44 55 88 aa >expect &&

This does not.

> > +       {
> > +               echo20 "append " 88 44 aa 55 &&
> 
> Which would slightly reduce the burden on the caller and make it read
> (very slightly) nicer:
> 
>     echo20 append 88 44 aa 55 &&

I agree that is more readable. But you'd have to make echo20 more like:

  if test -n "$1"; then
          prefix="$1 "
  else
          prefix=""
  fi

which is not too bad.

-Peff
