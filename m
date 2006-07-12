From: Junio C Hamano <junkio@cox.net>
Subject: Re: Re : 2 questions on git-send-email usage
Date: Wed, 12 Jul 2006 09:19:10 -0700
Message-ID: <7v7j2izthd.fsf@assigned-by-dhcp.cox.net>
References: <20060711084635.81393.qmail@web25809.mail.ukl.yahoo.com>
	<44B37893.5090501@innova-card.com>
	<7vd5cc3q0o.fsf@assigned-by-dhcp.cox.net>
	<44B4A6CA.3020206@innova-card.com>
	<Pine.LNX.4.64.0607120834200.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Franck Bui-Huu <vagabon.xyz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 12 18:20:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0hQn-0001qg-SG
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 18:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWGLQTS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 12:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWGLQTS
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 12:19:18 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:63208 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751457AbWGLQTR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 12:19:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060712161915.BSWG985.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Jul 2006 12:19:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607120834200.5623@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 12 Jul 2006 08:43:02 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23788>

Linus Torvalds <torvalds@osdl.org> writes:

> On a slightly related note, I absolutely _hate_ how cherry-picking adds 
> "(cherry-picked from commit <sha1>)" at the end. It's wrong for so many 
> reasons, one of them being that it then breaks things like this, but the 
> main one being that <sha1> will quite often actually end up not even 
> _existing_ in the resulting archive (you cherry-picked from your private 
> branch, and even if you keep your branch, you don't necessarily push it 
> out).
>
> Junio, can we make the default _not_ to do it, please?

I understand that it can be annoying.

I was hoping that however when you do something like this:

	git log --filter-backported-commits v2.6.16.9..v2.6.17

an improved log-inspection tool could notice and filter out the
ones that was backported from the mainline to the maintenance
branch.

But I realize that is probably a faulty logic.  First of all,
not all backports are cherry-picked (the same patch can be
applied from an e-mail, for example), so if we really want to do
the above filtering, we would need to be able to detect the same
patch anyway without "cherry-picked from" information.

To a certain degree, git-patch-id would help detecting such a
duplicated patch, but it would not help you detect "moral
equivalent" changes that are textually different.  A cherry-pick
after a conflict resolution that ends up applying a textually
different patch would still leave the "cherry-picked from"
message in the commit log (or a "note " header if we implement
it to reduce cluttering the log message), which would be the
only advantage of recording the information somehow.  But that
is probably not worth it -- it means "moral equivalent" changes
need to be recorded somehow by hand, which is unnecessarly
developer burden if it is rare enough to want to filter such
duplicates when inspecting the log.

Do people find "cherry-picked from" information useful?  Does
anybody mind if we change the default not to record it?
