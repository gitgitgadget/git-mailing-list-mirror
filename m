From: Junio C Hamano <junkio@cox.net>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow trees
Date: Mon, 16 Apr 2007 12:41:49 -0700
Message-ID: <7vwt0crts2.fsf@assigned-by-dhcp.cox.net>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net>
	<200704152051.35639.andyparkins@gmail.com>
	<Pine.LNX.4.64.0704151317180.5473@woody.linux-foundation.org>
	<200704161003.07679.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 21:42:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdX5L-0006wO-Ny
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 21:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030917AbXDPTlx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 15:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030920AbXDPTlx
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 15:41:53 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:63453 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030917AbXDPTlv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 15:41:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070416194150.FMQN1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 16 Apr 2007 15:41:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id nvhq1W0041kojtg0000000; Mon, 16 Apr 2007 15:41:50 -0400
In-Reply-To: <200704161003.07679.andyparkins@gmail.com> (Andy Parkins's
	message of "Mon, 16 Apr 2007 10:03:05 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44690>

Andy Parkins <andyparkins@gmail.com> writes:

> On Sunday 2007 April 15 21:51, Linus Torvalds wrote:
>
>> > Now, I print out that diagram and pin it to my wall - sometimes copies
>> > of it are given to others.  I do this on a regular basis.
>>
>> And is there *any* reason why you don't just do that as an "export"
>> option, when it's very clear that people won't send diffs that include it
>
> Of course there is a reason - the file I edit is the SVG itself, in inkscape 
> while editing that file I press "print" to get a print out.  Why on earth 
> would I want to jump through hoops by closing the file I'm editing, running 
> some export script to a temporary file that I don't want, then open up 
> Inkscape again, check the export looks okay and then print - on what planet 
> is /that/ simpler?

I have one question.

In your workflow, when do you "print"?

If you did this:

	$ cvs update draw.svg
        $ inkscape draw.svg
        ... do more editing
        ... press "PRINT"
	$ cvs diff draw.svg

the final "cvs diff" would say you have such and such changes to
the drawing file you just printed since the checked-in version.
However, doesn't "$Id: ... $" embedded in the printed copy say
it is from the last checked-in version?

Is inkscape aware of the "$Id: ... $" keyword and modifies such
string by munging it to "$Id: ..., modified $", once you make a
local modification to the document?  Otherwise you cannot tell
if the printed copy is pristine and match what the $Id$ keyword
claims it is.

Or maybe in your workflow, such a local modification may not
actually matter because you made a habit of not making a drastic
edit before printing.

Or perhaps maybe you never print a locally modified copy.

Does Inkscape have a batch mode operation?  It might be an
option to have something like this in the Makefile if it does (I
do not know if it does, and if so what the syntax is, so this is
totally made up):

        print:: draw.svg
                describe=$(git describe HEAD) && \
                git cat-file -p HEAD:draw.svg | \
                sed -e 's/$$Id$$/$$Id: '"$$described"'/g' | \
                inkscape --print --stdin
	.PHONY: print
