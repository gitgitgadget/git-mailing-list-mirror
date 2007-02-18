From: Junio C Hamano <junkio@cox.net>
Subject: Re: format-patch and send-email
Date: Sun, 18 Feb 2007 01:22:18 -0800
Message-ID: <7vps87hlbp.fsf@assigned-by-dhcp.cox.net>
References: <5680.1171788594@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Sun Feb 18 10:22:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIiFU-0008Vf-LF
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 10:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932964AbXBRJWV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 04:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933135AbXBRJWV
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 04:22:21 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:39014 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932964AbXBRJWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 04:22:19 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070218092219.NSFX21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 18 Feb 2007 04:22:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QxNJ1W00h1kojtg0000000; Sun, 18 Feb 2007 04:22:19 -0500
In-Reply-To: <5680.1171788594@localhost> (Xavier Maillard's message of "Sun,
	18 Feb 2007 09:49:54 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40068>

Xavier Maillard <zedek@gnu.org> writes:

> From 50c7032fa011b1e5c7bd63e4bc474c802017677d Mon Sep 17 00:00:00 2001
> From: Xavier Maillard <zedek@gnu.org>
> Date: Fri, 16 Feb 2007 20:20:18 +0100
> Subject: * Added 2007 to the copyright notice
> To: <maillaxa@gmail.com>
> * Added a note on relation between org-publish and blorg
> * Changed/corrected things here and there
> * Added a warning on needed skills before manipulating your own templates
> ---
>  doc/blorg.texi |   31 +++++++++++++++++++------------
>  1 files changed, 19 insertions(+), 12 deletions(-)

> The "To" header has been set up in my .git/config file. But why
> the 'Subject' is like this and also why are there 2 'From'
> headers ?

The "format-patch" output was designed to (minimally) mimic what
you would see in a UNIX mbox as if you (or whoever would apply
the e-mailed patches to repository) received it, so that anybody
can later run "am" on it.  The first "From " is what sometimes
is called "UNIX-From " line, which separates each piece of
e-mail in mbox formatted mailbox file.  The second one is used
to record the author of the patch.

The commit log message is expected to be:

	A single line description of a patch

	More detailed explanation of the patch with
        possibly multi-line or multi-paragraph text.

and the single line description becomes the subject.

Your commit seems to squash four completely unrelated changes
into one, and enumerates only single-liner description for each
independent item, like this:

	* foo
        * bar
        * baz
        * boa

which makes format-patch think you wanted to title it "* foo"
with more detailed description "* bar *baz *boa".  I think you
would be much happier if you acquired a habit to make smaller
commits, that touch only one thing at a time without mixing up
unrelated things together, and give more descriptive messages to
each of them.

> Actually, why can't I just do like this ? :
>
> git format-patch <origin> | git send-email ?

While I know format-patch can be told to write to standard
output, I do not know if send-email can be told to read from the
standard input (I do not use send-email myself).  Some people
seem to use send-imap to stuff format-patch output to imap
drafts.  I just read format-patch output into message
composition buffer of my MUA (message mode of Emacs) and send it
out just as an ordinary e-mail (iow, as if I typed it).  In
other words, you do not have to use send-email as-is, if what it
does does not suit your needs.

I suspect the intended usage original author of "send-email"
envisioned was to have lots of format-patch output files and
send them in bulk, so probably reading from standard input was
not high on its design goals.  I dunno.

While I do believe some people use it, I haven't seen much
active development/enhancement on send-email from the users
lately.
