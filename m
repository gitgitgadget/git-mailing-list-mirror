From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Closing the merge window for 1.6.0
Date: Mon, 14 Jul 2008 12:00:54 -0700
Message-ID: <7v3amcgujd.fsf@gitster.siamese.dyndns.org>
References: <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
 <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
 <7vprpwhp7t.fsf@gitster.siamese.dyndns.org>
 <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org>
 <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org>
 <7vabgqsc37.fsf@gitster.siamese.dyndns.org>
 <7vtzetjbif.fsf@gitster.siamese.dyndns.org>
 <7vzlokhpk7.fsf@gitster.siamese.dyndns.org>
 <20080714085555.GJ32184@machine.or.cz>
 <alpine.DEB.1.00.0807141256310.8950@racer>
 <20080714124109.25414.qmail@06d015ec9c6744.315fe32.mid.smarden.org>
 <alpine.LFD.1.10.0807141351540.12484@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Jul 14 21:02:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KITJE-0006GE-3f
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 21:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbYGNTBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 15:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752990AbYGNTBF
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 15:01:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49150 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbYGNTBE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 15:01:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B862233CBA;
	Mon, 14 Jul 2008 15:01:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9D3DD33CB9; Mon, 14 Jul 2008 15:00:56 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0807141351540.12484@xanadu.home> (Nicolas
 Pitre's message of "Mon, 14 Jul 2008 13:54:34 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 344045D4-51D7-11DD-B393-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88448>

Nicolas Pitre <nico@cam.org> writes:

> On Mon, 14 Jul 2008, Gerrit Pape wrote:
>
>> On Mon, Jul 14, 2008 at 12:57:56PM +0100, Johannes Schindelin wrote:
>> > On Mon, 14 Jul 2008, Petr Baudis wrote:
>> > > I'm saying this because I believe the best conservative upper bound for 
>> > > backwards compatibility is Git version in Debian stable. It gets 
>> > > probably the most stale from all the widely used software distributions 
>> > > using Git, and it *is* quite widely used. Etch carries v1.4.4.4, which 
>> > > fails miserably on the new packs.
>> > 
>> > Can't we just hit Debian's Git maintainer with a clue bat or a bus, 
>> 
>> Please don't.  It wouldn't help, rather the opposite I think, espacially
>> the bus.  We don't introduce new upstream versions into a Debian stable
>> release, there's a great effort done for each stable release to reach
>> high quality integration of all the software packages available in
>> Debian.  Once that status is reached, only security fixes and criticial
>> usability fixes are added.
>
> Please consider it as a critical usability problem.
>
> Maybe we can release 1.4.5 with the ability to read index v2?  That 
> wouldn't be hard to backport the reading part of it.

I am of two minds here.

On one hand, I am sympathetic to distros that want to give long time
support for ancient versions to keep working in an ever-changing new
world.  It is a wonderful thing that there are distros that aim for ultra
conservative stability, and I applaud them.

But as the upstream, we have our own deprecation schedule.  We should of
course plan carefully not to harm existing users of our releases, but
frankly speaking, 18 months since 1.4.4.4 was tagged (early January 2007)
is an eternity in git timescale.  Maybe we will slow down someday, and
this 18-month is not a set-in-stone rule in any way, but at this point
even without the packfile format issues, I personally think anything
before 1.5.0 is irrelevant --- maybe they are interesting as historical
curiosities, but not more than that.

We could:

	$ git checkout -b maint-1.4 v1.4.4.4
        $ git merge maint
        $ git tag v1.4.4.5

and push the result out.  While I would imagine that the end-user
experience after such a maintenance release would be very positive, that
is not something distros who really want to stay with a stale version for
a good reason would want to swallow ;-).

If we _were_ to keep v1.4.4.X series alive, serious backporting efforts
will be necessary.  For example, recent 'git-shell' futureproofing was
made not just to 1.5.6.X series but was backported to 1.5.4.X and 1.5.5.X,
and we would probably need to give it to 1.4.4.X as well.  What other
things are there that are missing in 1.4.4.X?  It would take nontrivial
engineering resource to even list them, let alone assessing how much
effort is required for such backporting and actually doing it.

The remotes/ layout, use of "git-add" for new contents (instead of only
new files), reflogs, detached HEAD, --pretty=format:%<blah>, bundles,
mergetool,...  all the things that a modern git workflow revolves around
and are described in the user manuals the users find on the net are not
found in 1.4.4.X series.  If a user of such a conservative distro needs to
work with a repository prepared on another platform with newer git,
perhaps crossmounted, should we backport "git branch -r" so that the user
can confortably work with remote tracking branches?  Should we backport
reflogs?

If a distro chooses to support its users whom they force to pin at 1.4.4.X
series, it's primarily _their_ choice.  I do not mind helping them in such
a backport, but the request has to come from the distro first with a
specific list of items that need to be supported.
