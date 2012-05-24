From: Jeff King <peff@peff.net>
Subject: Re: credential-helpers + remote-helper, starting  point?
Date: Thu, 24 May 2012 14:21:10 -0400
Message-ID: <20120524182110.GE3161@sigill.intra.peff.net>
References: <b13df32797edbe8f71c796dbb4dc06a5@telesun.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, matthieu.moy@imag.fr,
	kim-thuat.nguyen@ensimag.fr, pavel.volek@ensimag.fr,
	javier.roucher-iglesias@ensimag.fr
To: roucherj <roucherj@telesun.imag.fr>
X-From: git-owner@vger.kernel.org Thu May 24 20:21:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXcf1-0000qu-2w
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 20:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934053Ab2EXSVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 14:21:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53856
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933474Ab2EXSVN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 14:21:13 -0400
Received: (qmail 30154 invoked by uid 107); 24 May 2012 18:21:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 14:21:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 14:21:10 -0400
Content-Disposition: inline
In-Reply-To: <b13df32797edbe8f71c796dbb4dc06a5@telesun.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198402>

On Thu, May 24, 2012 at 05:14:35PM +0200, roucherj wrote:

> I want to know if anyone can help me with git-credential-helpers we
> are trying to use git-credential-helpers in the git-mediawiki
> (implemented as a remote-helper).
> We need to ask for the login/pass of the wiki and it would be nice if
> we can use credential-helpers to manage this credentials.

Yeah, I think it makes sense to use the credential-helpers.

> Anyone can send me a starting point, like a url with the
> documentation of git-credential-helpers?

Try:

  https://github.com/git/git/blob/master/Documentation/technical/api-credentials.txt

But that is the C API, and I assume you are building on the existing
mediawiki helper that is written in perl. So I think what you really
want is a "git credential" command that will let scripts hook into the
credential API. Something like:

  $ git credential get https://example.com
  username=bob
  password=secret

  $ cat <<\EOF | git credential store https://example.com
  username=bob
  password=secret
  EOF

  $ cat <<\EOF | git credential erase https://example.com
  username=bob
  password=secret
  EOF

I had planned eventually to do something like this for git-svn, but
realized that it was more sane to just let svn library handle the
credential storage.

Do you guys want to try writing "git credential" as above? It might be a
fun side project, but I know you are also on a limited timeframe for
your project. I can work on it if you don't have time.

-Peff
