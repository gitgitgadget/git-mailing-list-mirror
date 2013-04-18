From: Jeff King <peff@peff.net>
Subject: Re: Git over HTTPS with basic authentication
Date: Thu, 18 Apr 2013 16:43:20 -0400
Message-ID: <20130418204320.GA6888@sigill.intra.peff.net>
References: <1366314422.12299.3.camel@sibbo-laptop>
 <vpq8v4f62dj.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Schmidt <isibboi@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 18 22:43:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USvgA-0003qd-1p
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 22:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936594Ab3DRUnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 16:43:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:43521 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936581Ab3DRUnY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 16:43:24 -0400
Received: (qmail 16215 invoked by uid 102); 18 Apr 2013 20:43:28 -0000
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (75.15.5.89)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Apr 2013 15:43:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Apr 2013 16:43:20 -0400
Content-Disposition: inline
In-Reply-To: <vpq8v4f62dj.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221693>

On Thu, Apr 18, 2013 at 09:54:32PM +0200, Matthieu Moy wrote:

> Sebastian Schmidt <isibboi@gmail.com> writes:
> 
> > Why is git not working over HTTPS with basic authentication? I can clone
> > just fine, but when I try to push, it tells me
> 
> What are you using on the server? Dumb HTTP works by serving the
> repository files as static pages, which is fundamentally read-only. The
> recommended way is to use smart-HTTP (see man git-http-backend, requires
> Git on the server), and the alternative is to use webdav (much slower).

Yeah, this is definitely dumb http (since http-push is involved at all,
which the original error message showed).  Code 22 is curl's "there was
an HTTP error" code, but http-push annoyingly does not output the actual
HTTP error[1]. You can see more by setting GIT_CURL_VERBOSE=1 in the
environment.

Though if you know you did not set up WebDAV on the server, then we can
know that is the problem even without seeing the HTTP code. :)

-Peff

[1] The dumb-http push code is largely unloved and unmaintained at this
    point. Yet another reason to move to smart http.
