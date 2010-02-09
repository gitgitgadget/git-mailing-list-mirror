From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Generate a warning message if we find an unrecognized
 option.
Date: Tue, 9 Feb 2010 00:59:38 -0500
Message-ID: <20100209055938.GA14736@coredump.intra.peff.net>
References: <4B70913F.7060809@winehq.org>
 <20100209004514.GB4065@coredump.intra.peff.net>
 <7vvde7z0kf.fsf@alter.siamese.dyndns.org>
 <20100209030151.GA5370@coredump.intra.peff.net>
 <20100209051730.GA28599@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeremy White <jwhite@winehq.org>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 06:59:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nej8R-0000Cv-R6
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 06:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274Ab0BIF7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 00:59:38 -0500
Received: from peff.net ([208.65.91.99]:38614 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297Ab0BIF7h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 00:59:37 -0500
Received: (qmail 15633 invoked by uid 107); 9 Feb 2010 05:59:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 09 Feb 2010 00:59:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Feb 2010 00:59:38 -0500
Content-Disposition: inline
In-Reply-To: <20100209051730.GA28599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139371>

On Mon, Feb 08, 2010 at 09:17:31PM -0800, David Aguilar wrote:

> > > > And obviously that is weighed against the ability to notice things like
> > > > typos. But if we are going to start complaining about unknown config, we
> > > > would probably do better to complain about _all_ unknown config, and not
> > > > just this one subsection.
> 
> No, please, please no.

I would only be OK with it if it were optional.

> > I would rather have a "git config --lint" command, but that is even
> > harder, since we are not even loading most of the subsystems which know
> > about the valid config options. And it presupposes that people will
> > bother to actually run such a lint command.
> 
> This runs up against the same issue you pointed out
> earlier--that older versions of git cannot adequately lint
> configs from newer versions.

Yeah, but that isn't a big deal. You just don't run "config --lint" with
the older version. But if, for example, "git diff" breaks because your
config is too new, then that is a real pain (and that was what happened
with color.diff.func recently).

> There are also config variables from unknown git scripts outside
> of git.git that happen to use the git-config mechanism because
> it is convenient.  It would be unfortunate to punish those who
> chose to make up their own config variables by warning them
> that git doesn't know about them.

Yes, I don't think anyone is proposing to lint _all_ variables. But it
does not seem unreasonable for certain subsystems to claim portions of
the namespace. I would expect git-core to own "core.*". And I would
expect git-gui to own "git-gui", etc.

> I have to wonder if this is a non-existent problem.
> 
> Config variables are one-shot things.  You set them and forget
> about them.  When you set it you are usually pretty well aware
> of whether it's typoed because it simply does't work.
> color.ui is a perfect example.  If it's typoed, you don't need
> 'git config --lint' to tell you, you already know by virtue of
> using the thing.

I think I agree with you on this. It is _much_ more annoying to me not
to have version portability than it is not to have strict config
checking. I was mainly trying to put myself in the shoes of "regular"
users, who are less likely to be running the same config file on many
different versions, and are more likely to be clueless about config. But
I may have overcompensated.

-Peff
