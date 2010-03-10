From: Jeff King <peff@peff.net>
Subject: Re: wishlist: git gui not listing untracked files in unstaged list
Date: Wed, 10 Mar 2010 17:32:10 -0500
Message-ID: <20100310223210.GC4223@sigill.intra.peff.net>
References: <loom.20100310T203316-38@post.gmane.org>
 <7vaaugrlqs.fsf@alter.siamese.dyndns.org>
 <20100310200728.GD21994@spearce.org>
 <loom.20100310T225229-469@post.gmane.org>
 <20100310221228.GA4223@sigill.intra.peff.net>
 <20100310221403.GF21994@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Patrick Higgins <patrick133t@yahoo.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 10 23:32:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpURu-00085z-1p
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 23:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756404Ab0CJWcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 17:32:13 -0500
Received: from peff.net ([208.65.91.99]:56144 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753447Ab0CJWcM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 17:32:12 -0500
Received: (qmail 20230 invoked by uid 107); 10 Mar 2010 22:32:36 -0000
Received: from c-71-206-173-191.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.191)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 10 Mar 2010 17:32:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Mar 2010 17:32:10 -0500
Content-Disposition: inline
In-Reply-To: <20100310221403.GF21994@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141929>

On Wed, Mar 10, 2010 at 02:14:03PM -0800, Shawn O. Pearce wrote:

> Jeff King <peff@peff.net> wrote:
> > This is an inconsistency in the way that tilde-expansion is handled. The
> > core.excludesfile config variable is expanded internally with the
> > "pathname" magic (git_config_pathname). But handing the filename
> > directly to ls-files --exclude-from does not do that expansion.
> > 
> > So either there is a bug in ls-files, which should expand from the
> > command line, or one in git-gui, which should be using "git config
> > --path core.excludesfile" to get the path.
> 
> I'd say its git-gui, yes?  Doesn't my shell automatically do
> --exclude-from=~/my.list for me?  Its not the command's job
> to do that expansion.

It depends on the shell. Bash will expand it in _some_ cases (but not
this one). Dash never will:

  $ echo $BASH_VERSION
  4.1.0(1)-release
  $ echo foo=~/foo ;# expands
  foo=/home/peff/foo
  $ echo --foo=~/foo ;# does not
  --foo=~/foo
  $ dash -c 'echo foo=~/foo' ;# does not
  foo=~/foo

That being said, my gut feeling is for git-gui to fix it, too. Shell
callers can use $HOME if they want.

-Peff
