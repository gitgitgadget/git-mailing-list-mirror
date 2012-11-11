From: Paul Fox <pgf@foxharp.boston.ma.us>
Subject: Re: [PATCH 0/5] ignore SIGINT while editor runs
Date: Sun, 11 Nov 2012 15:24:19 -0500
Message-ID: <20121111202419.7602E2E8B6A@grass.foxharp.boston.ma.us>
References: <20121109192336.GA9401@sigill.intra.peff.net> <87a9uq5tql.fsf@Niukka.kon.iki.fi> <20121110155209.75EFC2E8B68@grass.foxharp.boston.ma.us> <871ug15k5c.fsf@Niukka.kon.iki.fi> <20121110220811.DC6A42E8B68@grass.foxharp.boston.ma.us> <87wqxs4o6f.fsf@Niukka.kon.iki.fi> <20121111154846.GA13188@sigill.intra.peff.net> <20121111163100.GB13188@sigill.intra.peff.net> <20121111191520.GA9474@shrek.podlesie.net> (sfid-20121111_141527_021773_CB1E8F7F)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Jeff King <peff@peff.net>, Kalle Olavi Niemitalo <kon@iki.fi>,
	git@vger.kernel.org
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 21:25:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXe6I-0008TA-HK
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 21:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422Ab2KKUYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 15:24:20 -0500
Received: from colo.foxharp.net ([166.84.7.52]:45882 "EHLO colo.foxharp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752054Ab2KKUYU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 15:24:20 -0500
Received: from grass.foxharp.boston.ma.us (localhost [127.0.0.1])
	by colo.foxharp.net (Postfix) with ESMTP id 162CC540E4;
	Sun, 11 Nov 2012 15:21:26 -0500 (EST)
Received: by grass.foxharp.boston.ma.us (Postfix, from userid 406)
	id 7602E2E8B6A; Sun, 11 Nov 2012 15:24:19 -0500 (EST)
Received: from grass (localhost [127.0.0.1])
	by grass.foxharp.boston.ma.us (Postfix) with ESMTP id 742692E8008;
	Sun, 11 Nov 2012 15:24:19 -0500 (EST)
In-reply-to: <20121111191520.GA9474@shrek.podlesie.net> (sfid-20121111_141527_021773_CB1E8F7F)
Content-ID: <29531.1352665459.1@grass>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209442>

krzysztof wrote:
 > On Sun, Nov 11, 2012 at 11:31:00AM -0500, Jeff King wrote:
 > > 
 > > Here's a series that I think should resolve the situation for everybody.
 > > 
 > >   [1/5]: launch_editor: refactor to use start/finish_command
 > > 
 > > The cleanup I sent out a few minutes ago.
 > > 
 > >   [2/5]: launch_editor: ignore SIGINT while the editor has control
 > > 
 > > Paul's patch rebased on my 1/5.
 > > 
 > >   [3/5]: run-command: drop silent_exec_failure arg from wait_or_whine
 > >   [4/5]: run-command: do not warn about child death by SIGINT
 > >   [5/5]: launch_editor: propagate SIGINT from editor to git
 > > 
 > > Act more like current git when the editor dies from SIGINT.
 > > 
 > 
 > Looks ok, but what about SIGQUIT? Some editors like GNU ed (0.4 and 1.6)
 > ignore SIGQUIT, and after SIGQUIT git dies, but editor is still running.
 > After pressing any key ed receives -EIO and prints "stdin: Input/output
 > error". GNU ed 1.6 then exits, but ed 0.4 prints this error forever.
 > Maybe git should kill the editor in such case?

there's certainly lots of precedent for treating SIGINT and SIGQUIT
the same.  but there's also some merit to saying that if the user
knows to send SIGQUIT instead of SIGINT, they may well have a reason. 
(after all, if we always treat them the same, there's no point in
having both.)

the em editor (linus' microemacs) behaves as you describe ed 0.4 does,
except without the error message -- it just spins silently getting EIO
from reading stdin.  i think em needs to be fixed, and it sounds like
GNU ed already has been.  (unless i misunderstand the relationship of
0.4 and 1.6.)

paul

 > 
 > Krzysiek
 > --
 > To unsubscribe from this list: send the line "unsubscribe git" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html

=---------------------
 paul fox, pgf@foxharp.boston.ma.us (arlington, ma, where it's 57.2 degrees)
