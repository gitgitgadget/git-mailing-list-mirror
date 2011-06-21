From: Johan Herland <johan@herland.net>
Subject: Re: git-union-merge proposal
Date: Tue, 21 Jun 2011 09:34:33 +0200
Message-ID: <201106210934.34025.johan@herland.net>
References: <20110621022049.GA1632@gnu.kitenet.net>
 <20110621052211.GA16919@elie>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Joey Hess <joey@kitenet.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 09:34:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYvTu-0006as-6H
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 09:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360Ab1FUHeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 03:34:36 -0400
Received: from smtp.getmail.no ([84.208.15.66]:65245 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276Ab1FUHeg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 03:34:36 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LN400C7KQDMFC90@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 21 Jun 2011 09:34:34 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 8DCDC1EA55F6_E00498AB	for <git@vger.kernel.org>; Tue,
 21 Jun 2011 07:34:34 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 5828A1EA28F4_E00498AF	for <git@vger.kernel.org>; Tue,
 21 Jun 2011 07:34:34 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LN40058UQDMJT30@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 21 Jun 2011 09:34:34 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.39-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <20110621052211.GA16919@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176131>

On Tuesday 21 June 2011, Jonathan Nieder wrote:
> Joey Hess wrote[1]:
> > * git notes merge -s cat_sort_uniq
> > 
> >   Notes are stored in a tree using the object sha, which can be
> >   union merged, when the notes' format is a series of independant
> >   lines.
> > 
> > [...]
> > 
> > So I've written a prototype of a git-union-merge that could be used
> > for all of these. It works like this:
> > 
> > git union-merge foo origin/foo refs/heads/foo
> 
> [...]
> 
> If the prototype were self-contained, I would encourage you to submit
> it for inclusion under contrib/ so it can evolve and eventually
> graduate out of there.  Cc-ing Johan (who has no doubt thought through
> these things in the context of "git notes") in case he has thoughts on
> it.

Thanks for the CC.

I must confess that my Haskell skills are exactly nil, but AFAICS the script 
depends on the filename as the only criteria to identify files that need a 
line-level merge. How does the script deal with renamed and copied files?

If you depend on the filename only, this script simply will not work for 
notes. The notes tree reorganizes itself dynamically for optimum 
performance, and this affects how notes trees can be merged.

E.g. given a note for object 01234567..., this note may exist as 
"01234567..." in one notes tree, while it may exist as "01/234567..." in a 
bigger notes tree, or even "01/23/4567..." in an even bigger notes tree. 
Even though the filenames differ, they all refer to the same note, and you 
cannot merge notes trees correctly without taking that fact into account.

Furthermore, if you (union-)merge two notes trees that both have 
"01/234567...", the result does not necessarily belong in "01/234567...". It 
could be that the sum/union of the two notes trees have pushed the number of 
notes in the result so high that "01/23/4567..." is now a more optimal name 
for this note.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
