From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] send-email: expand paths in sendemail.{to,cc}cmd
 config
Date: Tue, 24 Nov 2015 17:23:30 -0500
Message-ID: <20151124222330.GF29185@sigill.intra.peff.net>
References: <cover.1447797487.git.john@keeping.me.uk>
 <db0b817c4be57635248a48a529a32719ad232f02.1447797487.git.john@keeping.me.uk>
 <CAPig+cRY3W4VMgqnRuQFeMk7oueKsA=ZhMAk15LLyZg0KfVvCA@mail.gmail.com>
 <20151124084353.GH21488@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Nov 24 23:23:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Lzs-00038R-IA
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 23:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755344AbbKXWXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 17:23:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:33497 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754376AbbKXWXd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 17:23:33 -0500
Received: (qmail 26913 invoked by uid 102); 24 Nov 2015 22:23:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 16:23:33 -0600
Received: (qmail 19202 invoked by uid 107); 24 Nov 2015 22:23:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 17:23:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 17:23:30 -0500
Content-Disposition: inline
In-Reply-To: <20151124084353.GH21488@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281641>

On Tue, Nov 24, 2015 at 08:43:53AM +0000, John Keeping wrote:

> On Mon, Nov 23, 2015 at 07:04:46PM -0500, Eric Sunshine wrote:
> > On Tue, Nov 17, 2015 at 5:01 PM, John Keeping <john@keeping.me.uk> wrote:
> > > These configuration variables specify the paths to commands so we should
> > > support tilde-expansion for files inside a user's home directory.
> > 
> > Hmm, I don't see anything in the documentation which says that these
> > are paths to commands, and the code itself treats them purely as
> > commands to be invoked, not as paths to commands. What is the
> > behavior, for instance, with --tocmd='foobar -x zopp' or even
> > --tocmd='foobar -x ~/zopp'?
> 
> The path behaviour only expands leading '~' and '~user' (as documented
> in git-config(1)):
> 
> 	$ git -c sendemail.tocmd='foobar -x ~/zopp' config --path sendemail.tocmd
> 	foobar -x ~/zopp

We usually run user-supplied commands with a shell (and AFAICT, that is
the case here). So wouldn't that turn into (when used by send-email):

  sh -c 'foobar -x ~/zopp'

and the shell would expand it for us? Running:

  git -c sendemail.tocmd='echo ~/foo' send-email -1

seems to work for me (it puts "/home/peff/foo" into the "to" header).

-Peff
