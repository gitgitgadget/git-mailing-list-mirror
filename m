From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when contents are unchanged
Date: Tue, 07 Aug 2007 08:32:55 +0200
Message-ID: <86k5s7am7c.fsf@lola.quinscape.zz>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net> <vpqhcni47ek.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021050500.14781@racer.site> <vpqbqdq45ua.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021147110.14781@racer.site> <AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca> <Pine.LNX.4.64.0708021541520.14781@racer.site> <46B1F3F4.5030504@midwinter.com> <Pine.LNX.4.64.0708021614420.14781@racer.site> <20070803053717.GA16379@midwinter.com> <7v3az1qgdg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0708031121000.14781@racer.site> <7vir7wmk84.fsf@assigned-by-dhcp.cox.net> <86bqdkbq59.fsf@lola.quinscape.zz> <vpqr6mgwhsf.fsf@bauges.imag.fr> <7vodhkbdx2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 08:33:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIIdH-0006Q5-4V
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 08:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbXHGGdL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 02:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbXHGGdK
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 02:33:10 -0400
Received: from main.gmane.org ([80.91.229.2]:57496 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456AbXHGGdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 02:33:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IIIcq-00084V-NG
	for git@vger.kernel.org; Tue, 07 Aug 2007 08:33:04 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 08:33:04 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 08:33:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:htqQ0Hw2xFiktn/KOli8TvrjeGY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55222>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Unfortunately, the patch solves the "large and irrelevant output"
>> of git-diff, but not the performance problem (see the rest of the
>> thread, I failed to convince Junio that updating the index was a
>> performance improvement while keeping the same user semantics).
>
> That's what update-index --refresh (or status if you insist) are
> for, and the coalmine canary you are so dead set to kill are helping
> you realize the need for running.

That does not convince me.  Cache staleness should be a problem of
git, not of the user.  In particular if the user is just using
porcelain.  If letting the cache get stale impacts performance, then
git should clean up its act on its own without barfing when using
unrelated commands.  If it notices this during diff (presumably by
overstepping some staleness ratio), then it can set a "regenerate on
next opportunity" flag on the index, and then the next command wanting
to process the index from the start can rewrite a refreshed version.

-- 
David Kastrup
