From: Jeff King <peff@peff.net>
Subject: Re: Improving the git remote command
Date: Tue, 26 Aug 2014 12:37:41 -0400
Message-ID: <20140826163741.GA14983@peff.net>
References: <53FC537C.4080206@gmail.com>
 <20140826124027.GE29180@peff.net>
 <CAGK7Mr7BPvV6oO_t4x_1m9sDtWBgPWUqDq+3kZx6rVYAhY+wqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UsOpbXk=?= Hubscher <hubscher.remy@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 18:37:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMJkp-0007rm-7f
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 18:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbaHZQho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 12:37:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:59345 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752460AbaHZQhn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 12:37:43 -0400
Received: (qmail 31474 invoked by uid 102); 26 Aug 2014 16:37:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 11:37:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2014 12:37:41 -0400
Content-Disposition: inline
In-Reply-To: <CAGK7Mr7BPvV6oO_t4x_1m9sDtWBgPWUqDq+3kZx6rVYAhY+wqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255916>

On Tue, Aug 26, 2014 at 06:19:20PM +0200, Philippe Vaucher wrote:

> > Perhaps "-v" should have been the default all along.  I do not use "git
> > remote" myself, so I don't know if "-v" is what most people use. But
> > changing the output of "git remote" now is probably a bad thing (I
> > expect some people may depend on parsing it to get the list of remotes;
> > they should probably use the git-config plumbing to do the same thing,
> > but it's actually rather tricky to do it that way).
> 
> Just to be clear, the proposal is not about changing the output of
> "git remote".

I know. But we are left with three options:

  1. Add "git remote list" with verbose output. This is bad because it
     differs gratuitously from "git remote".

  2. Add "git remote list" with non-verbose output. This is good because
     it means "git remote" is just a shortcut for "git remote list",
     which is consistent with other parts of git. But it is potentially
     bad if "-v" is a better output format.

  3. Add "git remote list" with verbose output, and tweak "git remote"
     to match. This is bad because it breaks backwards compatibility.

The proposal is for (1). I think we agree that (3) is out. The question
is whether (1) or (2) is the least bad.

> Anyway, it got me curious about other git commands reguarding "list",
> and I was very surprised because I couldn't find another one. I mean
> "git remote" actually behaves like "git branch" and "git tag". I have
> no clue why I expect "list" to work with "git remote".

Branch and tag take "--list". Remote is the odd one out in that its
subcommands do not have dashes. git-stash also takes commands without
dashes (and has a list command), but its default mode is to create a
stash, not to list.

> It's probably because "git branch" and "git tag" expect a name, and
> there "list" can only be expressed by "no name" or with some flags. On
> the other hand, "git remote" expects a subcommand (add, delete, etc)
> and there what logically maps to "list" is the subcommand "list", "no
> name" being more expected to produce a list of the subcommands.

Yeah. Branch and tag need dashed subcommands because otherwise it is
ambiguous with creating tag called "list", functionality that existed
before "--list" was added. Git-remote was defined with subcommands from
day one, so it can get away with it. Git-stash is sort of in the
category as git-remote there, except that "save" can actually take an
argument. So to provide it you can't say "git stash foobar", but instead
have to say "git stash save foobar" (it actually used to allow the
former, but you can imagine the annoyance when you typo "git stash
lsit").

-Peff
