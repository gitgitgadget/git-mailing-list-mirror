From: Jeff King <peff@peff.net>
Subject: Re: Git-Mediawiki : cloning a set of pages
Date: Thu, 9 Jun 2011 11:50:01 -0400
Message-ID: <20110609155001.GA14969@sigill.intra.peff.net>
References: <BANLkTim1hOi0JdWZPR=Vw-S+9jTxqQ-=Tw@mail.gmail.com>
 <20110608151940.GD7805@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Claire Fousse <claire.fousse@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 09 17:50:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUhUp-0005jJ-35
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 17:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392Ab1FIPuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 11:50:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52481
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752252Ab1FIPuE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 11:50:04 -0400
Received: (qmail 13818 invoked by uid 107); 9 Jun 2011 15:50:12 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 11:50:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 11:50:01 -0400
Content-Disposition: inline
In-Reply-To: <20110608151940.GD7805@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175532>

On Wed, Jun 08, 2011 at 11:19:40AM -0400, Jeff King wrote:

> Maybe it would be even simpler and more flexible to give clone a "-c"
> flag that writes specific config variables in the newly-created
> repository. Like:
> 
>   git clone -c mediawiki.page=page1 \
>             -c mediawiki.page=page2 \
>             http://...
> 
> Then the remote helper can just consult the git config. As a bonus, it
> also lets you do things like:
> 
>   git clone -c core.ignorecase=true git://...
> 
> which is currently awkward (you either have to have set such variable in
> your ~/.gitconfig, or you must use init+config+fetch to do a clone
> manually.

This turned out to be a very tiny amount of code, but I found a ton
of other bugs while working on it. :)

So the patch series is long, but the important bits are at the end. I
factored the code from the existing "git -c", so most of the bugfixes
are there.

  [01/10]: strbuf_split: add a max parameter
  [02/10]: fix "git -c" parsing of values with equals signs

These two are the first bugfix.

  [03/10]: config: die on error in command-line config

Another bugfix.

  [04/10]: config: avoid segfault when parsing command-line config

Another bugfix.

  [05/10]: strbuf: allow strbuf_split to work on non-strbufs
  [06/10]: config: use strbuf_split_str instead of a temporary strbuf

Plugging a memory leak.

  [07/10]: parse-options: add OPT_STRING_LIST helper
  [08/10]: remote: use new OPT_STRING_LIST
  [09/10]: config: make git_config_parse_parameter a public function

These are refactoring for 10/10.

  [10/10]: clone: accept config options on the command line

And this is the actual patch.

-Peff
