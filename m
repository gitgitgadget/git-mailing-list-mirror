From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/3] connect: improve check for plink to reduce false
 positives
Date: Fri, 26 Jun 2015 13:23:39 -0400
Message-ID: <20150626172339.GA1945@peff.net>
References: <1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net>
 <1430080212-396370-1-git-send-email-sandals@crustytoothpaste.net>
 <1430080212-396370-4-git-send-email-sandals@crustytoothpaste.net>
 <20150626131524.GA2626@peff.net>
 <xmqq381ewiln.fsf@gitster.dls.corp.google.com>
 <20150626162701.GA32123@peff.net>
 <0838aaf747ce0db5a83de107495270cf@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 26 19:24:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8XM9-0001in-Sb
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 19:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbbFZRXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 13:23:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:52369 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751717AbbFZRXm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 13:23:42 -0400
Received: (qmail 16437 invoked by uid 102); 26 Jun 2015 17:23:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Jun 2015 12:23:41 -0500
Received: (qmail 18916 invoked by uid 107); 26 Jun 2015 17:23:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Jun 2015 13:23:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jun 2015 13:23:39 -0400
Content-Disposition: inline
In-Reply-To: <0838aaf747ce0db5a83de107495270cf@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272802>

On Fri, Jun 26, 2015 at 07:13:15PM +0200, Johannes Schindelin wrote:

> > It's the test suite for the server side of our git infrastructure, so
> > nothing gets installed. It's more like:
> > 
> >   export GIT_SSH=$PROJECT_ROOT/test/plink-wrapper.sh
> >   export REAL_PLINK=$PROJECT_ROOT/vendor/putty/plink
> >   git clone localhost:foo.git
> > 
> > and the wrapper knows to chain to $REAL_PLINK. So it was actually pretty
> > easy to swap, without any hacks to avoid recursing to ourselves in the
> > $PATH.
> > 
> > I doubt it is a problem for most people, because I don't imagine they
> > are writing test suites for git-related software.
> 
> Sorry to be so unavailable... day-job and Git for Windows[*1*], what can I say.

No problem. I don't envy you. :)

> Would it help you if we detected ^plink[^a-zA-Z]?

In our we would have needed "^plink[^a-zA-Z-.]". I think there's no real
"right" answer here, as you can come up with hypotheticals that work and
don't work with just about every pattern. I was less trying to advocate
for loosening, and more just providing a data point to the list.

If we were to do any loosening, I'd probably suggest "^plink.*" (in the
basename).

-Peff
