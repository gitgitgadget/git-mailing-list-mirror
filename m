From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: turn on network daemon tests by default
Date: Fri, 14 Feb 2014 04:58:42 -0500
Message-ID: <20140214095841.GA27161@sigill.intra.peff.net>
References: <20140210191521.GA3112@sigill.intra.peff.net>
 <20140210212931.GA16154@sigill.intra.peff.net>
 <xmqqa9dxpgw9.fsf@gitster.dls.corp.google.com>
 <20140211200445.GA27946@sigill.intra.peff.net>
 <xmqqzjlxnqvw.fsf@gitster.dls.corp.google.com>
 <20140212214753.GA6799@sigill.intra.peff.net>
 <xmqq38jom037.fsf@gitster.dls.corp.google.com>
 <xmqqfvnmlsb2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 10:58:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEFXn-0004Dj-Qg
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 10:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbaBNJ6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 04:58:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:50436 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751199AbaBNJ6o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 04:58:44 -0500
Received: (qmail 23553 invoked by uid 102); 14 Feb 2014 09:58:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Feb 2014 03:58:44 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Feb 2014 04:58:42 -0500
Content-Disposition: inline
In-Reply-To: <xmqqfvnmlsb2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242094>

On Thu, Feb 13, 2014 at 11:35:13AM -0800, Junio C Hamano wrote:

> >>   test_normalize_tristate GIT_TEST_DAEMON
> >
> > Heh, great minds think alike.  This is what I am playing with,
> > without committing (because I do like your "ask config if this is a
> > kind of various boolean 'false' representations, which I haven't
> > managed to add to it).
> 
> And this is with the "ask config" helper.

Thanks for picking this up.

> Two tangents.
> 
>  - We may want to do something similar in cvsserver and git-gui to
>    make them more robust.
> 
>    $ git grep -e true --and -e 1 --and -e yes

I assume the "something" here is to respect bool options more
consistently? I have no problem with that, but nor do I care too much
about those programs (that is partially laziness, but also partially
that I do not want to deal with introducing a regression).

>  - Do we want to do something similar to GIT_TEST_CREDENTIAL_HELPER?

No, it is not a boolean. It is a bit of a hack, but it is meant to be
used like:

  GIT_TEST_CREDENTIAL_HELPER=foo ./t0303-*

to test some random git-credential-foo you have in your PATH. There is
nothing to run "by default" there. It would be sensible to hook
contrib/credential to it, though.

> -- >8 --
> From: Jeff King <peff@peff.net>
> Date: Mon, 10 Feb 2014 16:29:37 -0500
> Subject: [PATCH] tests: turn on network daemon tests by default
> [...]
> In addition, we are forgiving of common setup failures (e.g., you do
> not have apache installed, or have an old version) when the
> tri-state is "auto" (or empty), but report an error when it is

You probably want to drop this "or empty" or change it to "or unset",
given the magic we do with empty-but-set variables in this version.

> ---
>  t/lib-git-daemon.sh     |  8 ++++---
>  t/lib-httpd.sh          | 22 +++++++++----------
>  t/test-lib-functions.sh | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 74 insertions(+), 14 deletions(-)

Patch looks good to me.

-Peff
