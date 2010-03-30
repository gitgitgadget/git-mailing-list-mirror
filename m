From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] fast textconv
Date: Tue, 30 Mar 2010 12:04:49 -0400
Message-ID: <20100330160449.GB17763@coredump.intra.peff.net>
References: <20100328145301.GA26213@coredump.intra.peff.net>
 <4BAF7F3F.5020604@drmicha.warpmail.net>
 <20100328161728.GA2828@coredump.intra.peff.net>
 <20100328161921.GA3435@coredump.intra.peff.net>
 <20100328165646.GA10293@coredump.intra.peff.net>
 <20100328173420.GA18047@coredump.intra.peff.net>
 <fabb9a1e1003281113o4cb1e723p4ed39521b645fffe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 18:05:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwdwC-0008Fu-Cu
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 18:05:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045Ab0C3QFC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 12:05:02 -0400
Received: from peff.net ([208.65.91.99]:48886 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069Ab0C3QFA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 12:05:00 -0400
Received: (qmail 21322 invoked by uid 107); 30 Mar 2010 16:05:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 30 Mar 2010 12:05:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Mar 2010 12:04:49 -0400
Content-Disposition: inline
In-Reply-To: <fabb9a1e1003281113o4cb1e723p4ed39521b645fffe@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143575>

On Sun, Mar 28, 2010 at 12:13:10PM -0600, Sverre Rabbelier wrote:

> On Sun, Mar 28, 2010 at 11:34, Jeff King <peff@peff.net> wrote:
> > Here is a quick and dirty in-core implementation. The most notable
> > defect is that all textconvs store under refs/notes/textconv, which is
> > obviously bogus if you might textconv the same blob in two different
> > ways.
> 
> What I did for the implementation of remote helpers is hash the url of
> the remote when storing it locally, that way you don't have to worry
> about escaping urls etc. You could do the same with the textconvs,
> store it under  refs/notes/textconv/<hash of textconv filter>?

I thought about something like that, but we want to keep something that
is comprehensible to the user. If my install of "exif" changes, I need
to be able to say "invalidate the cache for exif". If it's
human-readable, I know I need to clear refs/notes/textconv/exif. But if
it's a hash, then I need a special tool to figure out which ref is
relevant.

Instead, my plan is to use refs/notes/textconv/$TYPE, where $TYPE is the
same string used by the config (e.g., "diff.$TYPE.textconv") and the
gitattributes file (e.g., "*.jpg diff=$TYPE"). The user has already
provided us a with a short, unique, meaningful name.

-Peff
