From: Jeff King <peff@peff.net>
Subject: Re: [BUG] Autocompletion fails with "bash: words: bad array
 subscript"
Date: Tue, 10 May 2011 17:01:16 -0400
Message-ID: <20110510210116.GA25224@sigill.intra.peff.net>
References: <BANLkTi=nOUEp_J+2dkZZp=HvER-eAdG9eg@mail.gmail.com>
 <20110510203101.GG14456@sigill.intra.peff.net>
 <20110510203943.GH14456@sigill.intra.peff.net>
 <BANLkTi=0r_hCgt3wh4EkRqS6gnCyyKrY2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	"Shawn O. Pearce" <gsoc@spearce.org>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Stephen Boyd <bebarino@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 23:01:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJu3a-0006tN-89
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 23:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361Ab1EJVBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 17:01:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51968
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030Ab1EJVBU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 17:01:20 -0400
Received: (qmail 26280 invoked by uid 107); 10 May 2011 21:03:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 May 2011 17:03:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 May 2011 17:01:16 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=0r_hCgt3wh4EkRqS6gnCyyKrY2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173363>

On Tue, May 10, 2011 at 10:47:49PM +0200, Sverre Rabbelier wrote:

> On Tue, May 10, 2011 at 22:39, Jeff King <peff@peff.net> wrote:
> > Hrm. That code doesn't appear in our completion at all. We provide our
> > own _get_comp_words_by_ref, but if it is already defined, we use
> > whatever is there. So on my box, the problematic code comes from
> > /etc/bash_completion. And I think it is a bug there, as this is one of
> > the first things called (so git's completion hasn't had a change to
> > introduce any bugs yet :) ).
> 
> Most curious, since it doesn't happen when I don't source git
> completion. Perhaps it'll happen for any completion, or maybe we're
> using the completion wrong somehow? I'm on Debian wheezy/sid.

Right. Bash calls into our __git() completion function, which calls the
implementation of _get_comp_words_by_ref from /etc/bash_completion,
which has the bug. If you don't source git completion, then you are just
getting bash's default file completion.

-Peff
