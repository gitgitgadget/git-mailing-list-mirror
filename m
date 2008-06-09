From: Stephan Beyer <s-beyer@gmx.net>
Subject: squashing patches (was: Re: [RFC] git-sequencer.txt)
Date: Mon, 9 Jun 2008 13:45:50 +0200
Message-ID: <20080609114550.GA8079@leksak.fem-net>
References: <20080607220101.GM31040@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joerg Sommer <joerg@alea.gnuu.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 13:46:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5fpm-0007ET-25
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 13:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759928AbYFILpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 07:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759867AbYFILpz
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 07:45:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:56015 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759430AbYFILpy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 07:45:54 -0400
Received: (qmail invoked by alias); 09 Jun 2008 11:45:52 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp055) with SMTP; 09 Jun 2008 13:45:52 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19KB+cbj1RKEw1Nir6/e0brtc/lj406anXl88EqaB
	aiI+j72HTlrOE+
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K5fos-0002Hr-J4; Mon, 09 Jun 2008 13:45:50 +0200
Content-Disposition: inline
In-Reply-To: <20080607220101.GM31040@leksak.fem-net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84377>

Wow,

I didn't expect *that much* feedback :-)
I think I begin slowly to comment some things, and/or tell you
some things that are still open.
Then, maybe, someone of you swoops in :)

> TODO FILE FORMAT
> ----------------

First to say, I tried to be (backwards-)compatible to the 
rebase--interactive TODO file format in "master".
It became incompatible to the one in "next" in one point 
only (-> merge). But if I understood "next" right, this is
not bad, since Joerg Sommers rebase-i patchset is still
open for discussion (i.e. mark).

Well, now I come to the subject's topic.


I've noticed that one thing is *obviously* missing:

There's a slight asymmetry between
> file [<options>] <file>::
and
> pick [<options>] <commit>::
> edit <commit>::
> squash [<options>] <commit>::

"edit" is kept for backwards compatibility. It's a short form for and
internally `expanded' to "pick --edit".
As --edit is a general option, there is also "file --edit".
So there's no functional asymmetry in this case.

If you want to pick several commits and squash them together, there is
"squash".  BUT there is no equivalent for "file" currently.
The only way to squash several patches together is with an external tool
like your favourite text editor, which is not fun but error-prone.
And there is no way to squash a commit (in the repo) and a patch (as file)
together (in exactly this order). The only thing is that you could run
sequencer twice and squash in the second move.

So I wonder if file --squash is useful, too, or even --squash as an
general option. The latter means that you could squash merge commits
into other commits, too.

We've also discussed the non-atomic approach of doing something like
	pick ( a b c d )	# or another syntax for that
for picking multiple commits into one.
In my current point of view, this does not seem right, as it:
 - is not atomic ;), and...
 - Well, the approach could be used for "file ( a b c d )", too,
   but it doesn't help for squashing commits AND patches.

Comments? Opinions? Ideas?

A first try to prod,
  Stephan.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
