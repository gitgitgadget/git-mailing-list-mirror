From: Scott Lamb <slamb@slamb.org>
Subject: Re: CVS -> SVN -> Git
Date: Sun, 15 Jul 2007 16:09:11 -0700
Message-ID: <469AA917.3020401@slamb.org>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>	 <469804B4.1040509@alum.mit.edu> <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com> <4699034A.9090603@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org, dev <dev@cvs2svn.tigris.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 16 01:09:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IADDg-00073A-R1
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 01:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756185AbXGOXJh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 19:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755795AbXGOXJh
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 19:09:37 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:50554 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753612AbXGOXJg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 19:09:36 -0400
Received: from spiff.local (ppp-71-139-183-188.dsl.snfc21.pacbell.net [71.139.183.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hobbes.slamb.org (Postfix) with ESMTP id 521C198105;
	Sun, 15 Jul 2007 16:09:34 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <4699034A.9090603@alum.mit.edu>
X-Enigmail-Version: 0.95.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52596>

Michael Haggerty wrote:
> One quick-and-dirty idea that I had was to have cvs2svn output
> information compatible with cvsps's output, as I believe that several
> tools rely on cvsps to do the dirty work and so could perhaps be
> persuaded to use cvs2svn out of the box.

I think this would be an excellent approach. The interface between
cvs->X (cvsps), Y->git (git-fastimport), and cvs->git glue
(git-cvsimport) is a great idea for troubleshooting and for code sharing
with other converters. (Shawn O. Pearce's attitude is a great example of
this - he can maintain the part he cares about and several converters
benefit even though he's never used them.)

However, I was unhappy to see that cvsps doesn't reuse any cvs2svn code
or unit tests. I remember seeing a lot of those hairy cases on the
Subversion list long ago, so a CVS converter without those tests seems
untrustworthy. If I maintained an important CVS repository I wanted to
convert to git accurately, I would use cvs2svn.py+git-svnimport over
git-cvsimport any day.

They both seem much better than something like Tailor, though. I've
discovered several things that made me realize going through working
copies is error-prone (as well as slow).

>> Does cvs2svn handle incremental imports, remembering any "guesses"
>> taken earlier? Last time I looked at it, it had far better logic than
>> cvsps, but it didn't do incremental imports, and repeated imports done
>> at different times would "guess" different branching points for new
>> branches, so it _really_ didn't support incrementals
> 
> That's correct; cvs2svn does not support incremental conversion at all
> (at least not yet).

That's an important feature for me. I'm using git-cvsimport to track
other people's CVS repositories. Initial import is SLOW and
resource-intensive on the network, client, and server, so I couldn't
switch to anything that didn't support incremental use.

Best regards,
Scott

-- 
Scott Lamb <http://www.slamb.org/>
