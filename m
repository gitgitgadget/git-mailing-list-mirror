From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Add support for --wrt-author, --author and --exclude-author switches to git-rev-list
Date: Wed, 8 Jun 2005 10:58:34 +0200
Message-ID: <20050608085834.GC7916@pasky.ji.cz>
References: <20050607091523.14051.qmail@blackcubes.dyndns.org> <20050607094947.GC2676@pasky.ji.cz> <2cfc403205060702594da21fb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 10:57:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfwL6-0001G8-KS
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 10:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVFHI6r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 04:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVFHI6r
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 04:58:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:9942 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262143AbVFHI6g (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 04:58:36 -0400
Received: (qmail 6209 invoked by uid 2001); 8 Jun 2005 08:58:34 -0000
To: Jon Seymour <jon.seymour@gmail.com>
Content-Disposition: inline
In-Reply-To: <2cfc403205060702594da21fb1@mail.gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Jun 07, 2005 at 11:59:36AM CEST, I got a letter
where Jon Seymour <jon.seymour@gmail.com> told me that...
> On 6/7/05, Petr Baudis <pasky@ucw.cz> wrote:
> > I'd prefer just --wrt-author and --exclude-author to take an argument on
> > their own.
> 
> The reason I don't want to do this is that it doesn't really make
> sense in the context of the change to specify one author for
> --wrt-author and another for --exclude-author. In normal use --author
> defaults to GIT_AUTHOR_EMAIL or the locally derived user@host.domain.
> The  intention is simply to override this default derivation.

Hmm, then why not make it --wrt-author[=AUTHOR] ? Similar to the
--pretty option. BTW, can it do multiple author excludes now? The
commandline would look especially horrifying in that case now, I guess.

I'd prefer --stop-at-author from the choices you offer in your other
mail.

> > (Note that I don't endorse this patch and the --wrt-author behaviour in
> > particular seems strange. I don't have enough time to comment on it
> > sensibly now, though. I'm just focusing on style here since I'd like to
> > still be able to read git's source code few weeks from now on.)
> 
> The rationale for the change is as follows:
> 
> During parallel development, one is aware of ones own
> changes...everyone else changes haven't happened yet as far as you are
> concerned. Only when they appear in a future merge that incorporates
> one's own changes do the other changes appear in your own workspace.
> 
> As far as you are concerned, these changes occurred after you made
> your own - your changes were not dependent on those changes, only on
> those that came before. So the linearisation reflects that perceived
> ordering of changes.
> 
> --wrt-author helps to reconstruct the merge-history from the
> perspective of each individual committer.

Yes, such motivation makes sense. But is the author field the right one?
If you are integrating a lot of other people's patches in particular, I
think it makes no sense whatsoever - you already reviewed and
consciously applied them, but your option will regard them as something
alien and merged from outside, right?

And, after all, the other branches might be _quite_ long-lived. I think
it would be confusing for the user if the commit graph looked like

  a1 -- a2 -- a3 -- a4 -- a5 -- a6 -- a7 -- a8 -- a9 -- a10
     \           /           /     \                 /
      - b1 -- b2 -- b3 -- b4 -- b5 -- b6 -- b7 -- b8 -- b9

If your patch first chooses b1, it then shows all of it, completely
ignoring a2, right? I can't see how that would be right - the subsequent
merges from a should be shown.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
