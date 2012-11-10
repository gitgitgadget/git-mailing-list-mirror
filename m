From: Kalle Olavi Niemitalo <kon@iki.fi>
Subject: Re: What's cooking in git.git (Nov 2012, #02; Fri, 9)
Date: Sat, 10 Nov 2012 21:32:15 +0200
Message-ID: <871ug15k5c.fsf@Niukka.kon.iki.fi>
References: <20121109192336.GA9401@sigill.intra.peff.net>
	<87a9uq5tql.fsf@Niukka.kon.iki.fi>
	<20121110155209.75EFC2E8B68@grass.foxharp.boston.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Fox <pgf@foxharp.boston.ma.us>
X-From: git-owner@vger.kernel.org Sat Nov 10 20:31:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXGlw-0008JB-AP
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 20:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572Ab2KJTa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 14:30:58 -0500
Received: from sirokuusama.dnainternet.net ([83.102.40.133]:55101 "EHLO
	sirokuusama.dnainternet.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752265Ab2KJTa5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 14:30:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by sirokuusama.dnainternet.net (Postfix) with ESMTP id 456E13F975;
	Sat, 10 Nov 2012 21:30:56 +0200 (EET)
X-Virus-Scanned: DNA Postiturva at dnainternet.net
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from sirokuusama.dnainternet.net ([83.102.40.133])
	by localhost (sirokuusama.dnainternet.net [127.0.0.1]) (DNA Postiturva, port 10041)
	with ESMTP id z4p0HjAzjiEH; Sat, 10 Nov 2012 21:30:55 +0200 (EET)
Received: from omenapuu.dnainternet.net (omenapuu.dnainternet.net [83.102.40.212])
	by sirokuusama.dnainternet.net (Postfix) with ESMTP id B79673F912;
	Sat, 10 Nov 2012 21:30:55 +0200 (EET)
Received: from Niukka.Niemitalo.private (85-131-104-149.bb.dnainternet.fi [85.131.104.149])
	by omenapuu.dnainternet.net (Postfix) with ESMTP id 754572BAED;
	Sat, 10 Nov 2012 21:30:53 +0200 (EET)
In-Reply-To: <20121110155209.75EFC2E8B68@grass.foxharp.boston.ma.us> (Paul
	Fox's message of "Sat, 10 Nov 2012 10:52:09 -0500")
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.51 (gnu/linux)
X-Accept-Language: fi;q=1.0, en;q=0.9, sv;q=0.5, de;q=0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209301>

Paul Fox <pgf@foxharp.boston.ma.us> writes:

> when i implemented the change, i wondered if some twisted emacs
> workflow would be an issue. ;-)  and i almost blocked SIGQUIT as
> well -- the two programs i looked at for precedent (CVS and MH) both
> block both SIGQUIT and SIGINT when spawning an editor.
>
> but since emacs users must have dealt with CVS for a long time before
> dealing with git, how might they have done so?

I think I usually ran CVS via vc.el, which prompts for a commit
message in Emacs before it runs cvs commit.  So CVS did not need
to run $EDITOR.

I just tried emacsclient with CVS 1.12.13-MirDebian-9, and it
behaves somewhat differently from Git with pf/editor-ignore-sigint.
When I tell Emacs to send SIGINT to the *Shell* buffer, CVS prompts:

cvs commit: warning: editor session failed

Log message unchanged or not specified
a)bort, c)ontinue, e)dit, !)reuse this message unchanged for remaining dirs
Action: (continue) 

and then I can choose to abort.

With strace, it looks like CVS sets SIG_IGN as the handler of
SIGINT and SIGQUIT only in the parent process after forking, not
in the child process that executes the editor.

CVS also temporarily blocks signals by calling sigprocmask, but
it undoes that before it forks or waits for the child process.
