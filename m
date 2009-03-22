From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Respect core.autocrlf when preparing temporary files
	for external diff
Date: Sun, 22 Mar 2009 03:46:43 -0400
Message-ID: <20090322074643.GA4826@coredump.intra.peff.net>
References: <cover.1237635609u.git.johannes.schindelin@gmx.de> <8cb424b16f21164ddc26d0be3f6f7727254b3506.1237635609u.git.johannes.schindelin@gmx.de> <7vocvuekjb.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903220053260.10279@pacific.mpi-cbg.de> <7v8wmybf06.fsf@gitster.siamese.dyndns.org> <7vzlfe9ynj.fsf@gitster.siamese.dyndns.org> <20090322061046.GA14765@coredump.intra.peff.net> <7v63i281py.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 08:48:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlIQ5-00086v-Rx
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 08:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbZCVHqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 03:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbZCVHqu
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 03:46:50 -0400
Received: from peff.net ([208.65.91.99]:55340 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447AbZCVHqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 03:46:49 -0400
Received: (qmail 9981 invoked by uid 107); 22 Mar 2009 07:46:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 22 Mar 2009 03:46:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2009 03:46:43 -0400
Content-Disposition: inline
In-Reply-To: <7v63i281py.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114128>

On Sun, Mar 22, 2009 at 12:18:33AM -0700, Junio C Hamano wrote:

> Ok.  Although I already queued the removal to 'pu' for tonight's pushout
> and it is way too late to revert that, I think I didn't have to remove the
> function.  The codepath that lets you cheat by borrowing from the checkout
> runs convert_to_git() when it borrows, and if you are seeing a meaningful
> optimization even with that overhead, perhaps it would be worth keeping.

I certainly haven't done exhaustive tests. Obviously the one I did was a
bit contrived. I just think it makes sense to have numbers rather than
saying "this probably doesn't do anything anymore".

> While the purist in me says #1 above is the right argument to make for
> feeding "clean" version, I suspect that the textconv or extdiff tools more
> often are not made from scratch and ported across platforms than are
> cobbled up together out of tools the script writer finds on his platform.
> I suspect that Dscho's "a tempfile should look like a checkout" would be
> much friendlier to them in practice for this reason.

I think you and I have about the same feeling on this, then. As somebody
who does not actually use smudge/clean filters at all, I am willing to
defer to Dscho's opinion, which is based on practical experience.

> > For some reason, with your patch the tempfiles are created with mode
> > 0005 for me (whereas they are usually 0505), which makes open() in the
> > called script unhappy.  Looking over the patch text, though, I have no
> > idea what change could be causing that.
> 
> Neither 0005 nor 0505 sounds correct to me; shouldn't they be 0600 or
> something like that?

Argh, sorry, of course I should have realized something was wrong with
my baseline when I saw 0505. I was building on a half-finished WIP
related to textconv, which obviously is broken. Sorry for the noise.

-Peff
