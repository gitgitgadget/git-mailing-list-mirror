From: Jeff King <peff@peff.net>
Subject: Re: Git ksshaskpass to play nice with https and kwallet
Date: Tue, 4 Oct 2011 07:37:13 -0400
Message-ID: <20111004113713.GA19171@sigill.intra.peff.net>
References: <4E8ADDCF.6090406@drmicha.warpmail.net>
 <20111004105008.GA11789@sigill.intra.peff.net>
 <4E8AEDBD.4070404@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 04 13:37:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB3JK-0000r6-Uf
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 13:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140Ab1JDLhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 07:37:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52133
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755764Ab1JDLhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 07:37:16 -0400
Received: (qmail 7860 invoked by uid 107); 4 Oct 2011 11:42:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Oct 2011 07:42:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2011 07:37:13 -0400
Content-Disposition: inline
In-Reply-To: <4E8AEDBD.4070404@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182764>

On Tue, Oct 04, 2011 at 01:27:57PM +0200, Michael J Gruber wrote:

> Still, ksshaskpass's trying to guess a unique key from the prompt text
> seems quite hackish to me. But many people will have a Git without
> credential-helpers, and a KDE default setup, so hope my post helps
> someone besides myself.

Hmm. I don't think that pre-credential-helper git actually puts the
hostname in the prompt, though. It just says "Username:". So your trick
wouldn't work then, would it?

> Note that git-credentials-askpass would have a fair chance of doing
> better: credential_askpass() knows the username and could pass it to
> credential_ask_one(), e.g. by amending the description field, or setting
> the first field to "Password for user %(user)". Do you think that would
> be worth deviating from the default behavior (i.e. compared to no helper)?

I think that git should do that by default. v1.7.7 (and earlier) does:

  $ git push https://example.com/foo.git
  Username:
  Password:

With my patches in 'next', it does:

  $ git push https://example.com/foo.git
  Username for 'example.com':
  Password for 'example.com':

But it would probably be better to say:

  $ git push https://example.com/foo.git
  Username for 'example.com':
  Password for 'user@example.com':

The latter is especially useful if you have put a username in your
~/.gitconfig, in which case you get:

  $ git push https://example.com/foo.git
  Password for 'user@example.com':

which is a nice reminder. And it would happen to work with your askpass
magic (I also wonder if it should mention the protocol and the repo, but
most of the time that isn't relevant, and it does make the prompt harder
to read).

-Peff
