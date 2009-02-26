From: Jeff King <peff@peff.net>
Subject: Re: Does cloning a shallow repo require special setting in the
	cloned one?
Date: Thu, 26 Feb 2009 05:46:57 -0500
Message-ID: <20090226104657.GB4226@coredump.intra.peff.net>
References: <1235620146513-2387799.post@n2.nabble.com> <87tz6hn1tg.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: roylee17 <roylee17@gmail.com>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Feb 26 11:48:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcdnD-0000eF-Mh
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 11:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbZBZKrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 05:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753365AbZBZKrC
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 05:47:02 -0500
Received: from peff.net ([208.65.91.99]:35768 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753820AbZBZKrA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 05:47:00 -0500
Received: (qmail 3503 invoked by uid 107); 26 Feb 2009 10:47:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 26 Feb 2009 05:47:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Feb 2009 05:46:57 -0500
Content-Disposition: inline
In-Reply-To: <87tz6hn1tg.fsf@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111551>

On Thu, Feb 26, 2009 at 08:34:51AM +0200, Teemu Likonen wrote:

> On 2009-02-25 19:49 (-0800), roylee17 wrote:
> 
> > $ git clone --depth 1 git-full git-shallow2
> > 'git log' still gives a full history
> >
> > Why can't I clone a shallow repo from the git-full?
> > Does it requires some settings in the git-full repo?
> 
> I don't know the "why" part but using file:// URL should work:
> 
>     git clone --depth 1 file:///path/to/git-full git-shallow2

I don't think the behavior is intentional, but a side effect of the
fact that git takes some shortcuts when cloning locally. In particular,
it will try to copy or hardlink the object database rather than
transmitting over the git protocol locally. Using file:// has always
been the way to suppress that shortcut.

Perhaps to avoid surprise, that optimization should be turned off for
options which cause it to behave differently (like --depth). But I have
to wonder what the point of --depth is locally; if you are worried about
space, hardlinks (the default) or alternates ("clone -s") are a better
solution.

-Peff
