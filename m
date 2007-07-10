From: Theodore Tso <tytso@mit.edu>
Subject: Re: [RFC] series headers
Date: Tue, 10 Jul 2007 09:24:01 -0400
Message-ID: <20070710132401.GJ2343@thunk.org>
References: <Pine.LNX.4.64.0707100126250.6977@iabervon.org> <7vejjgsq3y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 15:24:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8FhN-0005Zv-1L
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 15:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbXGJNYK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 09:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752915AbXGJNYJ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 09:24:09 -0400
Received: from THUNK.ORG ([69.25.196.29]:36147 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337AbXGJNYI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 09:24:08 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I8FpC-0001nw-Uu; Tue, 10 Jul 2007 09:32:19 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I8FhB-00013a-QC; Tue, 10 Jul 2007 09:24:01 -0400
Content-Disposition: inline
In-Reply-To: <7vejjgsq3y.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52064>

On Mon, Jul 09, 2007 at 11:57:21PM -0700, Junio C Hamano wrote:
> I suspect that temptation to touch rev_info.commit_format arises
> purely because you are thinking about making 0/N a (perhaps
> fake) commit.  I do not see a point in that.
> 
> What is the workflow?

In general a patch series goes through multiple cycles of
improvements, where people send it out for review/comment, and then it
gets fixed up, etc. etc.   So you don't want to just do this:

>  $ work work work, commit commit commit, reorder and perfect
>  $ git format-patch --with-cover origin..HEAD
>  ... which notices --with-cover, and perhaps does
>  ... $ git-shortlog origin..HEAD
>  ... $ git diff --stat --summary origin..HEAD
>  ... $ echo "*** BLURB HERE ***"
>  ... to create 0/N which it did not do so far in
>  ... 0000-cover-letter.txt
>  $ $EDITOR 0000-cover-letter.txt
>  $ git-send-email 0*.txt

Because you'll be sending out the 0000-cover-letter.txt multiple
times, refining it (and the patches) as you go along.

Some people will use quilt for this process; others will use guilt or
stg in a seprate branch.  The way I would probably solve it is by
making the Patch 0/N cover letter be a empty commit with no changes,
and simply storing the comment in the commit log.  Yes, that means you
have to go back and edit the 0/N message after you've finished doing
your patch series, but the general work flow will require you to go
back and clean up patch 3/27 given some comment that Cristoph Hellwig
made, so you'll be going back and forth using some tool like guilt or
stg anyway.  So going back to edit the 0/N cover-letter is not a big deal.

The one advantage of putting the 0/N cover-letter at the end is that
it makes it easier to drop it if the patch series ends up being pushed
via git, but again, given that the patch series is going to be
reworked multiple times during its life cycle, reworking it one last
time to drop the cover letter doesn't seem like a major issue --- and
if it is ends up getting applied by the maintainer via e-mail and
git-am, the cover letter will get dropped by the maintainer simply not
including it in his mailbox of patches to apply.

	  	     	    	       	       - Ted
