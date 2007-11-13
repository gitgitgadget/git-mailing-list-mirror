From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/2] Fix parent rewriting in --early-output
Date: Wed, 14 Nov 2007 08:55:18 +1100
Message-ID: <18234.7494.851156.347578@cargo.ozlabs.ibm.com>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
	<18212.13862.637991.30536@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
	<18217.41899.54812.227152@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org>
	<18218.63946.772767.179841@cargo.ozlabs.ibm.com>
	<e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
	<alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org>
	<18221.14113.498416.396006@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0711032234030.15101@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711041004220.15101@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711041124050.15101@woody.linux-foundation.org>
	<alpine.LFD.0.9999.0711122046570.2786@woody.linux-foundation.org>
	<18233.30098.470244.421468@cargo.ozlabs.ibm.com>
	<7vbq9yt1te.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 22:56:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is3jn-0000sd-1n
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760033AbXKMVzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759560AbXKMVzq
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:55:46 -0500
Received: from ozlabs.org ([203.10.76.45]:36319 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757874AbXKMVzp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:55:45 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id A4A9DDDE29; Wed, 14 Nov 2007 08:55:44 +1100 (EST)
In-Reply-To: <7vbq9yt1te.fsf@gitster.siamese.dyndns.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64889>

Junio C Hamano writes:

> I suspect that a "-" in place of a commit object name may not be
> enough for your purpose, as the _number_ of parents can later
> change in the later re-output.

I don't mind if a commit that has "-" as one of its parents later
turns out to have more parents (i.e. the "-" can stand for zero or
more unknown parents).  I would be perturbed if a commit that didn't
have any "-" in its parent list later turned out to have a different
number of parents - but I don't think that's what you're implying, is
it?

> I wonder if the presense of "incomplete" on the "Final output"
> line is a good enough indication for that.  That is, until you
> see "Final output: $N done", you will treat the parent
> information as unreliable.

The easiest way for me to handle an unreliable parent is just to
ignore it.  But I can't ignore all the parents, because then I
wouldn't have a graph at all.

In other words, the presence of "incomplete" doesn't give me any clue
as to which particular parent ids are reliable.  As far as I can see,
git log internally knows when a parent id is unreliable (it's one
where it had to terminate the history simplification early), so it
shouldn't be hard to tell gitk about that.  And it would make my job a
lot easier.

Paul.
