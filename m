From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH v2] Teach 'git pull' about --rebase
Date: Wed, 28 Nov 2007 17:33:39 -0500
Message-ID: <20071128223339.GF7376@fieldses.org>
References: <Pine.LNX.4.64.0710260007450.4362@racer.site> <7v3avy21il.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0710261047450.4362@racer.site> <7v3aurcjpq.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711281307420.27959@racer.site> <27E5EF3C-19EF-441C-BB12-0F5B29BEAEDB@midwinter.com> <Pine.LNX.4.64.0711282039430.27959@racer.site> <8c5c35580711281310h8764a33pba48e65010abf859@mail.gmail.com> <7vhcj63uhw.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711282156520.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 23:34:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxVUR-0001XR-6t
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 23:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760637AbXK1WeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 17:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754839AbXK1WeU
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 17:34:20 -0500
Received: from mail.fieldses.org ([66.93.2.214]:34645 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760480AbXK1WeT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 17:34:19 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IxVTP-00078G-Gt; Wed, 28 Nov 2007 17:33:39 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711282156520.27959@racer.site>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66443>

On Wed, Nov 28, 2007 at 09:58:52PM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 28 Nov 2007, Junio C Hamano wrote:
> 
> > "Lars Hjemli" <hjemli@gmail.com> writes:
> > 
> > > On 11/28/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >> On Wed, 28 Nov 2007, Steven Grimm wrote:
> > >> > I wonder if this shouldn't be branch.<name>.pulltype or something like
> > >> > that, so we can represent more than just "rebase or not." Values could
> > >> > be "rebase", "merge" (the default) and maybe even "manual" to specify
> > >> > that git-pull should neither merge nor rebase a particular branch even
> > >> > if it matches a wildcard refspec.
> > >>
> > >> I am not convinced that this is a good thing... We already have
> > >> branch.<name>.mergeOptions for proper merges, and I want to make clear
> > >> that this is about rebase, and not about merge.
> > >
> > > Maybe branch.<name>.pullOptions ?
> > 
> > Maybe not make this part of git-pull at all?  merge and rebase have
> > totally different impact on the resulting history, so perhaps a separate
> > command that is a shorthand for "git fetch && git rebase" may help
> > unconfuse the users.
> 
> Not so sure about that.  We already have too many commands, according to 
> some outspoken people, and this would add to it.

What they're really complaining about is the size and complexity of the
interface, and the lack of a clearly identified subset for them to learn
first.

This has so far mainly manifested itself in complaints about the number
of commands, because that's currently where a lot of our complexity is.
But they *will* complain about proliferation of commandline switches and
config options too.  (I've heard complaints about the number of switches
required on the average cvs commandline, for example.)

We're stuck expanding the interface here, whether we expand it by
another command or another commandline switch.

So, how do you decide whether to make it a new command or not?

	- Look at existing documentation that talks about pull: if that
	  documentation will still apply to the new pull, that weighs
	  for keeping it the same command.  If theat documentation would
	  apply only without having a certain config value set, then I
	  think it's better as a separate command.

	- Will this make it more or less simple to identify the subset
	  of the git syntax that a user will have to do a given job?  If
	  there are jobs for which someone might only ever need the new
	  fetch+rebase, or for which they would only ever need the
	  traditional pull, then I think it would keep the two separate,
	  to make it easier for a learner to skip over information about
	  the one they're not using.

I've got no proposal for an alternate name.  All that comes to mind is
the portmanteau "freebase", which is terrible....

--b.
