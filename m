From: Junio C Hamano <junkio@cox.net>
Subject: Re: Unresolved issues
Date: Tue, 20 Feb 2007 16:25:47 -0800
Message-ID: <7vabz8uzjo.fsf@assigned-by-dhcp.cox.net>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702200934270.20368@woody.linux-foundation.org>
	<7vfy90v729.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702201621050.4043@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 01:26:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJfJP-0006qL-5H
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 01:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965309AbXBUAZu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 19:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965312AbXBUAZu
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 19:25:50 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:64654 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965309AbXBUAZt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 19:25:49 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070221002547.LSNJ1306.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 20 Feb 2007 19:25:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id S0Rn1W00a1kojtg0000000; Tue, 20 Feb 2007 19:25:48 -0500
In-Reply-To: <Pine.LNX.4.64.0702201621050.4043@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 20 Feb 2007 16:21:22 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40268>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 20 Feb 2007, Junio C Hamano wrote:
>> >
>> > No, that would be pretty horrid. So just tell everybody that it's based on 
>> > the working tree. I don't think it's likely to be a problem in practice.
>> 
>> Except for the initial checkout...
>
> Yeah, that's true. That's indeed pretty nasty.
>
> There's also a rather strange special case when you do merges: you can 
> certainly always use the .gitattributes of the working tree, but it will 
> cause some interesting issues if new files were added with new patterns.

Let alone the case where you need to merge .gitattributes file
itself and the conflicting part says something conflicting about
other paths that needed to be merged and the result need to be
checked out ;-).

> However, we're a bit lucky here (or perhaps "lucky" is not the right word: 
> we basically have a good design) where all these actions come down to "git 
> read-tree", regardless of whether it's checking out the end result of a 
> totally new clone, or a fast-forward update, or a merge. Or a "git 
> checkout" or "git reset". They all boil down to one thing:
>
> 	git read-tree -u
>
> and it should be fairly easy to add some simple logic just to 
> "cmd_read_tree()" to do the right thing. It has the "main tree" to use, 
> and the logic could be as simple as
>
> 	fd = open(".gitattributes", O_RDONLY);
> 	if (fd < 0) {
> 		.. try in "$tree:.gitattributes" instead ..
>
>
> and it would do the right thing for all the common operations.

Yes.  That is what I had in mind when I said "initial checkout".

> Again, the special case (as always) is
>  - git cat-file
>  - the file-level merger code (which uses the equivalent of git-cat-file)
> which would need to add their own logic for this.
>
> 		Linus

And git-apply which is (as usual) on its own.
