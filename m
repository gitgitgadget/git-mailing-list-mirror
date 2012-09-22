From: Jeff King <peff@peff.net>
Subject: Re: git clone over http with basic auth bug?
Date: Sat, 22 Sep 2012 01:09:35 -0400
Message-ID: <20120922050935.GA4542@sigill.intra.peff.net>
References: <505CFA42.9090504@pjr.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Paul J R <me@pjr.cc>
X-From: git-owner@vger.kernel.org Sat Sep 22 07:09:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFHyN-0000lA-HQ
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 07:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001Ab2IVFJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2012 01:09:39 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54120 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752939Ab2IVFJi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 01:09:38 -0400
Received: (qmail 14333 invoked by uid 107); 22 Sep 2012 05:10:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 22 Sep 2012 01:10:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Sep 2012 01:09:35 -0400
Content-Disposition: inline
In-Reply-To: <505CFA42.9090504@pjr.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206193>

On Sat, Sep 22, 2012 at 09:37:38AM +1000, Paul J R wrote:

> Im not sure if this is a bug, or just "as implemented". But when
> cloning from a repo sitting on a web site that uses basic auth, the
> git client appears to forget its authentication info and ignores the
> 401's the server is sending back. It appears to initially login and
> get refs and HEAD ok, but after that it never authenticates again.
> Using a .netrc file this will work (or a url of the form
> http://user:pass@host though http://user@host wont), but i'm curious
> if theres a way of doing this without having to expose the password
> in some way?
> 
> Im using git 1.7.9.5 and when i clone i get the following:
> [...]

>From your logs, it looks like you are using the "dumb" http protocol
(wherein the server does not have to understand git at all). In this
protocol, we end up making multiple simultaneous requests for objects
with different curl handles. We had a bug where not all handles are told
about the credential (but it doesn't always happen; it depends on the
exact pattern of requests).

This was fixed by dfa1725 (fix http auth with multiple curl handles,
2012-04-10), which is in git v1.7.10.2 and higher.

Can you try upgrading to see if that fixes your problem?

-Peff
