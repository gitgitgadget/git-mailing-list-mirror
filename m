From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: git gc & deleted branches
Date: Sat, 10 May 2008 12:24:00 -0400
Message-ID: <87prruxh3z.fsf@jeremyms.com>
References: <loom.20080509T011318-478@post.gmane.org>
	<20080509041921.GA14773@sigill.intra.peff.net>
	<E1B43061-69C7-43D7-9A57-34B7C55DF345@adacore.com>
	<48246A44.7020303@nrlssc.navy.mil>
	<alpine.LFD.1.10.0805091205580.23581@xanadu.home>
	<7vwsm39kft.fsf@gitster.siamese.dyndns.org> <877ie3yqb3.fsf@jeremyms.com>
	<20080510002014.GH29038@spearce.org>
	<7vskwr9coz.fsf@gitster.siamese.dyndns.org> <87y76jx6y4.fsf@jeremyms.com>
	<20080510052548.GA11556@sigill.intra.peff.net>
	<87tzh6yb2w.fsf@jeremyms.com> <alpine.DEB.1.00.0805101003350.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Geert Bosch <bosch@adacore.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 10 18:26:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JurtS-00018U-2c
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 18:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbYEJQY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 12:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752865AbYEJQY6
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 12:24:58 -0400
Received: from deleuze.hcoop.net ([69.90.123.67]:38557 "EHLO deleuze.hcoop.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854AbYEJQY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 12:24:56 -0400
Received: from [67.165.107.197] (helo=localhost)
	by deleuze.hcoop.net with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <jbms@cmu.edu>)
	id 1Jurrn-0000F7-RM; Sat, 10 May 2008 12:24:11 -0400
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
In-Reply-To: <alpine.DEB.1.00.0805101003350.30431@racer> (Johannes
	Schindelin's message of "Sat, 10 May 2008 10:04:27 +0100 (BST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81688>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
> On Sat, 10 May 2008, Jeremy Maitin-Shepard wrote:

>> Jeff King <peff@peff.net> writes:
>> 
>> > On Fri, May 09, 2008 at 09:51:15PM -0400, Jeremy Maitin-Shepard wrote:

>> >> When you create a new working directory, you would also create in the
>> >> original repository a symlink named
>> >> e.g. orig_repo/.git/peers/<some-arbitrary-name-that-doesn't-matter> that
>> >> points to the .git directory of the newly created working directory.
>> 
>> > That assumes you _can_ write to the original repository. That may or may
>> > not be the case, depending on your setup.

> FWIW this argument can be found in the mailing list.  It does not have to 
> be told over and over again, right?

Maybe you can point me at the relevant thread.  Fundamentally, though,
I'd say objects/info/alternates _cannot_ work reliably without the
source repository knowing about the objects that the sharing
repositories need.  Otherwise, there is no way for it to know not to
prune them.  The only way for it to have that information in general is
to write it in the repository.  In a site-specific setting, it may
indeed be possible to rely on some site-specific database, but that is
not particularly relevant.

Currently repository sharing seems to be used in many cases in quite
unsafe ways.  It may seem unfortunate that doing things the "safe way"
is much more of a hassle and doesn't work in certain environments, but
I'd say that is just the way things have to be.

Perhaps you can point me to an existing thread that addresses this idea,
though.

>> Well, I suppose in that case it could print a warning or maybe fail 
>> without some "force" option.  If you can't write to the repository, then 
>> I think it is safe to say that it will never know or care about you, so 
>> you will fundamentally have a fragile setup.  I'd say that except in 
>> very special circumstances, you are better off just not sharing it at 
>> all.

> Counterexample kernel.org.  Counterexample repo.or.cz.

repo.or.cz is not a counterexample.  It is completely "managed", and
could quite easily implement the approach I described.  I don't know
exactly how kernel.org works, but I imagine likewise some setuid helper
script could be provided to write these symlinks.

There is the issue that these setuid helper scripts would mean at the
very least that if user A can "fork" user B's repository, then to some
extent user B can make user A use large amounts of disk space
(i.e. exceed his quota or something) by just referencing a bunch of
temporary objects that user A happens to have in his repository, and it
would take careful examination of the git repository to actually figure
out that it is user B's fault.  I don't think this would be a
significant problem in practice, though.

-- 
Jeremy Maitin-Shepard
