From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 21:36:09 +0200
Message-ID: <86absjcqfq.fsf@lola.quinscape.zz>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz> <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0708221154150.16727@xanadu.home> <Pine.LNX.4.64.0708221713540.20400@racer.site> <86mywjcwv7.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0708221149440.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 21:36:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INw0F-0003ZH-Ur
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 21:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786AbXHVTg2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 15:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755759AbXHVTg2
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 15:36:28 -0400
Received: from main.gmane.org ([80.91.229.2]:45146 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752919AbXHVTg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 15:36:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1INw07-0003cn-Lk
	for git@vger.kernel.org; Wed, 22 Aug 2007 21:36:23 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 21:36:23 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 21:36:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:OKMAY+Ux/SwZ1hYHF3HkWmgaN1I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56412>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So scripting languages are often good for *prototyping*, and a lot
> of people like scripting languages for that reason. But once
> something is already prototyped, and if somebody then rewrites it in
> C, all the advantages of a scripting language have already
> disappeared!
>
> I don't understand why people consider scripting languages (whether
> shell, perl, or anything else) "better" than C if there is an
> alternative. Once the C work has been done (and if you require C
> _anyway_ for other reasons, like git does), doing it in C is simply
> superior.

Actually, the same holds for assembly language vs C.  Once the
prototyping is over...

The main point is that with an evolving product, the prototyping never
is over.  And if the prototyping language is good enough, one never
needs to spend the time to "implement properly" when one already has a
working prototype.  Instead one can build upon the prototype, which is
actual progress.  Emacs is an example: its bulk is written in Elisp.
Would it be faster, smaller and more efficient when rewritten
completely in C?  Sure.

But it would stop being as hackable.  And you could have the fun of
searching for memory leaks and buffer overflows and crashes all the
time with code you were just prototyping.  With Elisp, you have a
whole slew fewer ways to shoot yourself in the foot really hard.  When
only 5% of the code is C, only 5% can crash hard, leak memory and so
on.

> Having tried to do internal scripting languages, I can say that it's
> just easier to do it in C once you get past the hump of getting it
> written in C in the first place.

But it is not "once" that you need to do this.  It is a permanent job.

> So yes, we could just make the shell/etc from busybox _be_ the
> scripting language, but the fact is, that is *more* C code than just
> making the commands C code in the first place, and while a lot of
> the effort is already done for us, "busybox under windows" is
> actually likely to be more of a maintenance problem than "native git
> commands under windows" are.

Maintenance: yes.  Development: no.  If you want a product you do not
want to touch again, C is a good final choice.

> And LUA may be a nicer scriping thing than most, but you still end
> up having the impedance match, and quite frankly, I think we'd have
> much fewer problems with just rewriting all the remaining shell
> scripts in C, than to integrate LUA and write them in that.

Sure: if you are aiming for a job that gets finished and then no
longer touched.

Maybe something like Lua would be overkill for the amount of hacking
to be expected: it would indeed ask for reimplementing existing stuff
again.  git-busybox would have the advantage of being able to
jump-start the existing script base, while still obliterating the
whole portability angle.

> (Quite frankly, havign looked at monotone development, I can say
> that we should avoid LUA and things like Boost like the plague. If
> it's not a library that has been around for ten years or more, it's
> not worth the headache).

Lua development was started in 1993.

Anyway, I don't see things as black&white as you do, but as long as
nobody actually implements anything, the discussion is rather idle.

Lua would likely be more portable than git-busybox (and certainly much
smaller), but then one would indeed have a non-trivial rewriting task.
Anyway, I'll follow any git-busybox announcements.  At the current
point of time, it is probably the most advanced candidate for both
retaining scripting and gaining portability.

-- 
David Kastrup
