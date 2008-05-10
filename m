From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: git gc & deleted branches
Date: Sat, 10 May 2008 01:36:39 -0400
Message-ID: <87tzh6yb2w.fsf@jeremyms.com>
References: <loom.20080509T011318-478@post.gmane.org>
	<20080509041921.GA14773@sigill.intra.peff.net>
	<E1B43061-69C7-43D7-9A57-34B7C55DF345@adacore.com>
	<48246A44.7020303@nrlssc.navy.mil>
	<alpine.LFD.1.10.0805091205580.23581@xanadu.home>
	<7vwsm39kft.fsf@gitster.siamese.dyndns.org> <877ie3yqb3.fsf@jeremyms.com>
	<20080510002014.GH29038@spearce.org>
	<7vskwr9coz.fsf@gitster.siamese.dyndns.org> <87y76jx6y4.fsf@jeremyms.com>
	<20080510052548.GA11556@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Geert Bosch <bosch@adacore.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 10 07:38:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juhmg-0001Ii-Cd
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 07:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbYEJFhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 01:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbYEJFhQ
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 01:37:16 -0400
Received: from deleuze.hcoop.net ([69.90.123.67]:52216 "EHLO deleuze.hcoop.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750845AbYEJFhO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 01:37:14 -0400
Received: from c-67-165-107-197.hsd1.pa.comcast.net ([67.165.107.197] helo=localhost)
	by deleuze.hcoop.net with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <jbms@cmu.edu>)
	id 1JuhlC-0001ET-5Q; Sat, 10 May 2008 01:36:42 -0400
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
In-Reply-To: <20080510052548.GA11556@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 10 May 2008 01:25:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81651>

Jeff King <peff@peff.net> writes:

> On Fri, May 09, 2008 at 09:51:15PM -0400, Jeremy Maitin-Shepard wrote:
>> When you create a new working directory, you would also create in the
>> original repository a symlink named
>> e.g. orig_repo/.git/peers/<some-arbitrary-name-that-doesn't-matter> that
>> points to the .git directory of the newly created working directory.

> That assumes you _can_ write to the original repository. That may or may
> not be the case, depending on your setup.

Well, I suppose in that case it could print a warning or maybe fail
without some "force" option.  If you can't write to the repository, then
I think it is safe to say that it will never know or care about you, so
you will fundamentally have a fragile setup.  I'd say that except in
very special circumstances, you are better off just not sharing it at
all.

Consider, for instance, that even if the repository that you are sharing
form never deletes branches and never does non-fast-forward updates of
references, it could very well happen to have, due to some temporary
operation, some unreferenced object that happens to be exactly the same
object that you want to add to your repository.  Because you've listed
it in info/alternates, you won't write that object to your own
repository, but then the source repository will very likely garbage
collect the object at some later point, corrupting your repository.

-- 
Jeremy Maitin-Shepard
