From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Questions about git-fast-import for cvs2svn
Date: Sun, 15 Jul 2007 11:55:59 -0700
Message-ID: <7vd4ytebsw.fsf@assigned-by-dhcp.cox.net>
References: <469A2B1D.2040107@alum.mit.edu>
	<20070715120149.3271b736.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sun Jul 15 20:56:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA9GH-00070U-E0
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 20:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbXGOS4B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 14:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbXGOS4B
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 14:56:01 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:48580 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbXGOS4A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 14:56:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070715185600.SLRJ1393.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 15 Jul 2007 14:56:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Puvz1X0061kojtg0000000; Sun, 15 Jul 2007 14:55:59 -0400
In-Reply-To: <20070715120149.3271b736.seanlkml@sympatico.ca>
	(seanlkml@sympatico.ca's message of "Sun, 15 Jul 2007 12:01:49 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52578>

Sean <seanlkml@sympatico.ca> writes:

> Will take a stab at answering your questions...
>
>> 1. Is it a problem to create blobs that are never referenced?  The
>> easiest point to create blobs is when the RCS files are originally
>> parsed, but later we discard some CVS revisions, meaning that the
>> corresponding blobs would never be needed.  Would this be a problem?
>
> Not a problem.  Running "git gc" later will cleanup any unused objects.
>
>> 2. It appears that author/committer require an email address.  How
>> important is a valid email address here?
>
> It's not necessary for the operation of Git itself; it's up to you to
> decide how important the information is to your project.  You should
> be able to set an empty email address for author or committer in
> git fast-import as "name <>".

Don't do this; git-cvsimport and git-svn uses "name <name>"
which is a saner compromise.  This way, you can add .mailmap to
help later "git shortlog" to map using "<name>" part to more
human friendly name.  Mapping at conversion time would also be
good and git-cvsimport knows about it (I do not know about
git-svn).

>>    b. CVS tag/branch creation events do not even include a username.
>> Any suggestions for what to use here?
>
> Perhaps just use your own username or one specifically created to
> run the conversion process.

I'd suggest to take the person and time information from the
commit that is tagged; that way you can keep the conversion
stable (iow, two conversoin runs using the same input data would
produce identical result).

In git we do not record "branch creation event".  Also you can
use lightweight tags which does not have its own data -- which
means you do not have to come up with "the person who made the
tag".

>> 3. I expect we should set 'committer' to the value determined from CVS
>> and leave 'author' unused.  But I suppose another possibility would be
>> to set the 'committer' to 'cvs2svn' and the 'author' to the original CVS
>> author.  Which one makes sense?

I would set both to "name <name>" from CVS information.
