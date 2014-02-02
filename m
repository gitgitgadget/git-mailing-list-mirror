From: Jeff King <peff@peff.net>
Subject: Re: splitting a commit that adds new files
Date: Sun, 2 Feb 2014 18:11:10 -0500
Message-ID: <20140202231110.GC16196@sigill.intra.peff.net>
References: <CACsJy8BXGZ+1Oqrpcky5JPCtZRwvxmxhXGfuEqY9Ct4Pt8FmJg@mail.gmail.com>
 <xmqqzjm9fkk4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 00:11:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WA6CT-0001HZ-7E
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 00:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbaBBXLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 18:11:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:43357 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752513AbaBBXLM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 18:11:12 -0500
Received: (qmail 31792 invoked by uid 102); 2 Feb 2014 23:11:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 02 Feb 2014 17:11:12 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Feb 2014 18:11:10 -0500
Content-Disposition: inline
In-Reply-To: <xmqqzjm9fkk4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241389>

On Sun, Feb 02, 2014 at 10:15:07AM -0800, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > I usually start splitting a commit with "reset @^" then "add -p" back.
> > The problem is "reset @^" does not keep track of new files added in
> > HEAD, so I often end up forgetting to add new files back (with "add
> > -p"). I'm thinking of making "reset" to do "add -N" automatically for
> > me so I won't miss changes in "add -p". But maybe people already know
> > how to deal with this case without adding more code?
> 
> Is "reset -p" what you are looking for?  I do not use that myself,
> though.

I don't think so. He is at a commit that needs split, so the first thing
to do is to shift the HEAD back. "reset -p" is only about changing the
index[1]. I suppose you could start with a soft reset, and then "reset
-p" away the changes. But then you are going backwards ("this does not
belong in the commit, remove it" rather than "this does belong in the
commit, add it").

I don't typically have a problem with this because I keep my directory
free of untracked files (they are either marked by .gitignore, or
something that I am planning to commit). So just running "git status"
gives me a neat list of what needs to be added (and typically "git add
-N ." is a good starting point upon which to build a "git add -p"
session).

-Peff

[1] I _do_ use "reset -p" when splitting commits, but I do not think it
    is useful here. I use it for "oops, I staged this change, but it
    actually belongs in the next commit. Undo my staging, but leave the
    changes in the working tree for the next one".
