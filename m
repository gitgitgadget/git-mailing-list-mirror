From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 18:28:32 -0700
Message-ID: <7v647ulbcv.fsf@assigned-by-dhcp.cox.net>
References: <200704171041.46176.andyparkins@gmail.com>
	<Pine.LNX.4.64.0704170829500.5473@woody.linux-foundation.org>
	<46250175.4020300@dawes.za.net>
	<Pine.LNX.4.64.0704171121090.5473@woody.linux-foundation.org>
	<20070417235649.GE31488@curie-int.orbis-terrarum.net>
	<7vps62lfbw.fsf@assigned-by-dhcp.cox.net>
	<20070418002658.GA18683@fieldses.org>
	<Pine.LNX.4.64.0704171800290.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>,
	Rogan Dawes <lists@dawes.za.net>,
	Andy Parkins <andyparkins@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 03:28:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdyyM-0006gI-3k
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 03:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030973AbXDRB2e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 21:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030981AbXDRB2e
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 21:28:34 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:46334 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030973AbXDRB2d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 21:28:33 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418012832.LGYW1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Apr 2007 21:28:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id oRUY1W0081kojtg0000000; Tue, 17 Apr 2007 21:28:33 -0400
In-Reply-To: <Pine.LNX.4.64.0704171800290.5473@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 17 Apr 2007 18:19:34 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44850>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Besides, if you actually have the file, you can trivially get the SHA1 
> _without_ embedding it into the file. Just do
>
> 	(echo -e -n "blob <size>\0" ; cat file) | sha1sum
>
> where "size" is just the size in bytes of the file.
>
> So embedding the SHA1 doesn't actually buy you anything: every blob BY 
> DEFINITION has their SHA1 embedded into them.
>
> In fact, embedding the SHA1 (or doing any other modifications) just makes 
> it harder to do this, since then you have to filter it out again.

The use case the thread you are responding to assumes that you
do *not* have a preimage before the change.

You give a file out, somebody says "here is my updated version"
and returns the whole file.  You may recognize, from the
contents, which path the file was taken from, but you may not
know which revision to diff against, as the "update version" was
not sent to you along with the version before he started
updating.

In my day job, I made a protocol, with a diff-challenged person
in our Japanese subsidiary, for him to send *both* preimage and
postimage of his changes when sending updates to me, and that
has worked reasonably well without embedded ID. I can always do
a file-level 3-way merge to forward port his change to whatever
version I am working on.

But if it is not an option to insist getting the preimage back,
embedded blob ID would be one way to help that exchange.
