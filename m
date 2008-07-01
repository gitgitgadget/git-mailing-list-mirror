From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC/PATCH 2/4] Add git-sequencer prototype documentation
Date: Tue, 1 Jul 2008 21:50:33 +0200
Message-ID: <20080701195033.GD5301@leksak.fem-net>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <m34p79hhy9.fsf@localhost.localdomain> <20080701160322.GC5301@leksak.fem-net> <200807012004.11563.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 21:52:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDltI-0000kt-OH
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 21:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758632AbYGATuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 15:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753709AbYGATuj
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 15:50:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:35203 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752565AbYGATui (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 15:50:38 -0400
Received: (qmail invoked by alias); 01 Jul 2008 19:50:35 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp010) with SMTP; 01 Jul 2008 21:50:35 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/1cVNhJjD1PesiPaTWsnXDr6Ba6T6slwIp5EpMxe
	cEZQMPBRnUkZxE
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KDls1-0004pW-R4; Tue, 01 Jul 2008 21:50:33 +0200
Content-Disposition: inline
In-Reply-To: <200807012004.11563.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87063>

Hi,

On Tue, Jul 01, 2008 at 08:04:10PM +0200, Jakub Narebski wrote:
> On Tue, 1 Jul 2008, Stephan Beyer wrote:
> > On Tue, Jul 01, 2008 at 06:02:54AM -0700,
> > Jakub Narebski <jnareb@gmail.com> wrote:
> >> Stephan Beyer wrote:
> >>> +merge [options] <commit-ish1> <commit-ish2> ... <commit-ishN>::
> >>> +	Merge commits into HEAD.
> >> 
> >> Nice.
> >> 
> >> "HEAD" mean last picked up / created commit, isn't it?
> > 
> > Right. This is used throughout the document...
> > I thought it is clear and better to use than always describing around it
> > by "last created commit".
> 
> O.K.

I don't know.  If something like "last created commit" is better,
I have no problem to change it :)

> >>> +ref <ref>::
> >>> +	Set ref `<ref>` to the current HEAD, see also
> >>> +	linkgit:git-update-ref[1].
> >> 
> >> So this functions like "git reset --soft <ref>", isn't it?
> > 
> > No. Why do you think that? `ref` is set, and not HEAD.
> > I think the description makes that clear.
> 
> Ah.  I'm sorry.  So it is like "git branch <ref>", isn't it?

No. It is "git-update-ref <ref> HEAD".

> What is important is: does it update reflog (correctly)?

Good question. The reflog is another mistery to me that I haven't really
cared about, because I haven't used it yet myself.
At least the reflog test cases for git rebase -i in the test suite pass.
(Of course, this is only a weak indication that it works as it should.)

> >>> +squash [options] --from <mark>::
[...]
> > Here an example why it is useful for user-editing:
> > 
> > (on commit f00babe)
> > 	mark :1
> > 	pick badcebab
> > 	patch foo
> > 	pick dadadada
> > 	squash -m "Foo the cebab" --signoff --from :1
> > 
> > This squashes all between the mark and the squash into one commit,
> > on top of f00babe.
>  
> Ah, so squash --from <mark> picks up everything since "mark <mark>",
> but does not include marked commit!  Clever!  In this case allowing
> only <mark> is a good idea, IMVHO.

Good, thanks :)

> >>> +	--include-merges;;
> >>> +		Sanity check does not fail if you have merges
> >>> +		between HEAD and <mark>.
> >> 
> >> How do you squash merges?  Creating merge with an union of parents,
> >> excluding commits which got squashed?
> > 
> > My squashes are realized using git reset --soft ... and then commit.
> > I think this makes only sense when there are no merges in between,
> > so I added the check, but if someone wants to squash merges, he should
> > be able to do it.
> >
> > To somehow answer your question: I do not care what the result is,
> > because I do not know what the result "should be".
> 
> O.K.  I guess that is something left for later, especially that
> forbidding merges in squashed commit is default (and you can always
> do without merges, I think).

Forbidding merges is default currently. It's just a sanity check. And
the option bypasses this check.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
