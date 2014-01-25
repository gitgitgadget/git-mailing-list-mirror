From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: Globbing for ignored branches?
Date: Sat, 25 Jan 2014 18:15:48 +0100
Message-ID: <20140125171548.GB402@x4>
References: <20140124170739.GC396@x4>
 <20140124170909.GD396@x4>
 <20140124182341.GB8202@sigill.intra.peff.net>
 <20140124183222.GE396@x4>
 <20140124185538.GA9836@sigill.intra.peff.net>
 <xmqq4n4trvzj.fsf@gitster.dls.corp.google.com>
 <20140124204825.GA17167@sigill.intra.peff.net>
 <xmqqeh3xqe91.fsf@gitster.dls.corp.google.com>
 <20140125013433.GA22336@sigill.intra.peff.net>
 <20140125141542.GA402@x4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jim Garrison <jim.garrison@nwea.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 25 18:15:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W76pq-00014s-SD
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 18:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbaAYRPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jan 2014 12:15:53 -0500
Received: from ud10.udmedia.de ([194.117.254.50]:53918 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbaAYRPv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jan 2014 12:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=mail.ud10.udmedia.de; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=beta; bh=x/yz/Ev2dtyiKgPlpbIFgX1zoF
	kzGBqURlXIkkNbPjM=; b=d9H4jXJ+il+UGQrIgBiP0iESnUctf2ASmZe8eYMc9T
	e2u6IP1AO0PFdQ0lCZwxrhGgFN1ofw0IuLqU+ikxrNEn0z6d9Y22QB7c9bbYw3wr
	tcIpcnHr+LZXy4UpwtCWdrhrzxQR5V81rcAN0DyKOD4uHTUId2MR5G7h52K2vL3+
	I=
Received: (qmail 30436 invoked from network); 25 Jan 2014 18:15:48 +0100
Received: from unknown (HELO x4) (ud10?360p3@91.64.96.185)
  by mail.ud10.udmedia.de with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 25 Jan 2014 18:15:48 +0100
Content-Disposition: inline
In-Reply-To: <20140125141542.GA402@x4>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241069>

On 2014.01.25 at 15:15 +0100, Markus Trippelsdorf wrote:
> On 2014.01.24 at 20:34 -0500, Jeff King wrote:
> > On Fri, Jan 24, 2014 at 01:08:42PM -0800, Junio C Hamano wrote:
> > 
> > > Not really.  You do not have to view it as "'not refs/heads/foo' is
> > > affecting the previous '+refs/heads/*:refs/remotes/origin/*'".
> > > 
> > > You can think of two refspecs "refs/heads/foo refs/heads/bar" are
> > > both affecting the "end result"; so far we only had a single way for
> > > multiple refspecs to affect the end result and that was a "union".
> > > Introducing "subtract" as another mode of combining is not too bad,
> > > I would think, at the conceptual level.
> > 
> > > I tend to agree that "refs/heads/foo:" is being too cute and may be
> > > confusing, at least if it will be the only way to express this in
> > > the end-user-facing UI.  Even some people were confused enough on a
> > > very sensible "push nothing to ref means deletion" to make us add
> > > another explicit way, "push --delete", to ask for the same thing.
> > 
> > Agreed. I went with "^refs/heads/master" in the patch below, but I am
> > open to other suggestions.
> 
> Many thanks for the patch. It seems to work as advertised, but only if
> the negative refspec appears on a separate line. For example:

I've posted a wrong negative refspec. Sorry. Correction below.

> [remote "origin"]
>         url = git://gcc.gnu.org/git/gcc.git
>         fetch = +refs/heads/*:refs/remotes/origin/*
>         fetch = ^refs/remotes/hjl
          fetch = ^refs/remotes/origin/hjl

> works fine, but:
> 
> [remote "origin"]
>         url = git://gcc.gnu.org/git/gcc.git
>         fetch = +refs/heads/*:refs/remotes/origin/* ^refs/remotes/hjl 
          fetch = +refs/heads/*:refs/remotes/origin/* ^refs/remotes/origin/hjl

> doesn't. (I think this happens because bad_ref_char in refs.c checks for '^'.)

-- 
Markus
