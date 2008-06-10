From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC] git-sequencer.txt
Date: Tue, 10 Jun 2008 06:46:35 +0200
Message-ID: <200806100646.36528.chriscool@tuxfamily.org>
References: <20080607220101.GM31040@leksak.fem-net> <m3d4mqwnxh.fsf@localhost.localdomain> <20080610012159.GI8079@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joerg Sommer <joerg@alea.gnuu.de>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Jun 10 06:43:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5vhV-0004LP-Ty
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 06:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbYFJEmY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2008 00:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbYFJEmY
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 00:42:24 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:43536 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbYFJEmX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 00:42:23 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 8A1E21AB2AC;
	Tue, 10 Jun 2008 06:42:21 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 435DF1AB2AE;
	Tue, 10 Jun 2008 06:42:21 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080610012159.GI8079@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84472>

Le mardi 10 juin 2008, Stephan Beyer a =E9crit :
> > > SYNOPSIS
> > > --------
> > > [verse]
> > > 'git-sequencer' [-v | --verbose] <file> [<branch>]
> >
> > I think that you should think carefully if there would be no troubl=
es
> > with this way of specifying options.  Perhaps explicit file option
> > (-F/--file=3D<file>), or optional '--' separating revisions.  But
> > perhaps my fears are for nothing, and current proposal is good
> > solution.
>
> Well, I think we (my mentors and me) had around three different versi=
ons
> of a synopsis.

Yes, we discussed:

'git-sequencer' [-v | --verbose] [-b <branch>] [<file>]

that would use stdin if <file> is not provided. If -b <branch> is used =
and=20
<branch> does not already exists, it would create it.

> ATM I think the synopsis is not a very important thing to discuss, as=
 it
> is relatively easy changeable even in the last minute. ;)
>
> But what are your actual fears?  What troubles do you think of?
>
> > > 'git-sequencer' --continue | --skip | --abort | --edit
> >
> > The common '--continue | --skip | --abort' infrastructure is, I thi=
nk,
> > one of the most important things about this.  I'd like to have
> > '--what' (or '--status') option to tell us if we are in the middle =
of
> > sequence of oprations, and what this sequence is (rebase, rebase -i=
,
> > am, revert, cherry-pick, sequencer <file>,...).
>
> I've read the discussion about git-what and I wrote it down on a yell=
ow
> memo sheet *g* (no real TODO list) to have such a thing in git-sequen=
cer.
>
> First I didn't want to have it in the prototype so I didn't add it to
> the spec.
> But it leads me to an open question I've also noticed on testing:
>
> If you currently start a rebase or am and there's a conflict and
> you do
> 	git sequencer --continue
> instead of
> 	git rebase --continue
> or
> 	git am --resolved
> the cleanup code of rebase/am is not executed and thus the job is not
> properly finished.
>
> How to prevent this?
> My first idea is the one I don't really like: the user tools temporar=
ily
> generate some "post-sequencer scripts", that get executed after
> finished sequencing. This way, it doesn't matter if you call git
> sequencer --continue, git rebase --continue or git am --resolved to
> finish the job.
>
> The second idea is that somehow the user tool should set a "CALLER"
> environment variable or tell the caller otherwise (--caller=3Drebase?=
)
> and git-sequencer only continues if called by the same caller.

Maybe the sequencer can look at the filename it is passed.
If it is something like "$GIT_DIR/*/git-rebase--interactive-todo" that =
can=20
mean it is called by "git rebase --interactive".

And then maybe when "git sequencer --continue" is called interactively,=
 it=20
can say something like:

"This sequencer run was started by 'git rebase --interactive' please=20
continue using 'git rebase --continue'."

Thanks,
Christian.
