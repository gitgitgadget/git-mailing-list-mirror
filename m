From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Mon, 4 Jan 2010 01:44:08 -0500
Message-ID: <20100104064408.GA7785@coredump.intra.peff.net>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
 <fcaeb9bf1001021115j7b23264n42cfba7855c2253e@mail.gmail.com>
 <7v7hs09tpi.fsf@alter.siamese.dyndns.org>
 <87ljgfgbl0.fsf@catnip.gol.com>
 <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
 <877hrzga16.fsf@catnip.gol.com>
 <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
 <7v3a2mzzg4.fsf@alter.siamese.dyndns.org>
 <20100104053125.GA5083@coredump.intra.peff.net>
 <7vbphaquwl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 07:44:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRggS-0006hR-06
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 07:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917Ab0ADGoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 01:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752878Ab0ADGoN
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 01:44:13 -0500
Received: from peff.net ([208.65.91.99]:51383 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439Ab0ADGoN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 01:44:13 -0500
Received: (qmail 12707 invoked by uid 107); 4 Jan 2010 06:48:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 04 Jan 2010 01:48:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jan 2010 01:44:08 -0500
Content-Disposition: inline
In-Reply-To: <7vbphaquwl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136095>

On Sun, Jan 03, 2010 at 09:52:10PM -0800, Junio C Hamano wrote:

> > I agree that Solaris default tools are insane, but is there any reason
> > to munge the PATH for a single feature like external grep? Why not
> > EXTERNAL_GREP=/usr/xpg4/bin/grep (or /usr/local/bin/grep) in the
> > Makefile? Why not GIT_EXTERNAL_GREP=$HOME/bin/grep in the environment?
> 
> That git-sh-setup "fix" is not for running external grep.  It is for our
> scripted Porcelains that rely on working basic tools (sed, tr, who knows
> what else is broken).

Right, but I thought this thread was about external grep, and I thought
you were saying "if you want decent tools, you can use SANE_TOOL_PATH".
And I think we can do much better for that particular case than
recommending SANE_TOOL_PATH (but it seems that is not what you were
actually recommending).

But I admit, I have never really wanted to specify my own external grep.
Wanting your own grep for _features_ is probably insane, as some of your
greps (on worktree files) will use the external grep, and some (on
cached files) will not.  So it is really just an optimization, and I
have never felt it so slow that I cared about messing with an
alternative grep on Solaris.

I have to wonder, though...did anybody ever actually profile our
internal grep to find out _why_ it was so much slower than GNU grep?
Could we simply ship a better grep engine and obsolete external grep?

> In fact, our Makefile by default punts on external grep on Sun's.  Run
> "git grep NO_EXTERNAL_GREP -- Makefile" to see for yourself --- it would
> work even on Solaris ;-)

Yes, I am even mentioned in the commit log of 01ae841c. :)

-Peff
