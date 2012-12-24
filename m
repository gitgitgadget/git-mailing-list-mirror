From: Jeff King <peff@peff.net>
Subject: Re: Find the starting point of a local branch
Date: Mon, 24 Dec 2012 01:19:38 -0500
Message-ID: <20121224061938.GA25186@sigill.intra.peff.net>
References: <20121224035825.GA17203@zuhnb712>
 <201212240409.qBO49wkV020768@no.baka.org>
 <CACsJy8CNd3W_WUMbZ1QZ4ReZ5ziX90QejK9mh1TMs0ig33kGMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Seth Robertson <in-gitvger@baka.org>,
	Woody Wu <narkewoody@gmail.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 07:20:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tn1OK-00066O-37
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 07:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981Ab2LXGTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 01:19:42 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34899 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245Ab2LXGTl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 01:19:41 -0500
Received: (qmail 18182 invoked by uid 107); 24 Dec 2012 06:20:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Dec 2012 01:20:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Dec 2012 01:19:38 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8CNd3W_WUMbZ1QZ4ReZ5ziX90QejK9mh1TMs0ig33kGMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212101>

On Mon, Dec 24, 2012 at 12:28:45PM +0700, Nguyen Thai Ngoc Duy wrote:

> > You want to know "what commit was I at when I typed `git branch
> > mybranch`"?  The problem is git doesn't record this information and
> > doesn't have the slightest clue.
> 
> Maybe we should store this information. reflog is a perfect place for
> this, I think. If this information is reliably available, git rebase
> can be told to "rebase my whole branch" instead of my choosing the
> base commit for it.

Is that what you really want, though? We record the "upstream" branch
already, and you can calculate the merge base with that branch to see
which commits are unique to your branch. In simple cases, that is the
same as "where did I start the branch". In more complex cases, it may
not be (e.g., if you merged some of the early commits in the branch
already).  But in that latter case, would you really want to rebase
those commits that had been merged?

The reason that git does not bother storing "where did I start this
branch" is that it is usually not useful. The right question is usually
"what is the merge base". There are exceptions, of course (e.g., if you
are asking something like "what work did I do while checked out on the
'foo' branch"). But for merging and rebasing, I think the computed
merge-base is much more likely to do what people want.

-Peff
