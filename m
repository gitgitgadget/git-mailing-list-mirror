From: Junio C Hamano <junkio@cox.net>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Fri, 12 Jan 2007 10:47:56 -0800
Message-ID: <7virfct737.fsf@assigned-by-dhcp.cox.net>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 19:48:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5RRa-0005PE-Ap
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 19:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbXALSr7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 13:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbXALSr7
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 13:47:59 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:64761 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964851AbXALSr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 13:47:58 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112184757.YOEJ29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 13:47:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AJn51W00Y1kojtg0000000; Fri, 12 Jan 2007 13:47:06 -0500
To: "Chris Riddoch" <riddochc@gmail.com>
In-Reply-To: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com>
	(Chris Riddoch's message of "Fri, 12 Jan 2007 06:41:21 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36692>

"Chris Riddoch" <riddochc@gmail.com> writes:

> I suggest calling it something like update-index.  ;)

Exactly.

People new to git need to learn that the next commit is prepared
not in the working tree but in a separate entity (staging area),
and there are ways to update what it consists of.  If that
concept is new for people coming from other SCM, renaming
"index" to "staging area" only reduces potential confusion
(because "index" is too generic word that can mean anything) --
it does not remove the need to learn the new concept.

And we have called that staging area "the index", and the act of
updating what it consists of has been called "updating the
index" for a long time.  The primary command to do so has been
"git-update-index" plumbing, but we added some sugarcoating and
now "git-add" and "git-rm" (also "git-merge", "git-am" and
friends "updates the index" for automatable cases) are two most
visible ways for the users.

The logical name for the operation, if we _were_ to have only
one command for "updating the index", is "git-update" or
"git-update-index".  I do not have anything against "git stage"
but I simply do not see the point, other than "git update" would
imply something entirely different to people coming from other
SCM so we would want to avoid the word, and "git update-index"
is too long to type every day.

In any case, there are valid reasons that update-index has --add
and --remove options to force callers to specifically say "Yes I
know I am talking about unusual things, please".  If we _were_
to do a single command (be it "git-update" or "git-stage"), it
needs the same --add/--remove safety, which makes "it's too long
to type every day -- let's have a single Porcelain-ish" argument
somewhat moot.  We can have "git-add" and "git-rm" instead.

And indeed we do.  That's where we currently stand.

> First, specifying extra files after 'git commit' bypasses the index.

Which I happen to think is a misfeature.

> If I remove foo.txt, and want to make a new commit reflecting only
> that removal, 

If you try latest 'git status' in that situation, it would say
foo.txt is deleted but not updated and suggests to use git-add or
git-rm to include it in the commit you are creating.

> ...  But then I need to remember to use 'git add'
> to keep track of most changes in the index, new files and edits alike.

"git commit -a" is your friend.  I think new people should be
taught that form first, and then "git status" output, and then
what "git status" suggests them to do (which is "git add" or
"git rm").
