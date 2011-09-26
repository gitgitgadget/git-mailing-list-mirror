From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 1/2] is_url: Remove redundant assignment
Date: Mon, 26 Sep 2011 17:32:16 -0400
Message-ID: <20110926213216.GA5415@sigill.intra.peff.net>
References: <1316927182-14212-1-git-send-email-pangyanhan@gmail.com>
 <1316927182-14212-2-git-send-email-pangyanhan@gmail.com>
 <CALUzUxp-++A7azzimE1mjvPVoGxRM4rzYt9z66CmFb0B3vi7dQ@mail.gmail.com>
 <7vsjnj455l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Pang Yan Han <pangyanhan@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 23:32:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Iml-0006tq-7F
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 23:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260Ab1IZVcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 17:32:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44752
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109Ab1IZVcS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 17:32:18 -0400
Received: (qmail 16744 invoked by uid 107); 26 Sep 2011 21:37:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Sep 2011 17:37:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2011 17:32:16 -0400
Content-Disposition: inline
In-Reply-To: <7vsjnj455l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182168>

[+cc Ilari, who wrote the code originally]

On Mon, Sep 26, 2011 at 09:52:54AM -0700, Junio C Hamano wrote:

> Tay Ray Chuan <rctay89@gmail.com> writes:
> 
> > On Sun, Sep 25, 2011 at 1:06 PM, Pang Yan Han <pangyanhan@gmail.com> wrote:
> >> Signed-off-by: Pang Yan Han <pangyanhan@gmail.com>
> >> ---
> >>  url.c |    1 -
> >>  1 files changed, 0 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/url.c b/url.c
> >> index 3e06fd3..d2e17e6 100644
> >> --- a/url.c
> >> +++ b/url.c
> >> @@ -22,7 +22,6 @@ int is_url(const char *url)
> >>
> >>        if (!url)
> >>                return 0;
> >> -       url2 = url;
> >>        first_slash = strchr(url, '/');
> >>
> >>        /* Input with no slash at all or slash first can't be URL. */
> >
> > Looks correct. Perhaps you could mention in the patch message that
> >
> >   There are no operations on url2 until another assignment to it later
> > at line 41.
> 
> The looks correct, so I'll queue it, but it looks like that the function
> is implemented in an overly complicated way.
> 
> Why aren't we checking from left to right in a single pass, perhaps like
> this?
> 
> 	/* Make sure it is of form "scheme://something" */
> 	int is_url(const char *url)
> 	{
> 		/* Is "scheme" part reasonable? */
> 		if (!url || !is_urlschemechar(1, *url++))
> 	        	return 0;
> 		while (*url && *url != ':') {
> 			if (!is_urlschemechar(0, *url++))
> 				return 0;
> 		}
> 		/* We've seen "scheme"; we want colon-slash-slash */
> 		return (url[0] == ':' && url[1] == '/' && url[2] == '/');
> 	}

That looks right to me, and is way more readable.

-Peff
