From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] tile: support GENERIC_KERNEL_THREAD and
 GENERIC_KERNEL_EXECVE
Date: Wed, 24 Oct 2012 12:18:02 +0100
Message-ID: <20121024111802.GB2006@arm.com>
References: <20121019213548.GR2616@ZenIV.linux.org.uk>
 <5082A1F1.3080303@tilera.com>
 <20121020153401.GT2616@ZenIV.linux.org.uk>
 <20121020171643.GU2616@ZenIV.linux.org.uk>
 <5086D432.4070008@tilera.com>
 <20121023184122.GZ2616@ZenIV.linux.org.uk>
 <alpine.LFD.2.02.1210232232070.2756@ionos>
 <20121023205119.GA27729@sigill.intra.peff.net>
 <CAHkRjk6x9ToVzY7jv1ZxPt57F6agcH7SfHZpZNpHC3QP3PZp3Q@mail.gmail.com>
 <20121023212245.GA28828@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Chris Metcalf <cmetcalf@tilera.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: linux-kernel-owner@vger.kernel.org Wed Oct 24 13:18:46 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1TQyyy-0000PY-Ac
	for glk-linux-kernel-3@plane.gmane.org; Wed, 24 Oct 2012 13:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758251Ab2JXLS3 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 24 Oct 2012 07:18:29 -0400
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:47763 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751644Ab2JXLS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Oct 2012 07:18:27 -0400
Received: from arm.com (e102109-lin.cambridge.arm.com [10.1.69.68])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id q9OBI8E7027472;
	Wed, 24 Oct 2012 12:18:08 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20121023212245.GA28828@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208304>

On Tue, Oct 23, 2012 at 10:22:45PM +0100, Jeff King wrote:
> On Tue, Oct 23, 2012 at 10:09:46PM +0100, Catalin Marinas wrote:
> > > It is spelled:
> > >
> > >   git notes add -m <comment> SHA1
> > >
> > > The resulting notes are stored in a separate revision-controlled branch
> > > and can be pushed and pulled like regular refs. Note, though, that the
> > > default refspecs do not yet include refs/notes, so you'd have to add
> > > them manually. The workflows around notes are not very mature yet, so if
> > > you start using them, feedback would be appreciated.
> > 
> > What would be nice is that notes are pushed/pulled automatically with
> > standard git push/fetch/pull commands. Usually git walks the DAG
> > starting with the pulled commit or tag and following the parents. With
> > notes, the reference is reversed, the note pointing to the commit and
> > not the other way around. So handling this automatically in Git would
> > be really useful.
> 
> Right, that's what I meant about the refspecs. You can configure git to
> push or pull them automatically, but it is not the default. Something
> like:
> 
>   git config --add remote.origin.fetch '+refs/notes/*:refs/notes/origin/*'

Yes, but that's a bit more complicated than a simple pull. Anyway, Linus
seems to not be in favour of annotating commits later for adding acks,
so no need for such feature.

> > The other feature I'd like is that notes are automatically folded in
> > the log during git rebase (maybe similar to the squash option). If you
> > rebase, you lose all the notes (though this depends on the workflow,
> > it may not be needed with published branches).
> 
> Git-rebase can automatically copy notes from one commit to another
> during a rebase, but you need to set notes.rewriteRef to do so (see "git
> help config" for details). The reason for this conservative default is
> that some notes may not be appropriate for automatic copying (e.g., a
> notes tree containing QA approval should probably be invalidated during
> a rebase, whereas one with commentary probably should).

Thanks, I wasn't aware of this.

> Squashing the notes into the commit message during rebase would be a
> useful feature (at least for some type of notes), but that feature does
> not currently exist (and as far as I recall, this is the first it has
> been proposed).

For some workflow - I post patches to the list, people reply with their
acks, I could just add those to notes and later fold them into the
existing commits before pushing the branch upstream. I guess it may be
just a matter of changing git format-patch to include the notes. I can
later reword he commits and drop the "Notes:" line.

-- 
Catalin
