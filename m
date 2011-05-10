From: Jeff King <peff@peff.net>
Subject: Re: [BUG] Autocompletion fails with "bash: words: bad array
 subscript"
Date: Tue, 10 May 2011 16:31:01 -0400
Message-ID: <20110510203101.GG14456@sigill.intra.peff.net>
References: <BANLkTi=nOUEp_J+2dkZZp=HvER-eAdG9eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>,
	"Shawn O. Pearce" <gsoc@spearce.org>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Stephen Boyd <bebarino@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 22:31:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJtaJ-0000ba-9i
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 22:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225Ab1EJUbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 16:31:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57777
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704Ab1EJUbF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 16:31:05 -0400
Received: (qmail 25847 invoked by uid 107); 10 May 2011 20:33:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 May 2011 16:33:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 May 2011 16:31:01 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=nOUEp_J+2dkZZp=HvER-eAdG9eg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173359>

On Tue, May 10, 2011 at 10:13:11PM +0200, Sverre Rabbelier wrote:

> This happens if I try use ctrl-shift-r (reverse-i-search) for the
> string `git commit -am "S`, resulting in the following:
> 
> (reverse-i-search)`git commit -am "S': git commit -am "Set new Melange
> version number to 2-0-20110501 in app.yaml.template."
> 
> If I then hit tab, I get:
> 
> $ bash: words: bad array subscriptversion number to 2-0-20110501 in
> app.yaml.template."

I can reproduce it here pretty easily.

> Hitting tab again gives:
> 
> bash: words: bad array subscript
> 
> Display all 3032 possibilities? (y or n)
> 
> I have no clue how to debug this, other than that it doesn't happen if
> I don't source ~/code/git/contrib/completion/git-completion.bash.
> 
> Anyone have any idea's?

You can try "set -x" which will show you what was executing. Of course
that will spew pages of output. So you'll want to use something like
"script", or if you're man enough, "exec 2>stderr" and then do the whole
thing blind. ;)

It looks like we set $cword too low at some point, as the problematic
code seems to be:

  + upargs+=(-v $vprev "${words[cword - 1]}")
  bash: words: bad array subscript

but I haven't figured out yet where that happens.

-Peff
