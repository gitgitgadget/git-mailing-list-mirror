From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: Re: strange temporary pull-errors
Date: Mon, 25 Aug 2008 19:38:10 +0100
Message-ID: <20080825183810.GL7592@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 25 20:39:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXgyE-0002Ga-KD
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 20:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbYHYSiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 14:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbYHYSiM
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 14:38:12 -0400
Received: from mhs.swan.ac.uk ([137.44.1.33]:39550 "EHLO mhs.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769AbYHYSiM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 14:38:12 -0400
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by mhs.swan.ac.uk with esmtp (Exim 4.69)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1KXgx8-0005V1-VD; Mon, 25 Aug 2008 19:38:10 +0100
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id B4D6DDAE92;
	Mon, 25 Aug 2008 19:38:10 +0100 (BST)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id 89A20741BE; Mon, 25 Aug 2008 19:38:10 +0100 (BST)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93653>

Hi,

----------------------------------------

From: Thomas Rast <trast <at> student.ethz.ch>
 Subject: Re: strange temporary pull-errors
 Newsgroups: gmane.comp.version-control.git
 Date: 2008-08-23 08:44:45 GMT (2 days, 5 hours and 14 minutes ago)
Oliver Kullmann wrote:
> 
> > git pull
[...]
> error: Entry 'Buildsystem/Configuration/Html/local_html.mak' not uptodate. Cannot merge.
[...]
> > git status
[...]
> nothing to commit (working directory clean)
> > git pull
[succeeds]
> There is nothing special going out, the simple pull should succeed, but
> I have to try several times; don't know whether the "git status" is
> instrumental here or not --- will try the next time.

Saying 'git status' refreshes the index.  If you have touched (updated
mtime) local_html.mak without making any changes, 'git merge' just
compared the mtime and considered the file changed.  But 'git status'
actually compares the contents and finds it has not been changed.  I
don't know whether 1.6 (most likely builtin-merge) changed behaviour
in this respect, maybe you could try with an older version too.

There are other cases where you need a refresh, for example if you
have made a copy of a git-tracked directory with 'cp -r'.

------------------------------------------

More precisely:

1) First, repository B pulls from A.
2) Then I change B.
3) Then repository A wants to pull from B.
There the error occurs --- the files changed
in B are claimed not to be up-to-date in A!
Obviously!

This looks like a clear git-bug to me: And with 1.5.6.5
this doesn't happen (the second pull just goes through).

It must be something different than you are describing,
since at step 3 repository A is still unchanged, and the error
(like with local_html.mak above) occurs with a file which just
should be updated. Though, after executing "git status",
the pull becomes enabled, so I must have something to do
with the index.

Oliver

P.S. I wonder how one is supposed to reply to an e-mail one (only)
finds in http://article.gmane.org/gmane.comp.version-control.git/ ?
Above I just copy-and-pasted it from the web-page, but this is rather
tedious?
