From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: squashing patches
Date: Tue, 10 Jun 2008 02:38:16 +0200
Message-ID: <20080610003816.GH8079@leksak.fem-net>
References: <20080607220101.GM31040@leksak.fem-net> <20080609114550.GA8079@leksak.fem-net> <7vprqqh06j.fsf@gitster.siamese.dyndns.org> <20080609204327.GD8079@leksak.fem-net> <7vskvmfhjj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joerg Sommer <joerg@alea.gnuu.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 02:39:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5rtT-0000hp-HM
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 02:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbYFJAiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 20:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752102AbYFJAiX
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 20:38:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:36680 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751442AbYFJAiX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 20:38:23 -0400
Received: (qmail invoked by alias); 10 Jun 2008 00:38:21 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp014) with SMTP; 10 Jun 2008 02:38:21 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18YvDxkwOIYgDe0m73NkJJeap6JfS/Ys3ZrhIz0JM
	XUC6GkNpv1O2j/
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K5rsO-0000du-TI; Tue, 10 Jun 2008 02:38:16 +0200
Content-Disposition: inline
In-Reply-To: <7vskvmfhjj.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84463>

Hi,

> > Example:
> > 	pick ea7beef
> > 	edit		# or "pause" as you suggested
> > After a little discussion this became:
> > 	pick --edit ea7beef
> >
> > And I can't objectively say what's better
> 
> Me neither.  My "expectation" came primarily from what I understood,
> namely you seemt to prefer atomism, and not from "I want things to be this
> way".

Yes I prefer atomism, because it helps to keep things simple and stupid.

> If we think any proposed and future instruction would be reasonable to
> have --edit option, then all insn implementation would need to support
> "edit" option anyway, and the users do not have to remember which insn
> does and does not support --edit

Currently every insn where it makes sense (indeed, this may be
subjective) does support --edit.  So currently "file" (or "patch"),
"pick", "merge" and "squash" do, because they commit something.

But you are right (and I think Peff meant the same), that the separate
insn is more generic and thus it's more flexible.

So would you prefer a)"pause" or b)"edit"?
Or as text:
a)
edit [<commit>]::
	Pauses the sequencer process to let you manually make changes.
+
After you have finished your changes and added them to the index,
invoke `git-sequencer --continue`.
If you only want to edit the last commit message with an editor,
run `git commit --amend` (see linkgit:git-commit[1]) before.
+
If `<commit>` is given, pick `<commit>` first. This is a short form for
`pick <commit>` and `edit` on separate lines.)

b)
edit <commit>::
	Picks a commit and pauses the sequencer process to let you
	make changes.
+
This is a short form for `pick <commit> and `pause` on separate lines.

pause::		# (perhaps options may occur later, if they make sense)
	Pauses the sequencer process to let you manually make changes.
+
After you have finished your changes and added them to the index, 
invoke `git-sequencer --continue`.
If you only want to edit the last commit message with an editor,
run `git commit --amend` (see linkgit:git-commit[1]) before.


More flexible and modular seems to be the approach b).
But I want your opinion to go sure. ;-)

> I see.  Not using count but setting an explicit mark and using that commit
> sounds more robust, considering that use case.

So I take the --up-to syntax from Paolo?
Seemed right to me.

> >>  - The "tag" command looked a little out of place;
> >
> > Eh, why?
> 
> Why not?

Because it's practical.
The marks are only available during sequencer process and it's just
useful to tag something that you can reach by that name afterwards
(or during sequencing, too).
The user could use tag instead of mark if he wants to keep the ref
after sequencing.
I also can imagine sequencer-using scripts, that want to tag a version
release or something.

> I just wondered why there was a support only for lightweight tag there.

Basically because it's in next :)
And then I thought "Ok, nice. Let's keep it.".

> You do not have "branch" command, and your "tag" command does not seem to
> support things like -a, -s, -m<msg>, etc.

Hmmm, -a, -s and -m could even be useful.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
