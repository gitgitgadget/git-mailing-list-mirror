From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/2] Fix parent rewriting in --early-output
Date: Tue, 13 Nov 2007 20:59:46 +1100
Message-ID: <18233.30098.470244.421468@cargo.ozlabs.ibm.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 11:00:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrsZL-0006nD-TH
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 11:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbXKMKAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 05:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbXKMKAP
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 05:00:15 -0500
Received: from ozlabs.org ([203.10.76.45]:59477 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250AbXKMKAN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 05:00:13 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 8283DDDE02; Tue, 13 Nov 2007 21:00:12 +1100 (EST)
In-Reply-To: <alpine.LFD.0.9999.0711122046570.2786@woody.linux-foundation.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64778>

Linus Torvalds writes:

> However, while the parent is now correctly rewritten, it looks like gitk 
> is confused by this. Gitk will remember the original parent information, 
> even if a replay has given new parenthood information. Since the partial 
> early-output information is triggered by timing, this means that gitk will 
> show some totally random parent that quite possibly won't even be part of 
> the final commit set at all!

Yep.  It will be a little complex to deal with that because there are
bits of state that I set up for the parents, and if they're the wrong
parents, I'll have to go back and undo that.

In fact it would be easier for me if, instead of getting the id of
some random ancestor commit, I got an explicit indication to say
"unknown parent", such as just a "-" in place of the id of the
unknown parent(s).  Would that be doable?  I could then just not do
the processing for any unknown parent, and make sure to do it when I
see the final version of the commit.

Also, I have just about worked out an efficient way to do the commit
reordering incrementally, which would let me not use --topo-order or
--date-order, and display commits as they come in.  I'll have to see
whether that turns out to be better overall than using --early-output.

Paul.
