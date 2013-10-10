From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] http: add option to enable 100 Continue responses
Date: Wed, 9 Oct 2013 21:43:19 -0400
Message-ID: <20131010014319.GA15106@sigill.intra.peff.net>
References: <1381265287-39331-1-git-send-email-sandals@crustytoothpaste.net>
 <1381265287-39331-2-git-send-email-sandals@crustytoothpaste.net>
 <20131009193054.GA3767@sigill.intra.peff.net>
 <CAJo=hJvyorMjFYZnVwz4iZr88ewor6LuqOE-mpt4LsPyoddBqg@mail.gmail.com>
 <20131009213742.GA8362@sigill.intra.peff.net>
 <20131010013547.GA62549@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Oct 10 03:43:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VU5Hh-0002VQ-SC
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 03:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618Ab3JJBnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 21:43:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:46666 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752227Ab3JJBnV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 21:43:21 -0400
Received: (qmail 27307 invoked by uid 102); 10 Oct 2013 01:43:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Oct 2013 20:43:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Oct 2013 21:43:19 -0400
Content-Disposition: inline
In-Reply-To: <20131010013547.GA62549@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235849>

On Thu, Oct 10, 2013 at 01:35:47AM +0000, brian m. carlson wrote:

> > I don't have a GSS-enabled server to test on. Brian, can you try the
> > patch at the end of this message on your non-working server and see what
> > it outputs?
> 
> It doesn't trigger.  My server only requires authentication for the
> actual push operation, and it looks like your code doesn't trigger in
> that case.

Can you describe the sequence of requests, then?

Do you not have to auth for the info/refs request, and then have to auth
later for the git-receive-pack request? Does the auth trigger for the
probe_rpc call?

Can you show us GIT_CURL_VERBOSE=1 output for a session that fails (do
note that it will dump your auth headers, so you may want to redact them
before sharing)?

> > > > Is there any point in sending the Expect: header in cases where curl
> > > > would not send it, though? It seems like we should assume curl does the
> > > > right thing most of the time, and have our option only be to override
> > > > curl in the negative direction.
> 
> I think curl expects that data in the POSTFIELDS option in order to
> trigger.  I wasn't able to get it to trigger on its own.

Was your POST perhaps not big enough? My impression is that it only
sends it if the POST is too large to rewind (which seems like a good
thing in general), and I thought earlier in the thread that command-line
curl was sending one. I'm not sure what would be different for us here,
once our manual "Expect" suppression is turned off.

-Peff
